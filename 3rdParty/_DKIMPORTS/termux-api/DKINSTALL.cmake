#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ termux-api ############
# https://github.com/termux/termux-api.git
# https://aktermux.in/adb-in-termux/#howto-step-1680021612068
# https://github.com/termux/termux-api/releases/download/v0.50.1/termux-api_v0.50.1+github-debug.apk
dk_load(dk_builder)

if(NOT Android_Host)
	return()
endif()

#dk_import(https://github.com/termux/termux-api.git)
dk_import(https://github.com/termux/termux-api/archive/refs/heads/master.zip)
