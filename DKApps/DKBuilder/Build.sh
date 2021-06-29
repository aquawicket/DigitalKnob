# first remove the CMake cache file
git pull
rm /home/aquawicket/digitalknob/DK/DKApps/DKBuilder/linux32/Release/CMakeCache.txt

mkdir /home/aquawicket/digitalknob/DK/DKApps/DKBuilder/linux32/Release
cd /home/aquawicket/digitalknob/DK/DKApps/DKBuilder/linux32/Release
cmake -G "Unix Makefiles" -m32 -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON /home/aquawicket/digitalknob/DK

cd /home/aquawicket/digitalknob/DK/DKApps/DKBuilder/linux32/Release
make DKBuilder
