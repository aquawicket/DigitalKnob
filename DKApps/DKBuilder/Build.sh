# first remove the CMake cache file
rm home/aquawicket/digitalknob/DK/DKApps/DKBuilder/win32/CMakeCache.txt

cmake -G "Unix Makefiles" -m32 -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON -S home/aquawicket/digitalknob/DK -B home/aquawicket/digitalknob/DK/DKApps/DKBuilder/linux32

cd home/aquawicket/digitalknob/DK/DKApps/DKBuilder/linux32
make DKBuilder

