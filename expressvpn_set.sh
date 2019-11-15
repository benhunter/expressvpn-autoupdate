#!/bin/bash

# Download and install Expressvpn client for Ubuntu x64
# https://www.expressvpn.com/support/vpn-setup/app-for-linux/#install
# https://www.expressvpn.com/support/vpn-setup/pgp-for-linux/

URL="https://download.expressvpn.xyz/clients/linux/"
CLIENT="expressvpn_2.3.2-1_amd64.deb"
CLIENT_SIG="expressvpn_2.3.2-1_amd64.deb.asc"

# Download client and signature if it doesn't exist already
[ ! -e $CLIENT ] && wget $URL$CLIENT
[ ! -e $CLIENT_SIG ] && wget $URL$CLIENT_SIG

# Verify signature

if gpg --fingerprint release@expressvpn.com
then
    # fingerprint is 1D0B 09AD 6C93 FEE9 3FDD BD9D AFF2 A141 5F6A 3A38
    echo Fingerprint already added.
else
    # Method 1. Download PGP key
    # TODO only if not already downloaded
    gpg --keyserver x-hkp://pool.sks-keyservers.net --recv-keys 0xAFF2A1415F6A3A38
    # https://www.expressvpn.com/expressvpn_release_public_key_0xAFF2A1415F6A3A38.asc

    # or Method 2:
    # wget https://www.expressvpn.com/expressvpn_release_public_key_0xAFF2A1415F6A3A38.asc
    # gpg --keyid-format long --show-key expressvpn_release_public_key_0xAFF2A1415F6A3A38.asc
    # gpg --import expressvpn_release_public_key_0xAFF2A1415F6A3A38.asc

    gpg --keyserver x-hkp://pool.sks-keyservers.net --recv-keys 0xAFF2A1415F6A3A38
fi


# continue only if signature is valid
if ! gpg --verify $CLIENT_SIG $CLIENT
then
    return 1
fi

# Install client only if not already installed
# TODO if
sudo dpkg -i $CLIENT

# Activate - needs activation code
# TODO activation not required after upgrade
expressvpn activate

# Connect
expressvpn status
expressvpn connect
expressvpn status
