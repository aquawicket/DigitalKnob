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


dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

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





############ DKDuktape ############
dk_generateCmake()
dk_assets()
dk_configure()
dk_build()
