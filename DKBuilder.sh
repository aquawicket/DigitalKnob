#!/bin/bash
APP="DKBuilder"
OS="linux64"

echo " "
PS3='Please select an app to build: '
options=("UPDATE" "DKBuilder" "DKSDLRmlUi" "DKTestAll" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "UPDATE")
            echo "you chose UPDATE"
			git clone https://github.com/aquawicket/DigitalKnob.git /home/"$USER"/digitalknob/DK
			cd /home/"$USER"/digitalknob/DK
			git checkout -- .
			git pull origin master
            ;;
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

echo " "
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


mkdir /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS
mkdir /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release
cd /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release
rm /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release/CMakeCache.txt
cmake -G "Unix Makefiles" -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON /home/"$USER"/digitalknob/DK
chmod +x /home/"$USER"/digitalknob/DK/DKBuilder.sh

cd /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/Release
make $APP
