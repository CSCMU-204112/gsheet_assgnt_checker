#!/bin/bash

/usr/bin/screen -S secureGraderConnection -d -m /bin/bash -c '/usr/bin/ssh -L 8889:127.0.0.1:8889 grader@10.10.10.175'

sleep 10
/bin/date >> /home/kittipitch/ranking_update.log
/home/kittipitch/private_scripts/graderRankUpdate/rankingGsheet/updateRanking.sh >> /home/kittipitch/ranking_update.log

sleep 10
/usr/bin/screen -ls | grep Detached | grep secureGraderConnection | /usr/bin/awk -F'.' '{print $1}' | /usr/bin/xargs kill
