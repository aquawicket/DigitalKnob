include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

##################################################################################
# dk_load(var)
#
#	load a .cmake file and parse/load all of it's containing dk_function file recursivley 
#
#	@var  - The name of an eisting function/file or a full file path to a .cmake file.
#
macro(dk_load var)
	#message("dk_load(${ARGV})") #dk_debugFunc(${ARGV})
	
	
	string(STRIP ${var} fn)
	get_filename_component(name_we "${fn}" NAME_WE)
	if("${name_we}" STREQUAL "DKMAKE")
		#TESTME
		dk_getDirname("${fn}" fnDir)
		message("fnDir = ${fnDir}")
		if(fnDir)
			set(fn ${fnDir})
		endif()
		dk_getBasename("${fn}" fnName)
		message("fnName = ${fnName}")
		if(fnName)
			set(fn ${fnName})
		endif()
	else()
		set(fn ${name_we})
	endif()
	
	#NOTE: Loading a file with the name of an existing function will cause this to fail
	if(COMMAND ${fn})
		message("dk_load(${fn}) function already loaded")
	elseif(COMMAND ${var})
		message("dk_load(${var}) function already loaded")
	else()
		dk_parseFunctionsAndLoad(${fn} ${var})
	endif()
endmacro()

macro(dk_parseFunctionsAndLoad fn fpath)
	#message("dk_parseFunctionsAndLoad(${ARGV})") #dk_debugFunc(${ARGV})
	
	
	if(NOT dk_load_list)
		set(dk_load_list "" CACHE INTERNAL "")
	endif()
	
	# allow only dk_nnn fuction names 
	#if(NOT "${fn}" MATCHES "[Dd][Kk]_[A-Za-z0-9_]")
	#	message(WARNING "${fn} is NOT a valid function name")
	#endif()
	
	if(EXISTS ${DKCMAKE_FUNCTIONS_DIR}/${fpath}.cmake)
		set(${fn}_file ${DKCMAKE_FUNCTIONS_DIR}/${fpath}.cmake)
	elseif(EXISTS $ENV{DKCMAKE_DIR}/functions/${fpath}.cmake)
		set(${fn}_file $ENV{DKCMAKE_DIR}/functions/${fpath}.cmake)
	elseif(EXISTS ${fpath})
		set(${fn}_file ${fpath})
	else()
		message(FATAL_ERROR "${fpath}: file not found")
	endif()
			
	if(${${fn}_file} IN_LIST dk_load_list)
		message(DEBUG "dk_load(${fn}) function already in list @ ${${fn}_file}")
		message(VERBOSE  "dk_load_list = ${dk_load_list}")
	else()
		message(VERBOSE "loading ${${fn}_file}")
		set(dk_load_list ${dk_load_list} ${${fn}_file} CACHE INTERNAL "")
		list(REMOVE_DUPLICATES dk_load_list)
				
		message(VERBOSE "${fn}_file = ${${fn}_file}")
		file(READ ${${fn}_file} ${fn}_contents)
				
		## Match text that contains *dk_*( 		I.E.  WIN_HOST_dk_, MAC_X86_64_dk_, dk_
		string(REGEX MATCHALL "[A-Za-z0-9_]*[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" ${fn}_matches "${${fn}_contents}")
		unset(${fn}_contents)
		list(REMOVE_DUPLICATES ${fn}_matches)
		foreach(${fn}_item ${${fn}_matches})
			if(NOT ${fn}_item)
				continue()
			endif()
				
			message(VERBOSE "item-in = ${${fn}_item}")
				
			## remove any prefix to dk_*( 		I.E.  WIN_HOST_dk_  becomes dk_
			string(REGEX MATCH "[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" ${fn}_item ${${fn}_item})
			message(VERBOSE "item-out = ${${fn}_item}")
				
			string(STRIP ${${fn}_item} ${fn}_item)
			string(REPLACE "\t" "" ${fn}_item ${${fn}_item})
			string(REPLACE "\r" "" ${fn}_item ${${fn}_item})
			string(REPLACE "\n" "" ${fn}_item ${${fn}_item})
			string(REPLACE "(" "" ${fn}_item ${${fn}_item})
			message(VERBOSE "item-stripped = ${${fn}_item}")
					
			message(VERBOSE "${fn}_item  ${${fn}_item}")
			if(${${fn}_item} IN_LIST dk_load_list)
				message(VERBOSE "${fn} -> ${${fn}_item} already in list")
				continue()
			elseif(${${fn}_item} STREQUAL ${fn})
				message(VERBOSE "${fn} -> ${${fn}_item} item cannot load itself")
				continue()
			elseif(COMMAND ${${fn}_item})
				message(VERBOSE "${fn} -> ${${fn}_item} already loaded")
				continue()
			else()
				message(VERBOSE "${fn} -> loading ${${fn}_item}")
				dk_load(${${fn}_item})
			endif()
		endforeach()
			
		message(DEBUG "include(${${fn}_file})")
		include(${${fn}_file})
		
		### variable clean-up ###
		unset(${fn}_file)
		unset(${fn}_item)
		unset(${fn}_matches)
	endif()
endmacro()

function(dk_parseFunctionsAndLoadFromString str)
	#message("dk_debugFunc(${ARGV})") #dk_debugFunc(${ARGV})
	
	
	## Match text that contains *dk_*( 		I.E.  WIN_HOST_dk_function(,  MAC_X86_64_dk_function(  or  dk_function(
	string(REGEX MATCHALL "[A-Za-z0-9_]*[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" matches "${str}")
	unset(str)
	list(REMOVE_DUPLICATES matches)
	foreach(item ${matches})
		if(NOT item)
			continue()
		endif()
				
		message(VERBOSE "item-in = ${item}")
				
		## remove any prefix to dk_*( 		I.E.  WIN_HOST_dk_  becomes dk_
		string(REGEX MATCH "[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" item ${item})
		message(VERBOSE "item-out = ${item}")
				
		string(STRIP ${item} item)
		string(REPLACE "\t" "" item ${item})
		string(REPLACE "\r" "" item ${item})
		string(REPLACE "\n" "" item ${item})
		string(REPLACE "(" "" item ${item})
		message(VERBOSE "item-stripped = ${item}")
				
		message(VERBOSE "item  ${item}")
		if(${item} IN_LIST dk_load_list)
			message(VERBOSE "${item} already in list")
			continue()
		elseif(COMMAND ${item})
			message(VERBOSE "${item} already loaded")
			continue()
		else()
			message(VERBOSE "loading ${item}")
			dk_load(${item})
		endif()
	endforeach()
endfunction(dk_parseFunctionsAndLoadFromString)

#if(dk_load IN_LIST dk_load_list) 
#	set(dk_load_list dk_load CACHE INTERNAL "")
#endif()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction(DKTEST)