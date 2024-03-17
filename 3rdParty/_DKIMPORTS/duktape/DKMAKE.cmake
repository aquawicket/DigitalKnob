# https://duktape.org/duktape-2.6.0.tar.xz
# https://github.com/Squareys/duktape/tree/let-support
# https://github.com/aquawicket/duktape/archive/refs/heads/let-support.zip
# https://codeload.github.com/Squareys/duktape/zip/refs/heads/let-support
# https://github.com/svaarala/duktape/archive/refs/heads/master.zip
# https://wiki.duktape.org/projectsusingduktape


### DEPEND ###
dk_depend(python)
dk_depend(pyyaml)
#dk_depend(nodejs)
#dk_depend(msys2)


### IMPORT ###
dk_import(https://github.com/aquawicket/duktape.git PATCH) #NOTE: PATCH is for CMakeLists.txt
#dk_import(https://github.com/svaarala/duktape/releases/download/v2.7.0/duktape-2.7.0.tar.xz PATCH) #NOTE: PATCH is for CMakeLists.txt
#dk_import(https://github.com/svaarala/duktape.git PATCH) #NOTE: PATCH is for CMakeLists.txt


### LINK ###
if(MSVC)
	WIN_dk_define	(DUK_F_VBCC)
endif()
ANDROID_dk_define	(DUK_F_32BIT_PTRS)
dk_include			(${DUKTAPE}/src)

#UNIX_dk_libDebug	(${DUKTAPE}/${OS}/${DEBUG_DIR}/libduktape.a)
#UNIX_dk_libRelease	(${DUKTAPE}/${OS}/${RELEASE_DIR}/libduktape.a)
#WIN_dk_libDebug	(${DUKTAPE}/${OS}/${DEBUG_DIR}/duktape.lib)
#WIN_dk_libRelease	(${DUKTAPE}/${OS}/${RELEASE_DIR}/duktape.lib)
## TODO: create MSVC_dk_libDebug and MSVC_dk_libRelease
if(MSVC)
	dk_libDebug		(${DUKTAPE}/${OS}/${DEBUG_DIR}/duktape.lib)
	dk_libRelease	(${DUKTAPE}/${OS}/${RELEASE_DIR}/duktape.lib)
else()
	dk_libDebug		(${DUKTAPE}/${OS}/${DEBUG_DIR}/libduktape.a)
	dk_libRelease	(${DUKTAPE}/${OS}/${RELEASE_DIR}/libduktape.a)
endif()


### GENERATE ###
if(NOT EXISTS ${DUKTAPE}/src/duktape.c)
	#dk_executeProcess(${PYTHON_EXE} ${DUKTAPE}/util/dist.py)  # default generator	
	dk_executeProcess(${PYTHON_APP} ${DUKTAPE}/tools/configure.py
		--output-directory ${DUKTAPE}/src
		-DDUK_CMDLINE_DEBUGGER_SUPPORT
		-DDUK_USE_DEBUGGER_DUMPHEAP
		-DDUK_USE_DEBUGGER_INSPECT
		-DDUK_USE_DEBUGGER_SUPPORT
		-DDUK_USE_FATAL_HANDLER
		-DDUK_USE_GLOBAL_BINDING
		-DDUK_USE_INTERRUPT_COUNTER)
	#dk_executeProcess(${NODE_EXE} ${DUKTAPE}/src-tools/index.js configure --output-directory ${DUKTAPE}/src --source-directory ${DUKTAPE}/src-input --config-directory ${DUKTAPE}/config)
endif()

#dk_queueCommand(${DKCMAKE_BUILD} ${DUKTAPE})
dk_configure(${DUKTAPE})


### COMPILE ###
dk_build(${DUKTAPE}) # duktape)
