#!/bin/sh
APP="DKBuilder"
OS="linux64"

git clone https://github.com/aquawicket/DigitalKnob.git /home/"$USER"/digitalknob/DK
cd /home/"$USER"/digitalknob/DK
git checkout -- .
git pull origin master

mkdir /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release
cd /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release
rm /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release/CMakeCache.txt
cd /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release
cmake -G "Unix Makefiles" -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON /home/"$USER"/digitalknob/DK
cd /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release
make $APP
