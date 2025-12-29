{
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) readFile;
  askpass-bin = pkgs.nuenv.writeScriptBin {
    name = "askpass";
    script = readFile ./nu/askpass.nu;
  };
in {
  home.sessionVariables = {
    SUDO_ASKPASS = "${lib.getExe askpass-bin}";
  };

  home.packages = with pkgs; [
    (nuenv.writeScriptBin {
      name = "fzf-cliphist";
      script = readFile ./nu/fzf-preview.nu;
    })
    (nuenv.writeScriptBin {
      name = "conservation-mode";
      script = readFile ./nu/conservation-mode.nu;
    })
    (nuenv.writeScriptBin {
      name = "screenshot-and-save";
      script = readFile ./nu/screenshot-and-save.nu;
    })
    (nuenv.writeScriptBin {
      name = "kb-backlight";
      script = readFile ./nu/kb-backlight.nu;
    })

    (pkgs.writeShellScriptBin "delete-btrfs-subvolume" (readFile ./bash/delete-btrfs-subvolume.sh))
    askpass-bin
  ];
}
