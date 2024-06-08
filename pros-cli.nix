{ lib
, callPackage
, buildPythonApplication
, fetchFromGitHub
, fetchFromGitLab
, fetchPypi
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
,
}:
buildPythonApplication rec {
  pname = "pros-cli";
  version = "3.5.4";

  src = fetchFromGitHub {
    owner = "purduesigbots";
    repo = "pros-cli";
    rev = "${version}";
    hash = "sha256-1RnJd5k8vW2uuyIPCKq+MkQ35sKYuTs5xgidD4Su0mM=";
  };

  doCheck = false;

  # Relax some dependencies
  postPatch = ''
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
    ];

  meta = with lib; {
    description = "Command Line Interface for managing PROS projects. Works with V5 and the Cortex ";
    homepage = "https://github.com/purduesigbots/pros-cli";
    license = licenses.mpl20;
    maintainers = with maintainers; [ BattleCh1cken ];
  };
}
