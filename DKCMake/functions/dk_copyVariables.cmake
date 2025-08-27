#/usr/bin/cmake -P
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
# dk_copyVariables(prefixA, prefixB)
#
#	Copy all variables starting with prefixA to prefixB
#
#	Example Copy_Variables(Monday_, Wednesday_)
#  All variables whos name start with Monday_ will be copied to new variables
#	that star with Wednesday_.
#
#	Monday_todo_list  ->   Wednesday_todo_list
#	Monday_reminders  ->   Wednesday_reminders
#
#
function(dk_copyVariables)
    dk_debugFunc(0 1)

    set(prefixA "${ARGV0}")			
	set(prefixB "${ARGV1}")										
	
	get_cmake_property(_vars VARIABLES)
    string(REGEX MATCHALL "(^|;)${prefixA}[A-Za-z0-9_]*" _matchedVars "${_vars}")
    foreach(_variable ${_matchedVars})
		if(${_variable})
			string(REPLACE "${prefixA}" "${prefixB}" newVar "${_variable}")
			dk_set(${newVar} "${${_variable}}")
			#dk_debug("${newVar} = ${${newVar}}")
		endif()
    endforeach()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo()
	set(myVar1 "value of myVar1")
	set(myVar2 "value of myVar2")
	dk_echo("myVar1 = ${myVar1}")
	dk_echo("myVar2 = ${myVar2}")
	
	dk_echo()
	dk_echo("dk_copyVariables(\"myVar\" \"yourVar\")")
	dk_copyVariables("myVar" "yourVar")
	
	dk_echo()
	dk_echo("myVar1 = ${myVar1}")
	dk_echo("myVar2 = ${myVar2}")
	dk_echo("yourVar1 = ${yourVar1}")
	dk_echo("yourVar2 = ${yourVar2}")
endfunction()

