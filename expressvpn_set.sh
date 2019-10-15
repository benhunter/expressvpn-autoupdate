#!/bin/bash

# Download and install Expressvpn client for Ubuntu x64
# https://www.expressvpn.com/support/vpn-setup/app-for-linux/#install
# https://www.expressvpn.com/support/vpn-setup/pgp-for-linux/

URL="https://download.expressvpn.xyz/clients/linux/"
CLIENT="expressvpn_1.5.1_amd64.deb"
CLIENT_SIG="expressvpn_1.5.1_amd64.deb.asc"

# Download client and signature if it doesn't exist already
[ ! -e $CLIENT ] && curl -O $URL$CLIENT
[ ! -e $CLIENT_SIG ] && curl -O $URL$CLIENT_SIG

# Verify signature
# 1. Download PGP key
gpg --keyserver x-hkp://pool.sks-keyservers.net --recv-keys 0xAFF2A1415F6A3A38
# https://www.expressvpn.com/expressvpn_release_public_key_0xAFF2A1415F6A3A38.asc
# gpg --import expressvpn_release_public_key_0xAFF2A1415F6A3A38.asc

# Install client
sudo dpkg -i $CLIENT

# Activate - needs activation code
expressvpn activate

# Connect
expressvpn status
expressvpn connect us
expressvpn status
