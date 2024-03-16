include_guard()

###############################################################################
# dk_updateInfoPlist(app_name)
#
#	TODO
#
#	@app_name	- TODO
#
function(dk_updateInfoPlist app_name)
	DKDEBUGFUNC(${ARGV})
	if(MAC)
		# FIXME
		dk_info("Updating MAC info.plist . . .")
		if(DEBUG)
			if(EXISTS ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist)
				file(READ ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist plist)
				string(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				string(REPLACE "<string>logo</string>" "" plist ${plist})
				string(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				file(WRITE "${plist}" ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist)
			endif()
		endif()
		if(RELEASE)
			if(EXISTS ${DK_PROJECT_DIR}/${OS}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist)
				file(READ ${DK_PROJECT_DIR}/${OS}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist plist)
				string(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				string(REPLACE "<string>logo</string>" "" plist ${plist})
				string(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				file(WRITE "${plist}" ${DK_PROJECT_DIR}/${OS}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist)
			endif()	
		endif()
	endif()
	if(IOS OR IOSSIM)
		dk_info("Updating IOS Info.plist . . .")
		dk_info("CHECKING FOR... ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist")
		if(EXISTS ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist)
			dk_info("Updating IOS Debug Info.plist . . .")
			file(READ ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist plist)
			string(REPLACE "<dict>" "<dict>\n<key>Icon files</key>\n<array>\n<string>Icon.png</string>\n<string>Icon@2x.png</string>\n<string>Icon-72.png</string>\n<string>Icon-Small-50.png</string>\n<string>Icon-Small.png</string>\n<string>Icon-Small@2x.png</string>\n</array>\n" plist ${plist})
			file(WRITE "${plist}" ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/${app_name}.app/Info.plist)
		endif()
	endif()
endfunction()