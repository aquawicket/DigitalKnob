include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

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
	
	dk_getExtension(${path} ext)
	if(NOT ext)
		dk_error("The path does not contain an extension")
		set(${rtn_var} ERROR PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".app")
		set(${rtn_var} EXECUTABLE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".bash")
		set(${rtn_var} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".bat")
		set(${rtn_var} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".bz")
		set(${rtn_var} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".bz2")
		set(${rtn_var} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".com")
		set(${rtn_var} WEB PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".exe")
		set(${rtn_var} EXECUTABLE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".gif")
		set(${rtn_var} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".gz")
		set(${rtn_var} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".htm")
		set(${rtn_var} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".html")
		set(${rtn_var} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".jpeg")
		set(${rtn_var} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".jpg")
		set(${rtn_var} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".js")
		set(${rtn_var} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".png")
		set(${rtn_var} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".rar")
		set(${rtn_var} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".sh")
		set(${rtn_var} SCRIPT PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".tar")
		set(${rtn_var} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".tif")
		set(${rtn_var} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".tiff")
		set(${rtn_var} IMAGE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".xz")
		set(${rtn_var} ARCHIVE PARENT_SCOPE)
	elseif("${ext}" STREQUAL ".zip")
		set(${rtn_var} ARCHIVE PARENT_SCOPE)
	else()
		set(${rtn_var} UNKNOWN PARENT_SCOPE)
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)