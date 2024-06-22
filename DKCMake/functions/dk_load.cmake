include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

##################################################################################
# dk_load(funcName OR funcPath)
#
#	Source a dk_cmake function. Download it if needed then parse it and source all of it's content dk_cmake functions recursivley.
#
#	@funcName OR funcPath  - The name of an existing "functions/funcname.cmake" file, or a full filepath to a .cmake file.
#
macro(dk_load var)
	#dk_debugFunc(${ARGV})
	
	
	string(STRIP ${var} funcName)
	get_filename_component(name_we "${funcName}" NAME_WE)
	if("${name_we}" STREQUAL "DKMAKE")
		#TESTME
		dk_getDirname("${funcName}" funcDir)
		message("funcDir = ${funcDir}")
		if(funcDir)
			set(funcName ${funcDir})
		endif()
		dk_getBasename("${funcName}" funcName)
		message("funcName = ${funcName}")
		if(funcName)
			set(funcName ${fnName})
		endif()
	else()
		set(funcName ${name_we})
	endif()
	
	#NOTE: Loading a file with the name of an existing function will cause this to fail
	if(COMMAND ${funcName})
		message("dk_load(${funcName}) function already loaded")
	elseif(COMMAND ${var})
		message("dk_load(${var}) function already loaded")
	else()
		dk_parseFunctionsAndLoad(${funcName} ${var})
	endif()
endmacro()

macro(dk_parseFunctionsAndLoad funcName funcPath)
	#message("dk_parseFunctionsAndLoad(${ARGV})") #dk_debugFunc(${ARGV})
	
	
	if(NOT DKFUNCTIONS_LIST)
		set(DKFUNCTIONS_LIST "" CACHE INTERNAL "")
	endif()
	
	# allow only dk_nnn fuction names 
	#if(NOT "${funcName}" MATCHES "[Dd][Kk]_[A-Za-z0-9_]")
	#	message(WARNING "${funcName} is NOT a valid function name")
	#endif()
	
	if(EXISTS ${DKCMAKE_FUNCTIONS_DIR}/${funcPath}.cmake)
		set(${funcName}_file ${DKCMAKE_FUNCTIONS_DIR}/${funcPath}.cmake)
	elseif(EXISTS $ENV{DKCMAKE_DIR}/functions/${funcPath}.cmake)
		set(${funcName}_file $ENV{DKCMAKE_DIR}/functions/${funcPath}.cmake)
	elseif(EXISTS ${funcPath})
		set(${funcName}_file ${funcPath})
	else()
		message(FATAL_ERROR "${funcPath}: file not found")
	endif()
			
	if(${${funcName}_file} IN_LIST DKFUNCTIONS_LIST)
		message(DEBUG "dk_load(${funcName}) function already in list @ ${${funcName}_file}")
		message(VERBOSE  "DKFUNCTIONS_LIST = ${DKFUNCTIONS_LIST}")
	else()
		message(VERBOSE "loading ${${funcName}_file}")
		set(DKFUNCTIONS_LIST ${DKFUNCTIONS_LIST} ${${funcName}_file} CACHE INTERNAL "")
		list(REMOVE_DUPLICATES DKFUNCTIONS_LIST)
				
		message(VERBOSE "${funcName}_file = ${${funcName}_file}")
		file(READ ${${funcName}_file} ${funcName}_contents)
				
		## Match text that contains *dk_*( 		I.E.  WIN_HOST_dk_, MAC_X86_64_dk_, dk_
		string(REGEX MATCHALL "[A-Za-z0-9_]*[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" ${funcName}_matches "${${funcName}_contents}")
		unset(${funcName}_contents)
		list(REMOVE_DUPLICATES ${funcName}_matches)
		foreach(${funcName}_match ${${funcName}_matches})
			if(NOT ${funcName}_match)
				continue()
			endif()
				
			message(VERBOSE "match-in = ${${funcName}_match}")
				
			## remove any prefix to dk_*( 		I.E.  WIN_HOST_dk_  becomes dk_
			string(REGEX MATCH "[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" ${funcName}_match ${${funcName}_match})
			message(VERBOSE "match-out = ${${funcName}_match}")
				
			string(STRIP ${${funcName}_match} ${funcName}_match)
			string(REPLACE "\t" "" ${funcName}_match ${${funcName}_match})
			string(REPLACE "\r" "" ${funcName}_match ${${funcName}_match})
			string(REPLACE "\n" "" ${funcName}_match ${${funcName}_match})
			string(REPLACE "(" "" ${funcName}_match ${${funcName}_match})
			message(VERBOSE "match-stripped = ${${funcName}_match}")
					
			message(VERBOSE "${funcName}_match  ${${funcName}_match}")
			if(${${funcName}_match} IN_LIST DKFUNCTIONS_LIST)
				message(VERBOSE "${funcName} -> ${${funcName}_match} already in list")
				continue()
			elseif(${${funcName}_match} STREQUAL ${funcName})
				message(VERBOSE "${funcName} -> ${${funcName}_match} match cannot load itself")
				continue()
			elseif(COMMAND ${${funcName}_match})
				message(VERBOSE "${funcName} -> ${${funcName}_match} already loaded")
				continue()
			else()
				message(VERBOSE "${funcName} -> loading ${${funcName}_match}")
				dk_load(${${funcName}_match})
			endif()
		endforeach()
			
		message(DEBUG "include(${${funcName}_file})")
		include(${${funcName}_file})
		
		### variable clean-up ###
		unset(${funcName}_file)
		unset(${funcName}_match)
		unset(${funcName}_matches)
	endif()
endmacro()

function(dk_parseFunctionsAndLoadFromString str)
	#dk_debugFunc(${ARGV})
	
	
	## Match text that contains *dk_*( 		I.E.  WIN_HOST_dk_function(,  MAC_X86_64_dk_function(  or  dk_function(
	string(REGEX MATCHALL "[A-Za-z0-9_]*[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" matches "${str}")
	unset(str)
	list(REMOVE_DUPLICATES matches)
	foreach(match ${matches})
		if(NOT match)
			continue()
		endif()
				
		message(VERBOSE "match-in = ${match}")
				
		## remove any prefix to dk_*( 		I.E.  WIN_HOST_dk_  becomes dk_
		string(REGEX MATCH "[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" match ${match})
		message(VERBOSE "match-out = ${match}")
				
		string(STRIP ${match} match)
		string(REPLACE "\t" "" match ${match})
		string(REPLACE "\r" "" match ${match})
		string(REPLACE "\n" "" match ${match})
		string(REPLACE "(" "" match ${match})
		message(VERBOSE "match-stripped = ${match}")
				
		message(VERBOSE "match  ${match}")
		if(${match} IN_LIST DKFUNCTIONS_LIST)
			message(VERBOSE "${match} already in list")
			continue()
		elseif(COMMAND ${match})
			message(VERBOSE "${match} already loaded")
			continue()
		else()
			message(VERBOSE "loading ${match}")
			dk_load(${match})
		endif()
	endforeach()
endfunction(dk_parseFunctionsAndLoadFromString)

#if(dk_load IN_LIST DKFUNCTIONS_LIST) 
#	set(DKFUNCTIONS_LIST dk_load CACHE INTERNAL "")
#endif()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction(DKTEST)