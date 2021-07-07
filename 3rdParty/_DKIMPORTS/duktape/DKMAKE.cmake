## DKDEPEND(python)
## DKDEPEND(nodejs)

### VERSION ###
##DKSET(DUKTAPE_VERSION 2.6.0)
##DKSET(DUKTAPE_VERSION master)
DKSET(DUKTAPE_VERSION let-support)

### INSTALL ###
## https://duktape.org/duktape-2.6.0.tar.xz
## https://github.com/svaarala/duktape/archive/refs/heads/master.zip
## https://codeload.github.com/Squareys/duktape/zip/refs/heads/let-support
DKINSTALL(https://codeload.github.com/Squareys/duktape/zip/refs/heads/${DUKTAPE_VERSION} duktape duktape-${DUKTAPE_VERSION})
##DKINSTALL(https://duktape.org/duktape-${DUKTAPE_VERSION}.tar.xz duktape duktape-${DUKTAPE_VERSION})
DKSET(DUKTAPE ${3RDPARTY}/duktape-${DUKTAPE_VERSION})

IF(NOT EXISTS ${DUKTAPE}/src)
DKSETPATH(${DUKTAPE})
DKSET(QUEUE_BUILD ON)

LINUX_COMMAND(sudo apt-get install python python-yaml)
LINUX_COMMAND(python ${DUKTAPE}/util/dist.py)

WIN32_COMMAND(${PYTHON}/Scripts/pip install PyYAML)
WIN32_COMMAND(${PYTHON_EXE} ${DUKTAPE}/util/dist.py)
DKCOPY(${DUKTAPE}/dist/src/ ${DUKTAPE}/src TRUE)

#DKINSTALL(https://codeload.github.com/nodeca/js-yaml/zip/refs/tags/3.14.1 js-yaml-3.14.1 duktape-${DUKTAPE_VERSION}/src-tools/lib/extdeps/js-yaml)
#WIN32_COMMAND(${NODE_EXE} ${DUKTAPE}/src-tools/index.js configure --output-directory ${DUKTAPE}/src --source-directory ${DUKTAPE}/src-input --config-directory ${DUKTAPE}/config)
ENDIF()

### LINK ###
IF(WIN)
	DKDEFINE(DUK_F_VBCC)
ENDIF()
IF(ANDROID)
	##DKDEFINE(DUK_F_32BIT_PTRS)
ENDIF()
