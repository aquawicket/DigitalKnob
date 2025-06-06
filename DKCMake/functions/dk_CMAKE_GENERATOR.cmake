#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################

#########################################################################
# dk_CMAKE_GENERATOR()
#
#
function(dk_CMAKE_GENERATOR)
    dk_debugFunc()

	###### SET ######
	if(ARGV)
		dk_set(CMAKE_GENERATOR "${ARGV0}")
		
	###### GET ######	
	elseif(DEFINED ENV{CMAKE_GENERATOR})	
		dk_set(CMAKE_GENERATOR "$ENV{CMAKE_GENERATOR}")
		
	else()
		dk_validate(Target_Tuple "dk_Target_Tuple()")
	
		if(Android)    
			set(CMAKE_GENERATOR "Unix Makefiles")
		elseif(Cosmo)     
			set(CMAKE_GENERATOR "MSYS Makefiles")
		elseif(Emscripten)          
			set(CMAKE_GENERATOR "Unix Makefiles")
		elseif(Ios)           
			set(CMAKE_GENERATOR "Xcode")
		elseif(Iossim)          
			set(CMAKE_GENERATOR "Xcode")
		elseif(Linux)           
			set(CMAKE_GENERATOR "Unix Makefiles")
		elseif(Mac)             
			set(CMAKE_GENERATOR "Xcode")
		elseif(Raspberry)     
			set(CMAKE_GENERATOR "Unix Makefiles")
		elseif(Windows_Arm64_Clang)     
			set(CMAKE_GENERATOR "MinGW Makefiles")
		elseif(Windows_Arm64_Msvc)      
			set(CMAKE_GENERATOR "Visual Studio 17 2022")
			set(CMAKE_GENERATOR_PLATFORM ARM64)
			set(MSVC 1)
		elseif(Windows_X86_Clang)       
			set(CMAKE_GENERATOR "MinGW Makefiles")
		elseif(Windows_X86_Gcc)       
			set(CMAKE_GENERATOR "MinGW Makefiles")
		elseif(Windows_X86_Msvc)        
			set(CMAKE_GENERATOR "Visual Studio 17 2022")
			set(CMAKE_GENERATOR_PLATFORM Win32)
			set(MSVC 1)
		elseif(Windows_X86_64_Clang)    
			set(CMAKE_GENERATOR "MinGW Makefiles")
		elseif(Windows_X86_64_Gcc)   
			set(CMAKE_GENERATOR "MinGW Makefiles")
		elseif(Windows_X86_64_Msvc)     
			set(CMAKE_GENERATOR "Visual Studio 17 2022")
			set(CMAKE_GENERATOR_PLATFORM x64)
			set(MSVC 1)
		elseif(Windows_X86_64_Ucrt)     
			set(CMAKE_GENERATOR "MinGW Makefiles")
		else()
			dk_fatal("Could not get CMAKE_GENERATOR from Target_Tuple:${Target_Tuple}")
		endif()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
    dk_CMAKE_GENERATOR()
    dk_printVar(CMAKE_GENERATOR)
endfunction()
