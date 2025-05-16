#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ pyyaml ############
# https://github.com/yaml/pyyaml
dk_validate(PYTHON "dk_depend(python)")
dk_validate(Host_Tuple "dk_Host_Tuple()")

### INSTALL ###
if(Win_Host)
	dk_exec(${PYTHON}/Scripts/pip install PyYAML)
elseif(Mac_Host)
	dk_exec(pip install PyYAML)
else()
	dk_installPackage(python-yaml)
endif()

