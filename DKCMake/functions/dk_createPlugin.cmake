include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_createPlugin(url)
#
#	Generate a folder/DKMAKE.cmake for a new plugin
#
#	@url	- TODO
#
function(dk_createPlugin url)
	dk_debugFunc(${ARGV})
	
	dk_todo() #TODO
	dk_getAppName(${url} App_Name)
	dk_verbose(App_Name)					# My_App
	dk_toLower(${App_Name} app_name)
	dk_verbose(app_name)					# my_app
	dk_toUpper(${APP_NAME} APP_NAME)
	dk_verbose(APP_NAME)					# MY_APP
	dk_getAppDirectory(appDirectory)
	if(NOT exe_path)
		dk_set(exe_path ${appDirectory}/${App_Name}/${App_Name}.exe)
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()