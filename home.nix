{ config, pkgs, ... }:

{
    home.username = "nixa";
    home.homeDirectory = "/home/nixa";
    programs.git.enable = true;
    home.stateVersion = "25.05";
}
