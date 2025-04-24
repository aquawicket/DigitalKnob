#!/usr/bin/cmake -P
<<<<<<< HEAD
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
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


####################################################################
# dk_urlExists(url)
#
function(dk_urlExists)
	dk_debugFunc(1)

	###### CMD ######
	dk_depend(cmd)
	if(CMD_EXE)
		dk_callDKBatch(dk_urlExists "${ARGV0}")
		set(dk_urlExists "${dk_callDKBatch}" PARENT_SCOPE)
		return()
	endif()
	
	###### BASH ######
	dk_depend(bash)
	if(BASH_EXE)
		dk_callDKBash(dk_urlExists "${ARGV0}")
		set(dk_urlExists "${dk_callDKBash}" PARENT_SCOPE)
		return()
	endif()
	
	###### POWERSHELL ######
	dk_depend(powershell)
	if(POWERSHELL_EXE)
		dk_callDKPowershell(dk_urlExists "${ARGV0}")
		set(dk_urlExists "${dk_callDKPowershell}" PARENT_SCOPE)
		return()
	endif()

>>>>>>> Development
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
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
=======
	dk_debugFunc()

	dk_echo()
	set(url "http://www.google.com/index.html")
	dk_urlExists("${url}")
	if(${dk_urlExists} EQUAL 0)
		dk_echo("url:${url} exists") 
	else()
		dk_echo("url:${url} does not exist") 
	endif()
	
	
	dk_echo()
	set(url "http://www.nXoXnXeXxXiXsXtXiXnXg.com/nofile.no")
	dk_urlExists("${url}")
	if(${dk_urlExists} EQUAL 0)
		dk_echo("url:${url} exists") 
	else()
		dk_echo("url:${url} does not exist") 
	endif()
	
	
	dk_echo()
	set(url "https://aka.ms/vs/16/release/VC_redist.x86.exe")
	dk_urlExists("${url}")
	if(${dk_urlExists} EQUAL 0)
		dk_echo("url:${url} exists") 
	else()
		dk_echo("url:${url} does not exist") 
	endif()
	
	
	dk_echo()
	set(url "https://aka.ms/vs/16/release/VC_redist.x64.exe")
	dk_urlExists("${url}")
	if(${dk_urlExists} EQUAL 0)
		dk_echo("url:${url} exists") 
	else()
		dk_echo("url:${url} does not exist") 
>>>>>>> Development
	endif()

endfunction()
