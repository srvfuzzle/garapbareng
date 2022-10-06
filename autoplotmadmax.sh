#!/bin/bash
contract_key=
farmer_key=
while :
do
    totalplot=$(ls -lR /root/plots/*.plot 2>/dev/null | wc -l)
    core=$(lscpu | egrep '^CPU\(s\):' | awk -v FS=: '{print $2}' | tr -d '[:blank:]' )

        if [[ totalplot -le 2 ]]
                then
                        echo "mulai plotting"
                        rm -rf /root/temp1/*
                        rm -rf /root/temp2/*
                        /root/madmax/chia_plot -r $core -n 1 -t /root/temp1/ -2 /root/temp2/ -d /root/plots/ -f $farmer_key -c $contract_key
                        sleep 10
                else
                        sleep 10
                        echo "tidur dulu"
        fi
done