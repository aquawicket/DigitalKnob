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


