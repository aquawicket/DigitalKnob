include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

##################################################################################
# dk_load(fn)
#
#	load a ${fn}.cmake file located in the DKCMake path 
#
#	@fn	- TODO
#
macro(dk_load var)
	#dk_debugFunc(${ARGV})
	message("dk_load(${ARGV})")
	
	string(STRIP ${var} fn)
	
	get_filename_component(name_we "${fn}" NAME_WE)
	if("${name_we}" STREQUAL "DKMAKE")
		dk_getDirname("${fn}" fnDir)
		#message("fnDir = ${fnDir}")
		if(fnDir)
			set(fn ${fnDir})
		endif()
		dk_getBasename("${fn}" fnName)
		#message("fnName = ${fnName}")
		if(fnName)
			set(fn ${fnName})
		endif()
	else()
		set(fn ${name_we})
	endif()
	
	if(COMMAND ${fn})
		#message(VERBOSE "dk_load(${fn}) function already loaded")
	elseif(COMMAND ${var})
		#message(VERBOSE "dk_load(${var}) function already loaded")
	else()
		dk_parseFunctionsAndLoad(${fn} ${var})
	endif()
endmacro()

macro(dk_parseFunctionsAndLoad fn fpath)
	#dk_debugFunc(${ARGV})
	if(NOT dk_load_list)
		set(dk_load_list "" CACHE INTERNAL "")
	endif()
	
	
	#message("dk_parseFunctionsAndLoad(${ARGV})")
	if(NOT "${fn}" MATCHES "[Dd][Kk]_[A-Za-z0-9_]")
		#message(WARNING "${fn} is NOT a valid function name")
	endif()
	
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
		#message(DEBUG "dk_load(${fn}) function already in list @ ${${fn}_file}")
		#message(VERBOSE  "dk_load_list = ${dk_load_list}")
	else()
		#message(VERBOSE "loading ${${fn}_file}")
		set(dk_load_list ${dk_load_list} ${${fn}_file} CACHE INTERNAL "")
		list(REMOVE_DUPLICATES dk_load_list)
				
		#message(VERBOSE "${fn}_file = ${${fn}_file}")
		file(READ ${${fn}_file} ${fn}_contents)
		#string(REGEX MATCHALL "[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" ${fn}_matches "${${fn}_contents}")
				
		## Match text that contains *dk_*( 		I.E.  WIN_HOST_dk_, MAC_X86_64_dk_, dk_
		string(REGEX MATCHALL "[A-Za-z0-9_]*[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" ${fn}_matches "${${fn}_contents}")
		unset(${fn}_contents)
		list(REMOVE_DUPLICATES ${fn}_matches)
		foreach(${fn}_item ${${fn}_matches})
			if(NOT ${fn}_item)
				continue()
			endif()
				
			#message(VERBOSE "item-in = ${${fn}_item}")
				
			## remove any prefix to dk_*( 		I.E.  WIN_HOST_dk_  becomes dk_
			string(REGEX MATCH "[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" ${fn}_item ${${fn}_item})
			#message(VERBOSE "item-out = ${${fn}_item}")
				
			string(STRIP ${${fn}_item} ${fn}_item)
			string(REPLACE "\t" "" ${fn}_item ${${fn}_item})
			string(REPLACE "\r" "" ${fn}_item ${${fn}_item})
			string(REPLACE "\n" "" ${fn}_item ${${fn}_item})
			string(REPLACE "(" "" ${fn}_item ${${fn}_item})
			#message(VERBOSE "item-stripped = ${${fn}_item}")
					
			#message(VERBOSE "${fn}_item  ${${fn}_item}")
			if(${${fn}_item} IN_LIST dk_load_list)
				#message(VERBOSE "${fn} -> ${${fn}_item} already in list")
				continue()
			elseif(${${fn}_item} STREQUAL ${fn})
				#message(VERBOSE "${fn} -> ${${fn}_item} item cannot load itself")
				continue()
			elseif(COMMAND ${${fn}_item})
				#message(VERBOSE "${fn} -> ${${fn}_item} already loaded")
				continue()
			else()
				#message(VERBOSE "${fn} -> loading ${${fn}_item}")
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
	dk_debugFunc(${ARGV})
	
	
	#string(REGEX MATCHALL "[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" matches "${str}")
				
	## Match text that contains *dk_*( 		I.E.  WIN_HOST_dk_, MAC_X86_64_dk_, dk_
	string(REGEX MATCHALL "[A-Za-z0-9_]*[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" matches "${str}")
	unset(str)
	list(REMOVE_DUPLICATES matches)
	foreach(item ${matches})
		if(NOT item)
			continue()
		endif()
				
		#message(VERBOSE "item-in = ${item}")
				
		## remove any prefix to dk_*( 		I.E.  WIN_HOST_dk_  becomes dk_
		string(REGEX MATCH "[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" item ${item})
		#message(VERBOSE "item-out = ${item}")
				
		string(STRIP ${item} item)
		string(REPLACE "\t" "" item ${item})
		string(REPLACE "\r" "" item ${item})
		string(REPLACE "\n" "" item ${item})
		string(REPLACE "(" "" item ${item})
		#message(VERBOSE "item-stripped = ${item}")
				
		#message(VERBOSE "item  ${item}")
		if(${item} IN_LIST dk_load_list)
			#message(VERBOSE "${item} already in list")
			continue()
		elseif(COMMAND ${item})
			#message(VERBOSE "${item} already loaded")
			continue()
		else()
			#message(VERBOSE "loading ${item}")
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