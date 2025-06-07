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


############ DKDuktapeDebugger ############
dk_info("DKDuktapeDebugger/DKINSTALL.cmake")
dk_depend(DKDuktape)

#if(NOT EXISTS ${DKCPP_PLUGINS_DIR}/DKDuktapeDebugger/duk_trans_dvalue.c)
#	dk_copy(${DUKTAPE}/examples/debug-trans-dvalue/duk_trans_dvalue.h ${DKCPP_PLUGINS_DIR}/DKDuktapeDebugger/duk_trans_dvalue.h OVERWRITE)
#	dk_copy(${DUKTAPE}/examples/debug-trans-dvalue/duk_trans_dvalue.c ${DKCPP_PLUGINS_DIR}/DKDuktapeDebugger/duk_trans_dvalue.cpp OVERWRITE)
#endif()





############ DKDuktapeDebugger ############
dk_set(CURRENT_PLUGIN "DKDuktapeDebugger")
dk_generateCmake(${CURRENT_PLUGIN})
dk_assets(${CURRENT_PLUGIN})
dk_set(${CURRENT_PLUGIN} "${CMAKE_CURRENT_LIST_DIR}")
dk_configure(${CMAKE_CURRENT_LIST_DIR})
dk_build(${CMAKE_CURRENT_LIST_DIR})