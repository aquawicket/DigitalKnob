include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_updateInfoPlist(app_name)
#
#	TODO
#
#	@app_name	- TODO
#
function(dk_updateInfoPlist app_name)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 1)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	
	if(MAC)
		# FIXME
		dk_info("Updating MAC info.plist . . .")
		if(DEBUG)
			if(EXISTS ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist)
				file(READ ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist plist)
				dk_replaceAll(${plist} "<key>CFBundleIconFile</key>" "" plist)
				dk_replaceAll(${plist} "<string>logo</string>" "" plist)
				dk_replaceAll(${plist} "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist)
				dk_fileWrite(${plist} ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist)
			endif()
		endif()
		if(RELEASE)
			if(EXISTS ${DK_PROJECT_DIR}/${OS}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist)
				file(READ ${DK_PROJECT_DIR}/${OS}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist plist)
				dk_replaceAll(${plist} "<key>CFBundleIconFile</key>" "" plist)
				dk_replaceAll(${plist} "<string>logo</string>" "" plist)
				dk_replaceAll(${plist} "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist)
				dk_fileWrite(${plist} ${DK_PROJECT_DIR}/${OS}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist)
			endif()	
		endif()
	endif()
	if(IOS OR IOSSIM)
		dk_info("Updating IOS Info.plist . . .")
		dk_info("CHECKING FOR... ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist")
		if(EXISTS ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist)
			dk_info("Updating IOS Debug Info.plist . . .")
			file(READ ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist plist)
			dk_replaceAll(${plist} "<dict>" "<dict>\n<key>Icon files</key>\n<array>\n<string>Icon.png</string>\n<string>Icon@2x.png</string>\n<string>Icon-72.png</string>\n<string>Icon-Small-50.png</string>\n<string>Icon-Small.png</string>\n<string>Icon-Small@2x.png</string>\n</array>\n" plist)
			dk_fileWrite(${plist} ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist)
		endif()
	endif()
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_todo()
	dk_updateInfoPlist()
endfunction()