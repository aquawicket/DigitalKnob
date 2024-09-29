#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://docs.python.org/3/using/windows.html
# https://silentinstallhq.com/python-3-10-silent-install-how-to-guide/
# https://wiki.termux.com/wiki/Python

ANDROID_HOST_dk_set (PYTHON3_IMPORT python)
LINUX_HOST_dk_set	(PYTHON3_IMPORT python3)
MAC_HOST_dk_set 	(PYTHON3_IMPORT https://www.python.org/ftp/python/3.11.8/python-3.11.8-macos11.pkg)
WIN_HOST_dk_set		(PYTHON3_IMPORT https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-win32.zip)
dk_importVariables	("${PYTHON3_IMPORT}" PLUGIN_VAR_PREFIX)

if(ANDROID_HOST)
	dk_findProgram(PYTHON3_EXE python3)
elseif(LINUX_HOST)
	dk_findProgram(PYTHON3_EXE python3)
elseif(MAC_HOST)
	dk_findProgram(PYTHON3_EXE python3)
elseif(WIN_HOST)
	dk_findProgram(PYTHON3_EXE python3 "${PYTHON3_DIR}")
else()
	dk_findProgram(PYTHON3_EXE python3)
endif()


if(NOT EXISTS ${PYTHON3_EXE})
	ANDROID_HOST_dk_command	(pkg install ${PYTHON3_IMPORT} -y)
	dk_depend(sudo)
	LINUX_HOST_dk_command	(${SUDO_EXE} apt-get install ${PYTHON3_IMPORT})
	MAC_HOST_dk_import		("${PYTHON3_IMPORT}")
	WIN_HOST_dk_import		("${PYTHON3_IMPORT}")
	
	if(ANDROID_HOST)
		dk_findProgram(PYTHON3_EXE python3)
	elseif(LINUX_HOST)
		dk_findProgram(PYTHON3_EXE python3)
	elseif(MAC_HOST)
		dk_findProgram(PYTHON3_EXE python3)
	elseif(WIN_HOST)
		dk_findProgram(PYTHON3_EXE python3 "${PYTHON3_DIR}")
	else()
		dk_findProgram(PYTHON3_EXE python3)
	endif()
endif()

dk_assertPath(${PYTHON3_EXE})



if(EXISTS ${PYTHON3_DIR})
	dk_prependEnvPath("${PYTHON3_DIR}")
endif()

### 3RDPARTY LINK ###
dk_set(PYTHON3_CMAKE -DPython3_EXECUTABLE=${PYTHON3_EXE}) # -DPython3_Interpreter=${PYTHON3_EXE})




