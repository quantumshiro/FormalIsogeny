{
  description = "Lean 4 + mathlib development environment for FormalIsogeny";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { nixpkgs, ... }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [
              elan
              git
              curl
              zstd
            ];

            shellHook = ''
              export ELAN_HOME="$PWD/.elan"
              export PATH="$ELAN_HOME/bin:$PATH"

              toolchain="$(tr -d '[:space:]' < lean-toolchain)"
              if ! elan toolchain list | grep -Fqx "$toolchain"; then
                echo "Installing Lean toolchain $toolchain ..."
                elan toolchain install "$toolchain"
              fi
              elan override set "$toolchain" >/dev/null
            '';
          };
        });
    };
}
