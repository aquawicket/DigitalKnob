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


dk_todo()
################################################################################
# dk_isChildPathOf(haystack, needle, rtn_var)
#
#   https://en.wikipedia.org/wiki/Dirname
#
function(dk_isChildPathOf)
    dk_debugFunc(2 3)
	
#	set(_haystack_ "${ARGV0}")
#   set(_haystack_ %_haystack_:/=\%")									# replace all '/' with '\'
#	set(_haystack_ %_haystack_::=%"	)									# remove all ':'
#    if("${_haystack_}:~0,1%" equ "\") set(_haystack_=${_haystack_:~1}"	# remove first character if it's a '\'
#	#echo %_haystack_%
#	
#    set(_needle_ "${ARGV1}")
#    set(_needle_ "${_needle_:/=}")
#    set(_needle_ "${_needle_::=}")
#    if("${_needle_:~0,1}" equ "\") set(_needle_ ${_needle_:~1}")
#	#echo %_needle_%
# 
#    #message(NOT "${_haystack_:%_needle_%=!}" STREQUAL "${_haystack_}")
#    if(NOT "${_haystack_:%_needle_%=!}" STREQUAL "${_haystack_}")
#        if("%~3" neq "")
#			(endlocal & set(%3=true")
#        endif()
#		unset(_haystack_)
#        unset(_needle_)
#        dk_return(0) # true
#    endif()
#    
#    if("%~3" neq "")
#		(endlocal & set(%3=false")
#	endif()
#    unset(_haystack_)
#    unset(_needle_)
#    dk_return(1) # false
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)

#    ::###### Using if return value
#    %dk_call% dk_echo
#    set(childPath=C:\Program Files\Internet Explorer\en-US"
#    set(parentPath=C:\Program Files"
#    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%" result
#    if "%result%" equ "true" (%dk_call% dk_echo "the path is a child of the parentPath") else (%dk_call% dk_echo "the path is NOT a child of the parentPath")
#    
#    %dk_call% dk_echo
#	set(childPath=/C:/Users/Administrator\digitalknob/nonexistant"
#    set(parentPath=Administrator\digitalknob"
#    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%" result
#    if "%result%" equ "true" (%dk_call% dk_echo "the path is a child of the parentPath") else (%dk_call% dk_echo "the path is NOT a child of the parentPath")
#    ::FIXME: ERRORLEVEL is still 1 
#       
#    ::###### Using if ERRORLEVEL
#    %dk_call% dk_echo
#    set(childPath=C:\Users\Administrator\digitalknob\DKPowershell\functions"
#    set(parentPath=/C/Users/Administrator/digitalknob"
#    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%"
#    if not ERRORLEVEL 1 (%dk_call% dk_echo "the path is a child of the parentPath") else (%dk_call% dk_echo "the path is NOT a child of the parentPath")
#    
#    %dk_call% dk_echo
#    set(childPath=\C:\Users\Administrator/digitalknob\"
#    set(parentPath=C:\"
#    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%"
#    if not ERRORLEVEL 1 (%dk_call% dk_echo "the path is a child of the parentPath") else (%dk_call% dk_echo "the path is NOT a child of the parentPath")
#    ::FIXME: ERRORLEVEL is still 1 
#       
#    ::###### Using && and || conditionals
#    %dk_call% dk_echo
#    set(childPath=C:\Users\"
#    set(parentPath=D:\"
#    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%" && (%dk_call% dk_echo "the path is a child of the parentPath") || (%dk_call% dk_echo "the path is NOT a child of the parentPath")
#
#    %dk_call% dk_echo
#    set(childPath=/C:\Users\Administrator\digitalknob\DKBash\functions"
#    set(parentPath=C:\Users\Administrator\digitalknob\DKBash"
#    %dk_call% dk_isChildPathOf "%childPath%" "%parentPath%" && (%dk_call% dk_echo "the path is a child of the parentPath") || (%dk_call% dk_echo "the path is NOT a child of the parentPath")
#    ::FIXME: ERRORLEVEL is still 1
endfunction()
