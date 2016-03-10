#!/bin/bash


#sudo apt-get update
#sudo apt-get install subversion apache2 libapache2-svn apache2-utils


#sudo mkdir -p /svn/repos/

fileName="svn_user.csv"
#each line of the csv file should look like this
#user,password

while read line
do

        user=`echo "$line" | awk -F"," '{ print $3}'`
        password=`echo "$line" | awk -F"," '{ print $4}'`

        echo $user $password

        ../cms-1.1.0/cmscontrib/AddUser.py -p "$password" "$name" "$lname" "$use
r" -c $contestID

done < $fileName
