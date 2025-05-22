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

###############################################################################
# dk_getExtension(path rtn_var)
#
#	Get the extension portion of a path
#
#	@path		- The path to use
#	@rtn_var:	- Returns the extension upon success: False upon error
#
function(dk_getExtension)
	dk_debugFunc()
	
	# WHY A NEW GET EXTENSION FUNCTION ?
#	get_filename_component(extension ${url} EXT)       #Gets the large part of the extension of everything after the first .
#	get_filename_component(extension ${url} LAST_EXT)  #LAST_EXT only available with cmake 3.14+ 
#	cmake_path(GET url EXTENSION LAST_ONLY extension)  #LAST_ONLY only available with cmake 3.19+
	set(path "${ARGV0}")
	set(dk_getExtension "${ARGV0}" PARENT_SCOPE)
	
	string(FIND ${path} "." index REVERSE)
	if(${index} EQUAL -1)
		return() # no extension found
	endif()
	string(SUBSTRING ${path} ${index} -1 dk_getExtension)

	list(APPEND multiexts ".tar.gz")
	list(APPEND multiexts ".tar.xz")
	list(APPEND multiexts ".7z.exe")
	foreach(ext ${multiexts})
		if(path MATCHES "\\${ext}$")
			set(dk_getExtension "${ext}")
		endif()
	endforeach()
	
    set(dk_getExtension ${dk_getExtension} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_getExtension} PARENT_SCOPE)
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_set(myPath "/test/test2/xfile.exten")
    dk_getExtension("${myPath}")
    dk_printVar(dk_getExtension)
	
	dk_getExtension("test.zip")
    dk_printVar(dk_getExtension)
	
	dk_getExtension("test.tar.gz")
    dk_printVar(dk_getExtension)
	
	dk_getExtension("test.tar.xz.tar.gz.tar.xz")
    dk_printVar(dk_getExtension)
	
	dk_getExtension("test.tar.x.gz")
    dk_printVar(dk_getExtension)
	
	dk_getExtension("test.tar.xz")
    dk_printVar(dk_getExtension)
	
	dk_getExtension("test.7z.exe.b")
    dk_printVar(dk_getExtension)
	
	dk_getExtension("test.7z.exe")
    dk_printVar(dk_getExtension)
	
	### use rtn_var ###
	dk_getExtension("test.7z.exe" myReturnVar)
    dk_printVar(myReturnVar)
endfunction()