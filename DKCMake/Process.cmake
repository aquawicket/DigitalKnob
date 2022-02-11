include(Functions.cmake)
include(Options.cmake)
include(Disabled.cmake)
if(DKPROCESS_INCLUDED)
  return()
endif(DKPROCESS_INCLUDED)
DKSET(DKPROCESS_INCLUDED 1)

DKINFO("\n")
DKINFO("############################################################")
DKINFO("######################  DigitalKnob  #######################")
DKINFO("############################################################")
DKINFO("\n")
	
get_filename_component(APP_NAME ${DKPROJECT} NAME)
string(REPLACE " " "_" APP_NAME ${APP_NAME})

############################################################################################
############################   ADD EXECUTABLE  #############################################
############################################################################################
if(NOT TARGET)
	PROJECT(${APP_NAME})
	DKSET(DKAPP ON)
endif()
##################################################
##### Scan the DKPlugins and build the lists #####
##################################################
include(${DKCMAKE}/BuildFlags.cmake)
include(${DKPROJECT}/DKMAKE.cmake)
DKREMOVE(${DKPROJECT}/${OS}/DKBUILD.log)
dk_printSettings()
#dk_printAllVariables()

DKBUILD_LOG("##############################################")
DKBUILD_LOG("######  Enabled Dependencies (sorted)  #######")
DKBUILD_LOG("##############################################")
list(REMOVE_DUPLICATES dkdepend_list)
foreach(plugin ${dkdepend_list})
	DKBUILD_LOG("${plugin}")
endforeach()
DKBUILD_LOG("\n")

