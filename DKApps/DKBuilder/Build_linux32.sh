#!/bin/bash

git clone https://github.com/aquawicket/DigitalKnob.git /home/"$USER"/digitalknob/DK
cd /home/"$USER"/digitalknob/DK
git checkout -- .
git pull origin master

mkdir /home/"$USER"/digitalknob/DK/DKApps/DKBuilder/linux32/Release
cd /home/"$USER"/digitalknob/DK/DKApps/DKBuilder/linux32/Release
rm /home/"$USER"/digitalknob/DK/DKApps/DKBuilder/linux32/Release/CMakeCache.txt
cmake -G "Unix Makefiles" -m32 -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON /home/"$USER"/digitalknob/DK

cd /home/"$USER"/digitalknob/DK/DKApps/DKBuilder/linux32/Release
make DKBuilder
