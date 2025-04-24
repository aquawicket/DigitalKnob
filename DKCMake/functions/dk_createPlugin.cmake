#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_createPlugin(url)
#
<<<<<<< HEAD
#	Generate a folder/DKMAKE.cmake for a new plugin
=======
#	Generate a folder/DKINSTALL.cmake for a new plugin
>>>>>>> Development
#
#	@url	- TODO
#
function(dk_createPlugin url)
	dk_debugFunc()
	
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




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_createPlugin(todo) 	# dk_createPlugin
>>>>>>> Development
endfunction()