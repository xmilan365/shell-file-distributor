#!/bin/bash

####################################################################################################
# Script name:        file_manager.sh
# Description:        "Manages files in download folder to clean files based on extension"
# Arguments:          no arguments
# Author:             xmilan365
####################################################################################################

#find directory you want to clean up
TO_CLEAN_DIR=${HOME}"/Downloads" # directory to clean
TO_SAVE_DIR="${TO_CLEAN_DIR}" # directory to save files currently set as directory that is also cleaned
source config.sh

# check if directories exists, if not create
for DIR in "TABS" "TEXTS" "DATA" "AUDIO" "VIDEO" "IMAGES"  "DATABASES" "EXECUTABLES" "GAMES" "CADS" "GISES" "WEB" "PLUGINS" "FONTS" "SYSTEMS" "SETTINGS" "COMPRESSED" "DISK_IMAGES" "DEV_FILES"; do
	if [[ ! -d "${TO_SAVE_DIR}"/"${DIR}" ]]; then
		mkdir "${TO_SAVE_DIR}"/"${DIR}"
	fi
done


#create for loop
for FILE in "${TO_CLEAN_DIR}"/*; do
	FILE_EXT="${FILE#*.}"
	case "${FILE_EXT}" in
		doc | docx | log | msg | odt | pages | rtf | tex | txt | wpd | wps)
			mv "${FILE}" ${TO_SAVE_DIR}/"TEXTS";;
		csv | dat | ged | key | keychain | ppt | pptx | sdf | tar | tax2016 | tax2020 | vcf | xml)	
			mv "${FILE}" ${TO_SAVE_DIR}/"DATA";;
		aif | iff | m3u | m4a | mid | mp3 | mpa | wav | wma)	
			mv "${FILE}" ${TO_SAVE_DIR}/"AUDIO";;
		3g2 | 3gp | asf | avi | flv | m4v | mov | mp4 | mpg | rm | srt | swf | vob | wmv)	
			mv "${FILE}" ${TO_SAVE_DIR}/"VIDEO";;
		bmp | dds | gif | heic | jpeg | jpg | png | psd | pspimage | tga | thm | tif | tiff | yuv)	
			mv "${FILE}" ${TO_SAVE_DIR}/"IMAGES";;
		ai | eps | svg)	
			mv "${FILE}" ${TO_SAVE_DIR}/"IMAGES";;
		indd | pct | pdf)	
			mv "${FILE}" ${TO_SAVE_DIR}/"TEXTS";;
		xlr | xls | xlsx)	
			mv "${FILE}" ${TO_SAVE_DIR}/"TABS";;
		accdb | db | dbf | mdb | pdb | sql)	
			mv "${FILE}" ${TO_SAVE_DIR}/"DATABASES";;
		apk | app | bat | cgi | com | exe | gadget | jar | wsf)	
			mv "${FILE}" ${TO_SAVE_DIR}/"EXECUTABLES";;
		b | dem | gam | nes | rom | sav)	
			mv "${FILE}" ${TO_SAVE_DIR}/"GAMES";;
		dwg | dxf)	
			mv "${FILE}" ${TO_SAVE_DIR}/"CADS";;
		gpx | kml | kmz)	
			mv "${FILE}" ${TO_SAVE_DIR}/"GISES";;
		asp | aspx | cer | cfm | crdownload | csr | css | dcr | htm | html | js | jsp | php | rss | xhtml)	
			mv "${FILE}" ${TO_SAVE_DIR}/"WEB";;
		crx | plugin)	
			mv "${FILE}" ${TO_SAVE_DIR}/"PLUGINS";;
		fnt | fon | otf | ttf)	
			mv "${FILE}" ${TO_SAVE_DIR}/"FONTS";;
		cab | cpl | cur | deskthemepack | dll | dmp | drv | icns | ico | lnk | sys)
			mv "${FILE}" ${TO_SAVE_DIR}/"SYSTEMS";;
		hqx | mim | uue)
			mv "${FILE}" ${TO_SAVE_DIR}/"SETTINGS";;
		7z | cbr | deb | gz | pkg | rar | rpm | sitx | targz | zip | zipx)	
			mv "${FILE}" ${TO_SAVE_DIR}/"COMPRESSED";;
		bin | cue | dmg | iso | mdf | toast | vcd)	
			mv "${FILE}" ${TO_SAVE_DIR}/"DISK_IMAGES";;
		c | class | cpp | cs | dtd | fla | h | java | lua | m | pl | py | sh | sln | swift | vb | vcxproj | xcodeproj)	
			mv "${FILE}" ${TO_SAVE_DIR}/"DEV_FILES";;
#		bak | tmp | misc files | ics | msi | part | torrent)
#			mv "${FILE}" ${TO_SAVE_DIR}/"BACKUPS";;
#		*) 
#			mv "${FILE}" ${TO_SAVE_DIR}/"OTHER";;
	esac
done

# inform user that the following items will be deleted within two days.
sTime=$(date +%d%H%M)
delete_list=${HOME}"/bin/file_manager/delete_list_"$(date +%Y%m%d%H%M)".log"

if [[ ${sTime} = "81200" ]]; then
	echo -e "Subject: ALERT MONTHLY FILES PURGING\n\nFollowing files will be deleted in two days:\n\n" > "${delete_list}"
	find ${TO_CLEAN_DIR} -type f -mtime +28 >> "${delete_list}"
	ssmtp ${my_email} < "${delete_list}"
fi

# Check if old files should be deleted
if [[ ${sTime} = "101200" ]]; then
	find ${TO_CLEAN_DIR} -type f -mtime +30 -delete
fi


# if directory is empty, we don't need it so remove it and it can be created next time
rmdir "${TO_SAVE_DIR}"/* 2>/dev/null

# do not forget to set the crontab
#*	/10	*	*	*


