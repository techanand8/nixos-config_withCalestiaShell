{pkgs, ...}: {
  services.flatpak.enable = true;
  users.users.mayank-anand = {
    packages = with pkgs; [
      flatpak
      gnome-software
    ];
  };
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
