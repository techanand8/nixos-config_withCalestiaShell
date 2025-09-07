{pkgs, ...}:
{
environment.systemPackages = with pkgs;[
      scrcpy
      android-tools
      android-studio
     android-studio-tools
    #  androidenv.test-suite
     # android-file-transfer
      #android-backup-extractor
  ];
     #android_sdk.accept_license = true;
  }
