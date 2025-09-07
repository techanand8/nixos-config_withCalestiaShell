{pkgs, nixpkgs, ...}:
{
environment.systemPackages = with pkgs;[
     gnomeExtensions.arcmenu
     gnome-shell-extensions
     gnomeExtensions.zim-quick-launch
     gnomeExtensions.zen
     gnomeExtensions.zed-search-provider
     gnomeExtensions.yks-timer
     gnomeExtensions.yakuake
     gnomeExtensions.pano
     gnomeExtensions.fullscreen-notifications
     gnome-extension-manager
     gnome-extensions-cli
     gnome-tweaks
     gnomeExtensions.desktop-lyric
     gnomeExtensions.desktop-icons-ng-ding
     gnomeExtensions.clipboard-history
     gnomeExtensions.add-to-desktop
     gnomeExtensions.edit-desktop-files
     gnomeExtensions.search-light
     gnomeExtensions.gtk4-desktop-icons-ng-ding
     gnomeExtensions.blur-my-shell
     gnomeExtensions.dash-to-panel
     gnomeExtensions.gsconnect
     gnomeExtensions.kando-integration


];
}

