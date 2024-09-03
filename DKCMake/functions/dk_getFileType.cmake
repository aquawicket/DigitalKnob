include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

######################################################################
# dk_getFileType(path rtn_var)
#  
#	Takes a path and checks the extension to return the file type.
#
#	@path		- A string value of the path to identify
#	@rtn_var		- returns a string representing the  type of file.
#           	  Possible results are ARCHIVE, EXECUTABLE, IMAGE, SCRIPT, UNKNOWN, WEB, ...TODO
#
#	Reference: https://en.wikipedia.org/wiki/List_of_file_formats
#
function(dk_getFileType path rtn_var)
	dk_debugFunc(${ARGV})
	
	dk_getExtension(${path} extension)
	if(NOT extension)
		dk_error("The path does not contain an extension")
		set(fileType ERROR)
	elseif("${extension}" STREQUAL ".app")
		set(fileType EXECUTABLE)
	elseif("${extension}" STREQUAL ".bash")
		set(fileType SCRIPT)
	elseif("${extension}" STREQUAL ".bat")
		set(fileType SCRIPT)
	elseif("${extension}" STREQUAL ".bz")
		set(fileType ARCHIVE)
	elseif("${extension}" STREQUAL ".bz2")
		set(fileType ARCHIVE)
	elseif("${extension}" STREQUAL ".com")
		set(fileType WEB)
	elseif("${extension}" STREQUAL ".exe")
		set(fileType EXECUTABLE)
	elseif("${extension}" STREQUAL ".gif")
		set(fileType IMAGE)
	elseif("${extension}" STREQUAL ".gz")
		set(fileType ARCHIVE)
	elseif("${extension}" STREQUAL ".htm")
		set(fileType SCRIPT)
	elseif("${extension}" STREQUAL ".html")
		set(fileType SCRIPT)
	elseif("${extension}" STREQUAL ".jpeg")
		set(fileType IMAGE)
	elseif("${extension}" STREQUAL ".jpg")
		set(fileType IMAGE)
	elseif("${extension}" STREQUAL ".js")
		set(fileType SCRIPT)
	elseif("${extension}" STREQUAL ".png")
		set(fileType IMAGE)
	elseif("${extension}" STREQUAL ".rar")
		set(fileType ARCHIVE)
	elseif("${extension}" STREQUAL ".sh")
		set(fileType SCRIPT)
	elseif("${extension}" STREQUAL ".tar")
		set(fileType ARCHIVE)
	elseif("${extension}" STREQUAL ".tif")
		set(fileType IMAGE)
	elseif("${extension}" STREQUAL ".tiff")
		set(fileType IMAGE)
	elseif("${extension}" STREQUAL ".xz")
		set(fileType ARCHIVE)
	elseif("${extension}" STREQUAL ".zip")
		set(fileType ARCHIVE)
	else()
		set(fileType UNKNOWN)
	endif()
	
	#dk_printVar(fileType)
	set(${rtn_var} ${fileType} PARENT_SCOPE)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()