{
  description = "Nix dev shell for My C/C++ Project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs, ... }: let
    devShellFor = system: let
      pkgs = import nixpkgs { inherit system; };
    in pkgs.mkShell rec {
      buildInputs = [
        pkgs.gcc
        pkgs.meson
        pkgs.mold
        pkgs.samurai
        pkgs.pkgconf
        pkgs.zlib
        pkgs.libGLU
        pkgs.glfw
      ];

      shellHook = ''
        export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath buildInputs}:$LD_LIBRARY_PATH"
        export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib.outPath}/lib:$LD_LIBRARY_PATH"     
        echo "==> Entered dev shell"
      '';
    };

  in {
    devShells = {
      x86_64-linux.default = devShellFor "x86_64-linux";
    };
  };
}
