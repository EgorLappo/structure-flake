{
  description = "Structure v2.3.4";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        structure-drv = pkgs.stdenv.mkDerivation
          {
            name = "structure";
            version = "2.3.4";
            src = pkgs.fetchzip {
              url = "https://web.stanford.edu/group/pritchardlab/structure_software/release_versions/v2.3.4/structure_kernel_source.tar.gz";
              hash = "sha256-IR/90aUON68dSrJAAOzEFB1xsIRe28k0EuaMVxFSABg=";
            };

            NIX_CFLAGS_COMPILE = "-fcommon";

            buildPhase = ''
              make
            '';

            installPhase = ''
              mkdir -p $out/bin
              cp -r structure $out/bin
            '';

          };
      in
      rec
      {

        packages.default = structure-drv;

      });
}