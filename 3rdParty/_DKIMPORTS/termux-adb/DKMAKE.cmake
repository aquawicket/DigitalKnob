#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ termux-adb ############
# https://github.com/MasterDevX/Termux-ADB
dk_load(dk_builder)

if(NOT ANDROID_HOST)
	return()
endif()

# apt update && apt install wget && wget https://github.com/MasterDevX/Termux-ADB/raw/master/InstallTools.sh && ${BASH_EXE} InstallTools.sh

