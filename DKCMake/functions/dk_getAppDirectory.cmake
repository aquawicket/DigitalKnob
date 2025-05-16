#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_getAppDirectory(rtn_var)
#
#	Get the OS default app directory
#
#	@rtn_var		- TODO
#
function(dk_getAppDirectory rtn_var)
	dk_debugFunc()
	
	set(USE_32BIT 1)
	if(Windows_Host)
		set(appDirectory "C:/Program Files")
		if(${USE_32BIT} AND ${Windows_X86_64_Host})
			set(appDirectory "C:/Program Files (x86)")
		endif()
	elseif(Mac_Host)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(Ios_Host)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(Linux_Host)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(Raspberry_Host)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(Android_Host)
		dk_todo() #TODO
		set(appDirectory "/")
	endif()
	#dk_printVar(appDirectory)
	set(${rtn_var} ${appDirectory} PARENT_SCOPE)
	#dk_printVar(rtn_var)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()