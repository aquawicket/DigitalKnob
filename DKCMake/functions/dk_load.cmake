#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

if(NOT dk_loading_list)
	set(dk_loading_list "" CACHE INTERNAL "")
endif()
if(NOT dk_loaded_list)
	set(dk_loaded_list "" CACHE INTERNAL "")
endif()

set(indent_count 0 CACHE INTERNAL "")
##################################################################################
# dk_load(var)
#
#	load a .cmake file and parse/load all of it's containing dk_function file recursivley 
#
#	@var  - The name of an eisting function/file or a full file path to a .cmake file.
#
#	NOTE: dk_load should not use any dk_ functions. It may attempt to use said function before it has loaded it.
#		  Only use raw cmake functions here.
#
macro(dk_load var)
	#dk_debugFunc()
	
	string(STRIP ${var} fn)
	get_filename_component(name_we "${fn}" NAME_WE)
	if("${name_we}" STREQUAL "DKMAKE")
		get_filename_component(fnDir "${fn}" DIRECTORY)
		if(fnDir)
			set(fn ${fnDir})
		endif()
		get_filename_component(fnName "${fn}" NAME)
		if(fnName)
			set(fn ${fnName})
		endif()
	else()
		set(fn ${name_we})
	endif()
		
	if(NOT ${fn} IN_LIST dk_loading_list)
		list(APPEND dk_loading_list "${fn}")
		
		math(EXPR indent_count "${indent_count}+1")
		if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.15")
			string(REPEAT "-" ${indent_count} indent)
		endif()
		
#		message("${indent}> dk_load(${var})")	
		dk_parseFunctionsAndLoad(${fn} ${var})	#NOTE: Loading a file with the name of an existing function will cause this to fail
#		message("${indent}< dk_load(${var})")

		math(EXPR indent_count "${indent_count}-1")
		if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.15")
			string(REPEAT "-" ${indent_count} indent)
		endif()
	else()
		#message("${var} already loading")
	endif()
endmacro()




