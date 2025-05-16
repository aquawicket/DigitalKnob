#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_Target_Tuple()
#
#	Target_Tuple = TODO
#
function(dk_Target_Tuple)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(Target_Tuple "${ARGV0}")
	
	###### GET ######	
	elseif(NOT DEFINED ENV{Target_Tuple})
		if(NOT Target_Os)
			dk_Target_Os()
		endif()
		dk_assertVar(Target_Os)
		
		if(NOT Target_Arch)
			dk_Target_Arch()
		endif()
		dk_assertVar(Target_Arch)
		
		if(NOT Target_Env)
			dk_Target_Env()
		endif()
		dk_assertVar(Target_Env)
		
		dk_set(Target_Tuple "${Target_Os}_${Target_Arch}_${Target_Env}")
	else()
		dk_set(Target_Tuple "$ENV{Target_Tuple}")
	endif()
	
	dk_assertVar(Target_Tuple)
	dk_set(${Target_Tuple} 1)
	#dk_set(${Target_Tuple}_Target 1)
	
	###### VALIDATE RESULT ######
	    if(Android_Arm32_Clang)
	elseif(Android_Arm64_Clang)
	elseif(Android_X86_64_Clang)
	elseif(Android_X86_Clang)
	elseif(Emscripten_Arm32_Clang)
	elseif(Emscripten_Arm64_Clang)
	elseif(Emscripten_X86_64_Clang)
	elseif(Emscripten_X86_Clang)
	elseif(Ios_Arm32_Clang)
	elseif(Ios_Arm64_Clang)
	elseif(Ios_X86_64_Clang)
	elseif(Ios_X86_Clang)
	elseif(Iossim_Arm32_Clang)
	elseif(Iossim_Arm64_Clang)
	elseif(Iossim_X86_64_Clang)
	elseif(Iossim_X86_Clang)
	elseif(Linux_Arm32_Clang)
	elseif(Linux_Arm64_Clang)
	elseif(Linux_X86_64_Clang)
	elseif(Linux_X86_Clang)
	elseif(Mac_Arm32_Clang)
	elseif(Mac_Arm64_Clang)
	elseif(Mac_X86_64_Clang)
	elseif(Mac_X86_Clang)
	elseif(Raspberry_Arm32_Clang)
	elseif(Raspberry_Arm64_Clang)
	elseif(Raspberry_X86_64_Clang)
	elseif(Raspberry_X86_Clang)
	elseif(Win_Arm32_Clang)
	elseif(Win_Arm32_Gcc)
	elseif(Win_Arm32_Msvc)
	elseif(Win_Arm64_Clang)
	elseif(Win_Arm64_Gcc)
	elseif(Win_Arm64_Msvc)
	elseif(Win_X86_64_Clang)
	elseif(Win_X86_64_Gcc)
	elseif(Win_X86_64_Msvc)
	elseif(Win_X86_Clang)
	elseif(Win_X86_Gcc)
	elseif(Win_X86_Msvc)
	else()
		dk_fatal("Target_Tuple:'${Target_Tuple}' is INVALID!")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	###### GET ######
    dk_Target_Tuple()
	dk_printVar(Target_Tuple)
	#dk_printVar(${Target_Tuple}_Target)
	
	###### SET ######
	dk_Target_Tuple("Win_X86_Gcc")
	dk_printVar(Target_Tuple)
	#dk_printVar(${Target_Tuple}_Target)
endfunction()