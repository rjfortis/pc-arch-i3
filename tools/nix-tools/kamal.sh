#!/bin/bash
set -euo pipefail

nix profile add nixpkgs#kamal

# It's not necessary: nixpkgs#ruby
# nix profile add nixpkgs#ruby nixpkgs#kamal
