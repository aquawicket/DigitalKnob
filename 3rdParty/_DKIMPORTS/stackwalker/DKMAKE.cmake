# FIXME: Let's replace this with boost::stacktrace for cross platform support.
# https://www.boost.org/doc/libs/1_75_0/doc/html/stacktrace.html
IF(NOT CMAKE_HOST_WIN32)
	RETURN()
ENDIF()

DKSET(STACKWALKER ${3RDPARTY}/stackwalker)


### INSTALL ###
IF(NOT EXISTS ${3RDPARTY}/stackwalker)
	DKSETPATH(${DIGITALKNOB}/Download)
	DKDOWNLOAD(https://github.com/ConnectedVision/connectedvision/raw/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0/stackwalker-2014-12-28.zip)
	DKEXTRACT(${DIGITALKNOB}/Download/stackwalker-2014-12-28.zip ${3RDPARTY})
	DKRENAME(${3RDPARTY}/Main ${3RDPARTY}/stackwalker)
	DKCOPY(${DKIMPORTS}/stackwalker ${3RDPARTY}/stackwalker TRUE)
ENDIF()


### LINK ###
## DKINCLUDE(${STACKWALKER})