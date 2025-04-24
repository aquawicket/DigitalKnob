#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ pip ############
# https://docs.python.org/3/library/ensurepip.html#module-ensurepip

dk_validate(PYTHON3 "dk_depend(python3)")

execute_process(COMMAND python3 -m ensurepip --upgrade)
