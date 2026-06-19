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


############ pip ############
# https://docs.python.org/3/library/ensurepip.html#module-ensurepip
# https://stackoverflow.com/a/48906746

###### pip python ######
#dk_validate(python "dk_depend(python)")
#execute_process(COMMAND ${python3}/python.exe -m ensurepip --upgrade)
#execute_process(COMMAND ${python3}/python.exe -m pip --version)

###### pip python3 ######
# https://stackoverflow.com/a/48906746
dk_depend(python3)
#dk_download(https://bootstrap.pypa.io/get-pip.py)
#dk_exec(${python3}/python.exe ${dk_download})

dk_import()
dk_exec(${python3}/python.exe ${pip_Download})
dk_exec(${python3}/python.exe -m pip --version)
