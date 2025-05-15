#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_Target_Type()
#
#	Target_Type = Debug, Release
#
function(dk_Target_Type)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(Target_Type "${ARGV0}")
	
	###### GET ######	
	elseif(NOT DEFINED ENV{Target_Type})
		dk_echo()
		if(Target_Type_Cache)
			dk_echo(" 0) ${Target_Type_Cache}")
		endif()
		
		dk_echo()
		dk_echo(" 1) Debug")
		dk_echo(" 2) Release")
		dk_echo(" 3) Go Back")
		dk_echo(" 4) Exit")
		dk_echo()
		
		dk_keyboardInput(input)
		if("${input}" EQUAL "0")
			dk_set(Target_Type ${Target_Type_Cache})
		elseif("${input}" EQUAL "1")
			dk_set(Target_Type "Debug")
		elseif("${input}" EQUAL "2")
			dk_set(Target_Type "Release")
		elseif("${input}" EQUAL "3")
			#dk_unset(ENV{UPDATE})
		elseif("${input}" EQUAL "4")
			dk_exit(0)
		else()
			dk_warning("invalid selection: '${input}'")
		endif()
	else()
		dk_set(Target_Type "$ENV{Target_Type}")
	endif()
	
	dk_assertVar(Target_Type)
	#dk_set(${Target_Type}_Target 1)	
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	###### GET ######
    dk_Target_Type()
	dk_printVar(Target_Type)
	#dk_printVar(${Target_Type}_Target)
	
	###### SET ######
	dk_Target_Type("Debug")
	dk_printVar(Target_Type)
	#dk_printVar(${Target_Type}_Target)
endfunction()