#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ pytest ############
dk_validate(CMD_EXE "dk_CMD_EXE()")
dk_validate(PYTHON3 "dk_depend(python3)")
execute_process(COMMAND ${CMD_EXE} /c "pip install pytest")
