#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### python3 ######
# https://docs.python.org/3/using/windows.html
# https://silentinstallhq.com/python-3-10-silent-install-how-to-guide/
# https://wiki.termux.com/wiki/Python

dk_validate(host_triple "dk_host_triple()")
if(ANDROID_HOST)
	set(PYTHON3_IMPORT python)
elseif(MAC_HOST)
	set(PYTHON3_IMPORT https://www.python.org/ftp/python/3.11.8/python-3.11.8-macos11.pkg)
elseif(WIN_HOST)
	set(PYTHON3_IMPORT https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-win32.zip)
else()
	set(PYTHON3_IMPORT python3)
endif()
dk_importVariables	("${PYTHON3_IMPORT}" PLUGIN_VAR_PREFIX)

if(WIN_HOST)
	dk_findProgram(PYTHON3_EXE python3.exe "${PYTHON3_DIR}")
else()
	dk_findProgram(PYTHON3_EXE python3)
endif()


if(NOT EXISTS ${PYTHON3_EXE})
	if(MAC_HOST OR WIN_HOST)
		dk_import		("${PYTHON3_IMPORT}")
		dk_rename		("${PYTHON3_DIR}/python.exe" "${PYTHON3_DIR}/python3.exe")
	else()
		dk_installPackage("${PYTHON3_IMPORT}")
	endif()
	
	if(WIN_HOST)
		dk_findProgram(PYTHON3_EXE python3.exe "${PYTHON3_DIR}")
	else()
		dk_findProgram(PYTHON3_EXE python3)
	endif()
endif()
dk_assertPath(${PYTHON3_EXE})

if(NOT EXISTS "${PYTHON3_DIR}")
	dk_dirname("${PYTHON3_EXE}" PYTHON3_DIR)
endif()
dk_assertPath(${PYTHON3_DIR})
dk_prependEnvPath("${PYTHON3_DIR}")


### 3RDPARTY LINK ###
dk_set(PYTHON3_CMAKE -DPython3_EXECUTABLE=${PYTHON3_EXE}) # -DPython3_Interpreter=${PYTHON3_EXE})
