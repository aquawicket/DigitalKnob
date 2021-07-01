#!/bin/bash
APP = "DKBuilder"

git clone https://github.com/aquawicket/DigitalKnob.git /home/"$USER"/digitalknob/DK
cd /home/"$USER"/digitalknob/DK
git checkout -- .
git pull origin master

mkdir /home/"$USER"/digitalknob/DK/DKApps/APP/mac64/Release
cd /home/"$USER"/digitalknob/DK/DKApps/APP/mac64/Release
rm /home/"$USER"/digitalknob/DK/DKApps/APP/mac64/Release/CMakeCache.txt
cmake -G "Unix Makefiles" -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON /home/"$USER"/digitalknob/DK

cd /home/"$USER"/digitalknob/DK/DKApps/APP/mac64/Release
make APP
