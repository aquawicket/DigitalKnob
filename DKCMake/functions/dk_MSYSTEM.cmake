#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_MSYSTEM()
#
#
function(dk_MSYSTEM)
	dk_debugFunc()

	### Set MSYSTEM
	dk_validate(ENV "dk_target_triple2()")
	if(${ENV})
		if(CLANG AND ARM64)
			dk_set(msystem "${env}${arch}")	# msystem = clangarm64
			dk_set(MSYSTEM "${ENV}${ARCH}")	# MSYSTEM = CLANGARM64
		elseif(X86_64)
			dk_set(msystem "${env}64")		# msystem = clang64, mingw64, ucrt64
			dk_set(MSYSTEM "${ENV}64")		# MSYSTEM = CLANG64, MINGW64, UCRT64
		elseif(X86)
			dk_set(msystem "${env}32")		# msystem = clang32, mingw32
			dk_set(MSYSTEM "${ENV}32")		# MSYSTEM = CLANG32, MINGW32
		elseif(cosmo OR COSMO)
		#	dk_set(msystem "${env}")		# cosmo
		#	dk_set(MSYSTEM "${ENV}")		# COSMO
		elseif(msvc OR MSVC)
		#	dk_set(msystem "msvc")			# cosmo
		#	dk_set(MSYSTEM "MSVC")			# COSMO
		else()
			dk_fatal("The target triple:${triple} does not contain a valid env or msystem")
		endif()
		dk_set(${MSYSTEM} 1)				# CLANGARM64, CLANG64, CLANG32, MINGW64, MINGW32, UCRT64 = 1
	endif()
	
	dk_printVar(MSYSTEM)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_MSYSTEM()
endfunction()