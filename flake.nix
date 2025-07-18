{
  description = "A development environment for Zig";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "zig-dev-shell";

          buildInputs = [
            pkgs.zig       # The Zig compiler and toolchain
            pkgs.zls       # The official Zig Language Server
            pkgs.gdb       # The GNU Debugger
            pkgs.pkg-config # Manages library compile flags
          ];

          # Optional: Commands to run when the shell is activated
          # shellHook = ''
          #   echo "🚀 Entered Zig development environment."
          #   zig version
          # '';
        };
      });
}