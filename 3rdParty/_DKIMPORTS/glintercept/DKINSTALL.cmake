#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


########### glintercept ############
dk_validate(host_triple "dk_host_triple()")
# https://github.com/dtrebilco/glintercept.git
# https://github.com/dtrebilco/glintercept/archive/e204189eff4045c24d48b82c93d4f012ed44e166.zip
# https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe

if(NOT WIN_HOST)
	dk_undepend(glintercept)
	dk_return()
endif()


### IMPORT ###
#dk_import(https://github.com/dtrebilco/glintercept/archive/e204189eff4045c24d48b82c93d4f012ed44e166.zip)
#dk_import(https://github.com/dtrebilco/glintercept.git)
#dk_import(https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe)

# if HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\GLIntercept_is1 exists
dk_set(GLINTERCEPT "$ENV{SystemDrive}/Program Files (x86)/GLIntercept_1_3_4")
if(NOT EXISTS "${GLINTERCEPT}/unins000.exe")
	dk_download(https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe $ENV{DKDOWNLOAD_DIR}/GLIntercept_1_3_4.exe)
	dk_command($ENV{DKDOWNLOAD_DIR}/GLIntercept_1_3_4.exe)
endif()
