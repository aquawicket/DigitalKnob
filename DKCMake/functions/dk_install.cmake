#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_install(PLUGIN_IMPORT_NAME)
#
#	Install a 3rdParty library, executable or package
#	For archive files such as libraries and assets, the arguments are:  The download PLUGIN_URL, the name of its _DKIMPORTS folder, The name given to the installed 3rdParty/folder  
#	For executable files such as software amd IDE's the arguments are:  The download PLUGIN_URL, the name of the final name of the dl file, The installation path to check for installation.
#
#	@PLUGIN_URL			-The download url or local path to an install file. May be .zip, .exe, .msi, .tar.gz etc. 
#	@PLUGIN_DIR			-The path to the install location under DK/3rdParty
#	@plugin (optional)	-The name of the 3rdParty package being installed
#	PATCH				-Patch the install directory with files from the _DKIMPORTS path
#
function(dk_install PLUGIN_VAR_PREFIX) #PATCH
	dk_debugFunc()
	message("dk_install(${ARGV})")
	
	dk_getOption(NO_HALT  REMOVE)
	
	set(PLUGIN_IMPORT_NAME 	${${PLUGIN_VAR_PREFIX}_IMPORT_NAME})
	set(PLUGIN_URL 			${${PLUGIN_VAR_PREFIX}_URL})
	set(PLUGIN_DIR 			${${PLUGIN_VAR_PREFIX}_DIR})
	
	#if(NOT PLUGIN_IMPORT_NAME)
	#	dk_basename(${CMAKE_CURRENT_LIST_DIR} PLUGIN_IMPORT_NAME)
	#else()
	#	dk_basename(${PLUGIN_IMPORT_DIR} PLUGIN_IMPORT_NAME)
	#endif()
	
	#dk_toLower(${PLUGIN_IMPORT_NAME} plugin_lower)
	#if(NOT ${PLUGIN_IMPORT_NAME} STREQUAL ${plugin_lower})
	#	dk_fatal("ERROR:  dk_install() (${PLUGIN_IMPORT_NAME}) must be all lowercase")
	#endif()
	dk_assertPath($ENV{DKIMPORTS_DIR}/${PLUGIN_IMPORT_NAME})
	
	if(EXISTS ${PLUGIN_DIR}/installed)
		dk_info("${PLUGIN_IMPORT_NAME} already installed")
		if(ARGN MATCHES "PATCH")
			dk_patch(${PLUGIN_IMPORT_NAME} ${PLUGIN_DIR})
		endif()
		return()
	endif()
	#dk_echo(" ")
	#dk_printVar(PLUGIN_URL)
	dk_dirname(${PLUGIN_URL} PLUGIN_URL_DIR)
	dk_basename(${PLUGIN_URL} PLUGIN_URL_FILENAME)
	dk_getExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_EXTENSION)
	#dk_echo(" ")
	#dk_printVar(PLUGIN_DIR)
	dk_dirname(${PLUGIN_DIR} dest_directory)
	dk_basename(${PLUGIN_DIR} dest_filename)
	dk_getExtension(${dest_filename} dest_extension)
	#dk_echo(" ")
	
	### set the PLUGIN_DL_DIR
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	set(PLUGIN_DL_DIR "$ENV{DKDOWNLOAD_DIR}")
	
	### set the PLUGIN_DL_FILENAME ###
	# let's check that the PLUGIN_URL_FILENAME has at least the PLUGIN_IMPORT_NAME in it somewhere, or else we gotta rename it
	dk_toLower(${PLUGIN_URL_FILENAME} plugin_url_filename)
	if(NOT plugin_url_filename MATCHES "${PLUGIN_IMPORT_NAME}")
		dk_debug("The download filename:${PLUGIN_URL_FILENAME} does not contaian the import name:${PLUGIN_IMPORT_NAME}")
		dk_toLower(${dest_filename} dest_filename_lower)
		if(dest_filename_lower MATCHES "${PLUGIN_IMPORT_NAME}")
			set(PLUGIN_DL_FILENAME "${dest_filename}${PLUGIN_URL_EXTENSION}")
		else()
			set(PLUGIN_DL_FILENAME "${PLUGIN_IMPORT_NAME}-${dest_filename}${PLUGIN_URL_EXTENSION}") 
		endif()
	elseif(NOT ${PLUGIN_URL_FILENAME} MATCHES "[0-9]")
		dk_debug("The download filename ${PLUGIN_URL_FILENAME} does not contain any numbers to identify it's version")
		dk_debug("Normally we would rename the downloaded filename to ${dest_filename}${PLUGIN_URL_EXTENSION}, but we'll let it pass.")
