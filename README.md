# Slab PCB

[![Nix Flake](https://img.shields.io/badge/NIX%20FLAKE-5277C3.svg?logo=NixOS&logoColor=white)](https://nixos.org)

The full PCB, schematics, and gerber downloads for the [Slab keyboard project](https://github.com/headblockhead/slab).

Downloads are in the releases section.

## Layers

- The layer `User.3` stores non-polygon versions of the silkscreen text elements that can be edited.
- The layer `User.6` stores a printable outline of keyswitch locations, so a keymap can be drawn on paper to test the layout.

## Building

This project uses [Nix](https://nixos.org) for CI/CD only, to generate gerber files using KiCAD's CLI.

## Sponsorship

The PCB prototypes for this version of the Slab keyboard project were kindly provided by [PCBX](https://link.pcbx.com/fddd) for free!
