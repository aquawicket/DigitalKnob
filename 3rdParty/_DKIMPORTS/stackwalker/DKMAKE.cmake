# https://www.codeproject.com/Articles/11132/Walking-the-callstack-2
# https://github.com/ConnectedVision/connectedvision/tree/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0
#
# https://github.com/ConnectedVision/connectedvision/raw/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0/stackwalker-2014-12-28.zip
# https://www.codeproject.com/KB/threads/StackWalker/stackwalker.zip

if(NOT WIN_HOST)
	return()
endif()

# FIXME: Let's replace this with boost::stacktrace for cross platform support.
# https://www.boost.org/doc/libs/1_75_0/doc/html/stacktrace.html

### VERSION ###
DKSET(STACKWALKER_VERSION 2013-01-07-v14)
DKSET(STACKWALKER_NAME stackwalker-${STACKWALKER_VERSION})
DKSET(STACKWALKER_DL https://github.com/ConnectedVision/connectedvision/raw/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0/stackwalker-2014-12-28.zip)
DKSET(STACKWALKER ${3RDPARTY}/${STACKWALKER_NAME})


### INSTALL ###

DKINSTALL(${STACKWALKER_DL} stackwalker ${STACKWALKER})


### LINK ###
DKINCLUDE(${STACKWALKER}/StackWalker)