include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getAppDirectory(rtn_var)
#
#	Get the OS default app directory
#
#	@rtn_var		- TODO
#
function(dk_getAppDirectory rtn_var)
	dk_debugFunc(${ARGV})
	
	set(USE_32BIT 1)
	if(WIN_HOST)
		set(appDirectory "C:/Program Files")
		if(${USE_32BIT} AND ${WIN_X86_64_HOST})
			set(appDirectory "C:/Program Files (x86)")
		endif()
	elseif(MAC_HOST)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(IOS_HOST)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(LINUX_HOST)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(RASPBERRY_HOST)
		dk_todo() #TODO
		set(appDirectory "/")
	elseif(ANDROID_ANDROID)
		dk_todo() #TODO
		set(appDirectory "/")
	endif()
	dk_printVar(appDirectory)
	set(${rtn_var} ${appDirectory} PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()