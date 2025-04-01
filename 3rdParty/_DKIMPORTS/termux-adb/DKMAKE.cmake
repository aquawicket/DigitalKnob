#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ termux-adb ############
# https://github.com/MasterDevX/Termux-ADB
dk_load(dk_builder)

if(NOT ANDROID_HOST)
	return()
endif()

# apt update && apt install wget && wget https://github.com/MasterDevX/Termux-ADB/raw/master/InstallTools.sh && ${BASH_EXE} InstallTools.sh

