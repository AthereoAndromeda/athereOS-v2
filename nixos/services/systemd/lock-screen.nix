{pkgs, ...}: {
  systemd.user.services.hyprlock-loginctl = {
    description = "Bridge loginctl lock-session to hyprlock";
    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    after = ["graphical-session.target"];

    serviceConfig = {
      Type = "simple";
      # This script waits for the 'Lock' signal from logind and runs hyprlock
      ExecStart = pkgs.writeShellScript "hyprlock-bridge" ''
        ${pkgs.dbus}/bin/dbus-monitor --system "type='signal',interface='org.freedesktop.login1.Session',member='Lock'" | \
        while read -r line; do
          if echo "$line" | grep -q "Lock"; then
            ${pkgs.hyprlock}/bin/hyprlock
          fi
        done
      '';
      Restart = "always";
      RestartSec = 3;
    };
  };

  systemd.services.hyprlock-before-sleep = {
    description = "Lock the screen before suspend";
    before = ["sleep.target" "suspend.target"];
    wantedBy = ["sleep.target" "suspend.target"];
    environment = {
      DISPLAY = ":0";
      XDG_RUNTIME_DIR = "/run/user/1000";
    };
    serviceConfig = {
      Type = "simple";
      User = "athereo";
      ExecStart = "${pkgs.hyprlock}/bin/hyprlock";
    };
  };
}
