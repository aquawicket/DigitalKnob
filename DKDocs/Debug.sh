#!/bin/bash
APP = "DKBuilder"
OS = "linux64"

PS3='Please select an app to build: '
options=("DKBuilder" "DKSDLRmlUi" "DKTestAll" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "DKBuilder")
            echo "you chose DKBuilder"
			APP = "DKBuilder"
            ;;
        "DKSDLRmlUi")
            echo "you chose DKSDLRmlUi"
			APP = "DKSDLRmlUi"
            ;;
        "DKTestAll")
            echo "you chose choice $REPLY which is $opt"
			APP = "DKTestAll"
            ;;
        "Exit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


git clone https://github.com/aquawicket/DigitalKnob.git /home/"$USER"/digitalknob/DK
cd /home/"$USER"/digitalknob/DK
git checkout -- .
git pull origin master

mkdir /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release
cd /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release
rm /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release/CMakeCache.txt
cmake -G "Unix Makefiles" -m32 -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON /home/"$USER"/digitalknob/DK

cd /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release
make $APP