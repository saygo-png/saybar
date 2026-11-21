{ mkDerivation, base, bytestring, containers, criterion, fcft
, hs-bindgen-runtime, JuicyPixels, lib, network, pixman, relude
, sayland, time, typed-process, unix, vector
}:
mkDerivation {
  pname = "saybar";
  version = "0.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  libraryHaskellDepends = [
    base bytestring containers hs-bindgen-runtime JuicyPixels relude
    sayland time typed-process vector
  ];
  libraryPkgconfigDepends = [ fcft pixman ];
  executableHaskellDepends = [
    base bytestring containers JuicyPixels network relude sayland unix
  ];
  executablePkgconfigDepends = [ fcft ];
  benchmarkHaskellDepends = [ base criterion JuicyPixels relude ];
  doHaddock = false;
  homepage = "https://github.com/saygo-png/saybar";
  description = "extensible Wayland bar configured in source";
  license = lib.meta.getLicenseFromSpdxId "GPL-3.0-or-later";
  mainProgram = "saybar";
}
