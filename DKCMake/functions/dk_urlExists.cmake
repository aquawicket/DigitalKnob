#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_urlExists(url rtn_var)
#
function(dk_urlExists url rtn_var)
    dk_debugFunc()
    
	if(CMAKE_VERSION VERSION_LESS 3.19)
		file(DOWNLOAD 
			"${url}"
			"${DKCACHE_DIR}/dk_urlExists.temp"
			STATUS status
			##TIMEOUT 2
		)
		dk_delete("${DKCACHE_DIR}/dk_urlExists.temp")
	else()
		file(DOWNLOAD 
			"${url}"
			STATUS status
		)
	endif()
	dk_printVar(status)

	list(GET status 0 httpCode)
	dk_printVar(httpCode)
    if(${httpCode} EQUAL 0)
        set(${rtn_var} 1 PARENT_SCOPE)
	elseif(${httpCode} EQUAL 28)
		set(${rtn_var} 1 PARENT_SCOPE)
    else()
		set(${rtn_var} 0 PARENT_SCOPE)
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()

    dk_echo()
    #set(url http://www.google.com/index.html)
	set(url https://dl.google.com/android/repository/android-ndk-r23c-windows.zip)
    dk_urlExists(${url} url_exists)
    if(url_exists)
		dk_echo("${url} exists") 
	else()
		dk_echo("${url} does NOT exists") 
	endif()
    
	
    dk_echo()
    set(url http://www.nXoXnXeXxXiXsXtXiXnXg.com/nofile.no)
    dk_urlExists(${url} url_exists)
    if(url_exists)
		dk_echo("${url} exists") 
	else()
		dk_echo("${url} does NOT exists") 
	endif()

endfunction()
