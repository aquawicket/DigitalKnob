#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKDuktape ############
dk_depend(duktape)
dk_depend(DK)
if(USE_babel)
	dk_depend(babel)
endif()


#NOTE: include duktape.c in DKDuktape
#if(NOT EXISTS ${DKCPP_PLUGINS_DIR}/DKDuktape/duktape.cpp)
	#dk_copy(${DUKTAPE}/dist/src/duk_config.h 	${DKCPP_PLUGINS_DIR}/DKDuktape/duk_config.h OVERWRITE)
	#dk_copy(${DUKTAPE}/dist/src/duktape.h 		${DKCPP_PLUGINS_DIR}/DKDuktape/duktape.h 	OVERWRITE)
	#dk_copy(${DUKTAPE}/dist/src/duktape.c 		${DKCPP_PLUGINS_DIR}/DKDuktape/duktape.cpp 	OVERWRITE)
#endif()
	
#dk_set(ENABLE_eventloop ON)
if(ENABLE_eventloop)
	dk_define(HAVE_eventloop)
	if(NOT EXISTS ${DKCPP_PLUGINS_DIR}/DKDuktape/poll.cpp)
		dk_copy(${DUKTAPE}/examples/eventloop/poll.c ${DKCPP_PLUGINS_DIR}/DKDuktape/poll.cpp)
	endif()
	if(NOT EXISTS ${DKCPP_PLUGINS_DIR}/DKDuktape/c_eventloop.cpp)
		dk_copy(${DUKTAPE}/examples/eventloop/c_eventloop.c ${DKCPP_PLUGINS_DIR}/DKDuktape/c_eventloop.cpp)
	endif()
	if(NOT EXISTS ${DKCPP_PLUGINS_DIR}/DKDuktape/c_eventloop.js)
		dk_copy(${DUKTAPE}/examples/eventloop/c_eventloop.js ${DKCPP_PLUGINS_DIR}/DKDuktape/c_eventloop.js)
	endif()
	if(NOT EXISTS ${DKCPP_PLUGINS_DIR}/DKDuktape/ecma_eventloop.js)
		dk_copy(${DUKTAPE}/examples/eventloop/ecma_eventloop.js ${DKCPP_PLUGINS_DIR}/DKDuktape/ecma_eventloop.js)
	endif()
else()
	if(EXISTS ${DKCPP_PLUGINS_DIR}/DKDuktape/poll.cpp)
		dk_delete(${DKCPP_PLUGINS_DIR}/DKDuktape/poll.cpp)
	endif()
	if(EXISTS ${DKCPP_PLUGINS_DIR}/DKDuktape/c_eventloop.cpp)
		dk_delete(${DKCPP_PLUGINS_DIR}/DKDuktape/c_eventloop.cpp)
	endif()
	if(EXISTS ${DKCPP_PLUGINS_DIR}/DKDuktape/c_eventloop.js)
		dk_delete(${DKCPP_PLUGINS_DIR}/DKDuktape/c_eventloop.js)
	endif()
	if(EXISTS ${DKCPP_PLUGINS_DIR}/DKDuktape/ecma_eventloop.js)
		dk_delete(${DKCPP_PLUGINS_DIR}/DKDuktape/ecma_eventloop.js)
	endif()
endif()


dk_include(${DKCPP_PLUGINS_DIR}/DKDuktape)
dk_include(${DUKTAPE}/src)
dk_define(HAVE_DKDuktape)

dk_generateCmake(DKDuktape)
dk_assets(DKDuktape)
