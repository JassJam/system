{
  pkgs,
  version,
  hash,
  ...
}:
let
  ver = version;
in
pkgs.stdenv.mkDerivation rec {
  pname = "xmake";
  version = "${ver}";

  src = pkgs.fetchFromGitHub {
    owner = "xmake-io";
    repo = "xmake";
    rev = "v${ver}";
    hash = hash;
    fetchSubmodules = true;
  };

  nativeBuildInputs = with pkgs; [
    makeWrapper
    bash
    pkg-config
  ];

  buildInputs = with pkgs; [
    ncurses
    readline
  ];

  # XMake uses its own shell-based build script
  configurePhase = ''
    # Set up environment to find ncurses
    export CFLAGS="-I${pkgs.ncurses.dev}/include"
    export LDFLAGS="-L${pkgs.ncurses}/lib"
    export PKG_CONFIG_PATH="${pkgs.ncurses.dev}/lib/pkgconfig"

    # Run the configure script
    bash ./configure
  '';

  buildPhase = ''
    # Build using make
    make
  '';

  installPhase = ''
    # Install to the nix store output
    mkdir -p $out/bin $out/share/xmake
    make install PREFIX=$out

    # Wrap the binary to ensure ncurses is in the runtime path
    wrapProgram $out/bin/xmake \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.ncurses ]} \
      --set TERMINFO ${pkgs.ncurses}/share/terminfo \
      --prefix LD_LIBRARY_PATH : ${
        pkgs.lib.makeLibraryPath [
          pkgs.ncurses
          pkgs.readline
        ]
      }
  '';

  meta = with pkgs.lib; {
    description = "Cross-platform build utility based on Lua (built from source with ncurses)";
    homepage = "https://xmake.io";
    license = licenses.asl20;
    platforms = platforms.linux;
  };
}
