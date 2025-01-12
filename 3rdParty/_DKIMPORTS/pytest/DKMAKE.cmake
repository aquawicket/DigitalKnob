#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)



################ PYTEST ################

dk_validate(PYTHON3 "dk_depend(python3)")

execute_process(COMMAND ${CMD_EXE} /c "pip install pytest")