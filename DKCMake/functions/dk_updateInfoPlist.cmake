#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_updateInfoPlist(app_name)
#
#	TODO
#
#	@app_name	- TODO
#
function(dk_updateInfoPlist app_name)
<<<<<<< HEAD
	dk_debugFunc()
	if(NOT ${ARGC} EQUAL 1)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
=======
	dk_debugFunc(1)
>>>>>>> Development
	
	if(MAC)
		# FIXME
		dk_info("Updating MAC info.plist . . .")
		if(DEBUG)
<<<<<<< HEAD
			if(EXISTS ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist)
				file(READ ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist plist)
				dk_replaceAll(${plist} "<key>CFBundleIconFile</key>" "" plist)
				dk_replaceAll(${plist} "<string>logo</string>" "" plist)
				dk_replaceAll(${plist} "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist)
				dk_fileWrite(${plist} ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist)
			endif()
		endif()
		if(RELEASE)
			if(EXISTS ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist)
				file(READ ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist plist)
				dk_replaceAll(${plist} "<key>CFBundleIconFile</key>" "" plist)
				dk_replaceAll(${plist} "<string>logo</string>" "" plist)
				dk_replaceAll(${plist} "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist)
				dk_fileWrite(${plist} ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist)
=======
			if(EXISTS ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist)
				file(READ ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist plist)
				dk_replaceAll(${plist} "<key>CFBundleIconFile</key>" "" plist)
				dk_replaceAll(${plist} "<string>logo</string>" "" plist)
				dk_replaceAll(${plist} "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist)
				dk_fileWrite(${plist} ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${app_name}.app/Contents/info.plist)
			endif()
		endif()
		if(RELEASE)
			if(EXISTS ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist)
				file(READ ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist plist)
				dk_replaceAll(${plist} "<key>CFBundleIconFile</key>" "" plist)
				dk_replaceAll(${plist} "<string>logo</string>" "" plist)
				dk_replaceAll(${plist} "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist)
				dk_fileWrite(${plist} ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${app_name}.app/Contents/info.plist)
>>>>>>> Development
			endif()	
		endif()
	endif()
	if(IOS OR IOSSIM)
		dk_info("Updating IOS Info.plist . . .")
<<<<<<< HEAD
		dk_info("CHECKING FOR... ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${app_name}.app/Info.plist")
		if(EXISTS ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${app_name}.app/Info.plist)
			dk_info("Updating IOS Debug Info.plist . . .")
			file(READ ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${app_name}.app/Info.plist plist)
			dk_replaceAll(${plist} "<dict>" "<dict>\n<key>Icon files</key>\n<array>\n<string>Icon.png</string>\n<string>Icon@2x.png</string>\n<string>Icon-72.png</string>\n<string>Icon-Small-50.png</string>\n<string>Icon-Small.png</string>\n<string>Icon-Small@2x.png</string>\n</array>\n" plist)
			dk_fileWrite(${plist} ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${app_name}.app/Info.plist)
=======
		dk_info("CHECKING FOR... ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${app_name}.app/Info.plist")
		if(EXISTS ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${app_name}.app/Info.plist)
			dk_info("Updating IOS Debug Info.plist . . .")
			file(READ ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${app_name}.app/Info.plist plist)
			dk_replaceAll(${plist} "<dict>" "<dict>\n<key>Icon files</key>\n<array>\n<string>Icon.png</string>\n<string>Icon@2x.png</string>\n<string>Icon-72.png</string>\n<string>Icon-Small-50.png</string>\n<string>Icon-Small.png</string>\n<string>Icon-Small@2x.png</string>\n</array>\n" plist)
			dk_fileWrite(${plist} ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${app_name}.app/Info.plist)
>>>>>>> Development
		endif()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
	dk_updateInfoPlist()
endfunction()