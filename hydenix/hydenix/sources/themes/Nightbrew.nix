{ pkgs, mkTheme }:
mkTheme rec {
  name = "Nightbrew";
  src = pkgs.fetchFromGitHub {
    owner = "jackpawlik1";
    repo = "Nightbrew";
    rev = "main";
    name = name;
    sha256 = "sha256-L+AogaJS7JRxFvDF6QtvsjGazuqDYPh12AlSy+eu6CI=";
  };
  meta = {
    name = name;
    description = "HyDE Theme: Nightbrew";
    homepage = "https://github.com/jackpawlik1/Nightbrew";
    priority = 100;
  };
}
