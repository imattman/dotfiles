#!/bin/bash

THIS_SCRIPT=$(basename "$0")
THIS_DIR=$(dirname "$0")
BASE_DIR=$(cd "$THIS_DIR" && pwd)

INSTALL_CPU_FREQ=1
USE_SNAP=
WIFI_POWER_CONF='/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf'


tlp() {
  echo "Installing TLP..."
  if [[ $(which apt) ]]; then
    sudo apt install -y  tlp
  elif [[ $(which dnf) ]]; then
    sudo dnf install -y tlp
  fi

  echo "Enabling TLP with systemd..."
  sudo systemctl enable --now tlp
  sudo systemctl status --no-pager tlp
}


cpufreq() {
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
}


wifi() {
  # see: https://unix.stackexchange.com/questions/269661/how-to-turn-off-wireless-power-management-permanently
  [[ ! -e "$WIFI_POWER_CONF" ]] && return

  echo "Updating $WIFI_POWER_CONF ..."
  echo
  echo "  [connection]"
  echo "  wifi.powersave = 2"

  sudo perl -i -pe 's/(wifi.powersave\s*=)\s*\d+/\1 2/' $WIFI_POWER_CONF
}


if [[ $# -eq 0 ]]; then
  tlp
  wifi

  if [[ -n "$INSTALL_CPU_FREQ" ]]; then
    cpufreq
  else
    echo "Auto-cpufreq not installed. Set up with:"
    echo "  $0 cpufreq"
  fi
else
  $@
fi

echo
echo "reboot required."



