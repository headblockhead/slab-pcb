{
  description = "Tools for developing and building slab-pcb";
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
          packages.slab-pcb = pkgs.stdenv.mkDerivation {
            name = "slab-pcb";
            src = ./.;

            nativeBuildInputs = with pkgs; [
              kicad
              p7zip
            ];
            buildPhase = ''
              runHook preBuild
              mkdir -p left
              mkdir -p right
              mkdir -p hackpad
              kicad-cli pcb export gerbers -o left --layers "F.Cu,B.Cu,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,F.Mask,B.Mask,Edge.Cuts" --no-protel-ext --subtract-soldermask ./slab-pcb-left/slab-pcb-left.kicad_pcb
              kicad-cli pcb export drill -o left --excellon-separate-th --excellon-units "in" ./slab-pcb-left/slab-pcb-left.kicad_pcb
              kicad-cli pcb export gerbers -o right --layers "F.Cu,B.Cu,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,F.Mask,B.Mask,Edge.Cuts" --no-protel-ext --subtract-soldermask ./slab-pcb-right/slab-pcb-right.kicad_pcb
              kicad-cli pcb export drill -o right --excellon-separate-th --excellon-units "in" ./slab-pcb-right/slab-pcb-right.kicad_pcb
              kicad-cli pcb export gerbers -o hackpad --layers "F.Cu,B.Cu,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,F.Mask,B.Mask,Edge.Cuts" --no-protel-ext --subtract-soldermask ./slab-pcb-hackpad/slab-pcb-hackpad.kicad_pcb
              kicad-cli pcb export drill -o hackpad --excellon-separate-th --excellon-units "in" ./slab-pcb-hackpad/slab-pcb-hackpad.kicad_pcb
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
          packages.default = packages.slab-pcb;
        }
      );
}

