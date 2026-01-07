{ pkgs, inputs, ... }:
#
# TEMPORARY, ADAPTED FROM https://github.com/NixOS/nixpkgs/issues/448456#issuecomment-3453859659
#
let
  inherit (inputs) mesa-good;

  mesa-good-pkgs = import mesa-good {
    inherit (pkgs.stdenv) system;
    config.allowUnfree = true;
  };

  davinci = mesa-good-pkgs.davinci-resolve.passthru.davinci;
  davinci-fixed = pkgs.buildFHSEnv {
    pname = davinci.pname;
    version = davinci.version;

    runScript = pkgs.writers.writeBash "davinci-good-mesa-wrapper" ''
      export QT_XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"
      export QT_PLUGIN_PATH="${davinci}/libs/plugins:$QT_PLUGIN_PATH"

      export LD_LIBRARY_PATH=${mesa-good-pkgs.mesa}/lib:${mesa-good-pkgs.mesa}/lib/dri:$LD_LIBRARY_PATH
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/lib32:${davinci}/libs

      export OCL_ICD_VENDORS=${mesa-good-pkgs.mesa.opencl}/etc/OpenCL/vendors/rusticl.icd
      export RUSTICL_ENABLE=radeonsi

      exec ${davinci}/bin/resolve
    '';

    # we inline extraInstallCommands instead of referencing orig.extraInstallCommands, as it is not exposed
    extraInstallCommands = ''
      mkdir -p $out/share/applications $out/share/icons/hicolor/128x128/apps
      ln -s ${davinci}/share/applications/*.desktop $out/share/applications/
      ln -s ${davinci}/graphics/DV_Resolve.png $out/share/icons/hicolor/128x128/apps/davinci-resolve.png
    '';

    # we inline targetPkgs instead of referencing orig.targetPkgs, as it is not exposed
    targetPkgs =
      pkgs:
      [
        # our addition:
        mesa-good-pkgs.mesa
        davinci
      ]
      ++ (with pkgs; [
        # original dependencies:
        alsa-lib
        aprutil
        bzip2
        dbus
        expat
        fontconfig
        freetype
        glib
        libGL
        libGLU
        libarchive
        libcap
        librsvg
        libtool
        libuuid
        libxcrypt
        libxkbcommon
        nspr
        ocl-icd
        opencl-headers
        python3
        python3.pkgs.numpy
        udev
        xdg-utils
        xorg.libICE
        xorg.libSM
        xorg.libX11
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXi
        xorg.libXinerama
        xorg.libXrandr
        xorg.libXrender
        xorg.libXt
        xorg.libXtst
        xorg.libXxf86vm
        xorg.libxcb
        xorg.xcbutil
        xorg.xcbutilimage
        xorg.xcbutilkeysyms
        xorg.xcbutilrenderutil
        xorg.xcbutilwm
        xorg.xkeyboardconfig
        zlib
      ]);

    passthru = mesa-good-pkgs.davinci-resolve.passthru;
    meta = mesa-good-pkgs.davinci-resolve.meta;
  };
in
{
  environment.systemPackages = [ davinci-fixed ];
}
