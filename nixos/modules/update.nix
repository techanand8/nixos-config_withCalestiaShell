{ config, pkgs, ... }:

{
  ###############################
  ## Auto Upgrade Configuration
  ###############################

  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos";
#    flake = "path:${toString ./.}";
    flags = [
      "--update-input" "nixpkgs-stable"  # Security/stable updates first
      "--update-input" "nixpkgs"         # DevOps/unstable second
      "-L"                               # Show logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
    allowReboot = false;  # Never auto-reboot security systems
  };

  ###############################
  ## Visual Alert After Upgrade
  ###############################

  systemd.services.nixos-upgrade = {
    serviceConfig = {
      ExecStartPost = ''
        ${pkgs.libnotify}/bin/notify-send \
          -u critical \
          -i ${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg \
          "NixOS Stable Updated" \
          "Verify integrity on ${config.networking.hostName}"

        ${pkgs.libnotify}/bin/notify-send \
          -u critical \
          -i ${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg \
          "NixOS Unstable Updated" \
          "Verify integrity on ${config.networking.hostName}"
      '';
    };
  };

  ###############################
  ## Extra Logging and Safety
  ###############################

  nix.extraOptions = ''
    warn-dirty = true
    log-lines = 50
  '';

  #############################################
  ## Manual-Controlled Weekly Unstable Updates
  #############################################

  systemd.services.nixos-unstable-upgrade = {
    script = ''
      echo "⚠️  WARNING: Applying unstable updates..." >&2
      ${config.system.build.nixos-rebuild}/bin/nixos-rebuild switch \
        --flake .#${config.networking.hostName} \
        --update-input nixpkgs
    '';
    unitConfig = {
      ConditionACPower = true;  # Avoid running on battery
    };
    serviceConfig = {
      Type = "oneshot";
    };
  };

  systemd.timers.nixos-unstable-upgrade = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "Mon 03:00";            # Weekly at 3:00 AM
      RandomizedDelaySec = "20min";        # Avoid spikes
      Persistent = true;                   # Run missed jobs
    };
  };
}

