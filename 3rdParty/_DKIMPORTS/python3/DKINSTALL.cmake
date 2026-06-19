#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


###### python3 ######
# https://docs.python.org/3/using/windows.html
# https://silentinstallhq.com/python-3-10-silent-install-how-to-guide/
# https://wiki.termux.com/wiki/Python
# https://stackoverflow.com/a/48906746
# https://www.python.org/ftp/python/3.11.8/Python-3.11.8.tar.xz
# https://www.python.org/ftp/python/3.11.8/python-3.11.8-macos11.pkg
# https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-arm64.zip
# https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-amd64.zip
# https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-win32.zip

dk_import()
dk_assertPath("${python3}")

if(NOT EXISTS "${python3_exe}")
	if(Windows_Host)
		dk_set(python3_exe "${python3}/python.exe")
		#dk_findProgram(python3_exe python.exe "${python3}")
	else()
		dk_findProgram(python3_exe python3)
	endif()
endif()
dk_firewallAllow("${python3_exe}")

dk_fileReplace("${python3}/python311._pth" "#import site" "import site")
dk_prependEnvPath("${python3}")
dk_cacheVariable(PATH "$ENV{PATH}")

dk_set(python3_CMAKE -DPython3_EXECUTABLE=${python3_exe}) # -DPython3_Interpreter=${python3_exe})
