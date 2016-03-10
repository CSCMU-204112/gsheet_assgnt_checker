#!/bin/bash
# @Author: Kitt K
# @Date:   2016-03-11 00:09:25
# @Last Modified by:   Kitt K
# @Last Modified time: 2016-03-11 00:11:27

sudo apt-get install python3
sudo apt-get install python3-pip
sudo pip3 install virtualenv
virtualenv ./scripts/gfill
./scripts/gfill/bin/pip3 install -r ./scripts/REQUIREMENTS.txt
