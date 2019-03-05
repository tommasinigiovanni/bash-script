#!/bin/bash
#
# SCRIPT:   matrix.sh
# AUTHOR:   Giovanni Tommasini <tommasini.giovanni@gmail.com>
# DATE:     2019-03-05
# REV:      1.0.P (Valid are A, B, D, T and P)
#               (For Alpha, Beta, Dev, Test and Production)
#
# PURPOSE:  this script create a Matrix effect on you shell
#
# set -n   # Uncomment to check your syntax, without execution.
#          # NOTE: Do not forget to put the comment back in or
#          #       the shell script will not execute!
# set -x   # Uncomment to debug this shell script (Korn shell only)
#
set -e   # Uncomment to: it should exit the script if any statement returns a non-true return value

echo -e "\033[2J\033[?25l"; R=`tput lines` C=`tput cols`;: $[R--] ; while true
do ( e=echo\ -e s=sleep j=$[RANDOM%C] d=$[RANDOM%R];for i in `eval $e {1..$R}`;
do c=`printf '\\\\0%o' $[RANDOM%57+33]` ### http://bruxy.regnet.cz/web/linux ###
$e "\033[$[i-1];${j}H\033[32m$c\033[$i;${j}H\033[37m"$c; $s 0.1;if [ $i -ge $d ]
then $e "\033[$[i-d];${j}H ";fi;done;for i in `eval $e {$[i-d]..$R}`; #[mat!rix]
do echo -e "\033[$i;${j}f ";$s 0.1;done)& sleep 0.05;done #(c) 2011 -- [ BruXy ]
