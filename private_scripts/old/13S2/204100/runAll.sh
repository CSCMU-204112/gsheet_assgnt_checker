#!/bin/bash
find . | grep sec | grep -iv '~' | sort > tempRun.sh
chmod +x tempRun.sh
./tempRun.sh
rm tempRun.sh
