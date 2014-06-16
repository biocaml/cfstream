case "$OCAML_VERSION" in
4.00.1) ppa=avsm/ocaml40+opam11 ;;
4.01.0) ppa=avsm/ocaml41+opam11 ;;
*) echo Unknown $OCAML_VERSION; exit 1 ;;
esac

sudo add-apt-repository -y ppa:$ppa
sudo apt-get update -qq
sudo apt-get install -qq ocaml ocaml-native-compilers camlp4-extra aspcud opam

# configure and view settings
export OPAMYES=1
ocaml -version
opam --version
opam --git-version

# install OCaml packages
opam init 
eval `opam config env`
opam install ocamlfind omake core_kernel

# test this package
omake
omake doc
