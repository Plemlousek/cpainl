#!/bin/env bash

############################################################################
# script to quickly copy VPN files into /etc/openvpn and enable systemd
# service; to avoid NetworkManager shortcoming w/autoconnect
#  and Gnome-keyring.
############################################################################

# Enable debugging
set -vx

USAGE="Usage: `basename $0` <dirWithVPNconfFiles>"

# Test for parameters
if [[ -z $1 ]]
then
  echo $USAGE
  exit 1;
fi

# clientfile=$1/*.ovpn

syswideconfig=/etc/openvpn
[[ -d $syswideconfig ]] || echo "Is openvpn installed on your system?"  # check openvpn installed

clientdir="$1"
cp -r $clientdir/* $syswideconfig

# conffile=$syswideconfig/*.ovpn

conffile=$syswideconfig/*.conf
# servicefile=echo "`cut -d/ -f4 $conffile |cut -f1`"
servicefile=`ls -a /etc/openvpn/*.conf |cut -d/ -f4 |cut -d. -f1`
# ss22=echo "$servicefile"

# for f in `find $syswideconfig -iname '*.conf' -o -iname '*.ovpn' -type f`
# do
  # echo $f
# servicename="openvpn@$ss22'.service"
servicename="openvpn@$servicefile.service"
sleep 1
/bin/sysctemctl enable $servicename
# done

# if [[ -f $conffile ]]
# then
  # systemctl enable openvpn@$servicefile.service
# fi

exit

