# https://duktape.org/duktape-2.6.0.tar.xz
# https://github.com/Squareys/duktape/tree/let-support
#
# https://github.com/aquawicket/duktape/archive/refs/heads/let-support.zip
# https://codeload.github.com/Squareys/duktape/zip/refs/heads/let-support
# https://github.com/svaarala/duktape/archive/refs/heads/master.zip
#
# https://wiki.duktape.org/projectsusingduktape

dk_depend(python)
dk_depend(nodejs)

dk_import(https://github.com/aquawicket/duktape.git PATCH)

#dk_import(https://github.com/aquawicket/duktape/archive/0701a460ca25c2dc76a96bd3187849ca278d1865.zip PATCH)

#dk_set(DUKTAPE_VERSION let-support)
#dk_set(DUKTAPE_NAME duktape-${DUKTAPE_VERSION})
#dk_set(DUKTAPE_DL https://github.com/aquawicket/duktape/archive/refs/heads/${DUKTAPE_VERSION}.zip)
#dk_set(DUKTAPE ${3RDPARTY}/${DUKTAPE_NAME})
#dk_install(${DUKTAPE_DL} duktape ${DUKTAPE})


if(NOT EXISTS ${DUKTAPE}/src)
dk_setPath(${DUKTAPE})
dk_set(QUEUE_BUILD ON)

LINUX_DKQCOMMAND(sudo apt-get -y install python python-yaml)
LINUX_DKQCOMMAND(python ${DUKTAPE}/util/dist.py)

WIN_DKQCOMMAND(${PYTHON}/Scripts/pip install PyYAML)
WIN_DKQCOMMAND(${PYTHON_EXE} ${DUKTAPE}/util/dist.py)
dk_copy(${DUKTAPE}/dist/src/ ${DUKTAPE}/src TRUE)

#dk_install(https://codeload.github.com/nodeca/js-yaml/zip/refs/tags/3.14.1 js-yaml-3.14.1 ${DUKTAPE_NAME}/src-tools/lib/extdeps/js-yaml)
#WIN32_DKQCOMMAND(${NODE_EXE} ${DUKTAPE}/src-tools/index.js configure --output-directory ${DUKTAPE}/src --source-directory ${DUKTAPE}/src-input --config-directory ${DUKTAPE}/config)
endif()


#if(NOT EXISTS ${DUKTAPE}/src/duktape.cpp)
#	dk_copy(${DUKTAPE}/src/duktape.c ${DUKTAPE}/src/duktape.cpp FALSE)
#endif()
#if(NOT EXISTS ${DUKTAPE}/examples/eventloop/poll.cpp)
#	dk_copy(${DUKTAPE}/examples/eventloop/poll.c ${DUKTAPE}/examples/eventloop/poll.cpp FALSE)
#endif()
#if(NOT EXISTS ${DUKTAPE}/examples/eventloop/c_eventloop.cpp)
#	dk_copy(${DUKTAPE}/examples/eventloop/c_eventloop.c ${DUKTAPE}/examples/eventloop/c_eventloop.cpp FALSE)
#endif()



### LINK ###
IF(WIN)
	dk_define(DUK_F_VBCC)
ENDIF()
IF(ANDROID)
	##dk_define(DUK_F_32BIT_PTRS)
ENDIF()
