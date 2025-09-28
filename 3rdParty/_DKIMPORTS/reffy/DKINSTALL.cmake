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


dk_validate(Target_Config  "dk_Target_Config()")
# https://github.com/w3c/reffy.git

dk_depend(nodejs)

#dk_import(https://github.com/w3c/reffy.git BRANCH main)
dk_import(https://github.com/w3c/reffy/archive/refs/heads/main.zip)


# https://github.com/w3c/reffy#readme
dk_set(REFFY_CRAWL_IDL OFF)
if(${REFFY_CRAWL_IDL})
	dk_exec(${npm_exe} install -g reffy)
	dk_exec(${npm_exe} update -g reffy)
	dk_set(reffy_exe ${nodejs}/reffy.cmd)
	dk_exec(${reffy_exe} --spec fetch --module idl > fetch.idl)
	dk_exec(${reffy_exe} --spec html --module idl > html.idl)
	dk_exec(${reffy_exe} --module idl > all.idl)
endif()
