{
  description = "Tools for developing and building interchange-pcb";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        rec {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              xc
              kicad
            ];
          };
          packages.interchange-pcb = pkgs.stdenv.mkDerivation {
            name = "interchange-pcb";
            src = ./.;

            nativeBuildInputs = with pkgs; [
              kicad-small # (Without 3D-models)
              p7zip
            ];
            buildPhase = ''
              runHook preBuild
              mkdir -p left
              mkdir -p right
              mkdir -p hackpad
              export HOME=$PWD # KiCAD creates config files in $HOME
              #kicad-cli pcb export gerbers -o left --layers "F.Cu,B.Cu,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,F.Mask,B.Mask,Edge.Cuts" --no-protel-ext --subtract-soldermask ./interchange-pcb-left/interchange-pcb-left.kicad_pcb
              #kicad-cli pcb export drill -o left --excellon-separate-th --excellon-units "in" ./interchange-pcb-left/interchange-pcb-left.kicad_pcb
              kicad-cli pcb export gerbers -o right --layers "F.Cu,B.Cu,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,F.Mask,B.Mask,Edge.Cuts" --no-protel-ext --subtract-soldermask ./interchange-pcb-right/interchange-pcb-right.kicad_pcb
              kicad-cli pcb export drill -o right --excellon-separate-th --excellon-units "in" ./interchange-pcb-right/interchange-pcb-right.kicad_pcb
              #kicad-cli pcb export gerbers -o hackpad --layers "F.Cu,B.Cu,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,F.Mask,B.Mask,Edge.Cuts" --no-protel-ext --subtract-soldermask ./interchange-pcb-hackpad/interchange-pcb-hackpad.kicad_pcb
              #kicad-cli pcb export drill -o hackpad --excellon-separate-th --excellon-units "in" ./interchange-pcb-hackpad/interchange-pcb-hackpad.kicad_pcb
              runHook postBuild
            '';
            installPhase = ''
              runHook preInstall
              mkdir -p $out
              cp -r left $out
              cp -r right $out
              cp -r hackpad $out
              runHook postInstall
            '';
          };
          packages.default = packages.interchange-pcb;
        }
      );
}

