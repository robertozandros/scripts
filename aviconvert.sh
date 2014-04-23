#!/bin/sh
#
# simple script to rip and convert DVD -> AVI
# roberto 2008

# split the .avi file into 2 separate files, one for video and one for audio:
echo "transcoding ..."
transcode -i $1.avi -y ffmpeg --export_prof dvd-ntsc --export_asr 3 -o $1 \
              -D0 -s2 -m $1.ac3 -J modfps=clonetype=3 --export_fps 29.97

# put the video & audio file back together:
echo "merging video/audio ..."
mplex -f 8 -o $1.mpg $1.m2v $1.ac3

echo "creating $1.xml file ..."
echo "<dvdauthor dest=\"DVD\">" > $1.xml
echo "<vmgm />" >> $1.xml
echo "<titleset>" >> $1.xml
echo "<titles>" >> $1.xml
echo "<pgc>" >> $1.xml
echo "<vob file=\"$1.mpg\" chapters=\"0,15:00,30:00,45:00,1:00:00\"/>" >> \
        $1.xml
echo "</pgc>" >> $1.xml
echo "</titles>" >> $1.xml
echo "</titleset>" >> $1.xml
echo "</dvdauthor>" >> $1.xml

# create a DVD directory where your movie files are and do this:
echo "running dvdauthor -x ..."
dvdauthor -x $1.xml

# burn it
if [ $2 == "x" ]; then
   growisofs -Z /dev/dvd -dvd-video DVD/
else
   echo "transcoding successfull!!\n";
fi

