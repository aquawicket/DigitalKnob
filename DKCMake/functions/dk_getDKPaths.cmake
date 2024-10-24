include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getDKPaths()
#
#	Fill the cache variables with DigitalKnob specfic directories
#
function(dk_getDKPaths)
	dk_debugFunc("\${ARGV}")
	
	# digitalknob
	if(NOT DEFINED DIGITALKNOB)
		if(DEFINED ENV{DIGITALKNOB})
			set(DIGITALKNOB $ENV{DIGITALKNOB} CACHE INTERNAL "" FORCE)
		endif()
	endif()
	#dk_printVar(DIGITALKNOB)
	
	# /digitalknob
	if(NOT DEFINED DIGITALKNOB_DIR)
		if(DEFINED ENV{DIGITALKNOB_DIR})
			set(DIGITALKNOB_DIR $ENV{DIGITALKNOB_DIR} CACHE PATH "" FORCE)
		endif()
	endif()
	#dk_printVar(DIGITALKNOB_DIR)
	
		# Development
		if(NOT DEFINED DKBRANCH)
			if(DEFINED ENV{DKBRANCH})
				set(DKBRANCH $ENV{DKBRANCH} CACHE INTERNAL "" FORCE)
			endif()
		endif()
		#dk_printVar(DKBRANCH)
		
		# /digitalknob/Development
		if(NOT DEFINED DKBRANCH_DIR)
			if(DEFINED ENV{DKBRANCH_DIR})
				set(DKBRANCH_DIR $ENV{DKBRANCH_DIR} CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKBRANCH_DIR)
		
			# /digitalknob/Development/3rdParty
			if(NOT DEFINED DK3RDPARTY_DIR)
				if(DEFINED ENV{DK3RDPARTY_DIR})
					set(DK3RDPARTY_DIR $ENV{DK3RDPARTY_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DK3RDPARTY_DIR)
			
			# /digitalknob/Development/DKApps
			if(NOT DEFINED DKAPPS_DIR)
				if(DEFINED ENV{DKAPPS_DIR})
					set(DKAPPS_DIR $ENV{DKAPPS_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKAPPS_DIR)
			
			# /digitalknob/Development/DKBash
			if(NOT DEFINED DKBASH_DIR)
				if(DEFINED ENV{DKBASH_DIR})
					set(DKBASH_DIR $ENV{DKBASH_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKBASH_DIR)
			
				# /digitalknob/Development/DKBash/functions
				if(NOT DEFINED DKBASH_FUNCTIONS_DIR)
					if(DEFINED ENV{DKBASH_FUNCTIONS_DIR})
						set(DKBASH_FUNCTIONS_DIR $ENV{DKBASH_FUNCTIONS_DIR} CACHE PATH "" FORCE)
					endif()
				endif()
				#dk_printVar(DKBASH_FUNCTIONS_DIR)
				
			# /digitalknob/Development/DKBatch
			if(NOT DEFINED DKBATCH_DIR)
				if(DEFINED ENV{DKBATCH_DIR})
					set(DKBATCH_DIR $ENV{DKBATCH_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKBATCH_DIR)
			
				# /digitalknob/Development/DKBatch/functions
				if(NOT DEFINED DKBATCH_FUNCTIONS_DIR)
					if(DEFINED ENV{DKBATCH_FUNCTIONS_DIR})
						set(DKBATCH_FUNCTIONS_DIR $ENV{DKBATCH_FUNCTIONS_DIR} CACHE PATH "" FORCE)
					endif()
				endif()
				#dk_printVar(DKBATCH_FUNCTIONS_DIR)
				
			# /digitalknob/Development/DKCMake
			if(NOT DEFINED DKCMAKE_DIR)
				if(DEFINED ENV{DKCMAKE_DIR})
					set(DKCMAKE_DIR $ENV{DKCMAKE_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKCMAKE_DIR)
			
				# /digitalknob/Development/DKCMake/functions
				if(NOT DEFINED DKCMAKE_FUNCTIONS_DIR)
					if(DEFINED ENV{DKCMAKE_FUNCTIONS_DIR})
						set(DKCMAKE_FUNCTIONS_DIR $ENV{DKCMAKE_FUNCTIONS_DIR} CACHE PATH "" FORCE)
					endif()
				endif()
				#dk_printVar(DKCMAKE_FUNCTIONS_DIR)
				
			# /digitalknob/Development/DKCpp
			if(NOT DEFINED DKCPP_DIR)
				if(DEFINED ENV{DKCPP_DIR})
					set(DKCPP_DIR $ENV{DKCPP_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKCPP_DIR)
			
				# /digitalknob/Development/DKCpp/functions
				if(NOT DEFINED DKCPP_FUNCTIONS_DIR)
					if(DEFINED ENV{DKCPP_FUNCTIONS_DIR})
						set(DKCPP_FUNCTIONS_DIR $ENV{DKCPP_FUNCTIONS_DIR} CACHE PATH "" FORCE)
					endif()
				endif()
				#dk_printVar(DKCPP_FUNCTIONS_DIR)
				
			# /digitalknob/Development/DKCSharp
			if(NOT DEFINED DKCSHARP_DIR)
				if(DEFINED ENV{DKCSHARP_DIR})
					set(DKCSHARP_DIR $ENV{DKCSHARP_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKCSHARP_DIR)
			
				# /digitalknob/Development/DKCSharp/functions
				if(NOT DEFINED DKCSHARP_FUNCTIONS_DIR)
					if(DEFINED ENV{DKCSHARP_FUNCTIONS_DIR})
						set(DKCSHARP_FUNCTIONS_DIR $ENV{DKCSHARP_FUNCTIONS_DIR} CACHE PATH "" FORCE)
					endif()
				endif()
				#dk_printVar(DKCSHARP_FUNCTIONS_DIR)
				
			# /digitalknob/Development/DKDocs
			if(NOT DEFINED DKDOCS_DIR)
				if(DEFINED ENV{DKDOCS_DIR})
					set(DKDOCS_DIR $ENV{DKDOCS_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKDOCS_DIR)
			
			# /digitalknob/Development/DKHta
			if(NOT DEFINED DKHTA_DIR)
				if(DEFINED ENV{DKHTA_DIR})
					set(DKHTA_DIR $ENV{DKHTA_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKHTA_DIR)
			
				# /digitalknob/Development/DKHta/functions
				if(NOT DEFINED DKHTA_FUNCTIONS_DIR)
					if(DEFINED ENV{DKHTA_FUNCTIONS_DIR})
						set(DKHTA_FUNCTIONS_DIR $ENV{DKHTA_FUNCTIONS_DIR} CACHE PATH "" FORCE)
					endif()
				endif()
				#dk_printVar(DKHTA_FUNCTIONS_DIR)
				
			# /digitalknob/Development/DKJava
			if(NOT DEFINED DKJAVA_DIR)
				if(DEFINED ENV{DKJAVA_DIR})
					set(DKJAVA_DIR $ENV{DKJAVA_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKJAVA_DIR)
			
				# /digitalknob/Development/DKJava/functions
				if(NOT DEFINED DKJAVA_FUNCTIONS_DIR)
					if(DEFINED ENV{DKJAVA_FUNCTIONS_DIR})
						set(DKJAVA_FUNCTIONS_DIR $ENV{DKJAVA_FUNCTIONS_DIR} CACHE PATH "" FORCE)
					endif()
				endif()
				#dk_printVar(DKJAVA_FUNCTIONS_DIR)
				
			# /digitalknob/Development/DKJavascript
			if(NOT DEFINED DKJAVASCRIPT_DIR)
				if(DEFINED ENV{DKJAVASCRIPT_DIR})
					set(DKJAVASCRIPT_DIR $ENV{DKJAVASCRIPT_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKJAVASCRIPT_DIR)
			
				# /digitalknob/Development/DKJavascript/functions
				if(NOT DEFINED DKJAVASCRIPT_FUNCTIONS_DIR)
					if(DEFINED ENV{DKJAVASCRIPT_FUNCTIONS_DIR})
						set(DKJAVASCRIPT_FUNCTIONS_DIR $ENV{DKJAVASCRIPT_FUNCTIONS_DIR} CACHE PATH "" FORCE)
					endif()
				endif()
				#dk_printVar(DKJAVASCRIPT_FUNCTIONS_DIR)
				
			# /digitalknob/Development/DKPhp
			if(NOT DEFINED DKPHP_DIR)
				if(DEFINED ENV{DKPHP_DIR})
					set(DKPHP_DIR $ENV{DKPHP_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKPHP_DIR)
			
				# /digitalknob/Development/DKPhp/functions
				if(NOT DEFINED DKPHP_FUNCTIONS_DIR)
					if(DEFINED ENV{DKPHP_FUNCTIONS_DIR})
						set(DKPHP_FUNCTIONS_DIR $ENV{DKPHP_FUNCTIONS_DIR} CACHE PATH "" FORCE)
					endif()
				endif()
				#dk_printVar(DKPHP_FUNCTIONS_DIR)
				
			# /digitalknob/Development/DKPlugins
			if(NOT DEFINED DKPLUGINS_DIR)
				if(DEFINED ENV{DKPLUGINS_DIR})
					set(DKPLUGINS_DIR $ENV{DKPLUGINS_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKPLUGINS_DIR)
			
			# /digitalknob/Development/DKPowershell
			if(NOT DEFINED DKPOWERSHELL_DIR)
				if(DEFINED ENV{DKPOWERSHELL_DIR})
					set(DKPHP_DIR $ENV{DKPOWERSHELL_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKPOWERSHELL_DIR)
			
				# /digitalknob/Development/DKPowershell/functions
				if(NOT DEFINED DKPOWERSHELL_FUNCTIONS_DIR)
					if(DEFINED ENV{DKPOWERSHELL_FUNCTIONS_DIR})
						set(DKPOWERSHELL_FUNCTIONS_DIR $ENV{DKPOWERSHELL_FUNCTIONS_DIR} CACHE PATH "" FORCE)
					endif()
				endif()
				#dk_printVar(DKPOWERSHELL_FUNCTIONS_DIR)
				
			# /digitalknob/Development/DKPython
			if(NOT DEFINED DKPYTHON_DIR)
				if(DEFINED ENV{DKPYTHON_DIR})
					set(DKPYTHON_DIR $ENV{DKPYTHON_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKPYTHON_DIR)
			
				# /digitalknob/Development/DKPython/functions
				if(NOT DEFINED DKPYTHON_FUNCTIONS_DIR)
					if(DEFINED ENV{DKPYTHON_FUNCTIONS_DIR})
						set(DKPYTHON_FUNCTIONS_DIR $ENV{DKPYTHON_FUNCTIONS_DIR} CACHE PATH "" FORCE)
					endif()
				endif()
				#dk_printVar(DKPYTHON_FUNCTIONS_DIR)
				
			# /digitalknob/Development/DKVb
			if(NOT DEFINED DKVB_DIR)
				if(DEFINED ENV{DKVB_DIR})
					set(DKVB_DIR $ENV{DKVB_DIR} CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKVB_DIR)
			
				# /digitalknob/Development/DKVb/functions
				if(NOT DEFINED DKVB_FUNCTIONS_DIR)
					if(DEFINED ENV{DKVB_FUNCTIONS_DIR})
						set(DKVB_FUNCTIONS_DIR $ENV{DKVB_FUNCTIONS_DIR} CACHE PATH "" FORCE)
					endif()
				endif()
				#dk_printVar(DKVB_FUNCTIONS_DIR)
				
		# /digitalknob/DKTools
		if(NOT DEFINED DKTOOLS_DIR)
			if(DEFINED ENV{DKTOOLS_DIR})
				set(DKTOOLS_DIR $ENV{DKTOOLS_DIR} CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKTOOLS_DIR)
		
		# /digitalknob/download
		if(NOT DEFINED DKDOWNLOAD_DIR)
			if(DEFINED ENV{DKDOWNLOAD_DIR})
				set(DKDOWNLOAD_DIR $ENV{DKDOWNLOAD_DIR} CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKDOWNLOAD_DIR)
		
		# /digitalknob/temp
		if(NOT DEFINED DKTEMP_DIR)
			if(DEFINED ENV{DKTEMP_DIR})
				set(DKTEMP_DIR $ENV{DKTEMP_DIR} CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKTEMP_DIR)






	# try to deduce anything missing in the environment variables
	###### Get DKBRANCH_DIR ######
			if(NOT DEFINED DKBRANCH_DIR)
				if(DEFINED DKCMAKE_DIR)
					dk_dirname(${DKCMAKE_DIR} DKBRANCH_DIR)
					set(DKBRANCH_DIR "${DKBRANCH_DIR}" CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKBRANCH_DIR)

			if(NOT DEFINED DKBRANCH)
				if(DEFINED DKBRANCH_DIR)
					dk_basename(${DKBRANCH_DIR} DKBRANCH)
					set(DKBRANCH "${DKBRANCH}" CACHE INTERNAL "" FORCE)
				endif()
			endif()
			#dk_printVar(DKBRANCH)
	
		if(NOT DEFINED DK3RDPARTY_DIR)
			if(EXISTS "${DKBRANCH_DIR}/3rdParty")
				set(DK3RDPARTY_DIR "${DKBRANCH_DIR}/3rdParty" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DK3RDPARTY_DIR)
	
		if(NOT DEFINED DKAPPS_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKApps")
				set(DKAPPS_DIR "${DKBRANCH_DIR}/DKApps" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKAPPS_DIR)
	
		if(NOT DEFINED DKBASH_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKBash")
				set(DKBASH_DIR "${DKBRANCH_DIR}/DKBash" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKBASH_DIR)
			
			if(NOT DEFINED DKBASH_FUNCTIONS_DIR)
				if(EXISTS "${DKBASH_DIR}/functions")
					set(DKBASH_FUNCTIONS_DIR "${DKBASH_DIR}/functions" CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKBASH_FUNCTIONS_DIR)
		
		if(NOT DEFINED DKBATCH_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKBatch")
				set(DKBATCH_DIR "${DKBRANCH_DIR}/DKBatch" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKBATCH_DIR)
		
			if(NOT DEFINED DKBATCH_FUNCTIONS_DIR)
				if(EXISTS "${DKBATCH_DIR}/functions")
					set(DKBATCH_FUNCTIONS_DIR "${DKBATCH_DIR}/functions" CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKBATCH_FUNCTIONS_DIR)
			
			if(NOT DEFINED DKBATCH_FUNCTIONS_DIR_)
				if(EXISTS "${DKBATCH_DIR}/functions/")
					set(DKBATCH_FUNCTIONS_DIR_ "${DKBATCH_DIR}/functions/" CACHE PATH "" FORCE)
					dk_replaceAll(${DKBATCH_FUNCTIONS_DIR_} "/" "\\" DKBATCH_FUNCTIONS_DIR_)
				endif()
			endif()
			#dk_printVar(DKBATCH_FUNCTIONS_DIR_)
		
		if(NOT DEFINED DKCMAKE_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKCMake")
				set(DKCMAKE_DIR "${DKBRANCH_DIR}/DKCMake" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKCMAKE_DIR)
			
			if(NOT DEFINED DKCMAKE_FUNCTIONS_DIR)
				if(EXISTS "${DKCMAKE_DIR}/functions")
					set(DKCMAKE_FUNCTIONS_DIR "${DKCMAKE_DIR}/functions" CACHE PATH "" FORCE)
				endif()
			endif()
			#dk_printVar(DKCMAKE_FUNCTIONS_DIR)
		
		if(NOT DEFINED DKCPP_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKCpp")
				set(DKCPP_DIR "${DKBRANCH_DIR}/DKCpp" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKCPP_DIR)
		
		if(NOT DEFINED DKCSHARP_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKCSharp")
				set(DKCSHARP_DIR "${DKBRANCH_DIR}/DKCSharp" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKCSHARP_DIR)
		
		if(NOT DEFINED DKDOCS_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKDocs")
				set(DKDOCS_DIR "${DKBRANCH_DIR}/DKDocs" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKDOCS_DIR)
		
		if(NOT DEFINED DKHTA_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKHta")
				set(DKHTA_DIR "${DKBRANCH_DIR}/DKHta" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKHTA_DIR)
		
		if(NOT DEFINED DKJAVA_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKJava")
				set(DKJAVA_DIR "${DKBRANCH_DIR}/DKJava" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKJAVA_DIR)
		
		if(NOT DEFINED DKJAVASCRIPT_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKJavascript")
				set(DKJAVASCRIPT_DIR "${DKBRANCH_DIR}/DKJavascript" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKJAVASCRIPT_DIR)
		
		if(NOT DEFINED DKPHP_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKPhp")
				set(DKPHP_DIR "${DKBRANCH_DIR}/DKPhp" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKPHP_DIR)
		
		if(NOT DEFINED DKPLUGINS_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKPlugins")
				set(DKPLUGINS_DIR "${DKBRANCH_DIR}/DKPlugins" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKPLUGINS_DIR)
		
		if(NOT DEFINED DKPOWERSHELL_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKPowershell")
				set(DKPOWERSHELL_DIR "${DKBRANCH_DIR}/DKPowershell" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKPOWERSHELL_DIR)
		
		if(NOT DEFINED DKPYTHON_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKPython")
				set(DKPYTHON_DIR "${DKBRANCH_DIR}/DKPython" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKPYTHON_DIR)
		
		if(NOT DEFINED DKVB_DIR)
			if(EXISTS "${DKBRANCH_DIR}/DKVb")
				set(DKVB_DIR "${DKBRANCH_DIR}/DKVb" CACHE PATH "" FORCE)
			endif()
		endif()
		#dk_printVar(DKVB_DIR)
		
	if(NOT DEFINED DIGITALKNOB_DIR)
		if(DEFINED DKBRANCH_DIR)
			dk_dirname(${DKBRANCH_DIR} DIGITALKNOB_DIR)
			set(DIGITALKNOB_DIR "${DIGITALKNOB_DIR}" CACHE PATH "" FORCE)
		endif()
	endif()
	dk_assertPath(DIGITALKNOB_DIR)
	#dk_printVar(DIGITALKNOB_DIR)
	
	if(NOT DEFINED DIGITALKNOB)
		dk_basename(${DIGITALKNOB_DIR} DIGITALKNOB)
		set(DIGITALKNOB "${DIGITALKNOB}" CACHE INTERNAL "" FORCE)
	endif()
	dk_assert(DIGITALKNOB)
	#dk_printVar(DIGITALKNOB)
	
		if(NOT DEFINED DKTOOLS_DIR)
			if(EXISTS "${DIGITALKNOB_DIR}/DKTools")
				set(DKTOOLS_DIR "${DIGITALKNOB_DIR}/DKTools" CACHE PATH "" FORCE)
			endif()
		endif()
		dk_assertPath(DKTOOLS_DIR)
		#dk_printVar(DKTOOLS_DIR)
		
		if(NOT DEFINED DKDOWNLOAD_DIR)
			if(EXISTS "${DIGITALKNOB_DIR}/download")
				set(DKDOWNLOAD_DIR "${DIGITALKNOB_DIR}/download" CACHE PATH "" FORCE)
			endif()
		endif()
		dk_assertPath(DKDOWNLOAD_DIR)
		#dk_printVar(DKDOWNLOAD_DIR)
		
		if(NOT DEFINED DKTEMP_DIR)
			if(EXISTS "${DIGITALKNOB_DIR}/temp")
				set(DKTEMP_DIR "${DIGITALKNOB_DIR}/temp" CACHE PATH "" FORCE)
			endif()
		endif()
	
	
	
	
#	while(NOT ${DIGITALKNOB} STREQUAL "digitalknob")
#		dk_dirname(${DKBRANCH_DIR} DKBRANCH_DIR)
#		dk_dirname(${DKBRANCH_DIR} DIGITALKNOB_DIR)
#		dk_basename(${DIGITALKNOB_DIR} DIGITALKNOB)
#		if(${DKBRANCH_DIR} STREQUAL ${DIGITALKNOB_DIR})
#			dk_fatal("could not locate digitalknob")
#		endif()
#	endwhile()
#	if(NOT EXISTS "${DKBRANCH_DIR}/.git")
#		dk_fatal("Could not locate a .git folder in the branch directory")
#	endif()
#	dk_basename(${DKBRANCH_DIR} DKBRANCH)
#
#	set(DKBRANCH ${DKBRANCH} CACHE INTERNAL "" FORCE)
#	set(DKBRANCH_DIR ${DKBRANCH_DIR} CACHE INTERNAL "" FORCE)
#	set(DIGITALKNOB_DIR ${DIGITALKNOB_DIR} CACHE INTERNAL "" FORCE)
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





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_getDKPaths()
endfunction()
