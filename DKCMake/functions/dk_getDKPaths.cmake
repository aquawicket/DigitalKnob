include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getDKPaths()
#
#	Fill the cache variables with DigitalKnob specfic directories
#
function(dk_getDKPaths)
	dk_debugFunc(${ARGV})
	
	# digitalknob
	if(NOT DEFINED DIGITALKNOB)
		if(DEFINED ENV{DIGITALKNOB})
			set(DIGITALKNOB $ENV{DIGITALKNOB} CACHE INTERNAL "" FORCE)
		endif()
	endif()
	# /digitalknob
	if(NOT DEFINED DIGITALKNOB_DIR)
		if(DEFINED ENV{DIGITALKNOB_DIR})
			set(DIGITALKNOB_DIR $ENV{DIGITALKNOB_DIR} CACHE INTERNAL "" FORCE)
		endif()
	endif()
		# Development
		if(NOT DEFINED DKBRANCH)
			if(DEFINED ENV{DKBRANCH})
				set(DKBRANCH $ENV{DKBRANCH} CACHE INTERNAL "" FORCE)
			endif()
		endif()
		# /digitalknob/Development
		if(NOT DEFINED DKBRANCH_DIR)
			if(DEFINED ENV{DKBRANCH_DIR})
				set(DKBRANCH_DIR $ENV{DKBRANCH_DIR} CACHE INTERNAL "" FORCE)
			endif()
		endif()
			# /digitalknob/Development/3rdParty
			if(NOT DEFINED DK3RDPARTY_DIR)
				if(DEFINED ENV{DK3RDPARTY_DIR})
					set(DK3RDPARTY_DIR $ENV{DK3RDPARTY_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
			# /digitalknob/Development/DKApps
			if(NOT DEFINED DKAPPS_DIR)
				if(DEFINED ENV{DKAPPS_DIR})
					set(DKAPPS_DIR $ENV{DKAPPS_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
			# /digitalknob/Development/DKBash
			if(NOT DEFINED DKBASH_DIR)
				if(DEFINED ENV{DKBASH_DIR})
					set(DKBASH_DIR $ENV{DKBASH_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
				# /digitalknob/Development/DKBash/functions
				if(NOT DEFINED DKBASH_FUNCTIONS_DIR)
					if(DEFINED ENV{DKBASH_FUNCTIONS_DIR})
						set(DKBASH_FUNCTIONS_DIR $ENV{DKBASH_FUNCTIONS_DIR} CACHE INTERNAL "" FORCE)
					endif()
				endif()
			# /digitalknob/Development/DKBatch
			if(NOT DEFINED DKBATCH_DIR)
				if(DEFINED ENV{DKBATCH_DIR})
					set(DKBATCH_DIR $ENV{DKBATCH_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
				# /digitalknob/Development/DKBatch/functions
				if(NOT DEFINED DKBATCH_FUNCTIONS_DIR)
					if(DEFINED ENV{DKBATCH_FUNCTIONS_DIR})
						set(DKBATCH_FUNCTIONS_DIR $ENV{DKBATCH_FUNCTIONS_DIR} CACHE INTERNAL "" FORCE)
					endif()
				endif()
			# /digitalknob/Development/DKCMake
			if(NOT DEFINED DKCMAKE_DIR)
				if(DEFINED ENV{DKCMAKE_DIR})
					set(DKCMAKE_DIR $ENV{DKCMAKE_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
				# /digitalknob/Development/DKCMake/functions
				if(NOT DEFINED DKCMAKE_FUNCTIONS_DIR)
					if(DEFINED ENV{DKCMAKE_FUNCTIONS_DIR})
						set(DKCMAKE_FUNCTIONS_DIR $ENV{DKCMAKE_FUNCTIONS_DIR} CACHE INTERNAL "" FORCE)
					endif()
				endif()
			# /digitalknob/Development/DKCpp
			if(NOT DEFINED DKCPP_DIR)
				if(DEFINED ENV{DKCPP_DIR})
					set(DKCPP_DIR $ENV{DKCPP_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
				# /digitalknob/Development/DKCpp/functions
				if(NOT DEFINED DKCPP_FUNCTIONS_DIR)
					if(DEFINED ENV{DKCPP_FUNCTIONS_DIR})
						set(DKCPP_FUNCTIONS_DIR $ENV{DKCPP_FUNCTIONS_DIR} CACHE INTERNAL "" FORCE)
					endif()
				endif()
			# /digitalknob/Development/DKCSharp
			if(NOT DEFINED DKCSHARP_DIR)
				if(DEFINED ENV{DKCSHARP_DIR})
					set(DKCSHARP_DIR $ENV{DKCSHARP_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
				# /digitalknob/Development/DKCSharp/functions
				if(NOT DEFINED DKCSHARP_FUNCTIONS_DIR)
					if(DEFINED ENV{DKCSHARP_FUNCTIONS_DIR})
						set(DKCSHARP_FUNCTIONS_DIR $ENV{DKCSHARP_FUNCTIONS_DIR} CACHE INTERNAL "" FORCE)
					endif()
				endif()
			# /digitalknob/Development/DKDocs
			if(NOT DEFINED DKDOCS_DIR)
				if(DEFINED ENV{DKDOCS_DIR})
					set(DKDOCS_DIR $ENV{DKDOCS_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
			# /digitalknob/Development/DKHta
			if(NOT DEFINED DKHTA_DIR)
				if(DEFINED ENV{DKHTA_DIR})
					set(DKHTA_DIR $ENV{DKHTA_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
				# /digitalknob/Development/DKHta/functions
				if(NOT DEFINED DKHTA_FUNCTIONS_DIR)
					if(DEFINED ENV{DKHTA_FUNCTIONS_DIR})
						set(DKHTA_FUNCTIONS_DIR $ENV{DKHTA_FUNCTIONS_DIR} CACHE INTERNAL "" FORCE)
					endif()
				endif()
			# /digitalknob/Development/DKJava
			if(NOT DEFINED DKJAVA_DIR)
				if(DEFINED ENV{DKJAVA_DIR})
					set(DKJAVA_DIR $ENV{DKJAVA_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
				# /digitalknob/Development/DKJava/functions
				if(NOT DEFINED DKJAVA_FUNCTIONS_DIR)
					if(DEFINED ENV{DKJAVA_FUNCTIONS_DIR})
						set(DKJAVA_FUNCTIONS_DIR $ENV{DKJAVA_FUNCTIONS_DIR} CACHE INTERNAL "" FORCE)
					endif()
				endif()
			# /digitalknob/Development/DKJavascript
			if(NOT DEFINED DKJAVASCRIPT_DIR)
				if(DEFINED ENV{DKJAVASCRIPT_DIR})
					set(DKJAVASCRIPT_DIR $ENV{DKJAVASCRIPT_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
				# /digitalknob/Development/DKJavascript/functions
				if(NOT DEFINED DKJAVASCRIPT_FUNCTIONS_DIR)
					if(DEFINED ENV{DKJAVASCRIPT_FUNCTIONS_DIR})
						set(DKJAVASCRIPT_FUNCTIONS_DIR $ENV{DKJAVASCRIPT_FUNCTIONS_DIR} CACHE INTERNAL "" FORCE)
					endif()
				endif()
			# /digitalknob/Development/DKPhp
			if(NOT DEFINED DKPHP_DIR)
				if(DEFINED ENV{DKPHP_DIR})
					set(DKPHP_DIR $ENV{DKPHP_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
				# /digitalknob/Development/DKPhp/functions
				if(NOT DEFINED DKPHP_FUNCTIONS_DIR)
					if(DEFINED ENV{DKPHP_FUNCTIONS_DIR})
						set(DKPHP_FUNCTIONS_DIR $ENV{DKPHP_FUNCTIONS_DIR} CACHE INTERNAL "" FORCE)
					endif()
				endif()
			# /digitalknob/Development/DKPlugins
			if(NOT DEFINED DKPLUGINS_DIR)
				if(DEFINED ENV{DKPLUGINS_DIR})
					set(DKPLUGINS_DIR $ENV{DKPLUGINS_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
			# /digitalknob/Development/DKPowershell
			if(NOT DEFINED DKPOWERSHELL_DIR)
				if(DEFINED ENV{DKPOWERSHELL_DIR})
					set(DKPHP_DIR $ENV{DKPOWERSHELL_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
				# /digitalknob/Development/DKPowershell/functions
				if(NOT DEFINED DKPOWERSHELL_FUNCTIONS_DIR)
					if(DEFINED ENV{DKPOWERSHELL_FUNCTIONS_DIR})
						set(DKPOWERSHELL_FUNCTIONS_DIR $ENV{DKPOWERSHELL_FUNCTIONS_DIR} CACHE INTERNAL "" FORCE)
					endif()
				endif()
			# /digitalknob/Development/DKPython
			if(NOT DEFINED DKPYTHON_DIR)
				if(DEFINED ENV{DKPYTHON_DIR})
					set(DKPYTHON_DIR $ENV{DKPYTHON_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
				# /digitalknob/Development/DKPython/functions
				if(NOT DEFINED DKPYTHON_FUNCTIONS_DIR)
					if(DEFINED ENV{DKPYTHON_FUNCTIONS_DIR})
						set(DKPYTHON_FUNCTIONS_DIR $ENV{DKPYTHON_FUNCTIONS_DIR} CACHE INTERNAL "" FORCE)
					endif()
				endif()
			# /digitalknob/Development/DKVb
			if(NOT DEFINED DKVB_DIR)
				if(DEFINED ENV{DKVB_DIR})
					set(DKVB_DIR $ENV{DKVB_DIR} CACHE INTERNAL "" FORCE)
				endif()
			endif()
				# /digitalknob/Development/DKVb/functions
				if(NOT DEFINED DKVB_FUNCTIONS_DIR)
					if(DEFINED ENV{DKVB_FUNCTIONS_DIR})
						set(DKVB_FUNCTIONS_DIR $ENV{DKVB_FUNCTIONS_DIR} CACHE INTERNAL "" FORCE)
					endif()
				endif()
		# /digitalknob/DKTools
		if(NOT DEFINED DKTOOLS_DIR)
			if(DEFINED ENV{DKTOOLS_DIR})
				set(DKTOOLS_DIR $ENV{DKTOOLS_DIR} CACHE INTERNAL "" FORCE)
			endif()
		endif()
		# /digitalknob/download
		if(NOT DEFINED DKDOWNLOAD_DIR)
			if(DEFINED ENV{DKDOWNLOAD_DIR})
				set(DKDOWNLOAD_DIR $ENV{DKDOWNLOAD_DIR} CACHE INTERNAL "" FORCE)
			endif()
		endif()
	
	###### Get DKBRANCH_DIR ######
#	string(COMPARE GREATER ${CMAKE_CURRENT_LIST_DIR} ${CMAKE_SOURCE_DIR} CURRENT_DIR_LONGER)
#	if(CURRENT_DIR_LONGER)
#		set(DKBRANCH_DIR ${CMAKE_CURRENT_LIST_DIR})
#	else()
#		set(DKBRANCH_DIR ${CMAKE_SOURCE_DIR})
#	endif()
#	dk_printVar(DKBRANCH_DIR)
#	dk_getDirname(${DKBRANCH_DIR} DIGITALKNOB_DIR)
#	dk_getBasename(${DIGITALKNOB_DIR} DIGITALKNOB)
#	while(NOT ${DIGITALKNOB} STREQUAL "digitalknob")
#		dk_getDirname(${DKBRANCH_DIR} DKBRANCH_DIR)
#		dk_getDirname(${DKBRANCH_DIR} DIGITALKNOB_DIR)
#		dk_getBasename(${DIGITALKNOB_DIR} DIGITALKNOB)
#		if(${DKBRANCH_DIR} STREQUAL ${DIGITALKNOB_DIR})
#			dk_error("could not locate digitalknob")
#		endif()
#	endwhile()
#	if(NOT EXISTS "${DKBRANCH_DIR}/.git")
#		dk_error("Could not locate a .git folder in the branch directory")
#	endif()
#	dk_getBasename(${DKBRANCH_DIR} DKBRANCH)
#
#	set(DKBRANCH ${DKBRANCH} CACHE INTERNAL "" FORCE)
#	set(DKBRANCH_DIR ${DKBRANCH_DIR} CACHE INTERNAL "" FORCE)
#	set(DIGITALKNOB_DIR ${DIGITALKNOB_DIR} CACHE INTERNAL "" FORCE)
#	
#	dk_printVar(DKBRANCH_DIR)
#	dk_printVar(DKBRANCH)
#	dk_printVar(DIGITALKNOB_DIR)
#	dk_printVar(DIGITALKNOB)
#	
#	##### Set DKCMAKE_DIR ######
#	set(DKCMAKE_DIR ${DKBRANCH_DIR}/DKCMake CACHE INTERNAL "" FORCE)
#	set(ENV{DKCMAKE_DIR} ${DKCMAKE_DIR})
#	dk_printVar(DKCMAKE_DIR)
#	
#	##### Set DKTOOLS_DIR ######
#	set(DKTOOLS_DIR ${DIGITALKNOB_DIR}/DKTools CACHE INTERNAL "" FORCE)
#	dk_printVar(DKTOOLS_DIR)
#
#	##### Set DK3RDPARTY_DIR ######
#	set(DK3RDPARTY_DIR ${DKBRANCH_DIR}/3rdParty CACHE INTERNAL "" FORCE)
#	dk_printVar(DK3RDPARTY_DIR)
#
#	###### Set DKIMPORTS_DIR ######
#	set(DKIMPORTS_DIR ${DK3RDPARTY_DIR}/_DKIMPORTS CACHE INTERNAL "" FORCE)
#	dk_printVar(DKIMPORTS_DIR)
#
#	###### Set DKAPPS_DIR ######
#	set(DKAPPS_DIR ${DKBRANCH_DIR}/DKApps CACHE INTERNAL "" FORCE)
#	dk_printVar(DKAPPS_DIR)
#
#	###### Set DKPLUGINS_DIR ######
#	set(DKPLUGINS_DIR ${DKBRANCH_DIR}/DKPlugins CACHE INTERNAL "" FORCE)
#	dk_printVar(DKPLUGINS_DIR)
#
#	###### Set DKDOWNLOAD_DIR ######
#	set(DKDOWNLOAD_DIR ${DIGITALKNOB_DIR}/download CACHE INTERNAL "" FORCE)
#	dk_printVar(DKDOWNLOAD_DIR)
#	
#	###### Set DKBATCH_DIR ######
#	set(DKBATCH_DIR ${DKBRANCH_DIR}/DKBatch CACHE INTERNAL "" FORCE)
#	dk_printVar(DKBATCH_DIR)
#	
#	###### Set DKBASH_DIR ######
#	set(DKBASH_DIR ${DKBRANCH_DIR}/DKBash CACHE INTERNAL "" FORCE)
#	dk_printVar(DKBASH_DIR)
#	
#	###### Set DKPOWERSHELL_DIR ######
#	set(DKPOWERSHELL_DIR ${DKBRANCH_DIR}/DKPowershell CACHE INTERNAL "" FORCE)
#	dk_printVar(DKPOWERSHELL_DIR)
#
	###### Set DKWEB ######
	set(DKWEB "http://127.0.0.1" CACHE INTERNAL "" FORCE)
	dk_printVar(DKWEB)
	
endfunction()





function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()
