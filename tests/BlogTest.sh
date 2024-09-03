#!/bin/bash

RES=$(/bin/perl ./BlogTest.pm | cut -c1) 
ERR=1

if [ $RES == 0 ]; then
   $ERR = 0;
fi
#echo $RES
exit $RES
