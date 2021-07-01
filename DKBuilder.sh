#!/bin/sh
APP="DKBuilder"
OS="linux64"

PS3='Please select an app to build: '
options=("DKBuilder" "DKSDLRmlUi" "DKTestAll" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "DKBuilder")
            echo "you chose DKBuilder"
			APP="DKBuilder"
			break
            ;;
        "DKSDLRmlUi")
            echo "you chose DKSDLRmlUi"
			APP="DKSDLRmlUi"
            break
			;;
        "DKTestAll")
            echo "you chose choice $REPLY which is $opt"
			APP="DKTestAll"
            break
			;;
        "Exit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


PS3='Please select an OS to build for: '
options=("linux32" "linux64" "mac64" "raspberry32" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "linux32")
            echo "you chose linux32"
			OS="linux32"
			break
            ;;
        "linux64")
            echo "you chose linux64"
			OS="linux64"
            break
			;;
		"mac64")
            echo "you chose mac64"
			OS="mac64"
            break
			;;
        "raspberry32")
            echo "you chose raspberry32"
			OS="raspberry32"
            break
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
cmake -G "Unix Makefiles" -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON /home/"$USER"/digitalknob/DK

cd /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release
make $APP