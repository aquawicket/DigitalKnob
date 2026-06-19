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
# dk_inputBox(<title> <value> <output>:optional)
#
#
function(dk_inputBox)
	dk_debugFunc(0 3)
	

	set(mshta_exe "$ENV{SystemRoot}\\System32\\mshta.exe")
	
	dk_validate(DKHTAL_DIR "dk_DKBRANCH_DIR()")
	set(dk_inputBox_hta "${DKHTA_DIR}/functions/dk_inputBox.hta")
	
	if(NOT ARGV)
		set(ARGV "inputBox" "")
	endif()
	
	#dk_exec(cmd /c echo "title" "value" | ${mshta_exe} "${dk_inputBox_hta}")
	dk_exec("$ENV{ComSpec}" /c echo ${ARGV} | ${input} ${mshta_exe} "${dk_inputBox_hta}")
	set(dk_inputBox "${dk_exec}")

	# return
	set(dk_inputBox ${dk_inputBox} PARENT_SCOPE)
	if(ARGV2)
		set(${ARGV2} ${dk_inputBox} PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_inputBox("Custom Title" "Initial Value")
	dk_debug("dk_inputBox = ${dk_inputBox}")
	
	dk_inputBox()
	dk_debug("dk_inputBox = ${dk_inputBox}")
endfunction()