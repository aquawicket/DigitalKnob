#!/usr/bin/cmake -P
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

endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
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
	endif()

endfunction()
