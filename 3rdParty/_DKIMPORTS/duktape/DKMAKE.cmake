#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ duktape ############
# https://duktape.org/duktape-2.6.0.tar.xz
# https://github.com/Squareys/duktape/tree/let-support
# https://github.com/aquawicket/duktape/archive/refs/heads/let-support.zip
# https://codeload.github.com/Squareys/duktape/zip/refs/heads/let-support
# https://github.com/svaarala/duktape/archive/refs/heads/master.zip
# https://wiki.duktape.org/projectsusingduktape

dk_load(dk_builder)

### DEPEND ###
dk_depend(python3)
dk_depend(pyyaml)
#dk_depend(nodejs)
#dk_depend(msys2)


### IMPORT ###
dk_import(https://github.com/aquawicket/duktape/archive/0701a46.zip PATCH) #NOTE: PATCH is for CMakeLists.txt

### LINK ###
if(MSVC)
	if(WIN)
		dk_define	(DUK_F_VBCC)
	endif()
endif()
if(ANDROID)
	dk_define		(DUK_F_32BIT_PTRS)
endif()
dk_include			(${DUKTAPE_DIR}/src)

## TODO: create MSVC_dk_libDebug and MSVC_dk_libRelease
if(MSVC)
	dk_libDebug		(${DUKTAPE_DEBUG_DIR}/duktape.lib)
	dk_libRelease	(${DUKTAPE_RELEASE_DIR}/duktape.lib)
else()
	dk_libDebug		(${DUKTAPE_DEBUG_DIR}/libduktape.a)
	dk_libRelease	(${DUKTAPE_RELEASE_DIR}/libduktape.a)
endif()

### GENERATE ###
if(NOT EXISTS ${DUKTAPE_DIR}/src/duktape.c)
	#dk_executeProcess(${PYTHON_EXE} ${DUKTAPE_DIR}/util/dist.py)  # default generator	
	dk_executeProcess(${PYTHON_EXE} ${DUKTAPE_DIR}/tools/configure.py
		--output-directory ${DUKTAPE_DIR}/src
		-DDUK_CMDLINE_DEBUGGER_SUPPORT
		-DDUK_USE_DEBUGGER_DUMPHEAP
		-DDUK_USE_DEBUGGER_INSPECT
		-DDUK_USE_DEBUGGER_SUPPORT
		-DDUK_USE_FATAL_HANDLER
		-DDUK_USE_GLOBAL_BINDING
		-DDUK_USE_INTERRUPT_COUNTER)
	#dk_executeProcess(${NODE_EXE} ${DUKTAPE_DIR}/src-tools/index.js configure --output-directory ${DUKTAPE_DIR}/src --source-directory ${DUKTAPE_DIR}/src-input --config-directory ${DUKTAPE_DIR}/config)
endif()

dk_configure(${DUKTAPE_DIR})

### COMPILE ###
dk_build(${DUKTAPE}) # duktape)
