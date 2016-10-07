#!/bin/bash

if [[ -z `rpm -qa multitail` ]]; then
    echo "multitail is not installed"
    echo "yum install multitail"
    echo "or"
    echo "yum install ftp://fr2.rpmfind.net/linux/epel/7/x86_64/m/multitail-6.4.2-1.el7.x86_64.rpm"
    exit 1
fi

if [[ -z $1 ]]; then
    echo "Enter a regex for the nodes you want monitor to."
    echo "For example: ./ssh-overcloud.sh compute-0"
    echo "             ./ssh-overcloud.sh control"
    echo "             ./ssh-overcloud.sh overcloud"
    exit 1
fi

rm ~/.ssh/known_hosts 2&> /dev/null

declare -a IP_LIST
IP_LIST=$(nova list | grep $1 | cut -d '|' -f 7 | cut -d '=' -f 2)

for IP in $IP_LIST; do
    cmd+="-l \"ssh -oStrictHostKeyChecking=no heat-admin@$IP sudo journalctl -u os-collect-config -u yum -f\" "
done

cmd="multitail $cmd"
echo $cmd > /tmp/multitail_cmd

bash /tmp/multitail_cmd
