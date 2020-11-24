#!/bin/bash
# SCRIPT:   decrypt-pdf.sh
# AUTHOR:   Giovanni Tommasini <tommasini.giovanni@gmail.com>
# DATE:     2020-11-24
# REV:      1.0.P (Valid are A, B, D, T and P)
#               (For Alpha, Beta, Dev, Test and Production)
#
# PURPOSE:  this script use `qpdf` to decrypt your pdf
#
# set -n   # Uncomment to check your syntax, without execution.
#          # NOTE: Do not forget to put the comment back in or
#          #       the shell script will not execute!
# set -x   # Uncomment to debug this shell script (Korn shell only)
#
set -e   # Uncomment to: it should exit the script if any statement returns a non-true return value

PASSWORD=${1}
FILE=${2}

display_usage() { 
    echo "This script must be run giving password and file(s) to decrypt" 
    echo -e "\nUsage: ${0} password file.pdf\n" 
}

# if less than two arguments supplied, display usage 
if [ -z ${FILE} ] || [ -z ${PASSWORD} ] 
then 
    display_usage
    exit 1
fi

for f in ${FILE}
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  qpdf -password=${PASSWORD} -decrypt $f decrypt_$f
done