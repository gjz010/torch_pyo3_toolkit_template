{
  config,
  lib,
  pkgs,
  ...
}:
{
  #pre-commit.default_stages = [
  #  "pre-push"
  #  "manual"
  #];
  git-hooks.hooks = {
    clippy.enable = true;
    rustfmt.enable = true;
    nixfmt-rfc-style.enable = true;
    black.enable = true;
    flake8.enable = true;
    mypy = {
      enable = true;
      entry = "${config.env.VIRTUAL_ENV}/bin/python3 -m mypy";
    };
  };
  packages = [ pkgs.nixfmt-rfc-style ];
}
