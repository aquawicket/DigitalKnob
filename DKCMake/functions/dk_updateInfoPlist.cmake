#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_updateInfoPlist(app_name)
#
#	TODO
#
#	@app_name	- TODO
#
function(dk_updateInfoPlist app_name)
	dk_debugFunc(1)
	
	if(Mac)
		# FIXME
		dk_info("Updating Mac info.plist . . .")
		if(Debug)
			if(EXISTS ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${app_name}.app/Contents/info.plist)
				file(READ ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${app_name}.app/Contents/info.plist plist)
				dk_replaceAll(${plist} "<key>CFBundleIconFile</key>" "" plist)
				dk_replaceAll(${plist} "<string>logo</string>" "" plist)
				dk_replaceAll(${plist} "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist)
				dk_fileWrite(${plist} ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${app_name}.app/Contents/info.plist)
			endif()
		endif()
		if(Release)
			if(EXISTS ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${app_name}.app/Contents/info.plist)
				file(READ ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${app_name}.app/Contents/info.plist plist)
				dk_replaceAll(${plist} "<key>CFBundleIconFile</key>" "" plist)
				dk_replaceAll(${plist} "<string>logo</string>" "" plist)
				dk_replaceAll(${plist} "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist)
				dk_fileWrite(${plist} ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${app_name}.app/Contents/info.plist)
			endif()	
		endif()
	endif()
	if(IOS OR Iossim)
		dk_info("Updating IOS Info.plist . . .")
		dk_info("CHECKING FOR... ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${app_name}.app/Info.plist")
		if(EXISTS ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${app_name}.app/Info.plist)
			dk_info("Updating IOS Debug Info.plist . . .")
			file(READ ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${app_name}.app/Info.plist plist)
			dk_replaceAll(${plist} "<dict>" "<dict>\n<key>Icon files</key>\n<array>\n<string>Icon.png</string>\n<string>Icon@2x.png</string>\n<string>Icon-72.png</string>\n<string>Icon-Small-50.png</string>\n<string>Icon-Small.png</string>\n<string>Icon-Small@2x.png</string>\n</array>\n" plist)
			dk_fileWrite(${plist} ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${app_name}.app/Info.plist)
		endif()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
	dk_updateInfoPlist()
endfunction()