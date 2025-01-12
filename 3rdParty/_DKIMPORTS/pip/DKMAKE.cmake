#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)



############ pip ############
dk_validate(PYTHON3 "dk_depend(python3)")

# https://docs.python.org/3/library/ensurepip.html#module-ensurepip
execute_process(COMMAND python3 -m ensurepip --upgrade)
