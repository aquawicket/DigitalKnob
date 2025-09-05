#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_install(PLUGIN)
#
#	Install a 3rdParty library, executable or package
#	For archive files such as libraries and assets, the arguments are:  The download PLUGIN_Url, the name of its _DKIMPORTS folder, The name given to the installed 3rdParty/folder  
#	For executable files such as software amd IDE's the arguments are:  The download PLUGIN_Url, the name of the final name of the dl file, The installation path to check for installation.
#
#	@PLUGIN_Url						-The download url or local path to an install file. May be .zip, .exe, .msi, .tar.gz etc. 
#	@PLUGIN_Install_Path			-The path to the install location under DK/3rdParty
#	@PLUGIN_Import_Name (optional)	-The name of the 3rdParty package being installed
#	PATCH							-Patch the install directory with files from the _DKIMPORTS path
#
function(dk_install PLUGIN) #PATCH
	dk_debugFunc()
	dk_getParameter(NO_HALT  REMOVE)
	
	set(PLUGIN_Import_Name 	${${PLUGIN}_Import_Name})
	set(PLUGIN_Url 			${${PLUGIN}_Url})
	set(PLUGIN	 			${PLUGIN})
	
	#if(NOT PLUGIN_Import_Name)
	#	dk_basename(${CMAKE_CURRENT_LIST_DIR} PLUGIN_Import_Name)
	#else()
	#	dk_basename(${PLUGIN_Import_Dirname} PLUGIN_Import_Name)
	#endif()
	
	#dk_toLower(${PLUGIN_Import_Name} PLUGIN_Import_Name_lower)
	#if(NOT ${PLUGIN_Import_Name} STREQUAL ${PLUGIN_Import_Name_lower})
	#	dk_fatal("ERROR:  dk_install() (${PLUGIN_Import_Name}) must be all lowercase")
	#endif()
	dk_assertPath("$ENV{DKIMPORTS_DIR}/${PLUGIN_Import_Name}")
	
	if(EXISTS "${PLUGIN_Install_Path}/installed")
		dk_info("${PLUGIN_Import_Name} already installed")
		if(ARGN MATCHES "PATCH")
			dk_patch(${PLUGIN_Import_Name} ${PLUGIN_Install_Path})
		endif()
		return()
	endif()
	#dk_echo(" ")
	#dk_printVar(PLUGIN_Url)
	dk_dirname(${PLUGIN_Url} PLUGIN_Url_Dirname)
	dk_basename(${PLUGIN_Url} PLUGIN_Url_Basename)
	dk_getExtension(${PLUGIN_Url_Basename} PLUGIN_Url_Extension)
	#dk_echo(" ")
	#dk_printVar(PLUGIN_Install_Path)
	dk_dirname(${PLUGIN_Install_Path} dest_directory)
	dk_basename(${PLUGIN_Install_Path} dest_filename)
	dk_getExtension(${dest_filename} dest_extension)
	#dk_echo(" ")
	
	### set the PLUGIN_DL_Dirname
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	set(PLUGIN_DL_Dirname "$ENV{DKDOWNLOAD_DIR}")
	
	### set the PLUGIN_Import_Basename ###
	# let's check that the PLUGIN_Url_Basename has at least the PLUGIN_Import_Name in it somewhere, or else we gotta rename it
	dk_toLower(${PLUGIN_Url_Basename} PLUGIN_Url_basename)
	if(NOT PLUGIN_Url_basename MATCHES "${PLUGIN_Import_Name}")
		dk_debug("The download filename:${PLUGIN_Url_Basename} does not contaian the import name:${PLUGIN_Import_Name}")
		dk_toLower(${dest_filename} dest_filename_lower)
		if(dest_filename_lower MATCHES "${PLUGIN_Import_Name}")
			set(PLUGIN_Import_Basename "${dest_filename}${PLUGIN_Url_Extension}")
		else()
			set(PLUGIN_Import_Basename "${PLUGIN_Import_Name}-${dest_filename}${PLUGIN_Url_Extension}") 
		endif()
	elseif(NOT ${PLUGIN_Url_Basename} MATCHES "[0-9]")
		dk_debug("The download filename ${PLUGIN_Url_Basename} does not contain any numbers to identify it's version")
		dk_debug("Normally we would rename the downloaded filename to ${dest_filename}${PLUGIN_Url_Extension}, but we'll let it pass.")
