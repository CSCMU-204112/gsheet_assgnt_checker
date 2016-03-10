#!/bin/bash
# this works w/ zip file only
# the script unzip and rename the file inside the folder w/ the name of the folder
# write the extension of each file into the extList
extList="doc docx"
numZip=0
numFile=0
rm unzip.log
for zip in *.zip ; do


	((numZip++))
	dir=`echo ${zip%.zip} | sed -e 's/.zip//g'`
	
	if [ ! -e $dir ]
	then
		mkdir "$dir"
	fi
	echo $dir
    unzip -od "$dir" "$zip" >> unzip.log
	
	for ext in $extList; do
#		echo $ext;
		if [ -e  $dir/*.$ext  ]
		then
			mv $dir/*.$ext $dir.$ext
			((numFile++))
		fi
	done
#if the directory is empty then remove it, if not, there's some problem
	if [ "$(ls -A $dir 2> /dev/null)" == "" ]; 
	then
		rm -r "$dir"
	fi
done

echo "Sucessfully unzip "$numFile" from total of "$numZip" archive. Check unzip.log for detail"
