#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKXml ############
dk_depend(libxml2)
dk_depend(pugixml)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()


#dk_copy(${PUGIXML}/src/pugixml.hpp ${DKPLUGINS_DIR}/DKXml/pugixml.hpp)
dk_copy(${PUGIXML}/src/pugixml.cpp ${DKPLUGINS_DIR}/DKXml/pugixml.cpp)
dk_include(${PUGIXML}/src)
dk_include(${LIBXML2}/include)
dk_generateCmake(DKXml)
