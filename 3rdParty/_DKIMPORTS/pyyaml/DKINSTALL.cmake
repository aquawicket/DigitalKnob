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


############ pyyaml ############
# https://github.com/yaml/pyyaml
dk_depend(python)
dk_validate(Host_Tuple "dk_Host_Tuple()")

### INSTALL ###
if(Windows_Host)
	dk_exec(${PYTHON}/Scripts/pip install PyYAML)
elseif(Mac_Host)
	dk_exec(pip install PyYAML)
else()
	dk_installPackage(python-yaml)
endif()

