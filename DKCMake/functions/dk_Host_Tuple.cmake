#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_Host_Tuple()
#
#	set the cached host variables 
#
#   {Host_Os}_{Host_Arch}_Host				= Android_Arm64_Host, Emscripten_Arm64_Host, Ios_Arm64_Host, Iossim_Arm64_Host, Linux_Arm64_Host, Mac_Arm64_Host, Raspberry_Arm64_Host, Windows_Arm64_Host
#   {Host_Os}_{Host_Arch}_{Host_Env}_Host	= Android_Arm64_Clang_Host, Emscripten_Arm64_Clang_Host, Ios_Arm64_Clang_Host, Iossim_Arm64_Clang_Host, Linux_Arm64_Clang_Host, Mac_Arm64_Clang_Host, Raspberry_Arm64_Clang_Host, Windows_Arm64_Clang_Host 
#
function(dk_Host_Tuple)
	dk_debug("dk_Host_Tuple(ARGV='${ARGV}', ARGV0='${ARGV0}', ARGV1='${ARGV1}')")
	dk_debugFunc(0 1)
	
	dk_debug("Host_Tuple = ${Host_Tuple}")
	###### SET ######
	if(ARGV)
		dk_set(Host_Tuple "${ARGV0}")
	###### GET ######	
	#elseif(NOT DEFINED ENV{Host_Tuple})
	else()
		if(NOT Host_Os)
			dk_Host_Os()
		endif()
		
		###### First Tuple ######
		if(NOT Host_Arch)
			dk_Host_Arch()
		endif()
		dk_set(Host_Tuple "${Host_Os}_${Host_Arch}")
		dk_set(${Host_Tuple}_Host 1)
			### VALIDATE RESULT ###
			if(Android_Arm32_Host)
		elseif(Android_Arm64_Host)
		elseif(Android_X86_Host)
		elseif(Android_X86_64_Host)
		elseif(Emscripten_Arm32_Host)
		elseif(Emscripten_Arm64_Host)
		elseif(Emscripten_X86_Host)
		elseif(Emscripten_X86_64_Host)
		elseif(Ios_Arm32_Host)
		elseif(Ios_Arm64_Host)
		elseif(Ios_X86_Host)
		elseif(Ios_X86_64_Host)
		elseif(Iossim_Arm32_Host)
		elseif(Iossim_Arm64_Host)
		elseif(Iossim_X86_Host)
		elseif(Iossim_X86_64_Host)
		elseif(Linux_Arm32_Host)
		elseif(Linux_Arm64_Host)
		elseif(Linux_X86_Host)
		elseif(Linux_X86_64_Host)
		elseif(Mac_Arm32_Host)
		elseif(Mac_Arm64_Host)
		elseif(Mac_X86_Host)
		elseif(Mac_X86_64_Host)
		elseif(Raspberry_Arm32_Host)
		elseif(Raspberry_Arm64_Host)
		elseif(Raspberry_X86_Host)
		elseif(Raspberry_X86_64_Host)
		elseif(Windows_Arm32_Host)
		elseif(Windows_Arm64_Host)
		elseif(Windows_X86_Host)
		elseif(Windows_X86_64_Host)
		else()
			dk_fatal("Host_Tuple:'${Host_Tuple}' is INVALID!")
		endif()	
		
		# ###### Second Tuple ######
		# if(NOT Host_Env)
		# 	dk_Host_Env()
		# endif()
		# dk_set(Host_Tuple "${Host_Os}_${Host_Arch}_${Host_Env}")
		# dk_set(${Host_Tuple}_Host 1)
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	###### GET ######
    dk_Host_Tuple()
	dk_printVar(Host_Tuple)
	dk_printVar(${Host_Tuple}_Host)
	
	###### SET ######
	dk_Host_Tuple("Raspberry_Arm32_Host")
	dk_printVar(Host_Tuple)
	dk_printVar(${Host_Tuple}_Host)
endfunction()
