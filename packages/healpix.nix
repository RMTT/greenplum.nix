{ pkg-config, chrpath, zlib, cfitsio, stdenv }:
let
  version = "3.82";
  sharpsrc = fetchTarball {
    url = "https://sourceforge.net/projects/healpix/files/Healpix_${version}/Healpix_3.82_2022Jul28.tar.gz";
    sha256 = "1g7490yfaj60xnlv4v4ah5zmvi4ncj7nf5zrhpjf83ncw9b6ihqm";
  };
  src = fetchTarball {
    url = "https://sourceforge.net/projects/healpix/files/Healpix_${version}/healpix_cxx-3.82.0.tar.gz";
    sha256 = "0bmhlzfnkxsnc6gixfxmhg7gf0vl2m2q2wakcllvpd6vzi9xjzhd";
  };


  libsharp = stdenv.mkDerivation {
    pname = "libsharp";
    version = version;
    system = builtins.currentSystem;
    src = sharpsrc;
    configureFlags = [ "--auto=sharp" ];
    dontAddPrefix = true;
    installPhase = ''
      			mkdir -p $out
          	cp -r lib $out
          	cp -r include $out
      			'';
  };
in
stdenv.mkDerivation {
  pname = "healpix";
  version = version;
  system = builtins.currentSystem;
  src = src;
  buildInputs = [ cfitsio pkg-config zlib chrpath libsharp ];
  FITSDIR = "${cfitsio}/lib";
  FITSINC = "${cfitsio}/include";
}
