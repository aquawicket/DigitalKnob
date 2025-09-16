#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_dependB(Plugin)
#
#	Add a library or Plugin to the dependency list
#
#	@Plugin		- TODO
#
function(dk_dependB Plugin)
	dk_debugFunc()
	
#	if(Plugin IN_LIST init_list)
#		dk_debug("${Plugin} is allready in init_list")
#		return()  #Plugin is already in the init_list
#	endif()
#	dk_append(init_list "${Plugin}")
	
	dk_getPathToPlugin(${Plugin} Plugin_Path)
	
	###### Load the dkconfig.txt file ######
	if(EXISTS "${Plugin_Path}/dkconfig.txt")
		dk_getFileParams("${Plugin_Path}/dkconfig.txt")
		dk_success("Loaded ${Plugin_Path}/dkconfig.txt")
	else()
		dk_warning("${Plugin_Path}/dkconfig.txt NOT FOUND.")
	endif()
	
	###### Load the DKINSTALL.cmake file ######
#	dk_debug("dk_load(${Plugin_Path}/DKINSTALL.cmake)")
#	dk_load(${Plugin_Path}/DKINSTALL.cmake)
	
#	if(${ARGC} GREATER 1)
#		dk_info(ARGV)
#		dk_dump(ARGV) # FIXME: DUMP not working here, show 2 for the ARGC count, but only shows variable Plugin ARGV, no value
#	endif()

	if(Plugin IN_LIST dkdisabled_list)
		if(DISABLED_LIBS MATCHES "${Plugin}")
			dk_append(DISABLED_LIBS "${Plugin}") # this list is for the build.log
		endif()
		dk_notice("${Plugin} IS DISABLED")
		return()
	endif()
	
#	If dk_depend had second variable (a sub library), set that variable to ON
#	if(${ARGC} GREATER 1)
#	if(dkdepend_list MATCHES "${Plugin} ${args}")
#		return()  #library is already in the list
#	endif()
#	else()
#		if(dkdepend_list MATCHES "${Plugin}")
#			return() #library is already in the list
#		endif()
#	endif()
		
	if(Plugin IN_LIST dkdepend_list)
		#dk_verbose("${Plugin} already in dkdepend_list")
		return()  #library is already in the list
	endif()
	
	dk_enable(${Plugin})
	dk_runDepends(${Plugin}) # strip everything from the file except if() else() elseif() endif() and dk_depend() before sorting.
#	else()
#		if(dkdepend_list MATCHES "${Plugin}")
#			return() #library is already in the list
#		endif()
#		dk_runDepends(${Plugin}) # strip everything from the file except if() else() elseif() endif() and dk_depend() before sorting.
#	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_dependB(todo) #TODO
endfunction()