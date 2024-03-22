include_guard()

###############################################################################
# dk_getAppDirectory(RESULT)
#
#	Get the OS default app directory
#
#	@RESULT		- TODO
#
function(dk_getAppDirectory RESULT)
	DKDEBUGFUNC(${ARGV})
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
	set(${RESULT} ${appDirectory} PARENT_SCOPE)
endfunction()