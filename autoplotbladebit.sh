#!/bin/bash
contract_key=
farmer_key=
while :
do
        totalplot=$(ls -lR /root/plots/*.plot 2>/dev/null | wc -l)
    core=$(lscpu | egrep '^CPU\(s\):' | awk -v FS=: '{print $2}' | tr -d '[:blank:]' )
    (( core = $core - 2 ))

        if [[ totalplot -le 7 ]]
                then
                        echo "mulai plotting"
                        /root/bladebit -t $core -n 1 -f $farmer_key -c $contract_key /root/plots/
                        sleep 10
                else
                        sleep 10
                        echo "tidur dulu"
        fi
done