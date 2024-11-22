{config, lib, pkgs, ...}: {
    languages.python.enable = true;
    languages.python.poetry.enable = true;
    languages.python.poetry.activate.enable = true;
    languages.python.poetry.install.enable = true;
    # https://github.com/cachix/devenv/issues/1264
    env = {
      VIRTUAL_ENV = config.env.DEVENV_ROOT + "/.venv";
      PYTHONPATH = config.env.DEVENV_ROOT;
      MYPYPATH = config.env.DEVENV_ROOT;
      # so C extensions can find dyamically linked libraries
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc pkgs.zlib pkgs.zstd];
    };
}
