@Echo Off
echo ((( DigitalKnob Android Boost Library Compiler )))
echo Importing files from 3rdParty/_DKIMPORT . . .
robocopy "C:\digitalknob\DK\3rdParty\_DKIMPORTS\Boost-for-Android-master" "C:\digitalknob\DK\3rdParty\Boost-for-Android-master" /IS /IT /IM /NDL /NJH /NJS /nc /ns

echo Setting environment variables . . .
set ANDROIDNDKROOT=C:\digitalknob\DK\3rdParty\android-ndk-r20b
set NDKVER=r20b
set CLANGPATH=%ANDROIDNDKROOT%\toolchains\llvm\prebuilt\windows-x86_64\bin

echo Copying user-config.jam to boost_1_74_0/tools/build/src . . .
robocopy "C:\digitalknob\DK\3rdParty\Boost-for-Android-master" "C:\digitalknob\DK\3rdParty\Boost-for-Android-master\boost_1_74_0\tools\build\src" user-config.jam /IS /IT /IM /NDL /NJH /NJS /nc /ns
echo.
cd C:\digitalknob\DK\3rdParty\Boost-for-Android-master\boost_1_74_0
echo **** Running b2 architecture=arm --ignore-site-config -j4 target-os=android toolset=clang-armeabiv7a link=static threading=multi --layout=versioned --build-dir=../android32 --stagedir=../android32 stage
echo.

Rem : Adding a -q parameter to b2 will make it stop compiling on it's first error for easier debugging. 
b2 architecture=arm --ignore-site-config -j4 target-os=android toolset=clang-armeabiv7a link=static threading=multi --layout=versioned --build-dir=../android32 --stagedir=../android32 stage
cd C:\digitalknob\DK\3rdParty\Boost-for-Android-master
