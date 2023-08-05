{
  lib,
  buildPythonApplication,
  fetchPypi,
}:
buildPythonApplication rec {
  pname = "cobs";
  version = "1.2.0";
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-2TsQtTcNyIaJYK77cK2x9zpOYQexaRgwekru79PtuPY=";
  };
  # no tests in archive
  docheck = false;
}
