#!/bin/bash
APP="DKBuilder"
OS="linux64"
TYPE="Release"

echo " "
PS3='Please select an app to build: '
options=("UPDATE" "DKBuilder" "DKSDLRmlUi" "DKTestAll" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "UPDATE")
			echo "$opt"
			git clone https://github.com/aquawicket/DigitalKnob.git /home/"$USER"/digitalknob/DK
			cd /home/"$USER"/digitalknob/DK
			git checkout -- .
			git pull origin master
			echo "${options[@]}"
            ;;
		"DKBuilder")
            echo "$opt"
			APP="DKBuilder"
			break
            ;;
        "DKSDLRmlUi")
            echo "$opt"
			APP="DKSDLRmlUi"
            break
			;;
        "DKTestAll")
            echo "$opt"
			APP="DKTestAll"
            break
			;;
        "Exit")
			echo "$opt"
			Exit 0
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac 
	REPLY=
done

echo " "
PS3='Please select an OS to build for: '
options=("linux32" "linux64" "mac64" "raspberry32" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "linux32")
            echo "$opt"
			OS="linux32"
			break
            ;;
        "linux64")
            echo "$opt"
			OS="linux64"
            break
			;;
		"mac64")
            echo "$opt"
			OS="mac64"
            break
			;;
        "raspberry32")
            echo "$opt"
			OS="raspberry32"
            break
			;;
        "Exit")
			echo "$opt"
			Exit 0
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac 
	REPLY=
done

cd /home/"$USER"/digitalknob
echo Deleteing all CMakeCache.txt files....
find . -name "CMakeCache.*" -delete
#find . -type d -name "CMakeFiles" -delete
#find . -type d -name "CMakeFiles" -exec rm -rf {} \;
rm -rf `find . -type d -name CMakeFiles`
		
mkdir /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS
mkdir /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/$TYPE
cd /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/$TYPE
rm /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/$TYPE/CMakeCache.txt
cmake -G "Unix Makefiles" -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON /home/"$USER"/digitalknob/DK
chmod +x /home/"$USER"/digitalknob/DK/DKBuilder.sh

cd /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/$TYPE
make $APP
chmod +x /home/"$USER"/digitalknob/DK/DKApps/$APP/$OS/$TYPE/$APP

#eof#