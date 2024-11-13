#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### [cosmocc] ######
# https://cosmo.zip

dk_load(dk_builder)

dk_import(https://cosmo.zip/pub/cosmocc/cosmocc.zip)


dk_set(COSMO_AR				${COSMOCC}/bin/cosmoar)
dk_set(COSMO_C_COMPILER   	${COSMOCC}/bin/cosmocc)
dk_set(COSMO_CXX_COMPILER 	${COSMOCC}/bin/cosmoc++)
dk_set(COSMO_MAKE_PROGRAM 	${COSMOCC}/bin/make)
#dk_set(COSMO_RC_COMPILER  	${COSMOCC}/bin/???)
dk_set(COSMO_RANLIB			${COSMOCC}/bin/cosmoranlib)


###### set GLOBAL CMAKE VARIABLES ######
if(NOT CMAKE_C_COMPILER)
	dk_set(CMAKE_C_COMPILER		${COSMO_C_COMPILER})
endif()
if(NOT CMAKE_CXX_COMPILER)
	dk_set(CMAKE_CXX_COMPILER	${COSMO_CXX_COMPILER})
endif()
#dk_set(CMAKE_RC_COMPILER	${COSMO_RC_COMPILER})

dk_set(DKCONFIGURE_CC		${CMAKE_C_COMPILER})
dk_set(DKCONFIGURE_CXX		${CMAKE_CXX_COMPILER})