#!/bin/bash
#
# SCRIPT:   convert-wav2mp3.sh
# AUTHOR:   Giovanni Tommasini <tommasini.giovanni@gmail.com>
# DATE:     2016-09-15
# REV:      1.0.P (Valid are A, B, D, T and P)
#               (For Alpha, Beta, Dev, Test and Production)
#
# PURPOSE:  this script create a folder named with the today date in format YYY-MM-DD
#           convert the file from wav to mp3 format and save the file in che sub folder 
#               avconv -i input.wav -acodec libmp3lame -ab 128k cartella/output.mp3
#           after this, if the conversion is consistent, remove the wav file
#
# set -n   # Uncomment to check your syntax, without execution.
#          # NOTE: Do not forget to put the comment back in or
#          #       the shell script will not execute!
# set -x   # Uncomment to debug this shell script (Korn shell only)
#
set -e   # Uncomment to: it should exit the script if any statement returns a non-true return value

data=$(date '+%Y%m%d');
folder="/var/spool/asterisk/monitor";

echo "--- e_conversione START ---" >> /tmp/"$data-convert-wav2mp3";

if mkdir "$folder"/"$data"; then
    echo "mkdir folder $folder/$data: OK"  >> /tmp/"$data-convert-wav2mp3";
else
    echo "mkdir folder $folder/$data: FAIL" >> /tmp/"$data-convert-wav2mp3";
    exit 1;
fi

if cd $folder; then
    echo "cd in forlder $folder: OK"  >> /tmp/"$data-convert-wav2mp3";
else
    echo "cd in forder $folder: FAIL"  >> /tmp/"$data-convert-wav2mp3";
    exit 1;
fi

for i in $data*.wav; do 
    if avconv -i "$i" -acodec libmp3lame "$data"/"${i%%???}"mp3 > /dev/null 2>&1; then
        rm "$i";
        echo "avconv transcod in MP3 $i: OK"  >> "$data-convert-wav2mp3";
    else
        echo "avconv transcod in MP3 $i: ERROR"  >> "$data-convert-wav2mp3";
        exit 1;
    fi
done

echo "--- e_conversione END ---" >> "$data-convert-wav2mp3";
exit 0;