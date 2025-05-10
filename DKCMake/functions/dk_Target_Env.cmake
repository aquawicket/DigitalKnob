#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_Target_Env()
#
#	Target_Env = Clang, Gcc, Msvc, Ucrt
#
function(dk_Target_Env)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV0)
		dk_set(Target_Env "${ARGV0}")
	
	###### GET ######	
	else()
		dk_echo()
		if(NOT Target_Env_Cache)
			#d_k_Target_Env_Cache()
		endif()
		dk_echo(" 0) ${Target_Env_Cache}")
		if(NOT Host_Env)
			dk_Host_Env()
		endif()
		dk_echo(" 1) ${Host_Env}")
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
			dk_set(Target_Env "${Host_Env}")
		elseif("${input}" EQUAL "2")
			dk_set(Target_Env "Clang")
		elseif("${input}" EQUAL "3")
			dk_set(Target_Env "Msvc")
		elseif("${input}" EQUAL "4")
			dk_set(Target_Env "Ucrt")
		elseif("${input}" EQUAL "5")
			#dk_unset(ENV{UPDATE})
		elseif("${input}" EQUAL "6")
			dk_exit(0)
		else()
			dk_warning("invalid selection: '${input}'")
		endif()
	endif()
	
	dk_assertVar(Target_Env)
	#dk_set(${Target_Env}_Target 1)	
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	###### GET ######
    dk_Target_Env()
	dk_printVar(Target_Env)
	#dk_printVar(${Target_Env}_Target)
	
	###### SET ######
	dk_Target_Env("Linux")
	dk_printVar(Target_Env)
	#dk_printVar(${Target_Env}_Target)
endfunction()