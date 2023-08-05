{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem =
        { config
        , self'
        , inputs'
        , pkgs
        , system
        , ...
        }: {
          packages.default = pkgs.python310Packages.callPackage ./pros-cli.nix { };
          packages.pros-cli = pkgs.python310Packages.callPackage ./pros-cli.nix { };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              hello
            ];
          };
        };

      flake = {
        templates = {
          default = {
            path = ./template;
            description = "basic dev environment for pros";
          };
        };
      };
    };
}
