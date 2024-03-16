include_guard()

###############################################################################
# dk_createPlugin(url)
#
#	Generate a folder/DKMAKE.cmake for a new plugin
#
#	@url	- TODO
#
function(dk_createPlugin url)
	DKDEBUGFUNC(${ARGV})
	dk_todo() #TODO
	dk_getAppName(${url} App_Name)
	dk_verbose(App_Name		PRINTVAR)					# My_App
	dk_toLower(${App_Name} app_name)
	dk_verbose(app_name		PRINTVAR)					# my_app
	dk_toUpper(${APP_NAME} APP_NAME)
	dk_verbose(APP_NAME		PRINTVAR)					# MY_APP
	dk_getAppDirectory(appDirectory)
	if(NOT exe_path)
		dk_set(exe_path ${appDirectory}/${App_Name}/${App_Name}.exe)
	endif()
endfunction()