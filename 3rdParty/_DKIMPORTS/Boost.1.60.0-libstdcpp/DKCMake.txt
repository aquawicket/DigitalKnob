IF(NOT CMAKE_HOST_APPLE)
	RETURN()
ENDIF()
IF(MAC)
	RETURN() #iOS only
ENDIF()


### VERSION ###
DKSET(BOOST_VERSION 1.60.0)
DKSET(BOOST ${3RDPARTY}/Boost.${BOOST_VERSION}-libstdcpp)


### INSTALL ###
## FIXME
DKINSTALL(http://www.internet.com/Boost.${BOOST_VERSION}-libstdcpp.zip Boost.1.60.0-libstdcpp Boost.${BOOST_VERSION}-libstdcpp)


### DKPLUGINS LINK ###
DKINCLUDE(${BOOST})
LINK_DIRECTORIES(${BOOST}/libs/boost/ios)
DKINCLUDE(${BOOST}/libs/boost/include)
IOS_DEBUG_LIB(${BOOST}/libs/boost/ios/libboost.a)
IOS_RELEASE_LIB(${BOOST}/libs/boost/ios/libboost.a)
IOSSIM_DEBUG_LIB(${BOOST}/libs/boost/ios/libboost.a)
IOSSIM_RELEASE_LIB(${BOOST}/libs/boost/ios/libboost.a)
