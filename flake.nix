{
  description = "Reproducible NSF essay: primary sources, Python plots, Typst";
  # Locked to the same revision as Adam's NixOS configuration.
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          python = pkgs.python3.withPackages (p: [
            p.numpy p.pandas p.matplotlib p.pymupdf p.openpyxl
          ]);
        in {
          default = pkgs.mkShellNoCC {
            packages = [ python pkgs.typst pkgs.gnumake ];
            SOURCE_DATE_EPOCH = "1791158400";
            PYTHONNOUSERSITE = "1";
            shellHook = ''
              export TYPST_FONT_PATHS="$PWD/.cache/fonts"
              export MPLCONFIGDIR="$PWD/.cache/matplotlib"
              echo "Run make, or: python analysis/make_figures.py && typst compile main.typ"
            '';
          };
        });
    };
}
