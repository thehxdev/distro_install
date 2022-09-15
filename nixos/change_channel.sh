#!/usr/bin/env bash

### Unstable
nix-channel --add https://nixos.org/channels/nixos-unstable nixos

nix-channel --update nixos

nixos-rebuild switch

### 22.05 Stable
#nix-channel --add https://nixos.org/channels/nixos-22.05 nixos

#nix-channel --update nixos

#nixos-rebuild switch
