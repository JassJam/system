{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-jetbrains = config.coding.editors.jetbrains;

  cfg-any-jetbrains-enabled =
    cfg-jetbrains.clion || cfg-jetbrains.idea || cfg-jetbrains.webstorm || cfg-jetbrains.toolbox;
in
{
  options.coding.editors.jetbrains = {
    toolbox = lib.mkEnableOption "Install JetBrains Toolbox App";
    clion = lib.mkEnableOption "Install JetBrains CLion IDE";
    idea = lib.mkEnableOption "Install JetBrains IDEA OSS Edition";
    webstorm = lib.mkEnableOption "Install JetBrains WebStorm IDE";
  };

  config = {
    home-manager.users.${userName}.home = {
      packages =
        lib.optionals cfg-jetbrains.clion [
          # clion ide for c++
          pkgs.jetbrains.clion
        ]
        ++ lib.optionals cfg-jetbrains.idea [
          # idea OSS edition for java
          pkgs.jetbrains.idea-oss
        ]
        ++ lib.optionals cfg-jetbrains.webstorm [
          # webstorm ide for web development
          pkgs.jetbrains.webstorm
        ]
        ++ lib.optionals cfg-jetbrains.toolbox [
          # jetbrains toolbox app
          pkgs.jetbrains-toolbox
        ];
    };

    programs.nix-ld.enable = cfg-any-jetbrains-enabled;
    programs.nix-ld.libraries =
      with pkgs;
      [ ]
      ++ lib.optionals cfg-any-jetbrains-enabled [
        SDL
        SDL2
        SDL2_image
        SDL2_mixer
        SDL2_ttf
        SDL_image
        SDL_mixer
        SDL_ttf
        alsa-lib
        at-spi2-atk
        at-spi2-core
        atk
        bzip2
        cairo
        cups
        curlWithGnuTls
        dbus
        dbus-glib
        desktop-file-utils
        e2fsprogs
        expat
        flac
        fontconfig
        freeglut
        freetype
        fribidi
        fuse
        fuse3
        gdk-pixbuf
        glew110
        glib
        gmp
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-ugly
        gst_all_1.gstreamer
        gtk2
        harfbuzz
        icu
        keyutils.lib
        libGL
        libGLU
        libappindicator-gtk2
        libcaca
        libcanberra
        libcap
        libclang.lib
        libdbusmenu
        libdrm
        libgcrypt
        libgpg-error
        libidn
        libjack2
        libjpeg
        libmikmod
        libogg
        libpng12
        libpulseaudio
        librsvg
        libsamplerate
        libthai
        libtheora
        libtiff
        libudev0-shim
        libusb1
        libuuid
        libvdpau
        libvorbis
        libvpx
        libxcrypt-legacy
        libxkbcommon
        libxml2
        mesa
        nspr
        nss
        openssl
        p11-kit
        pango
        pixman
        python3
        speex
        stdenv.cc.cc
        tbb
        udev
        vulkan-loader
        wayland
        xorg.libICE
        xorg.libSM
        xorg.libX11
        xorg.libXScrnSaver
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXft
        xorg.libXi
        xorg.libXinerama
        xorg.libXmu
        xorg.libXrandr
        xorg.libXrender
        xorg.libXt
        xorg.libXtst
        xorg.libXxf86vm
        xorg.libpciaccess
        xorg.libxcb
        xorg.xcbutil
        xorg.xcbutilimage
        xorg.xcbutilkeysyms
        xorg.xcbutilrenderutil
        xorg.xcbutilwm
        xorg.xkeyboardconfig
        xz
        zlib
      ];
  };
}
