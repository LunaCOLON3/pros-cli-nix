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
}:
buildPythonApplication rec {
  pname = "pros-cli";
  version = "3.5.4";

  src = fetchFromGitHub {
    owner = "purduesigbots";
    repo = "pros-cli";
    rev = "${version}";
    hash = "sha256-za7XBPn8inWyGinTUW1Kqs3711jgpGzmGj4ierynPkA=";
  };

  doCheck = false;

  patches = [ ./version.patch ];

  # Relax some dependencies
  postPatch =
    ''
      echo  "version = '3.5.4'" >> _constants.py

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
