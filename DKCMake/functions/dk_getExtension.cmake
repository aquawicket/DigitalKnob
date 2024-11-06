#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_getExtension(path rtn_var)
#
#	Get the extension portion of a path
#
#	@path		- The path to use
#	@rtn_var:	- Returns the extension upon success: False upon error
#
function(dk_getExtension path rtn_var)
	dk_debugFunc()
	
	# WHY A NEW GET EXTENSION FUNCTION ?
#	get_filename_component(extension ${url} EXT)       #Gets the large part of the extension of everything after the first .
#	get_filename_component(extension ${url} LAST_EXT)  #LAST_EXT only available with cmake 3.14+ 
#	cmake_path(GET url EXTENSION LAST_ONLY extension)  #LAST_ONLY only available with cmake 3.19+
	string(FIND ${path} "." index REVERSE)
	if(${index} EQUAL -1)
		return() # no extension found
	endif()
	string(SUBSTRING ${path} ${index} -1 extension)

	list(APPEND multiexts ".tar.gz")
	list(APPEND multiexts ".tar.xz")
	list(APPEND multiexts ".7z.exe")
	foreach(ext ${multiexts})
		if(path MATCHES "\\${ext}$")
			set(extension "${ext}")
		endif()
	endforeach()
	
	#dk_printVar(extension)
    set(${rtn_var} ${extension} PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_set(myPath "/test/test2/xfile.exten")
    dk_getExtension("${myPath}" extension)
    dk_printVar(extension)
	
	dk_getExtension("test.zip" extension)
    dk_printVar(extension)
	
	dk_getExtension("test.tar.gz" extension)
    dk_printVar(extension)
	
	dk_getExtension("test.tar.xz.tar.gz.tar.xz" extension)
    dk_printVar(extension)
	
	dk_getExtension("test.tar.x.gz" extension)
    dk_printVar(extension)
	
	dk_getExtension("test.tar.xz" extension)
    dk_printVar(extension)
	
	dk_getExtension("test.7z.exe.b" extension)
    dk_printVar(extension)
	
	dk_getExtension("test.7z.exe" extension)
    dk_printVar(extension)
endfunction()