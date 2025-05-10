#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_Target_Arch()
#
#	Target_Arch = Arm32, Arm64, X86, X86_64, Cosmopolitan
#
function(dk_Target_Arch)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV0)
		dk_set(Target_Arch "${ARGV0}")
	
	###### GET ######	
	else()
		dk_echo()
		if(NOT Target_Arch_Cache)
			#d_k_Target_Arch_Cache()
		endif()
		dk_echo(" 0) ${Target_Arch_Cache}")
		if(NOT Host_Arch)
			dk_Host_Arch()
		endif()
		dk_echo(" 1) ${Host_Arch}")
		dk_echo()
		dk_echo(" 2) Arm32")
		dk_echo(" 3) Arm64")
		dk_echo(" 4) X86")
		dk_echo(" 5) X86_64")
		dk_echo(" 6) Cosmopolitan")
		dk_echo(" 7) Go Back")
		dk_echo(" 8) Exit")
		dk_echo()
		
		dk_keyboardInput(input)
		if("${input}" EQUAL "0")
			dk_set(Target_Arch ${Target_Arch_Cache})
		elseif("${input}" EQUAL "1")
			dk_set(Target_Arch "${Host_Arch}")
		elseif("${input}" EQUAL "2")
			dk_set(Target_Arch "Arm32")
		elseif("${input}" EQUAL "3")
			dk_set(Target_Arch "Arm64")
		elseif("${input}" EQUAL "4")
			dk_set(Target_Arch "X86")
		elseif("${input}" EQUAL "5")
			dk_set(Target_Arch "X86_64")
		elseif("${input}" EQUAL "6")
			dk_set(Target_Arch "Cosmopolitan")
		elseif("${input}" EQUAL "7")
			#dk_unset(ENV{UPDATE})
		elseif("${input}" EQUAL "8")
			dk_exit(0)
		else()
			dk_warning("invalid selection: '${input}'")
		endif()
	endif()
	
	dk_assertVar(Target_Arch)
	#dk_set(${Target_Arch}_Target 1)	
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	###### GET ######
    dk_Target_Arch()
	dk_printVar(Target_Arch)
	#dk_printVar(${Target_Arch}_Target)
	
	###### SET ######
	dk_Target_Arch("Linux")
	dk_printVar(Target_Arch)
	#dk_printVar(${Target_Arch}_Target)
endfunction()