foreach(plugin ${dkdepend_list})
	DKSET(QUEUE_BUILD OFF)
	DKSET(LIBLIST "") 
	## used for double checking
	#DKSET(CMAKE_FILE "")
	
	DKINFO("############################################################")
	DKINFO("######  Processing   ${plugin} . . .                        ")
	DKINFO("############################################################")
	
	##Strip any sublibrary named in the plugin, and enable it
	string(FIND "${plugin}" " " index)
	if(${index} GREATER -1)
		math(EXPR index "${index}+1")
		string(SUBSTRING ${plugin} ${index} -1 arg2)
		math(EXPR index "${index}-1")
		string(SUBSTRING ${plugin} 0 ${index} plugin)
		DKENABLE(${arg2})
	endif()
	
	#################### 3rdParty libs #####################
	dk_getPathToPlugin(${plugin} plugin_path)
	if(NOT plugin_path)
		return()
	endif()
	#DKINFO("plugin_path = ${plugin_path}")

	#This executes the 3rdParty library builds, and dkplugin setup, creates CMakeLists.txt files
	include(${plugin_path}/DKMAKE.cmake)
	
	
	#NOTE: we won't have the library paths to remove until we've run DKCMake.cmake for the library
	# We want to to use this to refresh 3rdParty Plugins
	#if(REBUILDALL)
		#foreach(lib ${LIBLIST})
		#	DKREMOVE(${lib})
		#	DKINFO("######  Removed ${lib}")
		#endforeach()
	#endif()
	
	# ADD THE 3rdParty library TO THE APP SOLUTION
	#string(TOUPPER ${plugin} PLUGIN_NAME)
	#if(EXISTS "${${PLUGIN_NAME}}/CMakeLists.txt")
	#	add_subdirectory(${${PLUGIN_NAME}} ${${PLUGIN_NAME}}/${OS})
	#	DKINFO("add_subdirectory( ${${PLUGIN_NAME}} ${${PLUGIN_NAME}}/${OS} )")
	#endif()
	
	#install(TARGETS <target_name> DESTINATION ${DIGITALKNOB}/DKInstall/lib/${OS})
	#install(FILES file.h DESTINATION ${DIGITALKNOB}/DKInstall/lib/${OS})
	
	####################### DKPlugins #######################
	# Libraries in the /DKPlugins folder
	string(TOLOWER "${DKPLUGIN_LIST}" DKPLUGIN_LIST_lower)
	string(TOLOWER "${plugin}" plugin_lower)	
	string(FIND "${DKPLUGIN_LIST_lower}" "${plugin_lower}" isDKPlugin)
	if(${isDKPlugin} GREATER -1)
		#Add the DKPlugin to the app project
		if(EXISTS "${plugin_path}/CMakeLists.txt")
			if(LINUX OR RASPBERRY)
				if(DEBUG)
					add_subdirectory(${plugin_path} ${plugin_path}/${OS}/Debug)
				elseif(RELEASE)
					add_subdirectory(${plugin_path} ${plugin_path}/${OS}/Release)
				endif()
			else()
				add_subdirectory(${plugin_path} ${plugin_path}/${OS})
			endif()
		endif()
		
		## Prebuild DKPlugins switch
		## Only prebuild if the library binaries are missing
		foreach(lib ${LIBLIST})
			if(NOT EXISTS ${lib})
				DKSET(PREBUILD ON)
				DKSET(QUEUE_BUILD ON)
			endif()
		endforeach()
		
		#DKSET(PREBUILD ON)
		if(PREBUILD)
			DKINFO("******* Prebuilding ${plugin} *******")
			#DKSET(CURRENT_DIR ${plugin_path}/${OS})
			#dk_makeDirectory(${CURRENT_DIR})
			DKSETPATH(${plugin_path}/${BUILD_DIR})
			if(WIN_32)
				WIN_DKQCOMMAND(${DKCMAKE_BUILD} -DWIN_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					WIN32_DKQCOMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
				endif()
				if(RELEASE)
					WIN32_DKQCOMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
				endif()
			endif()
			if(WIN_64)
				WIN_DKQCOMMAND(${DKCMAKE_BUILD} -DWIN_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					WIN64_DKQCOMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
				endif()
				if(RELEASE)
					WIN64_DKQCOMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
				endif()
			endif()
			if(MAC_32)
				MAC_DKQCOMMAND(${DKCMAKE_BUILD} -DMAC_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					MAC32_DKQCOMMAND(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					MAC32_DKQCOMMAND(xcodebuild -configuration Release build)
				endif()
			endif()
			if(MAC_64)
				MAC_DKQCOMMAND(${DKCMAKE_BUILD} -DMAC_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					MAC_DKQCOMMAND(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					MAC_DKQCOMMAND(xcodebuild -configuration Release build)
				endif()
			endif()
			if(IOS_32)
				IOS_DKQCOMMAND(${DKCMAKE_BUILD} -DIOS_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					IOS_DKQCOMMAND(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					IOS_DKQCOMMAND(xcodebuild -configuration Release build)
				endif()
			endif()
			if(IOS_64)
				IOS_DKQCOMMAND(${DKCMAKE_BUILD} -DIOS_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					IOS_DKQCOMMAND(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					IOS_DKQCOMMAND(xcodebuild -configuration Release build)
				endif()
			endif()
			if(IOSSIM_32)
				IOSSIM_DKQCOMMAND(${DKCMAKE_BUILD} -DIOSSIM_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					IOSSIM_DKQCOMMAND(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					IOSSIM_DKQCOMMAND(xcodebuild -configuration Release build)
				endif()
			endif()
			if(IOSSIM_64)
				IOSSIM_DKQCOMMAND(${DKCMAKE_BUILD} -DIOSSIM_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					IOSSIM_DKQCOMMAND(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					IOSSIM_DKQCOMMAND(xcodebuild -configuration Release build)
				endif()
			endif()
			if(LINUX_32)
				if(DEBUG)
					LINUX_DKQCOMMAND(${DKCMAKE_BUILD} -DLINUX_32=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
					LINUX_DKQCOMMAND(make)
				elseif(RELEASE)
					LINUX_DKQCOMMAND(${DKCMAKE_BUILD} -DLINUX_32=ON -DREBUILD=ON -DRELEASE=ON ${plugin_path})
					LINUX_DKQCOMMAND(make)
				endif()
			endif()
			if(LINUX_64)
				if(DEBUG)
					LINUX_DKQCOMMAND(${DKCMAKE_BUILD} -DLINUX_64=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
					LINUX_DKQCOMMAND(make)
				elseif(RELEASE)
					LINUX_DKQCOMMAND(${DKCMAKE_BUILD} -DLINUX_64=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
					LINUX_DKQCOMMAND(make)
				endif()
			endif()
			if(RASPBERRY_32)
				if(DEBUG)
					RASPBERRY_DKQCOMMAND(${DKCMAKE_BUILD} -DRASPBERRY_32=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
					RASPBERRY_DKQCOMMAND(make)
				elseif(RELEASE)
					RASPBERRY_DKQCOMMAND(${DKCMAKE_BUILD} -DRASPBERRY_32=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
					RASPBERRY_DKQCOMMAND(make)
				endif()
			endif()
			if(RASPBERRY_64)
				if(DEBUG)
					RASPBERRY_DKQCOMMAND(${DKCMAKE_BUILD} -DRASPBERRY_64=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
					RASPBERRY_DKQCOMMAND(make)
				elseif(RELEASE)
					RASPBERRY_DKQCOMMAND(${DKCMAKE_BUILD} -DRASPBERRY_64=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
					RASPBERRY_DKQCOMMAND(make)
				endif()
			endif()
			if(ANDROID_32)
				ANDROID_DKQCOMMAND(${DKCMAKE_BUILD} -DANDROID_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					ANDROID32_DKQCOMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
				endif()
				if(RELEASE)
					ANDROID32_DKQCOMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
				endif()
			endif()
			if(ANDROID_64)
				ANDROID_DKQCOMMAND(${DKCMAKE_BUILD} -DANDROID_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					ANDROID64_DKQCOMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
				endif()
				if(RELEASE)
					ANDROID64_DKQCOMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
				endif()
			endif()
		
			set(PREBUILD OFF)

			## double check that the missing libs were built
			foreach(lib ${LIBLIST})
				if(NOT EXISTS ${lib})
					DKINFO("\n\n\n****************************\nFAILED to find: ${lib} \n***********************************")
					#DKERROR(" ")
				endif()
			endforeach()
		endif()
		
	endif()
endforeach()

if(NOT DKAPP)
	return()
endif()	

DKINFO("\n")
DKINFO("***************************************")
DKINFO("********** Creating ${APP_NAME} **********")
DKINFO("***************************************\n")

# Create version from date
string(TIMESTAMP year "%y")
string(TIMESTAMP month "%m")
string(TIMESTAMP day "%d")
DKSET(APP_VERSION "${year}.${month}.${day}")

## Create the DKPlugins.h header file
if(PLUGINS_FILE)
	string(REPLACE "#include \"DKWindow.h\"" "" PLUGINS_FILE ${PLUGINS_FILE})
	string(REPLACE "\\n" "\n" PLUGINS_FILE ${PLUGINS_FILE})
	file(WRITE ${DKPROJECT}/DKPlugins.h ${PLUGINS_FILE})
endif()

if(HAVE_DK)
	DKINFO("Copying DKPlugins/_DKIMPORT/ to App...")
	DKCOPY(${DKPLUGINS}/_DKIMPORT/icons ${DKPROJECT}/icons FALSE) ## copy app default files recursivly without overwrite
	DKCOPY(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h FALSE) ## copy app default files recursivly without overwrite
	#DKCOPY(${DKPLUGINS}/_DKIMPORT/App.h ${DKPROJECT}/App.h FALSE) ## copy app default files recursivly without overwrite
	#DKCOPY(${DKPLUGINS}/_DKIMPORT/App.cpp ${DKPROJECT}/App.cpp FALSE) ## copy app default files recursivly without overwrite
	DKCOPY(${DKPLUGINS}/_DKIMPORT/main.cpp ${DKPROJECT}/main.cpp FALSE)
endif()
	
### Include all source files from the app folder for the compilers
#file(GLOB_RECURSE App_SRC
file(GLOB App_SRC
	${DKPROJECT}/*.h
	${DKPROJECT}/*.c
	${DKPROJECT}/*.cpp)
list(FILTER App_SRC EXCLUDE REGEX "${DKPROJECT}/assets/*")
list(FILTER App_SRC EXCLUDE REGEX "${DKPROJECT}/${OS}/*")
if(SRC_INCLUDE)
	file(GLOB App_SRC_INCLUDE ${SRC_INCLUDE})
	list(APPEND App_SRC ${App_SRC_INCLUDE})
endif()
if(SRC_EXCLUDE)
	foreach(item ${SRC_EXCLUDE})
		list(FILTER App_SRC EXCLUDE REGEX ${item})
	endforeach()
endif()

	
add_definitions(-DDKAPP)
include_directories(${DKPROJECT})
include_directories(${DKPLUGINS})

##########
if(WIN_32)
	########################## CREATE ICONS ###############################
	if(EXISTS ${DKPROJECT}/icons/icon.png)
		if(IMAGEMAGICK_CONVERT)
			DKINFO("Building icons for ${APP_NAME} . . .")
			dk_makeDirectory(${DKPROJECT}/icons/windows)
			DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=256,128,64,48,32,16 ${DKPROJECT}/icons/windows/icon.ico)
			DKCOPY(${DKPROJECT}/icons/windows/icon.ico ${DKPROJECT}/assets/icon.ico TRUE) # copy the icon to assets
			DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=16 ${DKPROJECT}/assets/favicon.ico)
		endif()
	endif()
	
	################# BACKUP USERDATA / INJECT ASSETS #####################	
	if(HAVE_DK)
		## ASSETS ##
		# Backup files and folders excluded from the package
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		# Remove excluded files and folders before packaging
		DKREMOVE(${DKPROJECT}/assets/USER)
		#Compress the assets, they will be included by resource.rc
		DKINFO("Creating assets.zip . . .")
		DKZIP(${DKPROJECT}/assets)
		# Restore the backed up files, excluded from assets
		DKCOPY(${DKPROJECT}/Backup ${DKPROJECT}/assets TRUE)
		DKREMOVE(${DKPROJECT}/Backup)
		DKCOPY(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h TRUE) #required
	endif()	
		
	###################### Backup Executable ###########################
	if(DEBUG)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup true)
	endif()
	if(RELEASE)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup true)
	endif()
		
	####################### Create Executable Target ###################
	if(HAVE_DK)
		DKCOPY(${DKPLUGINS}/_DKIMPORT/win/resource.h ${DKPROJECT}/resource.h FALSE)
		DKCOPY(${DKPLUGINS}/_DKIMPORT/win/resource.rc ${DKPROJECT}/resource.rc FALSE)
		file(GLOB_RECURSE resources_SRC 
			${DKPROJECT}/*.manifest
			${DKPROJECT}/*.rc
			${DKPROJECT}/icons/windows/*.rc)
			list(APPEND App_SRC ${resources_SRC})
	endif()
	add_executable(${APP_NAME} WIN32 ${App_SRC})
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()

	##set_source_files_properties(${DIGITALKNOB}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
	
	list(APPEND DEBUG_LINK_FLAGS /MANIFEST:NO)
	list(APPEND DEBUG_LINK_FLAGS /MANIFESTUAC:NO)
	list(APPEND DEBUG_LINK_FLAGS /level='highestAvailable')
	list(APPEND DEBUG_LINK_FLAGS /uiAccess='true')
	list(APPEND DEBUG_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
	list(APPEND DEBUG_LINK_FLAGS /SAFESEH:NO)
	string(REPLACE ";" " " DEBUG_FLAGS "${DEBUG_LINK_FLAGS}")
	
	##list(APPEND RELEASE_LINK_FLAGS /FORCE) ## This can be used to debug if libraries cause redefinitions
	list(APPEND RELEASE_LINK_FLAGS /INCREMENTAL:NO)
	list(APPEND RELEASE_LINK_FLAGS /OPT:NOREF)
	list(APPEND RELEASE_LINK_FLAGS /MANIFEST:NO)
	list(APPEND RELEASE_LINK_FLAGS /MANIFESTUAC:NO)
	list(APPEND RELEASE_LINK_FLAGS /level='highestAvailable')
	list(APPEND RELEASE_LINK_FLAGS /uiAccess='true')
	list(APPEND RELEASE_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
	list(APPEND RELEASE_LINK_FLAGS /SAFESEH:NO)
	string(REPLACE ";" " " RELEASE_FLAGS "${RELEASE_LINK_FLAGS}")
	
	set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${APP_NAME})
	
	### POST BUILD ###
	#CPP_DKFile_Copy(app_path+OS+"/Release/"+APP+".pdb", app_path+"assets/"+APP+".pdb", true)
	#CPP_DK_Execute(DIGITALKNOB+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/Release/"+APP+".exe")
		
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${APP_NAME}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	
	#add_custom_command(
    #TARGET ${APP_NAME}
    #POST_BUILD
    #COMMAND "mt.exe" -nologo
    #        -manifest \"${DKPROJECT}/compatibility.manifest\"
    #        -outputresource:"${DKPROJECT}/win32/Debug/${APP_NAME}.exe"\;\#1
    #COMMENT "Adding manifest..."
    #)
	
endif(WIN_32)
	
##########
if(WIN_64)
	########################## CREATE ICONS ###############################
	if(EXISTS ${DKPROJECT}/icons/icon.png)
		if(IMAGEMAGICK_CONVERT)
			DKINFO("Building icons for ${APP_NAME} . . .")
			dk_makeDirectory(${DKPROJECT}/icons/windows)
			DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=256,128,64,48,32,16 ${DKPROJECT}/icons/windows/icon.ico)
			DKCOPY(${DKPROJECT}/icons/windows/icon.ico ${DKPROJECT}/assets/icon.ico TRUE)
			DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=16 ${DKPROJECT}/assets/favicon.ico)
		endif()
	endif()
			
	################# BACKUP USERDATA / INJECT ASSETS #####################
	if(HAVE_DK)
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		DKREMOVE(${DKPROJECT}/assets/USER)
		#Compress the assets, they will be included by resource.rc
		DKINFO("Creating assets.zip . . .")
		DKZIP(${DKPROJECT}/assets)
		# Restore the backed up files
		DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ TRUE)
		DKREMOVE(${DKPROJECT}/Backup)
		#dummy assets.h file, or the builder wil complain about assets.h missing
		DKCOPY(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h TRUE)
	endif()

	###################### Backup Executable ###########################
	if(DEBUG)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup true)
	endif()
	if(RELEASE)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup true)
	endif()
		
	####################### Create Executable Target ###################
	if(HAVE_DK)
		##set_source_files_properties(${DIGITALKNOB}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
		DKCOPY(${DKPLUGINS}/_DKIMPORT/win/resource.h ${DKPROJECT}/resource.h FALSE)
		DKCOPY(${DKPLUGINS}/_DKIMPORT/win/resource.rc ${DKPROJECT}/resource.rc FALSE)
		file(GLOB_RECURSE resources_SRC 
			${DKPROJECT}/*.manifest
			${DKPROJECT}/*.rc
			${DKPROJECT}/icons/windows/*.rc)
	endif()
	list(APPEND App_SRC ${resources_SRC})
	add_executable(${APP_NAME} WIN32 ${App_SRC})

	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
		
	############# Link Libraries, Set Startup Project #################
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	list(APPEND DEBUG_LINK_FLAGS /MANIFEST:NO)
	list(APPEND DEBUG_LINK_FLAGS /MANIFESTUAC:NO)
	list(APPEND DEBUG_LINK_FLAGS /level='highestAvailable')
	list(APPEND DEBUG_LINK_FLAGS /uiAccess='true')
	list(APPEND DEBUG_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
	list(APPEND DEBUG_LINK_FLAGS /SAFESEH:NO)
	string(REPLACE ";" " " DEBUG_FLAGS "${DEBUG_LINK_FLAGS}")
	
	##list(APPEND RELEASE_LINK_FLAGS /FORCE) ## MySQL lib needs /FORCE due to zlib redefinitions
	list(APPEND RELEASE_LINK_FLAGS /INCREMENTAL:NO)
	list(APPEND RELEASE_LINK_FLAGS /OPT:NOREF)
	list(APPEND RELEASE_LINK_FLAGS /MANIFEST:NO)
	list(APPEND RELEASE_LINK_FLAGS /MANIFESTUAC:NO)
	list(APPEND RELEASE_LINK_FLAGS /level='highestAvailable')
	list(APPEND RELEASE_LINK_FLAGS /uiAccess='true')
	list(APPEND RELEASE_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
	list(APPEND RELEASE_LINK_FLAGS /SAFESEH:NO)
	string(REPLACE ";" " " RELEASE_FLAGS "${RELEASE_LINK_FLAGS}")
	
	set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${APP_NAME})
		
	####################### Do Post Build Stuff #######################
	#CPP_DKFile_Copy(app_path+OS+"/Release/"+APP+".pdb", app_path+"assets/"+APP+".pdb", true)
	#CPP_DK_Execute(DIGITALKNOB+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/Release/"+APP+".exe")
endif(WIN_64)


#######
if(MAC)
	###################### Backup Executable ###########################
	if(DEBUG)
		DKCOPY(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup TRUE)
	endif()
	if(RELEASE)
		DKCOPY(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup TRUE)
	endif()
		
	########################## CREATE ICONS ###############################
	if(EXISTS ${DKPROJECT}/icons/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/mac)
		dk_makeDirectory(${DKPROJECT}/icons/mac/icons.iconset)
		DKEXECUTE_PROCESS(sips -z 16 16 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_16x16.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 32 32 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_16x16@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 32 32 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_32x32.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 64 64 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_32x32@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 128 128 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_128x128.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 256 256 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_128x128@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 256 256 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_256x256.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 512 512 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_256x256@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 512 512 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_512x512.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 1024 1024 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_512x512@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(iconutil -c icns -o ${DKPROJECT}/icons/mac/icons.icns ${DKPROJECT}/icons/mac/icons.iconset WORKING_DIRECTORY ${DIGITALKNOB})
		set(MACOSX_BUNDLE_ICON_FILE icons.icns)
		set(app_ICONS ${DKPROJECT}/icons/mac/icons.icns)
		set_source_files_properties(${app_ICONS} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
	endif()
		
	################# BACKUP USERDATA / INJECT ASSETS #####################	
	DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
	DKREMOVE(${DKPROJECT}/assets/USER)
	DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
	DKREMOVE(${DKPROJECT}/Backup)
	
	####################### Create Executable Target ###################
	file(GLOB_RECURSE m_SRC 
		${DKPROJECT}/*.m
		${DKPROJECT}/*.mm)
	list(APPEND App_SRC ${m_SRC})
	add_executable(${APP_NAME} MACOSX_BUNDLE ${app_ICONS} ${App_SRC})
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			if(NOT ${plugin} MATCHES "DKCefChild")
				add_dependencies(${APP_NAME} ${plugin})
			endif()
		endif()
	endforeach()
		
	######################### Create Info.plist #######################
	DKSET(PRODUCT_BUNDLE_IDENTIFIER com.digitalknob.${APP_NAME})
	DKSET(CFBundleDevelopmentRegion en)
	DKSET(CFBundleDisplayName ${APP_NAME})
	DKSET(CFBundleExecutable wrapper) ##${APP_NAME})
	DKSET(CFBundleGetInfoString "DigitalKnob")
	DKSET(CFBundleIconFile "icons.icns")
	#DKSET(CFBundleIconFiles "icons.icns")
	DKSET(CFBundleIdentifier ${PRODUCT_BUNDLE_IDENTIFIER})
	DKSET(CFBundleInfoDictionaryVersion 6.0)
	DKSET(CFBundleLongVersionString "${APP_NAME}-${APP_VERSION}")
	DKSET(CFBundleName ${APP_NAME})
	DKSET(CFBundlePackageType APPL)
	DKSET(CFBundleShortVersionString ${APP_VERSION})
	DKSET(CFBundleSignature ????)
	DKSET(CFBundleVersion 1.0)
	#DKSET(LSRequiresIPhoneOS NO)
	DKSET(NSMainNibFile "")
	#DKSET(UILaunchStoryboardName dk)
	#DKSET(UIMainStoryboardFile dk.storyboard)
	set_target_properties(${APP_NAME} PROPERTIES 
		MACOSX_BUNDLE TRUE 
		XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ""
		MACOSX_BUNDLE_INFO_PLIST ${DKPLUGINS}/_DKIMPORT/mac/Info.plist)
		
	##############Delete Exlusions and Copy Assets to Bundle #######################
	
	DKREMOVE(${DKPROJECT}/assets/log.txt)
	DKREMOVE(${DKPROJECT}/assets/cef.txt)
	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${DKPROJECT}/assets $<TARGET_BUNDLE_CONTENT_DIR:${APP_NAME}>/Resources)
		
	############# Link Libraries, Set Startup Project #################
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY XCODE_STARTUP_PROJECT ${APP_NAME})
	
	####################### Do Post Build Stuff #######################
	# Copy the CEF framework into the app bundle
	if(EXISTS ${CEF})
		DKINFO("Adding Chromium Embedded Framework.framework to bundle . . .")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory "${CEF}/$<CONFIG>/Chromium Embedded Framework.framework" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/Chromium Embedded Framework.framework")
	endif()
	
	# Copy the DKCefChild into the app bundle
	if(EXISTS "${DKPLUGINS}/DKCefChild/${OS}/Release/DKCefChild.app")
		DKINFO("Adding Chromium Embedded Framework.framework to bundle . . .")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${DKPLUGINS}/DKCefChild/${OS}/$<CONFIG>/DKCefChild.app" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/${APP_NAME} Helper.app")
	endif()
	
	# Make bundle open with Terminal
	# https://github.com/pyinstaller/pyinstaller/issues/5154#issuecomment-690646012
	if(true)
		DKINFO("Making bundle app run in terminal on double-click . . .")
		set(TERMINAL_SCRIPT 
			"\#!/bin/bash\n"
			"dir=$(cd \"$( dirname \"\${0}\")\" && pwd )\n"
			"Open -a \"Terminal\" \"\${dir}/${APP_NAME}\""
		)
		file(WRITE ${DKPROJECT}/${OS}/wrapper ${TERMINAL_SCRIPT}) #${APP_NAME}
		DKEXECUTE_PROCESS(chmod +x ${DKPROJECT}/${OS}/wrapper WORKING_DIRECTORY ${DKPROJECT}/${OS})
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${DKPROJECT}/${OS}/wrapper" "$<TARGET_FILE_DIR:${APP_NAME}>/wrapper")
	endif()
	
	#CPP_DK_Execute("chmod +x "+app_path+OS+"/Debug/"+APP)
#			if(CPP_DKFile_Exists(app_path+"assets/DKCef/mac64Debug/Chromium Embedded Framework.framework")){
#				CPP_DKFile_MkDir(app_path+"mac64/Debug/"+APP+".app/Contents/Frameworks")
#				CPP_DKFile_Copy(app_path+"assets/DKCef/mac64Debug/Chromium Embedded Framework.framework", app_path+"mac64/Debug/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework", true)
#				if(CPP_DKFile_Exists(DIGITALKNOB+"DK/DKPlugins/DKCefChild/mac64/Debug/DKCefChild.app")){
#					CPP_DKFile_Copy(DIGITALKNOB+"DK/DKPlugins/DKCefChild/mac64/Debug/DKCefChild.app", app_path+"mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app", true)
#					CPP_DKFile_Rename(app_path+"mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/DKCefChild", app_path+"mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper", true)
#				}
#			}
#			//update the info.plist to include the logo icon
#			if(CPP_DKFile_Exists(app_path+OS+"/Debug/"+APP+".app/Contents/info.plist")){
#				let info_plist = CPP_DKFile_FileToString(app_path+OS+"/Debug/"+APP+".app/Contents/info.plist")
#				info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>")
#				CPP_DKFile_StringToFile(info_plist, app_path+OS+"/Debug/"+APP+".app/Contents/info.plist")
#			}
#			//update install_name_tool if cef present
#			if(CPP_DKFile_Exists(app_path+OS+"/Debug/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework")){
#				console.log("USING CHROMIUM EMBEDDED FRAMEWORK")
#				let command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+app_path+OS+"/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\""
#				console.log(command)
#				CPP_DK_Execute(command)
#				command = "install_name_tool -add_rpath \"@executable_path/../../../../\" \""+app_path+OS+"/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\""
#				console.log(command)
#				CPP_DK_Execute(command)
#				command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+app_path+OS+"/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+"\""
#				console.log(command)
#				CPP_DK_Execute(command)
#				command = "install_name_tool -add_rpath \"@executable_path/../\" \""+app_path+OS+"/Debug/"+APP+".app/Contents/MacOS/"+APP+"\""
#				console.log(command)
#				CPP_DK_Execute(command)
#			}
#			*/
endif()


# https://github.com/forexample/testapp/blob/master/CMakeLists.txt
#################
if(IOS OR IOSSIM)
	
	###################### Backup Executable ###########################
	if(DEBUG)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup true)
	endif()
	if(RELEASE)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup true)
	endif()
	
	###################### BACKUP USERDATA ###############################
	# Backup files and folders excluded from the package
	#DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
	# Remove excluded files and folders before packaging
	#DKREMOVE(${DKPROJECT}/assets/USER)
	# Restore the backed up files, excluded from assets
	#DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
	#DKREMOVE(${DKPROJECT}/Backup)
		
	########################## Images ##############################
	#TODO
	
	########################## ICONS ###############################
	if(EXISTS ${DKPROJECT}/icons/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/ios)
		dk_makeDirectory(${DKPROJECT}/icons/ios/icons.iconset)
		DKEXECUTE_PROCESS(sips -z 16 16 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_16x16.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 32 32 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_16x16@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 32 32 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_32x32.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 64 64 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_32x32@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 128 128 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_128x128.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 256 256 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_128x128@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 256 256 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_256x256.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 512 512 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_256x256@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 512 512 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_512x512.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(sips -z 1024 1024 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_512x512@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(iconutil -c icns -o ${DKPROJECT}/icons/ios/icons.icns ${DKPROJECT}/icons/ios/icons.iconset WORKING_DIRECTORY ${DIGITALKNOB})
		set(MACOSX_BUNDLE_ICON_FILE icons.icns)
		set(app_ICONS ${DKPROJECT}/icons/ios/icons.icns)
		set_source_files_properties(${app_ICONS} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
	endif()
	
	####################### Storyboards ############################
	#TODO
		
	####################### Create Executable Target ###################
	file(GLOB_RECURSE m_SRC 
	${DKPROJECT}/*.m
	${DKPROJECT}/*.mm)
	list(APPEND App_SRC ${m_SRC})
	#if(HAVE_DK)
	#	list(APPEND App_SRC ${DKPLUGINS}/DK/DKAppDelegate.h)
	#	list(APPEND App_SRC ${DKPLUGINS}/DK/DKAppDelegate.m)
	#endif()
	add_executable(${APP_NAME} MACOSX_BUNDLE ${app_ICONS} ${App_SRC} ${RES_FILES})
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
		
	######################### Create Info.plist #######################
	DKSET(PRODUCT_BUNDLE_IDENTIFIER com.digitalknob.${APP_NAME})
	DKSET(CFBundleDevelopmentRegion en)
	DKSET(CFBundleDisplayName ${APP_NAME})
	DKSET(CFBundleExecutable ${APP_NAME})
	DKSET(CFBundleGetInfoString DigitalKnob)
	DKSET(CFBundleIconFile "icons.icns")
	DKSET(CFBundleIdentifier ${PRODUCT_BUNDLE_IDENTIFIER})
	DKSET(CFBundleInfoDictionaryVersion 6.0)
	DKSET(CFBundleLongVersionString 1.0.0)
	DKSET(CFBundleName ${APP_NAME})
	DKSET(CFBundlePackageType APPL)
	DKSET(CFBundleShortVersionString 1.0)
	DKSET(CFBundleSignature ????)
	DKSET(CFBundleVersion 1.0)
	#DKSET(LSRequiresIPhoneOS NO)
	DKSET(NSMainNibFile "")
	#DKSET(UILaunchStoryboardName dk)
	#DKSET(UIMainStoryboardFile dk.storyboard)
	set_target_properties(${APP_NAME} PROPERTIES MACOSX_BUNDLE TRUE MACOSX_BUNDLE_INFO_PLIST ${DKPLUGINS}/_DKIMPORT/ios/Info.plist)
			
	###################### Add Assets to Bundle #######################
	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${DKPROJECT}/assets $<TARGET_FILE_DIR:${APP_NAME}>/assets)
	#if(EXISTS ${DKPROJECT}/icons/mac/icons.icns)
	#	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${DKPROJECT}/icons/ios/icons.icns $<TARGET_FILE_DIR:${APP_NAME}>/Resources/icons.icns)
	#endif()
	
	############# Link Libraries, Set Startup Project #################
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY XCODE_STARTUP_PROJECT ${APP_NAME})
endif()



#########
if(LINUX)
if(NOT RASPBERRY)
	###################### Backup Executable ###########################
	if(DEBUG)
		DKCOPY(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup TRUE)
	elseif(RELEASE)
		DKCOPY(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup TRUE)
	endif()
	
	########################## CREATE ICONS ###############################
	DKCOPY(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)
	
	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		DKREMOVE(${DKPROJECT}/assets/USER)
		# Remove excluded files and folders before packaging
		DKINFO("Creating assets.zip . . .")
		DKZIP(${DKPROJECT}/assets)
		#DKINFO("Creating assets.h . . .")
		bin2h(SOURCE_FILE ${DKPROJECT}/assets.zip HEADER_FILE ${DKPROJECT}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
		DKREMOVE(${DKPROJECT}/Backup)
	endif()
	
	####################### Create Executable Target ###################
	add_executable(${APP_NAME} ${App_SRC})
	if(DEBUG)
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${LIBS})
	elseif(RELEASE)
		target_link_libraries(${APP_NAME} ${RELEASE_LIBS} ${LIBS})
	endif()
	
	###################### Add Build Dependencies ######################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
	
	############# Create .desktop Icon Files / Install ################
	if(DEBUG)
		DKSET(DESKTOP_FILE
			"[Desktop Entry]\n"
			"Encoding=UTF-8\n"
			"Version=1.0\n"
			"Type=Application\n"
			"Terminal=true\n"
			"Name=${APP_NAME}\n"
			"Exec=${DKPROJECT}/${OS}/Debug/${APP_NAME}\n"
			"Icon=${DKPROJECT}/icons/icon.png\n")
		file(WRITE ${DKPROJECT}/${OS}/Debug/${APP_NAME}.desktop ${DESKTOP_FILE})
	elseif(RELEASE)
		DKSET(DESKTOP_FILE
			"[Desktop Entry]\n"
			"Encoding=UTF-8\n"
			"Version=1.0\n"
			"Type=Application\n"
			"Terminal=true\n"
			"Name=${APP_NAME}\n"
			"Exec=${DKPROJECT}/${OS}/Release/${APP_NAME}\n"
			"Icon=${DKPROJECT}/icons/icon.png\n")
		file(WRITE ${DKPROJECT}/${OS}/Release/${APP_NAME}.desktop ${DESKTOP_FILE})
	
		# Install shortcut of Release build to the apps menu
		DKEXECUTE_PROCESS(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DKPROJECT}/${OS}/Release/${APP_NAME}.desktop WORKING_DIRECTORY ${DKPROJECT}/${OS}/Release)
	endif()
	
	####################### Do Post Build Stuff #######################
	#CPP_DK_Execute("chmod +x "+app_path+OS+"/Debug/"+APP)
endif()
endif()



#############
if(RASPBERRY)
	########################## CREATE ICONS ###############################
	DKCOPY(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)

	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		# Remove excluded files and folders before packaging
		DKREMOVE(${DKPROJECT}/assets/USER)
		DKINFO("Creating assets.zip . . .")
		DKZIP(${DKPROJECT}/assets)
		#DKINFO("Creating assets.h . . .")
		bin2h(SOURCE_FILE ${DKPROJECT}/assets.zip HEADER_FILE ${DKPROJECT}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
		DKREMOVE(${DKPROJECT}/Backup)
	endif()
	
	###################### Backup Executable ###########################
	if(DEBUG)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup true)
	elseif(RELEASE)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup true)
	endif()
	
	####################### Create Executable Target ###################
	add_executable(${APP_NAME} ${App_SRC})
	if(DEBUG)
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${LIBS})
	elseif(RELEASE)
		target_link_libraries(${APP_NAME} ${RELEASE_LIBS} ${LIBS})
	endif()

	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
		
	############# Create .desktop Icon Files and Install ##############
	if(DEBUG)
	# Create .desktop file for Debug
	DKSET(DESKTOP_FILE
		"[Desktop Entry]\n"
		"Encoding=UTF-8\n"
		"Version=1.0\n"
		"Type=Application\n"
		"Terminal=true\n"
		"Name=${APP_NAME}\n"
		"Exec=${DKPROJECT}/${OS}/Debug/${APP_NAME}\n"
		"Icon=${DKPROJECT}/icons/icon.png\n")
	file(WRITE ${DKPROJECT}/${OS}/Debug/${APP_NAME}.desktop ${DESKTOP_FILE})
	endif()
	if(RELEASE)
	# Create .desktop file for Release
	DKSET(DESKTOP_FILE
		"[Desktop Entry]\n"
		"Encoding=UTF-8\n"
		"Version=1.0\n"
		"Type=Application\n"
		"Terminal=true\n"
		"Name=${APP_NAME}\n"
		"Exec=${DKPROJECT}/${OS}/Release/${APP_NAME}\n"
		"Icon=${DKPROJECT}/icons/icon.png\n")
	file(WRITE ${DKPROJECT}/${OS}/Release/${APP_NAME}.desktop ${DESKTOP_FILE})
	endif()
	
	# Install shortcut of Release build to the apps menu
	if(RELEASE)
		DKEXECUTE_PROCESS(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DKPROJECT}/${OS}/Release/${APP_NAME}.desktop WORKING_DIRECTORY ${DKPROJECT}/${OS}/Release)
	endif()
		
	####################### Do Post Build Stuff #######################
	#CPP_DK_Execute("chmod +x "+app_path+OS+"/Debug/"+APP)
endif()

###########
if(ANDROID)
	########################## CREATE ICONS ###############################
	if(IMAGEMAGICK_CONVERT)
		DKINFO("Building icons for ${APP_NAME} . . .")
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-hdpi)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 72x72 ${DKPROJECT}/icons/android/drawable-hdpi/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-ldpi)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 36x36 ${DKPROJECT}/icons/android/drawable-ldpi/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-mdpi)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 48x48 ${DKPROJECT}/icons/android/drawable-mdpi/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-xhdpi)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 96x96 ${DKPROJECT}/icons/android/drawable-xhdpi/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-xxhdpi)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 144x144 ${DKPROJECT}/icons/android/drawable-xxhdpi/icon.png)
	endif()
	DKCOPY(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)
	DKCOPY(${DKPROJECT}/icons/icon.png ${DKPROJECT}/${OS}/res/drawable/icon.png TRUE)
		
	###################### Backup Executable ###########################
	if(DEBUG)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.apk ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup true)
	endif()
	if(RELEASE)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.apk ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup true)
	endif()
		
	####################### Create Executable Target ###################
	if(ANDROID_32)
		DKCOPY(${DKPLUGINS}/_DKIMPORT/android32/ ${DKPROJECT}/android32/ FALSE)
		#DKCOPY(${DKPLUGINS}/_DKIMPORT/android32/Android.h ${DKPROJECT}/Android.h FALSE)
	endif()
	if(ANDROID_64)
		DKCOPY(${DKPLUGINS}/_DKIMPORT/android64/ ${DKPROJECT}/android64/ FALSE)
		#DKCOPY(${DKPLUGINS}/_DKIMPORT/android64/Android.h ${DKPROJECT}/Android.h FALSE)
	endif()
	set(CMAKE_ANDROID_GUI 1)
	add_library(${APP_NAME} SHARED ${App_SRC})
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
	
	######################### Link Libraries ###########################
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	target_include_directories(${APP_NAME} PUBLIC ${SDL2}/include)
	
	include_external_msproject(gradleAPK gradleAPK.androidproj TYPE 39E2626F-3545-4960-A6E8-258AD8476CE5)
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT gradleAPK)
		
	####################### Do Post Build Stuff #######################
endif()

DKBUILD_LOG("\n\n")
DKBUILD_LOG("########### ${APP_NAME} Post-Generated Compiler Settings ###########")
DKBUILD_LOG("     COMPILE_DEFINITIONS:  ${COMPILE_DEFINITIONS}")
DKBUILD_LOG("           DEFINE_SYMBOL:  ${DEFINE_SYMBOL}")
DKBUILD_LOG("         COMPILE_OPTIONS:  ${COMPILE_OPTIONS}")
DKBUILD_LOG("     INCLUDE_DIRECTORIES:  ${INCLUDE_DIRECTORIES}")
DKBUILD_LOG("        LINK_DIRECTORIES:  ${LINK_DIRECTORIES}")
DKBUILD_LOG("  STATIC_LIBRARY_OPTIONS:  ${STATIC_LIBRARY_OPTIONS}")
DKBUILD_LOG("             DEBUG_FLAGS:  ${DEBUG_FLAGS}")
DKBUILD_LOG("           RELEASE_FLAGS:  ${RELEASE_FLAGS}")
DKBUILD_LOG("                   FLAGS:  ${FLAGS}")
DKBUILD_LOG("          DKDEFINES_LIST:  ${DKDEFINES_LIST}")
DKBUILD_LOG("         DKLINKDIRS_LIST:  ${DKLINKDIRS_LIST}")

DKBUILD_LOG("\n\n")
DKBUILD_LOG("###################  ${APP_NAME} Source Files  ##################")
foreach(src ${App_SRC})
	DKBUILD_LOG(${src})
endforeach()

DKBUILD_LOG("\n\n")
DKBUILD_LOG("###############  ${APP_NAME} Include Diretories  ##############")
foreach(dir ${DKINCLUDES_LIST})
	DKBUILD_LOG(${dir})
endforeach()

DKBUILD_LOG("\n\n")
DKBUILD_LOG("###############  ${APP_NAME} Include Libraries  ##############")
DKBUILD_LOG("### Common libraries ###")
foreach(lib ${LIBS})
	DKBUILD_LOG(${lib})
endforeach()
DKBUILD_LOG("\n")
DKBUILD_LOG(" ### Debug libraries ###")
foreach(lib ${DEBUG_LIBS})
	if(NOT "${lib}" STREQUAL "debug")
		DKBUILD_LOG(${lib})
	endif()
endforeach()
DKBUILD_LOG("\n")
DKBUILD_LOG(" ### Release libraries ###")
foreach(lib ${RELEASE_LIBS})
	if(NOT "${lib}" STREQUAL "optimized")
		DKBUILD_LOG(${lib})
	endif()
endforeach()


DKINFO("\n\n")
DKINFO("**************************************************")
DKINFO("****** Generated ${APP_NAME} - ${OS}  ************")
DKINFO("**************************************************\n")
