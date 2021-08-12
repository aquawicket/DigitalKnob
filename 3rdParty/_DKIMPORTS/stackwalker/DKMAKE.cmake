# FIXME: Let's replace this with boost::stacktrace for cross platform support.
# https://www.boost.org/doc/libs/1_75_0/doc/html/stacktrace.html

### VERSION ###
DKSET(STACKWALKER_VERSION 2014-12-28)
DKSET(STACKWALKER ${3RDPARTY}/stackwalker)


### INSTALL ###
## https://github.com/ConnectedVision/connectedvision/raw/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0/stackwalker-2014-12-28.zip
DKINSTALL(https://github.com/ConnectedVision/connectedvision/raw/master/build_env/Conan/packages/StackWalker/2014.12.28/2.3.0/stackwalker-${STACKWALKER_VERSION}.zip stackwalker ${STACKWALKER})


### LINK ###
## DKINCLUDE(${STACKWALKER})