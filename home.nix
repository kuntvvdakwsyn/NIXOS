{ config, pkgs, ... }:

{
    home.username = "lain";
    home.homeDirectory = "/home/lain";
    programs.git.enable = true;
    home.stateVersion = "25.05";
    xdg.conifFile = {
        "foot".source = ./dot/foot;
        "hypr".source = ./dot/hypr;
        "waybar".source = ./dot/waybar;   
        "rofi".source = ./dot/rofi;
}
    home.packages = with pkgs; [
        foot 
        waybar
        hyprpaper
        rofi
    ];
}
