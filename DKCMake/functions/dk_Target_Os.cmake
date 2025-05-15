#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_Target_Os()
#
#	Target_Os = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
#
function(dk_Target_Os)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV0)
		dk_set(Target_Os "${ARGV0}")
	
	###### GET ######	
	else()
		dk_echo()
		if(NOT Target_Os_Cache)
			#d_k_Target_Os_Cache()
		endif()
		if(Target_Os_Cache)
			dk_echo(" 0) ${Target_Os_Cache}")
		endif()
		if(NOT Host_Os)
			dk_Host_Os()
		endif()
		dk_echo(" 1) ${Host_Os}")
		dk_echo()
		dk_echo(" 2) Android")
		dk_echo(" 3) Emscripten")
		dk_echo(" 4) Ios")
		dk_echo(" 5) Iossim")
		dk_echo(" 6) Linux")
		dk_echo(" 7) Raspberry")
		dk_echo(" 8) Windows")
		dk_echo(" 9) Go Back")
		dk_echo("10) Exit")
		dk_echo()
		
		dk_keyboardInput(input)
		if("${input}" EQUAL "0")
			dk_set(Target_Os ${Target_Os_Cache})
		elseif("${input}" EQUAL "1")
			dk_set(Target_Os "${Host_Os}")
		elseif("${input}" EQUAL "2")
			dk_set(Target_Os "Android")
		elseif("${input}" EQUAL "3")
			dk_set(Target_Os "Emscripten")
		elseif("${input}" EQUAL "4")
			dk_set(Target_Os "Ios")
		elseif("${input}" EQUAL "5")
			dk_set(Target_Os "Iossim")
		elseif("${input}" EQUAL "6")
			dk_set(Target_Os "Linux")
		elseif("${input}" EQUAL "7")
			dk_set(Target_Os "Raspberry")
		elseif("${input}" EQUAL "8")
			dk_set(Target_Os "Windows")
		elseif("${input}" EQUAL "9")
			#dk_unset(ENV{UPDATE})
		elseif("${input}" EQUAL "10")
			dk_exit(0)
		else()
			dk_warning("invalid selection: '${input}'")
		endif()
	endif()
	
	dk_assertVar(Target_Os)
	dk_set(${Target_Os} 1)
	#dk_set(${Target_Os}_Target 1)
	
	###### VALIDATE RESULT ######
	if(Android)
	elseif(Emscripten)
	elseif(Ios)
	elseif(Iossim)
	elseif(Linux)
	elseif(Mac)
	elseif(Raspberry)
	elseif(Win)
	else()
		dk_fatal("Target_Os:'${Target_Os}' is INVALID!")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	###### GET ######
    dk_Target_Os()
	dk_printVar(Target_Os)
	#dk_printVar(${Target_Os}_Target)
	
	###### SET ######
	dk_Target_Os("Linux")
	dk_printVar(Target_Os)
	#dk_printVar(${Target_Os}_Target)
endfunction()