# 		set(PLUGIN_Import_Basename "${dest_filename}${PLUGIN_Url_Extension}")
		set(PLUGIN_Import_Basename ${PLUGIN_Url_Basename})
	else()
		set(PLUGIN_Import_Basename ${PLUGIN_Url_Basename})
	endif()
	
	#dk_download("${PLUGIN_Url}")# "${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename}" NO_HALT)
	dk_download("${PLUGIN_Url}" NO_HALT)
	#dk_assertPath("${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename}") # "if the download file does not exist"
	dk_assertPath("${dk_download}") # "if the download file does not exist"
	
	set(FILETYPE "UNKNOWN")
	if(NOT ${PLUGIN_Url_Extension} STREQUAL "")
		if(${PLUGIN_Url_Extension} STREQUAL ".AppImage")
			set(FILETYPE "Executable")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".bat")
			set(FILETYPE "Executable")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".bz")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".bz2")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".cmd")
			set(FILETYPE "Executable")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".dmg")
			set(FILETYPE "BYPASS")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".exe")
			if(PLUGIN_Url_Basename MATCHES ".sfx.exe")
				set(FILETYPE "Archive")
			else()
				set(FILETYPE "Executable")
			endif()
		elseif(${PLUGIN_Url_Extension} STREQUAL ".gz")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".js")
			set(FILETYPE "Javascript")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".pkg")
			set(FILETYPE "Executable")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".rar")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".tar")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".tar.gz")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".tgz")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".xz")
			set(FILETYPE "Archive")
		elseif(${PLUGIN_Url_Extension} STREQUAL ".zip")
			set(FILETYPE "Archive")
		endif()
	endif()
	# If the file type is unknown, we'll still try to extract it like a compressed file anyway
	# It's better the have a chance at success.
	dk_debug("The Downloaded file ${${PLUGIN_Import_Basename}} is a ${FILETYPE} file ${PLUGIN_Url_Extension}")
	if(${FILETYPE} STREQUAL "UNKNOWN")
		set(FILETYPE "Archive")
		dk_debug("We will try to extract it in case it's an archive, but it may fail.")
	endif()
	if(${FILETYPE} STREQUAL "Archive")
		#dk_todo("replace this section with dk _smartExtract() function")
		dk_info("Extracting ${PLUGIN_Import_Basename}")
		
#		if(Android_Host)
#			set(src_extractPath "$ENV{HOME}/dkdownload")
#		else()
#			set(src_extractPath "${PLUGIN_DL_Dirname}/UNZIPPED")
#		endif()
		#dk_delete(${PLUGIN_DL_Dirname}/UNZIPPED NO_HALT)
#		dk_delete(${src_extractPath} NO_HALT)
		
		#dk_extract(${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename} ${PLUGIN_DL_Dirname}/UNZIPPED)
#		dk_extract(${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename} ${src_extractPath} ${NO_HALT})
#		dk_copy("${src_extractPath}" "${PLUGIN_Install_Path}")

#		# We either have a root folder in /UNZIPPED, or multiple files without a root folder
#		file(GLOB items RELATIVE "${src_extractPath}/" "${src_extractPath}/*")
#		list(LENGTH items count)
#		if(${count} GREATER 2) ##NOTE: This should be "${count} GREATER 1" but msys has a readme file in it next to the inner msys folder and that messes things up for more than 1
#			#vZip extracted with no root folder, Rename UNZIPPED and move to 3rdParty
#			dk_rename(${src_extractPath} ${PLUGIN_Install_Path} OVERWRITE)
#		else()
#			if(EXISTS ${src_extractPath}/${dest_filename}) ##Zip extracted to expected folder. Move the folder to 3rdParty
#				dk_rename(${src_extractPath}/${dest_filename} ${PLUGIN_Install_Path} OVERWRITE)
#				dk_delete(${src_extractPath})
#			else() #vZip extracted to a root folder, but not named what we expected. Rename and move folder to 3rdParty
#				foreach(item ${items})
#					if(NOT IS_DIRECTORY ${src_extractPath}/${item})
#						list(REMOVE_ITEM items ${item}) #remove any readme.txt or other non-directory items
#					endif()
#				endforeach()
#				dk_rename(${src_extractPath}/${items} ${PLUGIN_Install_Path} OVERWRITE)
#				dk_delete(${src_extractPath})
#			endif() 
#		endif()
		dk_smartExtract("${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename}" "${PLUGIN_Install_Path}")

	elseif(${FILETYPE} STREQUAL "Executable")
		dk_chdir(${PLUGIN_DL_Dirname})
		dk_assertPath(${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename}) # "dk_install():167")
		
		if(${PLUGIN_Url_Extension} STREQUAL ".pkg")
			if(Mac_Host)
				dk_exec(chmod 777 ${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename})
				dk_depend(sudo)
				dk_exec(${sudo_exe} -s installer -pkg ${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename} -target /)
			endif()
		else()
			dk_exec(${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename})
		endif()
	elseif(${FILETYPE} STREQUAL "BYPASS")
		# (BYPASS) do nothing
	else() #NOT ARCHIVE, just copy the file into it's 3rdParty folder
		dk_assertPath(${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename}) # "dk_install():181")
		dk_copy(${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename} ${PLUGIN_Install_Path}/${PLUGIN_Import_Basename} OVERWRITE)
		dk_debug("dk_copy(${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename} ${PLUGIN_Install_Path}/${PLUGIN_Import_Basename} OVERWRITE)")
	endif()
	
	#string(FIND "${ARGN}" "PATCH" index)
	#if(${index} GREATER -1)
	if(ARGN MATCHES "PATCH")
		dk_patch(${PLUGIN_Import_Name} ${PLUGIN_Install_Path})
	else()
		file(GLOB ITEMS $ENV{DKIMPORTS_DIR}/${PLUGIN_Import_Name}/*)
		list(LENGTH ITEMS count)
		if(${count} GREATER 1)
			dk_notice(" Found ${count} items in the ${PLUGIN_Import_Name} import folder. dk_install has not requested to PATCH the installed files. If needed, add PATCH as the last argument to the dk_install or dk_import command in $ENV{DKIMPORTS_DIR}/${PLUGIN_Import_Name}/DKINSTALL.cmake ")
		endif()
	endif()
	
	dk_fileWrite(${PLUGIN_Install_Path}/installed "${dest_filename} ")
	
	if(DELETE_DOWNLOADS) # conserve disk space 
		dk_delete(${PLUGIN_DL_Dirname}/${PLUGIN_Import_Basename})
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_install(todo)	#TODO
endfunction()