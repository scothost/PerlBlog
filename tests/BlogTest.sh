#!/bin/bash

RES=$(/bin/perl ./BlogTest.pm | cut -c1) 

if [ $RES == 0 ]; then
   exit 0
fi

if [ $RES == 1 ]; then
  exit 1
fi

exit 1
