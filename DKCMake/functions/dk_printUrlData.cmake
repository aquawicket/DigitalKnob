include_guard()

###############################################################################
# dk_printUrlData(url)
#
#	Print url seperated into an array
#
#	@url	- The url to print
#
function(dk_printUrlData url)
	DKDEBUGFUNC(${ARGV})
	if(NOT url)
		dk_error("url invalid! ")
	endif()
	dk_verbose("*** url Variables ***")
	dk_verbose(url					PRINTVAR)
	string(REPLACE "/" ";" PLUGIN_URL_LIST ${url}) # seperate the url nodes into a list 
	dk_verbose(PLUGIN_URL_LIST		PRINTVAR)
	list(LENGTH PLUGIN_URL_LIST PLUGIN_URL_LENGTH)
	dk_verbose(PLUGIN_URL_LENGTH	PRINTVAR)
	set(n -1)
	foreach(PLUGIN_URL_ITEM ${PLUGIN_URL_LIST})
		math(EXPR n "${n}+1")
		set(url_${n} ${PLUGIN_URL_ITEM})
		dk_verbose(url_${n}			PRINTVAR)
		set(url_last ${url_${n}})
	endforeach()
	dk_verbose(url_last			PRINTVAR)
	dk_getFileType(${url} url_filetype)
	dk_verbose(url_filetype		PRINTVAR)
endfunction()