#!/bin/bash
jsondir="/root/tempjson"
file=""
while true; do
if [ $(ls -1 /root/plots/*.plot -1 2>/dev/null | wc -l) != 0 ];
    then
    touch /root/plots/proses.txt
    function checkplot(){
    ls /root/plots/*.plot -1 | cut -d "/" -f 4 |while read line; do
        cat /root/plots/proses.txt | grep $line >/dev/null;
        if [ $? -ne 0 ]; then
        declare -r file="$(echo $line)"
        #echo $file >> /root/plots/proses.txt
        echo $file
        break ; fi
    done
    }
    file=$(checkplot)
    if [ -z $file ]; then 
        echo "No new Plot, sleep 10 minutes"
        sleep 600
        continue ; 
    else
    filepath="/root/plots/$file"
    echo "mulai copy file $(echo $file | rev | cut -d "-" -f1 | rev | cut -d "." -f1 | tail -c 8) $(date +%m-%d-%T)"
    randcrud=`cat crudlist.txt | shuf -n 1`
    jsonfile="$(echo $file | cut -d "." -f1).json"
    mkdir -p $jsondir
    json_path="$jsondir/$jsonfile"
    curl -s --request GET $randcrud > $json_path
    id=$(cat $json_path | jq -cr '[.[] | select( .status == "kosong")] | .[0]._id')
    if [ $id == null ]; then
    echo "No empty Storj on $randcrud, sleep 10 menit"
    sleep 600
    continue ;
    else
    echo $file >> /root/plots/proses.txt
    json_id="$jsondir/$id.json"
    cat $json_path | jq ".[] | select( ._id == \"$id\" )" > "$json_id"
    urlcrud="$randcrud/$id"
    cat $json_id > $json_path
    cat $json_id  | jq ".status |= \"progress\" | .file |= \"$file\"" > $json_id.temp && mv $json_id.temp $json_id
    sed -i '/_id/d' $json_id
    curl --location --request PUT $urlcrud --header 'Content-Type: application/json' -d @$json_id
    access_key=$(cat $json_id | jq -cr ".access_key")
    secret_key=$(cat $json_id | jq -cr ".secret_key")
    endpoint=$(cat $json_id| jq -cr ".endpoint")
    short_file=$(echo $file | rev | cut -d "-" -f1 | rev | cut -d "." -f1 | tail -c 8)
    screen -dmS upload_$(echo $file | rev | cut -d "-" -f1 | rev | cut -d "." -f1 | tail -c 8) bash ./upload.sh $access_key $secret_key $endpoint $filepath $urlcrud $json_id
    echo "Uploading file \"plot...$short_file.plot\" on Screen session upload_$short_file"
    sleep 60
    fi
    fi
else
        echo "No Plot Available, sleep 10 minutes"
        sleep 600
fi
done
