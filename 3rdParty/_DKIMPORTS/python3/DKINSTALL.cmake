#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### python3 ######
# https://docs.python.org/3/using/windows.html
# https://silentinstallhq.com/python-3-10-silent-install-how-to-guide/
# https://wiki.termux.com/wiki/Python

dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/python3/dkconfig.txt")

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(Mac_X86_64_Host)
	set(PYTHON3_IMPORT ${PYTHON3_MAC_X86_64_IMPORT})
elseif(Windows_Arm64_Host)
	set(PYTHON3_IMPORT ${PYTHON3_WIN_ARM64_IMPORT})
elseif(Windows_X86_64_Host)
	set(PYTHON3_IMPORT ${PYTHON3_WIN_X86_64_IMPORT})
elseif(Windows_X86_Host)
	set(PYTHON3_IMPORT ${PYTHON3_WIN_X86_IMPORT})
else()
	set(PYTHON3_IMPORT python)
endif()

	
dk_isUrl(${PYTHON3_IMPORT})
if(dk_isUrl)
	dk_importVariables("${PYTHON3_IMPORT}")
endif()

if(Windows_Host)
	dk_findProgram(PYTHON3_EXE python.exe "${PYTHON3}")
else()
	dk_findProgram(PYTHON3_EXE python3)
endif()


if(NOT EXISTS "${PYTHON3_EXE}")
	if(Mac_Host OR Windows_Host)
		dk_import("${PYTHON3_IMPORT}")
	else()
		dk_installPackage("${PYTHON3_IMPORT}")
	endif()
	
	if(Windows_Host)
		dk_findProgram(PYTHON3_EXE python.exe "${PYTHON3}")
	else()
		dk_findProgram(PYTHON3_EXE python3)
	endif()
endif()

if(NOT EXISTS "${PYTHON3}")
	dk_dirname("${PYTHON3_EXE}" PYTHON3)
endif()


dk_prependEnvPath("${PYTHON3}")
dk_exportVars(PATH "$ENV{PATH}")


### 3RDPARTY LINK ###
dk_set(PYTHON3_CMAKE -DPython3_EXECUTABLE=${PYTHON3_EXE}) # -DPython3_Interpreter=${PYTHON3_EXE})

dk_firewallAllow("Python3" "${PYTHON3_EXE}")

dk_assertPath("${PYTHON3}")
dk_assertPath("${PYTHON3_EXE}")
