#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

if(NOT DEFINED Target_Env_Default)
	set(Target_Env_Default "Clang")
endif()
##################################################################################
# dk_Target_Env()
#
#	Target_Env = Clang, Gcc, Msvc, Ucrt
#
function(dk_Target_Env)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(Target_Env "${ARGV0}")
	
	###### GET ######	
	elseif(DEFINED ENV{Target_Env})
		dk_set(Target_Env "$ENV{Target_Env}")
		
	else()
		dk_echo()
		if(Target_Env_Cache)
			dk_echo(" 0) ${Target_Env_Cache}")
		endif()
		
		dk_echo()
		if(NOT Host_Env)
			dk_Host_Env()
		endif()
		dk_echo(" 1) ${Target_Env_Default}")
		dk_echo()
		dk_echo(" 2) Clang")
		dk_echo(" 3) Gcc")
		dk_echo(" 4) Msvc")
		dk_echo(" 5) Ucrt")
		dk_echo(" 6) Go Back")
		dk_echo(" 7) Exit")
		dk_echo()
		
		dk_keyboardInput(input)
		if("${input}" EQUAL "0")
			dk_set(Target_Env ${Target_Env_Cache})
		elseif("${input}" EQUAL "1")
			dk_set(Target_Env "${Target_Env_Default}")
		elseif("${input}" EQUAL "2")
			dk_set(Target_Env "Clang")
		elseif("${input}" EQUAL "3")
			dk_set(Target_Env "Gcc")
		elseif("${input}" EQUAL "4")
			dk_set(Target_Env "Msvc")
		elseif("${input}" EQUAL "5")
			dk_set(Target_Env "Ucrt")
		elseif("${input}" EQUAL "6")
			#dk_unset(ENV{UPDATE})
		elseif("${input}" EQUAL "7")
			dk_exit(0)
		else()
			dk_warning("invalid selection: '${input}'")
		endif()
	endif()
	
	dk_assertVar(Target_Env)
	dk_set(${Target_Env}_Target  1)	
	dk_set(${Target_Env}         1)	
	
	
	
	###### VALIDATE RESULT ######
		if(Clang)
	elseif(Gcc)
	elseif(Msvc)
	elseif(Ucrt)
	else()
		dk_fatal("Target_Env:'${Target_Env}' is INVALID!")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	###### GET ######
    dk_Target_Env()
	dk_printVar(Target_Env)
	dk_printVar(${Target_Env}_Target)
	
	###### SET ######
	dk_Target_Env("Ucrt")
	dk_printVar(Target_Env)
	dk_printVar(${Target_Env}_Target)
endfunction()