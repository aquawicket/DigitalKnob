set AndroidNDKRoot=C:/digitalknob/DK/3rdParty/android-ndk-r20b
set NDKver=r20b
set ClangPath=%AndroidNDKRoot%/toolchains/llvm/prebuilt/windows-x86_64/bin

#!/bin/sh
cd /c/digitalknob/DK/3rdParty/Boost-for-Android-master;
export AndroidNDKRoot=/c/digitalknob/DK/3rdParty/android-ndk-r20b\;
export AndroidBinariesPath=`dirname $AndroidNDKRoot/toolchains/llvm/prebuilt/windows-x86_64/bin/clang++`\;
export AndroidTargetVersion32=29\;
export AndroidTargetVersion64=29\;
export PlatformOS=windows\;
export AndroidSourcesDetected=1\;
export NO_BZIP2=1\;
export PATH=/c/digitalknob/DK/3rdParty/mingw/mingw32/bin:$PATH\;
export PATH=/c/digitalknob/DK/3rdParty/mingw/msys/bin:$PATH\;
export PATH=$AndroidBinariesPath:$PATH\;
cd /c/digitalknob/DK/3rdParty/Boost-for-Android-master/boost_1_74_0;
./b2 -q -d+2 --ignore-site-config -j1 target-os=android toolset=clang-armeabiv7a link=static threading=multi --layout=versioned --with-libraries=chrono,date_time,filesystem,system,thread --build-dir=/c/digitalknob/DK/3rdParty/Boost-for-Android-master/build --prefix=/c/digitalknob/DK/3rdParty/Boost-for-Android-master/android32