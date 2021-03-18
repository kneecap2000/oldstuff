#!/bin/bash

series () {
  echo "${dircall} is a series"
  dircound=$(($dircound + 1))
}

video () {
  echo "${dircall} is a video"
  vidcount=$(($vidcount + 1))
}

dircound=0
vidcount=0
cat /var/www/html/vplayer/tvtmp > /var/www/html/vplayer/tvlist.html
rm -rf /var/www/html/vplayer/tvindex/*
cp /var/www/html/vplayer/tvsheet.css /var/www/html/vplayer/tvindex/
cp /var/www/html/vplayer/stylesheet.css /var/www/html/vplayer/tvindex/
ln -s /var/www/html/vplayer/tvimg /var/www/html/vplayer/tvindex/tvimg
for realoranime in $(ls -1d /local/media/video/Anime/* /local/media/video/TVShows/*)
  do
    if [ -d ${realoranime} ]
	  then
	  sed -r s/SERIESCNG/$(echo "${realoranime}" | cut -d\/ -f6)/g /var/www/html/vplayer/seriestemp >> /var/www/html/vplayer/tvlist.html
	fi
    series
        for dircall in $(ls -1 ${realoranime})
          do
            if [ -d ${realoranime}/${dircall} ]
              then
			  echo "The Series is called $(echo "${realoranime}" | cut -d\/ -f6)"
#			  if [ -d /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6) ]
#			  then
#			    rm -rf /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)
#			  fi
			  mkdir /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)
			  cat /var/www/html/vplayer/tvtmp > /var/www/html/vplayer/tvindex/${dircall}.html
                for subdircall in $(ls -1 ${realoranime}/${dircall})
                  do
                    if [ -f ${realoranime}/${dircall}/${subdircall} ]
                      then
						  sed s/EPI/$(echo "${subdircall}"|cut -d. -f1)/g /var/www/html/vplayer/sertmp >> /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6).html
						  mkdir /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/${dircall}
						  ln -sf ${realoranime}/${dircall}/ /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/${dircall}/video
							if [ -f /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/${dircall}/$(echo "${subdircall}"|cut -d. -f1).html ]
							  then
							    rm /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/${dircall}/$(echo "${subdircall}"|cut -d. -f1).html
							fi
							echo "${subdircall} CHECK ME I'M IMPORTANT!"
						    cp /var/www/html/vplayer/tvtemplate.html /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/${dircall}/$(echo "${subdircall}"|cut -d. -f1).html
							sed -i s/EPNAME/${subdircall}/g /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/${dircall}/$(echo "${subdircall}"|cut -d. -f1).html
							sed -i s/SNAME/${dircall}/g /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/${dircall}/$(echo "${subdircall}"|cut -d. -f1).html
							sed -i s/SER/$(echo "${realoranime}" | cut -d\/ -f6)/g /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6).html
							sed -i s/MER/$(echo "${dircall}")/g /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6).html
                      else
                          echo "no idea what ${realoranime}/${dircall}/${subdircall} is"
                      fi
                  done
            elif [ -f ${realoranime}/${dircall} ]
              then
                sed s/EPI/$(echo "${dircall}"|cut -d. -f1)/g /var/www/html/vplayer/sirtmp >> /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6).html
				mkdir /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)
				ln -sf ${realoranime} /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/video
				if [ -f /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/$(echo "${dircall}"|cut -d. -f1).html ]
					then
						rm /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/$(echo "${dircall}"|cut -d. -f1).html
				fi
				echo "${subdircall} CHECK ME I'M IMPORTANT!"
				cp /var/www/html/vplayer/tvtemplate.html /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/$(echo "${dircall}"|cut -d. -f1).html
				sed -i s/EPNAME/${dircall}/g /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/$(echo "${dircall}"|cut -d. -f1).html
				sed -i s/SNAME/${dircall}/g /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6)/$(echo "${dircall}"|cut -d. -f1).html
				sed -i s/SER/$(echo "${realoranime}" | cut -d\/ -f6)/g /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6).html
#				sed -i s/MER/$(echo "${dircall}")/g /var/www/html/vplayer/tvindex/$(echo "${realoranime}" | cut -d\/ -f6).html
				
            else
                echo "no idea what ${dircall} inside ${realoranime} is"
            fi
        done
  done
printf "\n</div>\n\n</body>\n</html>\n" >> /var/www/html/vplayer/tvlist.html


</html>
echo "Total subs is ${dircound}"
echo "Total Video count is ${vidcount}"
