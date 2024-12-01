#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_depend(plugin)
#
#	Each plugin invoked will fill a a varaible or it's name to the path where it
#   is installed..   
#   I.E.  dk_depend(zlib) =  dk_validate(ZLIB "dk_dependB(zlib)") 
#   Which says, "if ZLIB variable is not set,  call  3rdParty/_DKIMPORTS/zlib/DKMAKE.cmake
#   to fill fill ZLIB with the path zlib is installed to.
#
function(dk_depend plugin)
	dk_toUpper("${plugin}" PLUGIN)
	dk_convertToCIdentifier(${PLUGIN} PLUGIN)
	dk_validate(${PLUGIN} "dk_dependB(${plugin})")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(zlib)
endfunction()