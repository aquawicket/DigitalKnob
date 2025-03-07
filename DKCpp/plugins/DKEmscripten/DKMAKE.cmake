#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKEmscripten ############
## https://emscripten.org/docs/getting_started/downloads.html

dk_depend(emsdk)

##dk_generateCmake(DKEmscripten)
##dk_assets(DKEmscripten)

dk_cd(${DKCPP_PLUGINS_DIR}/DKEmscripten)
dk_set(QUEUE_BUILD ON)
##WIN_X86_dk_queueCommand(${EMSCRIPTEN}/emscripten/1.37.33/emcc ${DKCPP_PLUGINS_DIR}/DKEmscripten/hello.c -o hello.html)

if(EXISTS ${EMSCRIPTEN}/emscripten/1.37.33/emcc)
	WIN_X86_dk_queueCommand(${EMSCRIPTEN}/emscripten/1.37.33/emcc --bind -o test.js ${DKCPP_PLUGINS_DIR}/DKEmscripten/test.cpp)
endif()