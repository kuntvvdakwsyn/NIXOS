{ config, pkgs, ... }:

{
    home.username = "lain";
    home.homeDirectory = "/home/lain";
    programs.git.enable = true;
    home.stateVersion = "25.05";
}
