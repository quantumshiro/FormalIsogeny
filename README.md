# FormalIsogeny

Lean 4 + mathlib project managed with Nix flakes.

## Setup

```sh
nix develop
lake update
lake exe cache get
lake build
```

Lean and mathlib are both pinned to the stable release `v4.33.0`, and Nixpkgs
is pinned to the stable `nixos-26.05` branch. The first `nix develop` installs
the pinned Lean toolchain into the project-local `.elan` directory.