# 		set(PLUGIN_DL_FILENAME "${dest_filename}${PLUGIN_URL_EXTENSION}")
		set(PLUGIN_DL_FILENAME ${PLUGIN_URL_FILENAME})
	else()
		set(PLUGIN_DL_FILENAME ${PLUGIN_URL_FILENAME})
	endif()
	
	dk_download("${PLUGIN_URL}" "${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME}" NO_HALT)
	dk_assertPath("${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME}") # "if the download file does not exist"
	
	set(FILETYPE "UNKNOWN")
	if(NOT ${PLUGIN_URL_EXTENSION} STREQUAL "")
		if(${PLUGIN_URL_EXTENSION} STREQUAL ".AppImage")
			set(FILETYPE "Executable")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".bat")
			set(FILETYPE "Executable")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".bz")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".bz2")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".cmd")
			set(FILETYPE "Executable")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".dmg")
			set(FILETYPE "BYPASS")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".exe")
			if(PLUGIN_URL_FILENAME MATCHES ".sfx.exe")
				set(FILETYPE "Archive")
			else()
				set(FILETYPE "Executable")
			endif()
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".gz")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".js")
			set(FILETYPE "Javascript")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".pkg")
			set(FILETYPE "Executable")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".rar")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".tar")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".tar.gz")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".tgz")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".xz")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_URL_EXTENSION} STREQUAL ".zip")
			set(FILETYPE "Archive")
		endif()
	endif()
	# If the file type is unknown, we'll still try to extract it like a compressed file anyway
	# It's better the have a chance at success.
	dk_debug("The Downloaded file ${${PLUGIN_DL_FILENAME}} is a ${FILETYPE} file ${PLUGIN_URL_EXTENSION}")
	if(${FILETYPE} STREQUAL "UNKNOWN")
		set(FILETYPE "Archive")
		dk_debug("We will try to extract it in case it's an archive, but it may fail.")
	endif()
	if(${FILETYPE} STREQUAL "Archive")
		#dk_todo("replace this section with dk _smartExtract() function")
		dk_info("Extracting ${PLUGIN_DL_FILENAME}")
		
#		if(ANDROID_HOST)
#			set(src_extractPath "$ENV{HOME}/dkdownload")
#		else()
#			set(src_extractPath "${PLUGIN_DL_DIR}/UNZIPPED")
#		endif()
		#dk_delete(${PLUGIN_DL_DIR}/UNZIPPED NO_HALT)
#		dk_delete(${src_extractPath} NO_HALT)
		
		#dk_extract(${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME} ${PLUGIN_DL_DIR}/UNZIPPED)
#		dk_extract(${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME} ${src_extractPath} ${NO_HALT})
#		dk_copy("${src_extractPath}" "${PLUGIN_DIR}")

#		# We either have a root folder in /UNZIPPED, or multiple files without a root folder
#		file(GLOB items RELATIVE "${src_extractPath}/" "${src_extractPath}/*")
#		list(LENGTH items count)
#		if(${count} GREATER 2) ##NOTE: This should be "${count} GREATER 1" but msys has a readme file in it next to the inner msys folder and that messes things up for more than 1
#			#vZip extracted with no root folder, Rename UNZIPPED and move to 3rdParty
#			dk_rename(${src_extractPath} ${PLUGIN_DIR} OVERWRITE)
#		else()
#			if(EXISTS ${src_extractPath}/${dest_filename}) ##Zip extracted to expected folder. Move the folder to 3rdParty
#				dk_rename(${src_extractPath}/${dest_filename} ${PLUGIN_DIR} OVERWRITE)
#				dk_delete(${src_extractPath})
#			else() #vZip extracted to a root folder, but not named what we expected. Rename and move folder to 3rdParty
#				foreach(item ${items})
#					if(NOT IS_DIRECTORY ${src_extractPath}/${item})
#						list(REMOVE_ITEM items ${item}) #remove any readme.txt or other non-directory items
#					endif()
#				endforeach()
#				dk_rename(${src_extractPath}/${items} ${PLUGIN_DIR} OVERWRITE)
#				dk_delete(${src_extractPath})
#			endif() 
#		endif()
		dk_smartExtract("${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME}" "${PLUGIN_DIR}")

	elseif(${FILETYPE} STREQUAL "Executable")
		dk_chdir(${PLUGIN_DL_DIR})
		dk_set(QUEUE_BUILD ON)
		dk_assertPath(${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME}) # "dk_install():167")
		
		if(${PLUGIN_URL_EXTENSION} STREQUAL ".pkg")
			if(MAC_HOST)
				dk_exec(chmod 777 ${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME})
				dk_depend(sudo)
				dk_exec(${SUDO_EXE} -s installer -pkg ${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME} -target /)
			endif()
		else()
			dk_exec(${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME})
		endif()
	elseif(${FILETYPE} STREQUAL "BYPASS")
		# (BYPASS) do nothing
	else() #NOT ARCHIVE, just copy the file into it's 3rdParty folder
		dk_assertPath(${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME}) # "dk_install():181")
		dk_copy(${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME} ${PLUGIN_DIR}/${PLUGIN_DL_FILENAME} OVERWRITE)
		dk_debug("dk_copy(${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME} ${PLUGIN_DIR}/${PLUGIN_DL_FILENAME} OVERWRITE)")
	endif()
	
	#string(FIND "${ARGN}" "PATCH" index)
	#if(${index} GREATER -1)
	if(ARGN MATCHES "PATCH")
		dk_patch(${PLUGIN_IMPORT_NAME} ${PLUGIN_DIR})
	else()
		file(GLOB ITEMS $ENV{DKIMPORTS_DIR}/${PLUGIN_IMPORT_NAME}/*)
		list(LENGTH ITEMS count)
		if(${count} GREATER 1)
			dk_notice(" Found ${count} items in the ${PLUGIN_IMPORT_NAME} import folder. dk_install has not requested to PATCH the installed files. If needed, add PATCH as the last argument to the dk_install or dk_import command in $ENV{DKIMPORTS_DIR}/${PLUGIN_IMPORT_NAME}/DKINSTALL.cmake ")
		endif()
	endif()
	
	dk_fileWrite(${PLUGIN_DIR}/installed "${dest_filename} ")
	
	if(DELETE_DOWNLOADS) # conserve disk space 
		dk_delete(${PLUGIN_DL_DIR}/${PLUGIN_DL_FILENAME})
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_install(todo)	#TODO
endfunction()