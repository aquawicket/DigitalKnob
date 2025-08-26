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


############ duktape ############
# https://duktape.org/duktape-2.6.0.tar.xz
# https://github.com/Squareys/duktape/tree/let-support
# https://github.com/aquawicket/duktape/archive/refs/heads/let-support.zip
# https://codeload.github.com/Squareys/duktape/zip/refs/heads/let-support
# https://github.com/svaarala/duktape/archive/refs/heads/master.zip
# https://wiki.duktape.org/projectsusingduktape

dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
dk_depend(python3)
dk_depend(pyyaml)
#dk_depend(nodejs)
#dk_validate(MSYS2 "dk_depend(msys2)")

### IMPORT ###
dk_import(${duktape_Import} PATCH) #NOTE: PATCH is for CMakeLists.txt


### LINK ###
if(MSVC)
	if(Windows)
		dk_define	(DUK_F_VBCC)
	endif()
endif()
if(Android)
	dk_define		(DUK_F_32BIT_PTRS)
endif()
dk_include			(${DUKTAPE}/src)

## TODO: create MSVC_dk_libDebug and MSVC_dk_libRelease
if(MSVC)
	dk_libDebug		(${DUKTAPE_Debug_Dir}/duktape.lib)
	dk_libRelease	(${DUKTAPE_Release_Dir}/duktape.lib)
else()
	dk_libDebug		(${DUKTAPE_Debug_Dir}/libduktape.a)
	dk_libRelease	(${DUKTAPE_Release_Dir}/libduktape.a)
endif()

### GENERATE ###
if(NOT EXISTS ${DUKTAPE}/src/duktape.c)
	#dk_exec(${PYTHON_EXE} ${DUKTAPE}/util/dist.py)  # default generator	
	dk_exec(${PYTHON_EXE} ${DUKTAPE}/tools/configure.py
		--output-directory ${DUKTAPE}/src
		-DDUK_CMDLINE_DEBUGGER_SUPPORT
		-DDUK_USE_DEBUGGER_DUMPHEAP
		-DDUK_USE_DEBUGGER_INSPECT
		-DDUK_USE_DEBUGGER_SUPPORT
		-DDUK_USE_FATAL_HANDLER
		-DDUK_USE_GLOBAL_BINDING
		-DDUK_USE_INTERRUPT_COUNTER)
	#dk_exec(${NODE_EXE} ${DUKTAPE}/src-tools/index.js configure --output-directory ${DUKTAPE}/src --source-directory ${DUKTAPE}/src-input --config-directory ${DUKTAPE}/config)
endif()

dk_configure()

### COMPILE ###
dk_build()
