include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

####################################################################
# dk_urlExists(url rtn_var)
#
function(dk_urlExists url rtn_var)
    dk_debugFunc(${ARGV})
    
    if(DISABLE_curl)
		return()
	endif()
    
	#for /f "usebackq tokens=*" %%f in (`curl -sI -o nul -w "%%{http_code}" "%~1"`) do set "httpCode=%%f"
	file(DOWNLOAD ${url} STATUS status)
	list(GET status 0 httpCode)

    if(${httpCode} EQUAL 0)
        set(${rtn_var} TRUE PARENT_SCOPE)	
    else()
		set(${rtn_var} FALSE PARENT_SCOPE)
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(${ARGV})

    dk_echo()
    set(url http://www.google.com/index.html)
    dk_urlExists(${url} url_exists)
    if(url_exists)
		dk_echo("${url} exists") 
	else()
		dk_echo("${url} does NOT exists") 
	endif()
    
    dk_echo()
    set(url http://www.nonexisting.com/nofile.no)
    dk_urlExists(${url} url_exists)
    if(url_exists)
		dk_echo("${url} exists") 
	else()
		dk_echo("${url} does NOT exists") 
	endif()

endfunction()
