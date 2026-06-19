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


############ pyyaml ############
# https://github.com/yaml/pyyaml
dk_validate(python "dk_depend(python)")

### INSTALL ###
if(Windows_Host)
	dk_exec(${PYTHON}/Scripts/pip install PyYAML)
elseif(Mac_Host)
	dk_exec(pip install PyYAML)
else()
	dk_installPackage(python-yaml)
endif()

