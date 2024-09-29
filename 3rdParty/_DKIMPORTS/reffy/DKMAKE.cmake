#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/w3c/reffy.git

dk_depend(nodejs)

#dk_import(https://github.com/w3c/reffy.git BRANCH main)
dk_import(https://github.com/w3c/reffy/archive/refs/heads/main.zip)


# https://github.com/w3c/reffy#readme
dk_set(REFFY_CRAWL_IDL OFF)
if(${REFFY_CRAWL_IDL})
	dk_command(${NPM_EXE} install -g reffy)
	dk_command(${NPM_EXE} update -g reffy)
	dk_set(REFFY_EXE ${NODEJS}/reffy.cmd)
	dk_command(${REFFY_EXE} --spec fetch --module idl > fetch.idl)
	dk_command(${REFFY_EXE} --spec html --module idl > html.idl)
	dk_command(${REFFY_EXE} --module idl > all.idl)
endif()
