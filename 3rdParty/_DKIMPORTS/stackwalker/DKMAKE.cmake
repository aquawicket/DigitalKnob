# https://www.codeproject.com/Articles/11132/Walking-the-callstack-2
# https://github.com/ConnectedVision/connectedvision/tree/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0
# https://github.com/ConnectedVision/connectedvision/raw/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0/stackwalker-2014-12-28.zip
# https://www.codeproject.com/KB/threads/StackWalker/stackwalker.zip
# FIXME: Let's replace this with boost::stacktrace for cross platform support.
# https://www.boost.org/doc/libs/1_75_0/doc/html/stacktrace.html
if(NOT WIN_HOST)
	dk_undepend(stackwalker)
	dk_return()
endif()


### IMPORT ###
dk_import(https://github.com/ConnectedVision/connectedvision/raw/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0/stackwalker-2014-12-28.zip FOLDER stackwalker-2014-12-28 PATCH)


### LINK ###
dk_include			(${STACKWALKER}/StackWalker)
#UNIX_dk_libDebug	(${STACKWALKER}/${OS}/${DEBUG_DIR}/libstackwalker.a)
#UNIX_dk_libRelease	(${STACKWALKER}/${OS}/${RELEASE_DIR}/libstackwalker.a)
WIN_dk_libDebug		(${STACKWALKER}/${OS}/${DEBUG_DIR}/stackwalker.lib)
WIN_dk_libRelease	(${STACKWALKER}/${OS}/${RELEASE_DIR}/stackwalker.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${STACKWALKER})


### COMPILE ###
dk_build(${STACKWALKER})
