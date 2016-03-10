#!/bin/bash


#sudo apt-get update
#sudo apt-get install subversion apache2 libapache2-svn apache2-utils


#sudo mkdir -p /svn/repos/
#sudo htpasswd -b -m /etc/svnpasswd admin p_$$w0rd
#sudo cp ./student_repo.conf /etc/apache2/sites-available/
#sudo cp ./master.acl /svn/student_repo.acl
#sudo a2ensite student_repo
#sudo service apache2 reload

passwd_fileName="svn_user.csv"
acl_path="/svn/"
acl_fileName="student_repo.acl"

cp $acl_path$acl_fileName .

#each line of the csv file should look like this
#user,password

while read line
do

        user=`echo "$line" | awk -F"," '{ print $1}'`
        password_raw=`echo "$line" | awk -F"," '{ print $2}'`

        echo $user $password_raw
        password="$(echo -e "${password_raw}" | tr -d '[[:space:]]')"
        if [[ -n "$user" ]]; then
                sudo htpasswd -b -m /etc/svnpasswd "$user" "$password"
                sudo svnadmin create /svn/repos/"$user"
                sudo chown -R www-data:www-data /svn/repos/"$user"

                echo "[$user:/]" >> $acl_fileName
                echo "admin = r" >> $acl_fileName
                echo "$user = rw" >> $acl_fileName
                echo "* = " >> $acl_fileName
                echo -e "\n" >> $acl_fileName
        fi

done < $passwd_fileName

sudo cp ./"$acl_fileName" "$acl_path$acl_fileName"
sudo service apache2 reload
