#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKDuktapeDebugger ############
dk_info("DKDuktapeDebugger/DKMAKE.cmake")
dk_depend(DKDuktape)

#if(NOT EXISTS ${DKCPP_PLUGINS_DIR}/DKDuktapeDebugger/duk_trans_dvalue.c)
#	dk_copy(${DUKTAPE}/examples/debug-trans-dvalue/duk_trans_dvalue.h ${DKCPP_PLUGINS_DIR}/DKDuktapeDebugger/duk_trans_dvalue.h OVERWRITE)
#	dk_copy(${DUKTAPE}/examples/debug-trans-dvalue/duk_trans_dvalue.c ${DKCPP_PLUGINS_DIR}/DKDuktapeDebugger/duk_trans_dvalue.cpp OVERWRITE)
#endif()

dk_generateCmake(DKDuktapeDebugger)
dk_assets(DKDuktapeDebugger)
