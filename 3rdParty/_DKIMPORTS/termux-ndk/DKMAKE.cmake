#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")



############ termux-ndk ############
# https://github.com/jzinferno2/termux-ndk

# https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r17c-aarch64.zip
# https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r18b-aarch64.zip
# https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r19c-aarch64.zip
# https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r20b-aarch64.zip
# https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r21e-aarch64.zip
# https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r22b-aarch64.zip
# https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r23b-aarch64.zip
# https://github.com/jzinferno2/termux-ndk/releases/download/v1/android-ndk-r24-aarch64.zip


dk_import("https://github.com/jzinferno2/termux-ndk/archive/5dd527b8.zip")