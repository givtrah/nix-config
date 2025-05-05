{ inputs, pkgs, ... }:
{

  # Enable Hyprland
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";




# Hyprland related packages
  environment.systemPackages = with pkgs; [
    hyprdim # Automatically dim windows when switching between them
    hyprsome # Awesome WM like workspaces for Hyprland (per monitor workspaces)
    hyprshot # Hyprland screen shot utility

    # hyprprop # An xprop replacement for Hyprland - no idea what this does

    hypridle # Screen idle utility 
    hyprlock # Screen lock utility

    hyprsunset # Application to enable a blue-light filter on Hyprland

    hyprsysteminfo # A tiny qt6/qml application to display information about the running system
    hyprpolkitagent # Polkit authentication agent written in QT/QML

    hyprland-qtutils # Hyprland QT/qml utility apps
    hyprland-protocols # Wayland protocol extensions for Hyprland
    hyprland-qt-support # A Qt6 QML provider for hypr* apps
    hyprland-activewindow # Multi-monitor-aware Hyprland workspace widget helper


    pyprland
    hyprpicker # Wlroots-compatible Wayland color picker that does not suck
    hyprcursor # Hyprland cursor format, library and utilities
    hyprpaper # Blazing fast wayland wallpaper utility

    pywal16
    hellwal

    swaynotificationcenter # notification daemon
	libsForQt5.qt5.qtwayland
#	qtwayland # cross-platform framework needed for QT support on Wayland
    
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gnome

    waybar

    zathura
    mpv
    imv
    
    # extra...
    wofi # menu
    yazi # file-manager

    bluez
    bluez-tools
    bluez-experimental
    blueman
    bluetui
    wl-clipboard
    upower

    pulsemixer # cli volume control

    hyprpanel

  ];


}
