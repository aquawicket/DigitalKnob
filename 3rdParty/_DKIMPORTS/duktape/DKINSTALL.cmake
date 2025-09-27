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
#dk_depend(msys2)

### IMPORT ###
dk_import() #PATCH

### LINK ###
if(MSVC AND Windows)
	dk_define		(DUK_F_VBCC)
endif()
if(Android)
	dk_define		(DUK_F_32BIT_PTRS)
endif()
dk_include			(${duktape}/src)

## TODO: create MSVC_dk_libDebug and MSVC_dk_libRelease
if(MSVC)
	dk_libDebug		(${duktape_Debug_Dir}/duktape.lib)
	dk_libRelease	(${duktape_Release_Dir}/duktape.lib)
else()
	dk_libDebug		(${duktape_Debug_Dir}/libduktape.a)
	dk_libRelease	(${duktape_Release_Dir}/libduktape.a)
endif()

### GENERATE ###
if(NOT EXISTS ${duktape}/src/duktape.c)
	#dk_exec(${python_exe} ${duktape}/util/dist.py)  # default generator	
	dk_exec(${python_exe} ${duktape}/tools/configure.py
		--output-directory ${duktape}/src
		-DDUK_CMDLINE_DEBUGGER_SUPPORT
		-DDUK_USE_DEBUGGER_DUMPHEAP
		-DDUK_USE_DEBUGGER_INSPECT
		-DDUK_USE_DEBUGGER_SUPPORT
		-DDUK_USE_FATAL_HANDLER
		-DDUK_USE_GLOBAL_BINDING
		-DDUK_USE_INTERRUPT_COUNTER)
	#dk_exec(${node_exe} ${duktape}/src-tools/index.js configure --output-directory ${duktape}/src --source-directory ${duktape}/src-input --config-directory ${duktape}/config)
endif()

dk_configure()

### COMPILE ###
dk_build()