macro(dk_parseFunctionsAndLoad fn fpath)
	#dk_debugFunc()
	
	if(NOT dk_load_list)
		set(dk_load_list "" CACHE INTERNAL "")
	endif()
	
	# allow only dk_nnn fuction names 
	#if(NOT "${fn}" MATCHES "[Dd][Kk]_[A-Za-z0-9_]")
	#	dk_echo(WARNING "${fn} is NOT a valid function name")
	#endif()
	
	if(EXISTS ${DKCMAKE_FUNCTIONS_DIR_}${fpath}.cmake)
		set(${fn}_file ${DKCMAKE_FUNCTIONS_DIR_}${fpath}.cmake)
	elseif(EXISTS $ENV{DKCMAKE_DIR}/functions/${fpath}.cmake)
		set(${fn}_file $ENV{DKCMAKE_DIR}/functions/${fpath}.cmake)
	elseif(EXISTS ${fpath})
		set(${fn}_file ${fpath})
	#elseif(EXISTS ${fpath}.cmake)
	#	set(${fn}_file ${fpath}.cmake)
	else()
		dk_fatal("fpath:${fpath} file not found")   # FIXME: do not use dk_ functions in dk_load.cmake, only use raw cmake functions.
	endif()
	
	#if(${${fn}_file} IN_LIST dk_load_list)
		#dk_debug("dk_load(${fn}) function already in list @ ${${fn}_file}")
		#dk_verbose("dk_load_list = ${dk_load_list}")
	#else()
		#dk_verbose("loading ${${fn}_file}")
		#list(APPEND dk_load_list "${${fn}_file}")
				
		#dk_verbose("${fn}_file = ${${fn}_file}")
		file(READ ${${fn}_file} ${fn}_contents)
				
		## Match text that contains *dk_*( 		I.E.  WIN_HOST_dk_, MAC_X86_64_dk_, dk_
		string(REGEX MATCHALL "[A-Za-z0-9_]*[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" ${fn}_matches "${${fn}_contents}")
		unset(${fn}_contents)
		list(REMOVE_DUPLICATES ${fn}_matches)
		
		foreach(${fn}_item ${${fn}_matches})
			if(NOT ${fn}_item)
				continue()
			endif()
				
			#dk_verbose("item-in = ${${fn}_item}")
				
			## remove any prefix to dk_*( 		I.E.  WIN_HOST_dk_  becomes dk_
			string(REGEX MATCH "[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" ${fn}_item ${${fn}_item})
			#dk_verbose("item-out = ${${fn}_item}")
				
			string(STRIP ${${fn}_item} ${fn}_item)
			string(REPLACE "\t" "" ${fn}_item ${${fn}_item})
			string(REPLACE "\r" "" ${fn}_item ${${fn}_item})
			string(REPLACE "\n" "" ${fn}_item ${${fn}_item})
			string(REPLACE "(" "" ${fn}_item ${${fn}_item})
			#dk_verbose("item-stripped = ${${fn}_item}")
					
			#dk_verbose("${fn}_item  ${${fn}_item}")
			#if(${${fn}_item} IN_LIST dk_load_list)
			if(${${fn}_item} IN_LIST dk_loading_list)
				#dk_verbose("${fn} -> ${${fn}_item} already in list")
				continue()
			elseif(${${fn}_item} STREQUAL ${fn})
				#dk_verbose("${fn} -> ${${fn}_item} item cannot load itself")
				continue()
			elseif(COMMAND ${${fn}_item})
				#dk_verbose("${fn} -> ${${fn}_item} already loaded")
				continue()
			else()
				#if(${fn} STREQUAL "dk_error")
				#	message("fn = ${fn}")
				#	message("fpath = ${fpath}")
				#	message("fn_file} = ${${fn}_file}")
				#	message("fn_item} = ${${fn}_item}")
				#	message("DKSCRIPT_PATH = ${DKSCRIPT_PATH}")
				#	message("DKSCRIPT_NAME = ${DKSCRIPT_NAME}")
				#endif()

				#if(NOT ${${fn}_file} STREQUAL "${DKSCRIPT_PATH}")
				#if(NOT ${fn} IN_LIST dk_loaded_list)
					#if(${fn} IN_LIST dk_loading_list)
					#	include(${${fn}_file})
					#else()
						dk_load(${${fn}_item})
					#endif()
				#endif()
			endif()
		endforeach()

		if(NOT "${${fn}_file}" STREQUAL "${DKSCRIPT_PATH}")
			#dk_echo("${fn} -> include(${${fn}_file})")
		#if(NOT ${fn} IN_LIST dk_loading_list)
			include(${${fn}_file})
		endif()
		
		### variable clean-up ###
		unset(${fn}_file)
		unset(${fn}_item)
		unset(${fn}_matches)
	#endif()
endmacro()

function(dk_parseFunctionsAndLoadFromString str)
	#dk_echo("dk_debugFunc()") #dk_debugFunc()
	
	## Match text that contains *dk_*( 		I.E.  WIN_HOST_dk_function(,  MAC_X86_64_dk_function(  or  dk_function(
	string(REGEX MATCHALL "[A-Za-z0-9_]*[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" matches "${str}")
	unset(str)
	list(REMOVE_DUPLICATES matches)
	foreach(item ${matches})
		if(NOT item)
			continue()
		endif()
				
		#dk_verbose("item-in = ${item}")
				
		## remove any prefix to dk_*( 		I.E.  WIN_HOST_dk_  becomes dk_
		string(REGEX MATCH "[Dd][Kk]_.[A-Za-z0-9_\t]*\\(" item ${item})
		#dk_verbose("item-out = ${item}")
				
		string(STRIP ${item} item)
		string(REPLACE "\t" "" item ${item})
		string(REPLACE "\r" "" item ${item})
		string(REPLACE "\n" "" item ${item})
		string(REPLACE "(" "" item ${item})
		#dk_verbose("item-stripped = ${item}")
				
		#dk_verbose("item  ${item}")
		if(${item} IN_LIST dk_load_list)
			#dk_verbose("${item} already in list")
			continue()
		elseif(COMMAND ${item})
			#dk_verbose("${item} already loaded")
			continue()
		else()
			#dk_verbose("loading ${item}")
			dk_load(${item})
		endif()
	endforeach()
endfunction(dk_parseFunctionsAndLoadFromString)

#if(NOT dk_load IN_LIST dk_load_list) 
#	set(dk_load_list dk_load CACHE INTERNAL "")
#endif()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc()
	
	dk_load(msys2)
endfunction()
