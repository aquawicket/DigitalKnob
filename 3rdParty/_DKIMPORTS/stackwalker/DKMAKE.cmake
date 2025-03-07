#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ stackwalker ############
# https://www.codeproject.com/Articles/11132/Walking-the-callstack-2
# https://github.com/ConnectedVision/connectedvision/tree/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0
# https://github.com/ConnectedVision/connectedvision/raw/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0/stackwalker-2014-12-28.zip
# https://www.codeproject.com/KB/threads/StackWalker/stackwalker.zip
# FIXME: Let's replace this with boost::stacktrace for cross platform support.
# https://www.boost.org/doc/libs/1_75_0/doc/html/stacktrace.html
dk_load(dk_builder)
if(NOT MSVC)
	dk_undepend	(stackwalker)
	dk_disable	(stackwalker)
	dk_return	()
endif()

### IMPORT ###
dk_import(https://github.com/ConnectedVision/connectedvision/raw/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0/stackwalker-2014-12-28.zip FOLDER stackwalker-2014-12-28 PATCH)

### LINK ###
dk_include		(${STACKWALKER}/StackWalker)
dk_libDebug		(${STACKWALKER_DEBUG_DIR}/stackwalker.lib)
dk_libRelease	(${STACKWALKER_RELEASE_DIR}/stackwalker.lib)

### GENERATE ###
dk_configure	(${STACKWALKER})

### COMPILE ###
dk_build		(${STACKWALKER})
