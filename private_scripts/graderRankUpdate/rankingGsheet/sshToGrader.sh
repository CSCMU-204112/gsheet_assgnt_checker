#!/bin/bash

/usr/bin/screen -S manualGraderConnect -d -m /bin/bash -c '/usr/bin/ssh -L 8889:127.0.0.1:8889 grader@10.10.10.175'
