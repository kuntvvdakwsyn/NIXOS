{ config, pkgs, lib, pkgs-unstable, ... }:

{
    imports = [
        ./hardware-configuration.nix 
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    zramSwap.enable = true;

    security.sudo.extraConfig = ''
        Defaults env_keep+="HOME"
        '';

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.powersave = false;
    time.timeZone = "Europe/Chisinau";

    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    programs.gamescope.enable = true;

    programs.hyprland.enable = true;

    nixpkgs.config.allowUnfree = true; 

    hardware.graphics = {
        enable = true;
        enable32Bit = true; 
        extraPackages = with pkgs; [
            vulkan-loader
                vulkan-validation-layers
                mesa
        ];
    };

    services.xserver.videoDrivers = [ "nvidia" ];
    boot.blacklistedKernelModules = [ "wacom" "hid-uclogic" ];

    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        open = false;
        nvidiaSettings = true;

        prime = {
            offload = {
                enable = true;
                enableOffloadCmd = true;
            };
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
        };
    };
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };

    users.users.nixa = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" "audio" "vboxusers" "input" ];
        shell = pkgs.zsh;  
    };
    qt = { 
        enable = true;
        platformTheme = "qt5ct";
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
    };
    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-hyprland ]; 
        config.common.default = "*";
    };

    programs.yazi.enable = true;

    environment.systemPackages = with pkgs; [
        fd
            ripgrep
            cliphist
            rust-analyzer
            foot
            fastfetch
            unimatrix
            tty-clock
            cava
            wl-clipboard
            pkg-config
            bat
            slurp
            lutris
            wineWowPackages.staging
            winetricks
            vulkan-tools
            vulkan-loader
            grim
            cliphist
            jq
            btop
            obsidian
            vim
            wget
            git
            gcc
            sfml_2
            gnumake
            python3
            python3Packages.pip
            audacious
            pavucontrol
            zsh-autosuggestions
            zsh-syntax-highlighting
            brightnessctl
            pulseaudio
            swaynotificationcenter
            kdePackages.dolphin    
            firefox
            brave
            hyprpaper
            telegram-desktop
            viber
            (discord.override { withOpenASAR = true; })
            mpv
            vscode    
            waybar
            rofi
            hyprlock
            eww
            hypridle 
            mako
            libnotify
            networkmanagerapplet
            glib
            bibata-cursors
            nerd-fonts.jetbrains-mono
            osu-lazer-bin
            hydralauncher
            qbittorrent
            ] ++ [
            pkgs-unstable.fzf
            ];

    environment.pathsToLink = [ "/include" ];
    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
    ];
####CLIPBOARD#####
    systemd.user.services.cliphist = {
        description = "Cliphist clipboard synchronization daemon";
        wantedBy = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";
            Restart = "on-failure";
        };
    };




    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    programs.git.enable = true;
    programs.vim.enable = true;

    systemd.user.services.waybar = {
        description = "Waybar status bar";
        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];
        serviceConfig = {
            ExecStart = "${pkgs.waybar}/bin/waybar";
            Restart = "always";
        };
    };
    system.stateVersion = "25.05";
}
