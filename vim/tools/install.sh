set -e

hash git >/dev/null 2>&1 && env git clone --depth=1 https://github.com/koara-local/dotvim.git ${HOME}/dotvim || {
  echo "git not installed"
  exit
}

${HOME}/dotvim/setup.sh
