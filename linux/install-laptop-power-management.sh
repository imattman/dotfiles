#!/bin/bash

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)


echo "Installing TLP..."
sudo apt install -y  tlp

echo "Enabling TLP with systemd..."
sudo systemctl enable --now tlp


# install auto-cpufreq via SNAP or manually
if [[ -n "$USE_SNAP" ]]; then
  echo "Ensuring snapd is installed..."
  sudo apt install -y snapd

  echo "Installing auto-cpufreq via snap..."
  sudo snap install auto-cpufreq
else
  echo "Downloading auto-cpufreq via git..."
  pushd $WORKSPACE
  git clone https://github.com/AdnanHodzic/auto-cpufreq.git

  echo "Installing auto-cpufreq..."
  cd auto-cpufreq && sudo ./auto-cpufreq-installer
  popd
fi

sudo auto-cpufreq --install

