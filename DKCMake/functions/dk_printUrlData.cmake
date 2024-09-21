include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_printUrlData(url)
#
#	Print url seperated into an array
#
#	@url	- The url to print
#
function(dk_printUrlData url)
	dk_debugFunc("\${ARGV}")
	
	if(NOT url)
		dk_fatal("url invalid! ")
	endif()
	dk_verbose("*** url Variables ***")
	dk_verbose(url)
	dk_replaceAll(${url} "/" ";" PLUGIN_URL_LIST) # seperate the url nodes into a list 
	dk_verbose(PLUGIN_URL_LIST)
	list(LENGTH PLUGIN_URL_LIST PLUGIN_URL_LENGTH)
	dk_verbose(PLUGIN_URL_LENGTH)
	set(n -1)
	foreach(PLUGIN_URL_ITEM ${PLUGIN_URL_LIST})
		math(EXPR n "${n}+1")
		set(url_${n} ${PLUGIN_URL_ITEM})
		dk_verbose(url_${n})
		set(url_last ${url_${n}})
	endforeach()
	dk_verbose(url_last)
	dk_getFileType(${url} url_filetype)
	dk_verbose(url_filetype)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()