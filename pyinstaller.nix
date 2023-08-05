{
  buildPythonApplication,
  fetchPypi,
  zlib,
  keyring,
  future,
  django,
}:
buildPythonApplication rec {
  pname = "pyinstaller";
  version = "5.7.0";
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-DllTk3018LN1Q8xpFdrK8yOby98/0+y7eGZkVGihZ3U=";
  };

  buildInputs = let
    pyinstaller-hooks-contrib = buildPythonApplication rec {
      pname = "pyinstaller-hooks-contrib";
      version = "2022.15";
      src = fetchPypi {
        inherit pname version;
        hash = "sha256-c/1AUdwWIPOulkMpHNni9Hv+1YKt4usF4yR+yrSk9fM=";
      };
    };

    altgraph = buildPythonApplication rec {
      pname = "altgraph";
      version = "0.17.3";
      src = fetchPypi {
        inherit pname version;
        hash = "sha256-rTM1gRTffJQWzbj6HqpYUhZsUFEYcXAhxqjHx6u9A90=";
      };
    };
  in [
    zlib
    pyinstaller-hooks-contrib
    altgraph
    keyring
    future
    django
  ];
  # no tests in archive
  docheck = false;
}
