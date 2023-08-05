{
  lib,
  buildPythonApplication,
  fetchPypi,
  pytest,
}:
buildPythonApplication rec {
  pname = "observable";
  version = "1.0.3";
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-l/6OnYwqYYXO42YfpfupzjjHujiIlBMpQM1qgWM2Jtk=";
  };
  # no tests in archive

  propagatedBuildInputs = [
    pytest
  ];
  docheck = false;
}
