#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()


###############################################################################
# dk_depend(plugin) target
#
#	Each plugin invoked will fill a a varaible or it's name to the path where it
#   is installed..   
#   I.E.  dk_depend(zlib) =  dk_validate(ZLIB "dk_dependB(zlib)") 
#   Which says, "if ZLIB variable is not set,  call  3rdParty/_DKIMPORTS/zlib/DKMAKE.cmake
#   to fill fill ZLIB with the path zlib is installed to.
#
function(dk_depend plugin) #target
	dk_debugFunc(1 2)
	
	if(plugin IN_LIST dk_disabled_list)
		if(DISABLED_LIBS MATCHES "${plugin}")
			dk_append(DISABLED_LIBS "${plugin}") # this list is for the build.log
		endif()
		dk_notice("${plugin} IS DISABLED")
		return()
	endif()
	
	dk_toUpper("${plugin}" PLUGIN)
	dk_convertToCIdentifier(${PLUGIN} PLUGIN)
	if((NOT EXISTS ${PLUGIN}) OR (NOT EXISTS ${${PLUGIN}_DIR}))
		

		###### Push Plugin to the PLUGIN_STACK ######
		dk_envList(PLUGIN PUSH "${PLUGIN}")
		#############################################
	
		
	
		dk_notice("dk_depend(): loading ${PLUGIN} . . .")
		dk_dependB(${plugin})
	
		
	
		###### Pop Plugin from the PLUGIN_STACK######
		dk_envList(PLUGIN POP)
		#dk_notice("POP ENV{CURRENT_PLUGIN} = $ENV{CURRENT_PLUGIN}")
		#############################################
		
	else()
		dk_notice("dk_depend(): ${PLUGIN} is already loaded")
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(zlib)
endfunction()