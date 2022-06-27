# https://www.codeproject.com/Articles/11132/Walking-the-callstack-2
# https://github.com/ConnectedVision/connectedvision/tree/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0
#
# https://github.com/ConnectedVision/connectedvision/raw/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0/stackwalker-2014-12-28.zip
# https://www.codeproject.com/KB/threads/StackWalker/stackwalker.zip
# 
# FIXME: Let's replace this with boost::stacktrace for cross platform support.
# https://www.boost.org/doc/libs/1_75_0/doc/html/stacktrace.html

if(NOT WIN_HOST)
	return()
endif()


#dk_set(STACKWALKER_VERSION 2013-01-07-v14)
#dk_set(STACKWALKER_NAME stackwalker-${STACKWALKER_VERSION})
#dk_set(STACKWALKER_DL https://github.com/ConnectedVision/connectedvision/raw/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0/stackwalker-2014-12-28.zip)
#dk_set(STACKWALKER ${3RDPARTY}/${STACKWALKER_NAME})
#dk_install(${STACKWALKER_DL} ${STACKWALKER})
dk_import(https://github.com/ConnectedVision/connectedvision/raw/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0/stackwalker-2014-12-28.zip)


### LINK ###
dk_include(${STACKWALKER}/StackWalker)
