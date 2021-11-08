# http://autogen.sourceforge.net
# https://macappstore.org/autogen/

if(CMAKE_HOST_APPLE)
	MAC_COMMAND(brew install autogen)
	MAC_COMMAND(brew install autoconf)
	MAC_COMMAND(brew install automake)
endif()
