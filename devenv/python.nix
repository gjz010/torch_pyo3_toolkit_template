{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.torch.backend;
  cfgName = if cfg == null then "null" else cfg;
  extraDriver = config.torch.driverPkg;
in
{
  options.torch.backend = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.enum [
        "cuda"
        "rocm"
        "cpu"
      ]
    );
    default = null;
    description = ''
      Backend to use for PyTorch.
      - null: No backend. Disables Python environment auto activation.
      - cuda: CUDA backend.
      - rocm: ROCm backend.
      - cpu: CPU backend.
    '';
  };
  options.torch.driverPkg = lib.mkPackageOption pkgs "nvidia_x11" {
    nullable = true;
    extraDescription = ''
      Extra path for drivers. Useful for non-NixOS usage.
    '';
  };
  config = {
    languages.python = {
      enable = true;
      venv.enable = true;
      uv = {
        enable = true;
        sync = {
          enable = cfg != null; # Only enable sync if a backend is set
          extras = [ cfgName ];
        };
      };
    };

    env = {
      VIRTUAL_ENV = config.env.DEVENV_ROOT + "/.devenv/state/venv";
      PYTHONPATH = config.env.DEVENV_ROOT;
      MYPYPATH = config.env.DEVENV_ROOT;
      # so C extensions can find dyamically linked libraries
      # https://github.com/cachix/devenv/issues/1264
      # https://github.com/cachix/devenv/issues/1228
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (
        let
          xorg = pkgs.xorg;
        in
        [
          pkgs.stdenv.cc.cc.lib
          pkgs.zstd
          pkgs.zlib
          pkgs.libGL
          xorg.libX11
          xorg.libxcb
          xorg.libXcomposite
          xorg.libXext
          pkgs.libxkbcommon
          xorg.libXrender
          pkgs.zlib
          xorg.xcbutilimage
          xorg.xcbutilkeysyms
          xorg.libXfixes
          xorg.libXtst
          pkgs.fontconfig
          pkgs.freetype
          pkgs.gtk3
          pkgs.gdk-pixbuf
          pkgs.glib
          pkgs.pango
          pkgs.dbus
        ]
        ++ (lib.optional (extraDriver != null) extraDriver)
        ++ (lib.optional (cfg == "cuda") "/run/opengl-driver")
      );
    };
  };
}
