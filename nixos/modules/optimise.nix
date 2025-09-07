{
  config,
  pkgs,
  ...
}: {
  # Enable periodic store optimization (deduplication)
  nix.optimise.automatic = true;
  nix.optimise.dates = ["03:45"]; # Optional: set your preferred schedule[1]

  # Alternatively, optimize store on every build (may slow down builds)
  nix.settings.auto-optimise-store = true; # Only affects new files[1][2][3][9]

  # Enable automatic garbage collection
  nix.gc = {
     automatic = true;
    dates = "weekly"; # Or use cron syntax for more control
    options = "--delete-older-than 7d"; # Remove generations older than 30 days
  };

  # Optional: run GC when disk space is low
  nix.extraOptions = ''
    min-free = ${toString (100 * 1024 * 1024)}   # 100 MiB
    max-free = ${toString (1024 * 1024 * 1024)} # 1 GiB
  '';
}
