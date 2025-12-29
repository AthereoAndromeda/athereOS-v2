{pkgs ? import <nixpkgs> {}}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    vscode-css-languageserver
    dart-sass
  ];

  shellHook = ''
    vscode-css-languageserver --node-ipc &> /dev/null
    echo running
  '';
}
