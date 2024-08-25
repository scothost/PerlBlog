#!/bin/bash

RES=$(/bin/perl /var/www/html/perl/tests/BlogTest.pm | cut -c1) 
cat /var/www/html/perl/x
if [ $RES == 0 ]; then
   exit 0
fi

if [ $RES == 1 ]; then
  exit 1
fi

