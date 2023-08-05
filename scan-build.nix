{
  lib,
  buildPythonApplication,
  fetchPypi,
}:
buildPythonApplication rec {
  pname = "scan-build";
  version = "2.0.20";
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-8fnx3D2vkG7xBgd9usTYcvV0CEMXPcdAcO87Odo9Dwc=";
  };
  # no tests in archive
  docheck = false;
}
