include_guard()

###############################################################################
# dk_getExtension(path RESULT)
#
#	Get the extension portion of a path
#
#	@path		- The path to use
#	@RESULT:	- Returns the extension upon success: False upon error
#
function(dk_getExtension path RESULT)
	DKDEBUGFUNC(${ARGV})
	# WHY A NEW GET EXTENSION FUNCTION ?
#	get_filename_component(extension ${url} EXT)       #Gets the large part of the extension of everything after the first .
#	get_filename_component(extension ${url} LAST_EXT)  #LAST_EXT only available with cmake 3.14+ 
#	cmake_path(GET url EXTENSION LAST_ONLY extension)  #LAST_ONLY only available with cmake 3.19+
	string(FIND ${path} "." index REVERSE)
	if(${index} EQUAL -1)
	#dk_includes(${path} "." index REVERSE)
	#if(NOT ${index})
		return() # no extension found
	endif()
	string(SUBSTRING ${path} ${index} -1 ext)

	#look for .tar
	math(EXPR tar ${index}-4)
	if(${tar} GREATER -1)
		string(SUBSTRING ${path} ${tar} -1 tarext)
		if("${tarext}" STREQUAL ".tar${ext}")
			set(ext ${tarext})
		endif()
	endif()
    set(${RESULT} ${ext} PARENT_SCOPE)
endfunction()