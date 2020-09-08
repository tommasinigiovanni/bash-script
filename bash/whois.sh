#!/bin/bash
# SCRIPT:   whois.sh
# AUTHOR:   Giovanni Tommasini <tommasini.giovanni@gmail.com>
# DATE:     2020-09-08
# REV:      1.0.P (Valid are A, B, D, T and P)
#               (For Alpha, Beta, Dev, Test and Production)
#
# PURPOSE:  this script read a txt file with a public IP list and
#           show you the Name of the organization who manage that IP.
#
# set -n   # Uncomment to check your syntax, without execution.
#          # NOTE: Do not forget to put the comment back in or
#          #       the shell script will not execute!
# set -x   # Uncomment to debug this shell script (Korn shell only)
#
set -e   # Uncomment to: it should exit the script if any statement returns a non-true return value

input=${1}

display_usage() { 
    echo "This script must be run point to the txt or csv file where to read the IP list." 
    echo -e "\nUsage:${0} file.txt\n" 
}

# if less than two arguments supplied, display usage 
if [ -z ${input} ] 
then 
    display_usage
    exit 1
fi

# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $# == "--help") ||  $# == "-h" ]]
then
    display_usage
    exit 0
fi

while IFS= read -r line
do
    name=$(whois ${line} | grep -m 1 'OrgTechName' | awk '{print $2}')
    if [ -z "${name}" ]
    then
        # echo -e "\r${line}   $(whois $line | grep -m 1 'mnt-by' | awk '{print $2}')"
        echo -e "\r${line}    $(whois $line | grep -m 1 'netname' | awk '{print $2}')"
    else
        echo -e "\r${line}    $(whois ${line} | grep -m 1 'OrgTechName' | awk '{print $2}')"
    fi
done < "$input"