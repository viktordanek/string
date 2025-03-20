{
    inputs =
        {
            flake-utils.url = "github:numtide/flake-utils" ;
            nixpkgs.url = "github:NixOs/nixpkgs" ;
        } ;
    outputs =
        { flake-utils , nixpkgs , self } :
            let
                fun =
                    system :
                        let
                            lib = name : value : "--set ${ name } ${ value }" ;
                            pkgs = builtins.import nixpkgs { system = system ; } ;
                            in
                                {
                                    checks =
                                        {
                                            main =
                                                pkgs.stdenv.mkDerivation
                                                    {
                                                        installPhase =
                                                            ''
                                                                ${ pkgs.coreutils }/bin/touch $out &&
                                                                    if [ "${ lib "663d7f24e1a2baf71e0a0546ab5a3cb5b418420b9c08c8ad356adf39b19fb1ca9f282f8b089deb8aa538325786186d36775651d4c123deb4cd260a0d373241b0" "1d168532d8f29f74d54441489e8781899081afbefbeb3d09c0554532472a7bb8d9915eb01e7067512b9a3f9482f2faaa4b99f7e75803cefb781d1cdc26c83202" }" != "--set 663d7f24e1a2baf71e0a0546ab5a3cb5b418420b9c08c8ad356adf39b19fb1ca9f282f8b089deb8aa538325786186d36775651d4c123deb4cd260a0d373241b0 1d168532d8f29f74d54441489e8781899081afbefbeb3d09c0554532472a7bb8d9915eb01e7067512b9a3f9482f2faaa4b99f7e75803cefb781d1cdc26c83202" ]
                                                                    then
                                                                        exit 64
                                                                    fi
                                                            '' ;
                                                        name = "main" ;
                                                        src = ./. ;
                                                    } ;
                                        } ;
                                    lib = lib ;
                                } ;
                in flake-utils.lib.eachDefaultSystem fun ;
}