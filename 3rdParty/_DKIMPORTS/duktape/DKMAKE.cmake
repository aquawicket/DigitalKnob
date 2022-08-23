# https://duktape.org/duktape-2.6.0.tar.xz
# https://github.com/Squareys/duktape/tree/let-support
# https://github.com/aquawicket/duktape/archive/refs/heads/let-support.zip
# https://codeload.github.com/Squareys/duktape/zip/refs/heads/let-support
# https://github.com/svaarala/duktape/archive/refs/heads/master.zip
# https://wiki.duktape.org/projectsusingduktape


dk_depend(python)
dk_depend(nodejs)


#dk_import(https://github.com/aquawicket/duktape/archive/0701a460ca25c2dc76a96bd3187849ca278d1865.zip PATCH)
dk_import(https://github.com/aquawicket/duktape.git PATCH) #NOTE: PATCH is for CMakeLists.txt


if(NOT EXISTS ${DUKTAPE}/dist/src/duktape.c)
	dk_setPath(${DUKTAPE})
	
	WIN_dk_executeProcess(${PYTHON}/Scripts/pip install PyYAML)
	#WIN_dk_executeProcess(${PYTHON_EXE} ${DUKTAPE}/util/dist.py)  #default generator
	WIN_dk_makeDirectory(${DUKTAPE}/dist)
	WIN_dk_executeProcess(${PYTHON_APP} ${DUKTAPE}/tools/configure.py
		--output-directory ${DUKTAPE}/dist/src
		-DDUK_USE_GLOBAL_BINDING 
		-DDUK_USE_FATAL_HANDLER 
		-DDUK_USE_DEBUGGER_SUPPORT 
		-DDUK_USE_INTERRUPT_COUNTER 
		-DDUK_USE_DEBUGGER_DUMPHEAP 
		-DDUK_USE_DEBUGGER_INSPECT)
	
	MAC_dk_executeProcess(pip install PyYAML)
	#MAC_dk_executeProcess(python ${DUKTAPE}/util/dist.py) #default generator
	MAC_dk_executeProcess(${PYTHON_APP} ${DUKTAPE}/tools/configure.py
		--output-directory ${DUKTAPE}/dist/src
		-DDUK_USE_GLOBAL_BINDING 
		-DDUK_USE_FATAL_HANDLER 
		-DDUK_USE_DEBUGGER_SUPPORT 
		-DDUK_USE_INTERRUPT_COUNTER 
		-DDUK_USE_DEBUGGER_DUMPHEAP 
		-DDUK_USE_DEBUGGER_INSPECT)

	LINUX_dk_executeProcess(sudo apt-get -y install python python-yaml)
	#LINUX_dk_executeProcess(python ${DUKTAPE}/util/dist.py) #default generator
	LINUX_dk_executeProcess(${PYTHON_APP} ${DUKTAPE}/tools/configure.py
		--output-directory ${DUKTAPE}/dist/src
		-DDUK_USE_GLOBAL_BINDING 
		-DDUK_USE_FATAL_HANDLER 
		-DDUK_USE_DEBUGGER_SUPPORT 
		-DDUK_USE_INTERRUPT_COUNTER 
		-DDUK_USE_DEBUGGER_DUMPHEAP 
		-DDUK_USE_DEBUGGER_INSPECT)

	#dk_copy(${DUKTAPE}/dist/src/ ${DUKTAPE}/src OVERWRITE)
endif()


#dk_import(https://codeload.github.com/nodeca/js-yaml/zip/refs/tags/3.14.1 ${DUKTAPE_NAME}/src-tools/lib/extdeps/js-yaml)
#WIN32_dk_executeProcess(${NODE_EXE} ${DUKTAPE}/src-tools/index.js configure --output-directory ${DUKTAPE}/src --source-directory ${DUKTAPE}/src-input --config-directory ${DUKTAPE}/config)

### LINK ###
IF(WIN)
	dk_define(DUK_F_VBCC)
ENDIF()
IF(ANDROID)
	##dk_define(DUK_F_32BIT_PTRS)
ENDIF()
