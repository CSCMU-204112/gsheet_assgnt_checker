#!/bin/bash

sec="Sec005"
fileGlob="5????????_gform.doc*"
assgn="Lab04"
hwdirMain="$HOME/homework/"
class="204100"
duedate="20131209"
emailAdd="kittipitch+204100@gmail.com,arttaniti.s@gmail.com"
#emailAdd="kittipitch+204100@gmail.com"
ftpHost='hw.cs.science.cmu.ac.th'
ftpUser='hw204100'
ftpPasswd='hw0041@c$'

#calling the main script by sourcing so that the variables are passed to the main script
. ~kittipitch/scripts/hwCronGForm.sh


