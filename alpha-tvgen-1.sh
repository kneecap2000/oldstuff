#!/bin/bash

URL="http://willow.doommoo.local/vplayer/tvindex/"
DC="div class"
ANIMEPATH="/local/media2/Video/Anime/"
TVSHOWPATH="/local/media2/Video/TVShows/"
for overview in ${ANIMEPATH} ${TVSHOWPATH}
do
for VSHOWS in $(ls -1 ${overview})
  do
  echo ${VSHOWS}
    if [ -d ${overview}${VSHOWS}/Season*1 ]
	then
#######################################################	Remove and create Show directories
	  if [ -e /var/www/html/vplayer/tvindex/${VSHOWS} ]
	  then
	    rm -rf /var/www/html/vplayer/tvindex/${VSHOWS}
		mkdir /var/www/html/vplayer/tvindex/${VSHOWS}
	  else
	    mkdir /var/www/html/vplayer/tvindex/${VSHOWS}
	  fi
####################################################### Close Show directories
####################################################### Scan Seasons
	  for SEASONS in $(ls -1 ${overview}${VSHOWS})
      do
	    sed s/SERIES/${VSHOWS}/g SERIESTMP.txt > ${VSHOWS}.html
        echo '<${DC}="container">' >> ${VSHOWS}.html
	    printf "\n" >> ${VSHOWS}.html
	    echo '<${DC}="lilbox3">' >> ${VSHOWS}.html
	    echo "<${DC}=img2><img src=\"tvimg/${VSHOWS}-s$(echo $SEASONS | cut -d"-" -f2)-header.png\" width=\"950px\" height=\"450px\" alt=\"${VSHOWS}\" /></div>" >> ${VSHOWS}.html
	    echo '</div>' >> ${VSHOWS}.html
	    printf "\n" >> ${VSHOWS}.html

        for episodes in $(ls -1 ${overview}${VSHOWS}${SEASONS})  ################### Scan Episodes within seasons
		do
		  
		  CUTNAME=$(echo ${VSHOWS}| cut -d\. -f1| tr -t \- " ")
		  sed s/EPNAME/${episodes}/g SERIESTMP.txt >${VSHOWS}/${episodes}.html
		  sed -i s/SNAME/${CUTNAME}/g ${VSHOWS}/${episodes}.html
		  
		  printf "<${DC}=\"bucket\">\n<a href=\"${URL}${VSHOWS}/${SEASONS}/${episodes}\">\n<${DC}=\"img\"><img src=\"images/play.png\" width=\"100px\" height=\"100px\" alt=\"${CUTNAME}\"></div>\n${episodes}\n</a>\n</div>">> ${VSHOWS}.html

          printf "\n\n" >> ${VSHOWS}.html
		done  ######### Close Episodes
	  done  ########### Close Seasons
	else
	  for episodes in $(ls -1 ${overview}/${VSHOWS})
	  do
		  
		CUTNAME=$(echo ${VSHOWS}| cut -d\. -f1| tr -t \- " ")
		sed s/EPNAME/${episodes}/g SERIESTMP.txt >${VSHOWS}/${episodes}.html
		sed -i s/SNAME/${CUTNAME}/g ${VSHOWS}/${episodes}.html
		
		printf "<${DC}=\"bucket\">\n<a href=\"${URL}${VSHOWS}/${episodes}\">\n<${DC}=\"img\"><img src=\"images/play.png\" width=\"100px\" height=\"100px\" alt=\"${CUTNAME}\"></div>\n${episodes}\n</a>\n</div>">> ${VSHOWS}.html

        printf "\n\n" >> ${VSHOWS}.html
      done
	fi
  done
done
chown -R clouser:media /var/www/html/vplayer/tvindex/
chmod -R 775 /var/www/html/vplayer/tvindex/

echo '</body>' >> $2.html
echo '</html>' >> $2.html
