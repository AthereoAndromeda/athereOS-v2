{
  pkgs,
  lib,
  ...
}: {
  # reference: https://haseebmajid.dev/posts/2023-10-08-how-to-create-systemd-services-in-nix-home-manager/
  # because nixos and home-manager have different ways to setup systemd
  # for some reason

  # systemd.user.services.wayidle-suspend = {
  #   description = "Suspend after 15 minutes of inactivity";

  #   # Start once the graphical session is ready
  #   # wantedBy = ["graphical-session.target"];
  #   # partOf = ["graphical-session.target"];
  #   # after = ["graphical-session.target"];

  #   serviceConfig = {
  #     Type = "simple";

  #     ExecStart = ''
  #       ${pkgs.bash}/bin/bash -c "${pkgs.wayidle}/bin/wayidle --timeout 900 && ${pkgs.systemd}/bin/systemctl suspend;"
  #     '';

  #     Restart = "always";
  #     RestartSec = "1sec";
  #   };
  # };

  # This is equivalent to the above. Why are they structured differently?????
  systemd.user.services.wayidle-suspend = {
    Unit = {
      Description = "Suspend after 15 minutes of inactivity";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      Restart = "always";
      RestartSec = "5s";

      ExecStart = "${pkgs.writeShellScript "wayidle-suspend" ''
        #!/usr/bin/env bash
        ${lib.getExe pkgs.wayidle} -t 900 ${pkgs.systemd}/bin/systemctl suspend
      ''}";
    };
  };

  systemd.user.services.wayidle-lock = {
    Unit = {
      Description = "Lock screen after 8 minutes";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      Restart = "always";
      RestartSec = "1s";

      ExecStart = "${pkgs.writeShellScript "wayidle-lock" ''
        #!/usr/bin/env bash
        ${lib.getExe pkgs.wayidle} -t 480 pidof ${lib.getExe pkgs.hyprlock} || ${lib.getExe pkgs.hyprlock}
      ''}";
    };
  };

  systemd.user.services.wayidle-brightness = {
    Unit = {
      Description = "Lower brightness after 5 minutes";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      Restart = "always";
      RestartSec = "1s";

      ExecStart = "${pkgs.writeShellScript "wayidle-brightness" ''
        #!/usr/bin/env bash
        ${lib.getExe pkgs.wayidle} -t 300 ${lib.getExe pkgs.brightnessctl} set 5
      ''}";
    };
  };
}
