@Echo Off
echo ((( DigitalKnob Android Boost Library Compiler )))
echo Importing files from 3rdParty/_DKIMPORT . . .
robocopy "C:\digitalknob\DK\3rdParty\_DKIMPORTS\Boost-for-Android-master" "C:\digitalknob\DK\3rdParty\Boost-for-Android-master" /IS /IT /IM /NDL /NJH /NJS /nc /ns

echo Setting environment variables . . .
set ANDROIDNDKROOT=C:\digitalknob\DK\3rdParty\android-ndk-r20b
set NDKVER=r20b
set CLANGPATH=%ANDROIDNDKROOT%\toolchains\llvm\prebuilt\windows-x86_64\bin

echo Patching boost_1_74_0 for android . . . 

echo Copying user-config.jam to boost_1_74_0/tools/build/src . . .
robocopy "C:\digitalknob\DK\3rdParty\Boost-for-Android-master" "C:\digitalknob\DK\3rdParty\Boost-for-Android-master\boost_1_74_0\tools\build\src" user-config.jam /IS /IT /IM /NDL /NJH /NJS /nc /ns
echo.
echo.
echo **** Copy and paste this command to this sh terminal to debug (auto)****
echo.
cd C:\digitalknob\DK\3rdParty\Boost-for-Android-master\boost_1_74_0
Rem : Adding a b2 -q parameter will stop b2 on it's first error and allow you to see any errors quicker. 
b2 --without-graph --without-regex --without-container --without-chrono --without-type_erasure --without-program_options --without-serialization --without-stacktrace --without-test --without-timer --without-context --without-coroutine --without-fiber --without-python architecture=arm --ignore-site-config -j4 target-os=android  toolset=clang-armeabiv7a link=static threading=multi --layout=tagged --build-dir=../build/arm/r20b --stagedir=../stage_arm_r20b stage
cd C:\digitalknob\DK\3rdParty\Boost-for-Android-master







