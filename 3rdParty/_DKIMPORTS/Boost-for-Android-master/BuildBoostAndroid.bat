@Echo Off
echo ((( DigitalKnob Android Boost Library Compiler )))
echo Setting invironment variables . . .
set ANDROIDNDKROOT=C:\digitalknob\DK\3rdParty\android-ndk-r20b
set NDKVER=r20b
set CLANGPATH=%ANDROIDNDKROOT%\toolchains\llvm\prebuilt\windows-x86_64\bin

echo Patching boost_1_74_0 for android . . . 

echo Copying user-config.jam to boost_1_74_0/tools/build/src . . .
robocopy "C:\digitalknob\DK\3rdParty\Boost-for-Android-master" "C:\digitalknob\DK\3rdParty\Boost-for-Android-master\boost_1_74_0\tools\build\src" user-config.jam /IS /IT /IM /NDL /NJH /NJS /nc /ns

echo.
echo.
echo **** Copy and paste this command to this sh terminal to debug ****
echo.
echo ./b2 -q --without-math --without-context --without-coroutine --without-fiber --without-python architecture=arm --ignore-site-config -j4 target-os=android  toolset=clang-armeabiv7a link=static threading=multi --layout=tagged --build-dir=build/arm/%NDKVER% --stagedir=stage_arm_%NDKVER% stage
echo.
sh







