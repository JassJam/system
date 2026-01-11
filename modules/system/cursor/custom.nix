{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-custom = config.system.cursor.custom;

  mkCursorFromFile =
    {
      path,
      cursorName ? "default",
      displaySize,
      hotspotX ? null,
      hotspotY ? null,
    }:
    let
      actualHotspotX = if hotspotX != null then hotspotX else (displaySize / 2);
      actualHotspotY = if hotspotY != null then hotspotY else (displaySize / 2);
    in
    pkgs.stdenv.mkDerivation {
      name = "custom-cursor-${cursorName}";
      src = path;

      nativeBuildInputs = with pkgs; [
        xorg.xcursorgen
        imagemagick
      ];

      unpackPhase = "true";

      buildPhase = ''
        # Convert .cur to PNG
        convert $src cursor.png

        # Create cursor config
        echo "${toString displaySize} ${toString actualHotspotX} ${toString actualHotspotY} cursor.png" > cursor.config

        # Generate X11 cursor
        mkdir -p cursors
        xcursorgen cursor.config cursors/${cursorName}
      '';

      installPhase = ''
                mkdir -p $out/share/icons/${cfg-custom.themeName}/cursors
                cp cursors/${cursorName} $out/share/icons/${cfg-custom.themeName}/cursors/
                
                # copy the config for debugging purposes
                cp cursor.config $out/share/icons/${cfg-custom.themeName}/cursors/
                
                cd $out/share/icons/${cfg-custom.themeName}/cursors
                for name in default left_ptr arrow; do
                  ln -sf ${cursorName} $name
                done
                
                # Create index.theme
                cat > $out/share/icons/${cfg-custom.themeName}/index.theme <<EOF
        [Icon Theme]
        Name=${cfg-custom.themeName}
        Comment=Custom cursor theme of ${cursorName}
        EOF
      '';
    };

  mkDownloadCursor =
    {
      url,
      hash,
      cursorName ? "default",
      displaySize,
      hotspotX ? null,
      hotspotY ? null,
    }:
    let
      downloaded = pkgs.fetchurl {
        url = url;
        sha256 = hash;
      };
    in
    mkCursorFromFile {
      path = downloaded;
      cursorName = cursorName;
      displaySize = displaySize;
      hotspotX = hotspotX;
      hotspotY = hotspotY;
    };

  mkUpscaledCursor =
    {
      path,
      targetSize,
      themeName,
    }:
    pkgs.stdenv.mkDerivation {
      name = "upscaled-cursor-${themeName}";
      src = path;

      nativeBuildInputs = with pkgs; [
        xorg.xcursorgen
        imagemagick
        perl
      ];

      buildPhase = ''
              mkdir -p output/cursors
              
              echo "Upscaling cursors to ${toString targetSize}px using xcur2png..."
              
              cat > xcur2png.pl <<'PERLSCRIPT'
        #!/usr/bin/env perl
        use strict;
        use warnings;

        my $file = $ARGV[0];
        my $outbase = $ARGV[1];

        open(my $fh, '<:raw', $file) or die "Cannot open $file: $!";

        my $header;
        read($fh, $header, 16);
        my ($magic, $header_size, $version, $ntoc) = unpack('a4VVV', $header);

        die "Not an Xcursor file" unless $magic eq "Xcur";

        my @toc;
        for (1..$ntoc) {
            my $entry;
            read($fh, $entry, 12);
            my ($type, $subtype, $position) = unpack('VVV', $entry);
            push @toc, { type => $type, subtype => $subtype, position => $position };
        }

        my $img_num = 0;
        for my $entry (@toc) {
            next unless $entry->{type} == 0xfffd0002;
            
            seek($fh, $entry->{position}, 0);
            
            my $chunk_header;
            read($fh, $chunk_header, 16);
            my ($chunk_size, $chunk_type, $chunk_subtype, $chunk_version) = unpack('VVVV', $chunk_header);
            
            my $image_header;
            read($fh, $image_header, 20);
            my ($width, $height, $xhot, $yhot, $delay) = unpack('VVVVV', $image_header);
            
            my $pixels;
            read($fh, $pixels, $width * $height * 4);
            
            print "$width $xhot $yhot " . $outbase . "_" . $img_num . ".png";
            print " $delay" if $delay > 0;
            print "\n";
            
            open(my $raw, '|-', 'convert', '-size', $width . "x" . $height, '-depth', '8', 
                 'bgra:-', $outbase . "_" . $img_num . ".png") or die "Cannot run convert: $!";
            print $raw $pixels;
            close($raw);
            
            $img_num++;
        }

        close($fh);
        PERLSCRIPT
              
              chmod +x xcur2png.pl
              
              for cursor in cursors/*; do
                if [ -f "$cursor" ]; then
                  name=$(basename "$cursor")
                  echo "Processing $name..."
                  
                  if perl xcur2png.pl "$cursor" "tmp_$name" > "config_$name.txt" 2>/dev/null; then
                    sed -i.bak "s|tmp_''${name}_|scaled_''${name}_|g" "config_$name.txt"
                    
                    for img in tmp_"$name"_*.png; do
                      if [ -f "$img" ]; then
                        outimg=$(echo "$img" | sed "s|tmp_|scaled_|")
                        convert "$img" -resize ${toString targetSize}x${toString targetSize}! "$outimg"
                        rm "$img"
                      fi
                    done
                    
                    awk -v size=${toString targetSize} '{
                      split($0, a); 
                      old_size = a[1]; 
                      scale = size / old_size;
                      new_xhot = int(a[2] * scale);
                      new_yhot = int(a[3] * scale);
                      printf "%d %d %d %s", size, new_xhot, new_yhot, a[4];
                      if (NF > 4) printf " %s", a[5];
                      printf "\n";
                    }' "config_$name.txt" > "config_$name.new"
                    mv "config_$name.new" "config_$name.txt"
                    
                    if xcursorgen "config_$name.txt" "output/cursors/$name"; then
                      echo "✓ Created $name"
                    else
                      echo "✗ Failed to create $name"
                    fi
                    
                    rm -f tmp_"$name"_*.png scaled_"$name"_*.png config_"$name.txt" config_"$name.txt.bak"
                  else
                    echo "✗ Failed to extract $name"
                  fi
                fi
              done
      '';

      installPhase = ''
              mkdir -p $out/share/icons/${themeName}
              cp -r output/cursors $out/share/icons/${themeName}/
              
              if [ -f index.theme ]; then
                cp index.theme $out/share/icons/${themeName}/
              else
                cat > $out/share/icons/${themeName}/index.theme <<EOF
        [Icon Theme]
        Name=${themeName}
        Comment=Upscaled cursor theme of ${themeName}
        EOF
              fi
      '';
    };

  mkDirectoryToPackage =
    {
      path,
    }:
    pkgs.stdenv.mkDerivation {
      name = "custom-cursor-theme";
      src = path;

      installPhase = ''
                # copy to .icons directory
                mkdir -p $out/share/icons/${cfg-custom.themeName}
                cp -r $src/* $out/share/icons/${cfg-custom.themeName}/

                # Create index.theme if not present
                if [ ! -f $out/share/icons/${cfg-custom.themeName}/index.theme ]; then
                  cat > $out/share/icons/${cfg-custom.themeName}/index.theme <<EOF
        [Icon Theme]
        Name=${cfg-custom.themeName}
        Comment=Custom cursor theme of ${cfg-custom.themeName}
        EOF
                fi  

                # link common cursor names to default cursor
                if [ -d $out/share/icons/${cfg-custom.themeName}/cursors ] && [ -f $out/share/icons/${cfg-custom.themeName}/cursors/${cfg-custom.cursorName} ]; then
                  cd $out/share/icons/${cfg-custom.themeName}/cursors
                  for name in default left_ptr arrow; do
                    # Only create symlink if it doesn't already exist
                    if [ ! -e $name ]; then
                      ln -sf ${cfg-custom.cursorName} $name
                    fi
                  done
                fi
      '';
    };

  pointerCursorPackage =
    if cfg-custom.type == "compiled" && cfg-custom.autoUpscale then
      mkUpscaledCursor {
        path = cfg-custom.cursorPath;
        targetSize = cfg-custom.displaySize;
        themeName = cfg-custom.themeName;
      }
    else
      {
        "download" = mkDownloadCursor {
          url = cfg-custom.cursorUrl;
          hash = cfg-custom.cursorHash;
          cursorName = cfg-custom.cursorName;
          displaySize = cfg-custom.displaySize;
          hotspotX = cfg-custom.hotspotX;
          hotspotY = cfg-custom.hotspotY;
        };
        "file" = mkCursorFromFile {
          path = cfg-custom.cursorPath;
          cursorName = cfg-custom.cursorName;
          displaySize = cfg-custom.displaySize;
          hotspotX = cfg-custom.hotspotX;
          hotspotY = cfg-custom.hotspotY;
        };
        "compiled" = mkDirectoryToPackage {
          path = cfg-custom.cursorPath;
        };
      }
      .${cfg-custom.type};
in
{
  options.system.cursor.custom = {
    enable = lib.mkEnableOption "Enable custom cursor theming";

    type = lib.mkOption {
      type = lib.types.enum [
        "download"
        "file"
        "compiled"
      ];
      description = "Method to obtain the cursor: 'file' for .cur files, 'download' to fetch from URL, 'compiled' for pre-built cursor directories (will auto-upscale to displaySize)";
    };

    cursorUrl = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "URL to download the .cur file from (only for type='download')";
      example = "https://example.com/cursors/saesd.cur";
    };

    cursorHash = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "SHA256 hash of the downloaded .cur file (only for type='download')";
      example = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };

    cursorPath = lib.mkOption {
      type = lib.types.path;
      description = "Path to the .cur file or cursor theme directory";
      example = lib.literalExpression "./cursors/saesd.cur";
    };

    cursorName = lib.mkOption {
      type = lib.types.str;
      default = "default";
      description = "Name of the cursor (used internally for symlinks)";
    };

    themeName = lib.mkOption {
      type = lib.types.str;
      default = "CustomCursor";
      description = "Name of the cursor theme";
      example = "koishi";
    };

    hotspotX = lib.mkOption {
      type = lib.types.nullOr lib.types.int;
      default = null;
      description = "X coordinate of the cursor hotspot (only for 'file' and 'download' types). Defaults to center if not specified.";
    };

    hotspotY = lib.mkOption {
      type = lib.types.nullOr lib.types.int;
      default = null;
      description = "Y coordinate of the cursor hotspot (only for 'file' and 'download' types). Defaults to center if not specified.";
    };

    displaySize = lib.mkOption {
      type = lib.types.int;
      description = "Display size for the cursor in pixels. For 'compiled' type with autoUpscale=true, cursors will be upscaled to this size.";
      example = 48;
    };

    autoUpscale = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Automatically upscale compiled cursors to displaySize (experimental, may look pixelated)";
    };
  };

  config = lib.mkIf cfg-custom.enable {
    home-manager.users.${userName}.home = {
      pointerCursor = {
        enable = true;
        name = cfg-custom.themeName;
        package = pointerCursorPackage;
        size = cfg-custom.displaySize;
        gtk.enable = true;
        x11.enable = true;
      };
    };

    environment.sessionVariables = {
      XCURSOR_THEME = cfg-custom.themeName;
      XCURSOR_SIZE = toString cfg-custom.displaySize;
    };
  };
}
