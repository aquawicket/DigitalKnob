#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


###### python3 ######
# https://docs.python.org/3/using/windows.html
# https://silentinstallhq.com/python-3-10-silent-install-how-to-guide/
# https://wiki.termux.com/wiki/Python

##dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_validate(Host_Tuple "dk_Host_Tuple()")
#set(python3_Import "${python3_${Host_Tuple}_Import}")
if(NOT python3_Import)
	set(python3_Import python)
endif()
	
dk_isUrl(${python3_Import})
if(dk_isUrl)
	dk_importVariables("${python3_Import}")
	dk_assertVar(python3)
endif()

if(Windows_Host)
	dk_findProgram(python3_exe python.exe "${python3}")
else()
	dk_findProgram(python3_exe python3)
endif()


if(NOT EXISTS "${python3_exe}")
	if(Mac_Host OR Windows_Host)
		dk_import("${python3_Import}")
	else()
		dk_installPackage("${python3_Import}")
	endif()
	
	if(Windows_Host)
		dk_findProgram(python3_exe python.exe "${python3}")
	else()
		dk_findProgram(python3_exe python3)
	endif()
endif()

if(NOT EXISTS "${python3}")
	dk_dirname("${python3_exe}" python3)
endif()


dk_prependEnvPath("${python3}")
dk_exportVars(PATH "$ENV{PATH}")


### 3RDPARTY LINK ###
dk_set(python3_CMAKE -DPython3_EXECUTABLE=${python3_exe}) # -DPython3_Interpreter=${python3_exe})

dk_assertPath("${python3}")
dk_assertPath("${python3_exe}")
dk_firewallAllow("${python3_exe}")


