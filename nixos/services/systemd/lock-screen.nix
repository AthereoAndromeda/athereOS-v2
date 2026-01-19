{pkgs, ...}: {
  systemd.user.services.hyprlock-loginctl = {
    description = "Bridge loginctl lock-session to hyprlock";
    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    after = ["graphical-session.target"];

    serviceConfig = {
      Type = "simple";
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

  systemd.user.services.hyprlock-suspend-bridge = {
    description = "Lock hyprlock on system suspend";
    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    after = ["graphical-session.target"];

    serviceConfig = {
      Type = "simple";
      ExecStart = pkgs.writeShellScript "hyprlock-suspend-bridge" ''
        ${pkgs.dbus}/bin/dbus-monitor --system "type='signal',interface='org.freedesktop.login1.Manager',member='PrepareForSleep'" | \
        while read -r line; do
          # The signal sends 'boolean true' when going to sleep
          if echo "$line" | grep -q "boolean true"; then
            ${pkgs.hyprlock}/bin/hyprlock
          fi
        done
      '';
      Restart = "always";
      RestartSec = 3;
    };
  };
}
