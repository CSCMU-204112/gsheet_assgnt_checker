#!/bin/bash
#mailMerge
sec="Sec003"
fileGlob="5*_word2.*"
assgn="Lab06"
hwdirMain="$HOME/homework/"
class="204100"
duedate="20130812"
emailAdd="cjakarin+204100@gmail.com,jantrakas.ch@gmail.com,kittipitch+204100@gmail.com"
ftpHost="hw.cs.science.cmu.ac.th"
ftpUser="hw204100"
ftpPasswd='c$hw204100'

#calling the main script by sourcing so that the variables are passed to the main script
. ~kittipitch/scripts/hwCronMain.sh


