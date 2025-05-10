#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_Host_Tuple()
#
#	set the cached host variables 
#
#   <Os>_<Arch>_Host		= Android_Arm64_Host, Emscripten_Arm64_Host, Ios_Arm64_Host, Iossim_Arm64_Host, Linux_Arm64_Host, Mac_Arm64_Host, Raspberry_Arm64_Host, Windows_Arm64_Host
#   <Os>_<Arch>_<Env>_Host	= Android_Arm64_Clang_Host, Emscripten_Arm64_Clang_Host, Ios_Arm64_Clang_Host, Iossim_Arm64_Clang_Host, Linux_Arm64_Clang_Host, Mac_Arm64_Clang_Host, Raspberry_Arm64_Clang_Host, Windows_Arm64_Clang_Host 
#
function(dk_Host_Tuple)
	dk_debugFunc(0 1)
	
	###### SET ######
	if(ARGV0)
		dk_set(Host_Tuple "${ARGV0}")
		dk_set(${Host_Tuple}_Host 1)
		
	###### GET ######	
	else()
		if(NOT Host_Os)
			dk_Host_Os()
		endif()
		if(NOT Host_Arch)
			dk_Host_Arch()
		endif()
		if(NOT Host_Env)
			dk_Host_Env()
		endif()
		
		if((Host_Os) AND (Host_Arch))
			dk_set(Host_Tuple "${Host_Os}_${Host_Arch}")
			dk_set(${Host_Tuple}_Host 1)
		endif()
		if((Host_Os) AND (Host_Arch) AND (Host_Env))
			dk_set(Host_Tuple "${Host_Os}_${Host_Arch}_${Host_Env}")
			dk_set(${Host_Tuple}_Host 1)
		endif()
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
	dk_Host_Tuple("My_Host_Tuple")
	dk_printVar(Host_Tuple)
	dk_printVar(${Host_Tuple}_Host)
endfunction()
