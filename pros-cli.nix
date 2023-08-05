{ lib
, callPackage
, buildPythonApplication
, fetchFromGitHub
, fetchFromGitLab
, fetchPypi
, click
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
  version = "da40202739658f54c64c3d5a1d284e8896a0c71c";

  src = fetchFromGitHub {
    owner = "purduesigbots";
    repo = "pros-cli";
    rev = "${version}";
    hash = "sha256-Idgraf6F1d1P9ZZZjRZxUtVH4ZBzphAAnMvV8cR+D7s=";
  };

  patches = [
    #./patches/pyinstaller.patch
    #./patches/dependencies.patch
    ./patches/version.patch
  ];

  doCheck = false;

  # Relax some dependencies
  postPatch = ''
    substituteInPlace requirements.txt \
      --replace 'scan-build==2.0.13' 'scan-build' \
      --replace 'pypng==0.0.20' 'pypng' \
      --replace 'pyinstaller' ' ' \
      --replace 'click>=6,<7' 'click' \
  '';


  propagatedBuildInputs =
    let
      cobs = callPackage ./cobs.nix { };
      scan-build = callPackage ./scan-build.nix { };
      observable = callPackage ./observable.nix { };
    in
    [
      click # >=6,<7
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
