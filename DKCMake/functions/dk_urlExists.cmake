#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


####################################################################
# dk_urlExists(url)
#
function(dk_urlExists)
	dk_debugFunc(1)# 2)

	set(url "${ARGV0}")


		###### CMD ######
	dk_depend(cmd)
	if(CMD_EXE)
		dk_callDKBatch(dk_urlExists "${url}")
		dk_echo("dk_callDKBatch = ${dk_callDKBatch}")
		set(dk_urlExists "${dk_callDKBatch}")
		return()
	endif()
	
	dk_callDKBash(dk_urlExists "${url}")
#	dk_echo("dk_callDKBash = ${dk_callDKBash}")
#	set(dk_urlExists "${dk_callDKBash}")
#	return()
		
	if(CMAKE_VERSION VERSION_LESS 3.19)
		file(DOWNLOAD "${url}" "$ENV{DKCACHE_DIR}/dk_urlExists.temp" STATUS status)
		dk_delete("$ENV{DKCACHE_DIR}/dk_urlExists.temp")
	else()
		file(DOWNLOAD "${url}" STATUS status)
	endif()
	list(GET status 0 httpCode)
	dk_printVar(httpCode)
	if(${httpCode} EQUAL 0)
		set(dk_urlExists 1)
	elseif(${httpCode} EQUAL 28)
		set(dk_urlExists 1)
	else()
		set(dk_urlExists 0)
	endif()

	#dk_printVar(status)
	
	set(dk_urlExists ${dk_urlExists} PARENT_SCOPE)
	
	#if("${ret}")
	#	set(${ret} "${dk_urlExists}" PARENT_SCOPE)
	#endif()
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
