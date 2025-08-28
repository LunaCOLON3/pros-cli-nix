{ lib
, callPackage
, buildPythonApplication
, fetchFromGitHub
, click
, rich-click
, pyserial
, cachetools
, requests
, requests-futures
, tabulate
, jsonpickle
, semantic-version
, colorama
, pyzmq
, sentry-sdk
, pypng
, setuptools
, installShellFiles
}:
buildPythonApplication rec {
  pname = "pros-cli";
  version = "a075f9455ef9f738fc806f963ec678238998348a";

  src = fetchFromGitHub {
    owner = "purduesigbots";
    repo = "pros-cli";
    rev = "${version}";
    hash = "sha256-cEtF2W7T2uit4SWvQe/bFHyrzyP/rAEyKHcDlFjZGik=";
  };

  doCheck = false;
  pyproject = true;
  build-system = [setuptools];

  patches = [ ./version.patch ];

  # Relax some dependencies
  postPatch =
    ''
      substituteInPlace requirements.txt \
        --replace 'scan-build==2.0.13' 'scan-build' \
        --replace 'pyinstaller' ' ' \
        --replace 'pypng==0.0.20' 'pypng' \
    '';

  propagatedBuildInputs =
    let
      cobs = callPackage ./cobs.nix { };
      scan-build = callPackage ./scan-build.nix { };
      observable = callPackage ./observable.nix { };
    in
    [
      click # >=6,<7
      rich-click
      pyserial
      cachetools
      requests
      requests-futures
      tabulate
      jsonpickle
      semantic-version
      colorama
      pyzmq
      cobs
      scan-build # ==2.0.13
      sentry-sdk
      observable
      pypng # ==0.0.20
      setuptools
    ];

  meta = with lib; {
    description = "Command Line Interface for managing PROS projects. Works with V5 and the Cortex ";
    homepage = "https://github.com/purduesigbots/pros-cli";
    license = licenses.mpl20;
    maintainers = with maintainers; [ BattleCh1cken ];
  };
}
