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
# dk_Target_Os()
#
#	Target_Os = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
#
function(dk_Target_Os)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(Target_Os "${ARGV0}")
	
	###### GET ######	
	elseif(DEFINED ENV{Target_Os})
		dk_set(Target_Os "$ENV{Target_Os}")
	
	else()
		dk_echo()
		if(Target_Os_Cache)
			dk_echo(" 0) ${Target_Os_Cache}")
		endif()
		
		dk_echo()
		if(NOT Host_Os)
			dk_call(dk_Host_Os)
		endif()
		
		### TODO: add cached option here ###
		
		dk_echo(" 1) ${Host_Os}")
		dk_echo()
		dk_echo(" 2) Android")
		dk_echo(" 3) Cosmo")
		dk_echo(" 4) Emscripten")
		dk_echo(" 5) Ios")
		dk_echo(" 6) Iossim")
		dk_echo(" 7) Linux")
		dk_echo(" 8) Mac")
		dk_echo(" 9) Raspberry")
		dk_echo("10) Windows")
		dk_echo("11) Go Back")
		dk_echo("12) Exit")
		dk_echo()
		
		dk_call(dk_keyboardInput input)
		if("${input}" EQUAL "0")
			dk_set(Target_Os ${Target_Os_Cache})
		elseif("${input}" EQUAL "1")
			dk_set(Target_Os "${Host_Os}")
		elseif("${input}" EQUAL "2")
			dk_set(Target_Os "Android")
		elseif("${input}" EQUAL "3")
			dk_set(Target_Os "Cosmo")
		elseif("${input}" EQUAL "4")
			dk_set(Target_Os "Emscripten")
		elseif("${input}" EQUAL "5")
			dk_set(Target_Os "Ios")
		elseif("${input}" EQUAL "6")
			dk_set(Target_Os "Iossim")
		elseif("${input}" EQUAL "7")
			dk_set(Target_Os "Linux")
		elseif("${input}" EQUAL "8")
			dk_set(Target_Os "Mac")
		elseif("${input}" EQUAL "9")
			dk_set(Target_Os "Raspberry")
		elseif("${input}" EQUAL "10")
			dk_set(Target_Os "Windows")
		elseif("${input}" EQUAL "11")
			dk_unset(Target_App)
		elseif("${input}" EQUAL "12")
			dk_exit(0)
		else()
			dk_warning("invalid selection: '${input}'")
		endif()
	endif()
	############
	
	
	##### FINALIZE ######
	dk_assertVar(Target_Os)
	dk_set(${Target_Os} 1)
	
	###### Set Platform and Vender variables
	if(Android)
		dk_set(Google 1)
		dk_set(Unix 1)
	elseif(Cosmo)
		dk_set(Apple 1)
		dk_set(Google 1)
		dk_set(Microsoft 1)
		dk_set(Unix 1)
	elseif(Emscripten)
		dk_set(Unix 1)
	elseif(Ios)
		dk_set(Apple 1)
		dk_set(Unix 1)
	elseif(Iossim)
		dk_set(Apple 1)
		dk_set(Unix 1)
	elseif(Linux)
		dk_set(Unix 1)
	elseif(Mac)
		dk_set(Apple 1)
		dk_set(Unix 1)
	elseif(Raspberry)
		dk_set(Unix 1)
	elseif(Windows)
		dk_set(Microsoft 1)
	else()
		dk_fatal("Target_Os:'${Target_Os}' is INVALID!")
	endif()
	
	
	### Set Debug_Dir and Release_Dir variables
	if(Ios)
		dk_set(Debug_Dir Debug-iphoneos)
		dk_set(Release_Dir Release-iphoneos)
	elseif(Iossim)
		dk_set(Debug_Dir Debug-iphonesimulator)
		dk_set(Release_Dir Release-iphonesimulator)
	else()
		dk_set(Debug_Dir Debug)
		dk_set(Release_Dir Release)
	endif()
	dk_assertVar(Debug_Dir)
	dk_assertVar(Release_Dir)
	
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	###### GET ######
    dk_Target_Os()
	dk_printVar(Target_Os)
	dk_printVar(${Target_Os})
	
	###### SET ######
	dk_Target_Os("Linux")
	dk_printVar(Target_Os)
	dk_printVar(${Target_Os})
endfunction()