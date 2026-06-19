#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
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
			dk_set(CMAKE_GENERATOR "Unix Makefiles")
		elseif(Cosmo)     
			dk_set(CMAKE_GENERATOR "MSYS Makefiles")
		elseif(Emscripten)          
			dk_set(CMAKE_GENERATOR "Unix Makefiles")
		elseif(Ios)           
			dk_set(CMAKE_GENERATOR "Xcode")
		elseif(Iossim)          
			dk_set(CMAKE_GENERATOR "Xcode")
		elseif(Linux)           
			dk_set(CMAKE_GENERATOR "Unix Makefiles")
		elseif(Mac)             
			dk_set(CMAKE_GENERATOR "Xcode")
		elseif(Raspberry)     
			dk_set(CMAKE_GENERATOR "Unix Makefiles")
		elseif(Windows_Arm32_Msvc)      
			dk_set(CMAKE_GENERATOR "Visual Studio 17 2022")
			dk_set(CMAKE_GENERATOR_PLATFORM ARM)
		elseif(Windows_Arm64_Clang)     
			dk_set(CMAKE_GENERATOR "MinGW Makefiles")
		elseif(Windows_Arm64_Msvc)      
			dk_set(CMAKE_GENERATOR "Visual Studio 17 2022")
			dk_set(CMAKE_GENERATOR_PLATFORM ARM64)
		elseif(Windows_X86_Clang)       
			dk_set(CMAKE_GENERATOR "MinGW Makefiles")
		elseif(Windows_X86_Gcc)       
			dk_set(CMAKE_GENERATOR "MinGW Makefiles")
		elseif(Windows_X86_Msvc)        
			dk_set(CMAKE_GENERATOR "Visual Studio 17 2022")
			dk_set(CMAKE_GENERATOR_PLATFORM Win32)
		elseif(Windows_X86_64_Clang)    
			dk_set(CMAKE_GENERATOR "MinGW Makefiles")
		elseif(Windows_X86_64_Gcc)   
			dk_set(CMAKE_GENERATOR "MinGW Makefiles")
		elseif(Windows_X86_64_Msvc)     
			dk_set(CMAKE_GENERATOR "Visual Studio 17 2022")
			dk_set(CMAKE_GENERATOR_PLATFORM x64)
		elseif(Windows_X86_64_Ucrt)     
			dk_set(CMAKE_GENERATOR "MinGW Makefiles")
		else()
			dk_fatal("Could not get CMAKE_GENERATOR from Target_Tuple:${Target_Tuple}")
		endif()
	endif()
	
	if(CMAKE_GENERATOR MATCHES "Unix") #OR (CMAKE_CXX_COMPILER_ID STREQUAL "GNU"))
		dk_set(GNU 1)
	elseif(CMAKE_GENERATOR MATCHES "Xcode")
		dk_set(XCODE 1)
	elseif(CMAKE_GENERATOR MATCHES "Visual Studio")
		dk_set(MSVC 1)
	elseif(CMAKE_GENERATOR MATCHES "MinGW")
		dk_set(MINGW 1)
	elseif(CMAKE_GENERATOR MATCHES "Msys")
		dk_set(MSYS 1)
	else()
		dk_fatal("Could not determin IDE Environment Variable")
	endif()
	dk_debug("")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
    dk_CMAKE_GENERATOR()
    dk_printVar(CMAKE_GENERATOR)
endfunction()
