include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_install(plugin)
#
#	Install a 3rdParty library, executable or package
#	For archive files such as libraries and assets, the arguments are:  The download url_path, the name of its _DKIMPORTS folder, The name given to the installed 3rdParty/folder  
#	For executable files such as software amd IDE's the arguments are:  The download url_path, the name of the final name of the dl file, The installation path to check for installation.
#
#	@url_path			-The download url or local path to an install file. May be .zip, .exe, .msi, .tar.gz etc. 
#	@dest_path			-The path to the install location under DK/3rdParty
#	@plugin (optional)	-The name of the 3rdParty package being installed
#	PATCH				-Patch the install directory with files from the _DKIMPORTS path
#
function(dk_install plugin) #PATCH
	dk_debugFunc("\${ARGV}")
	
	#dk_debug("dk_install(${plugin})")
	
	# set PLUGIN_URL variable
	dk_convertToCIdentifier(${plugin} plugin_alpha_numeric)
	dk_toUpper(${plugin_alpha_numeric} plugin_var)	
	set(dest_path ${${plugin_var}_DIR})
	dk_printVar(dest_path)
	set(url_path ${${plugin_var}_URL})
	
	#if(NOT "${ARGV2}" STREQUAL "PATCH")
	#	set(plugin ${ARGV2})
	#endif()
	
	#if(NOT plugin)
	#	dk_basename(${CMAKE_CURRENT_LIST_DIR} plugin)
	#else()
	#	dk_basename(${plugin} plugin)
	#endif()
	
	#dk_toLower(${plugin} plugin_lower)
	#if(NOT ${plugin} STREQUAL ${plugin_lower})
	#	dk_fatal("ERROR:  dk_install() (${plugin}) must be all lowercase")
	#endif()
	dk_assertPath(${DKIMPORTS_DIR}/${plugin})
	
	if(EXISTS ${dest_path}/installed)
		dk_info("${plugin} already installed")
		dk_includes("${ARGN}" "PATCH" hasPATCH)
		if(${hasPATCH})
			dk_patch(${plugin} ${dest_path})
		endif()
		return()
	endif()
	dk_debug(" ")
	dk_printVar(url_path)
	dk_getDirectory(${url_path} url_directory)
	#dk_printVar(url_directory)
	dk_basename(${url_path} url_filename)
	#dk_printVar(url_filename)
	dk_getExtension(${url_filename} url_extension)
	#dk_printVar(url_extension)
	dk_debug(" ")
	dk_printVar(dest_path)
	dk_getDirectory(${dest_path} dest_directory)
	#dk_printVar(dest_directory)
	dk_basename(${dest_path} dest_filename)
	#dk_printVar(dest_filename)
	dk_getExtension(${dest_filename} dest_extension)
	#dk_printVar(dest_extension)
	dk_debug(" ")
	
	# let's check that the scr_filename has at least the name of the target in it somewhere, or else we gotta rename it
	dk_toLower(${url_filename} url_filename_lower)
	string(FIND ${url_filename_lower} ${plugin} index)
	if(${index} EQUAL -1)
	#dk_includes(${url_filename_lower} ${plugin} result)
	#if(NOT ${result})
		dk_debug("The download filename ${url_filename} does not contaian the import name ${plugin}")
		dk_toLower(${dest_filename} dest_filename_lower)
		string(FIND ${dest_filename_lower} ${plugin} index)
		if(${index} EQUAL -1)
		#dk_includes(${dest_filename_lower} ${plugin} result)
		#if(NOT ${result})
			set(dl_filename "${plugin}-${dest_filename}${url_extension}") 
		else()
			set(dl_filename "${dest_filename}${url_extension}")
		endif()
	elseif(NOT ${url_filename} MATCHES "[0-9]")
		dk_debug("The download filename ${url_filename} does not contain any numbers to identify it's version")
		dk_debug("Normally we would rename the downloaded filename to ${dest_filename}${url_extension}, but we'll let it pass.")
# 		set(dl_filename "${dest_filename}${url_extension}")
		set(dl_filename ${url_filename})
	else()
		set(dl_filename ${url_filename})
	endif()
	
	dk_download(${url_path} ${DKDOWNLOAD_DIR}/${dl_filename} NO_HALT)
	# TODO: option to delete downloaded file after extraction to conserve disk space
	
	#if(NOT EXISTS ${DKDOWNLOAD_DIR}/${dl_filename})
	#	dk_fatal("The download files does not exist")
	#endif()
	dk_assertPath(${DKDOWNLOAD_DIR}/${dl_filename})
	
	set(FILETYPE "UNKNOWN")
	if(NOT ${url_extension} STREQUAL "")
		if(${url_extension} STREQUAL ".AppImage")
			set(FILETYPE "Executable")
		elseif(${url_extension} STREQUAL ".bz")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".bz2")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".dmg")
			set(FILETYPE "BYPASS")
		elseif(${url_extension} STREQUAL ".exe")
			dk_includes(${url_filename} ".sfx.exe" result)
			if(${result})
				set(FILETYPE "Archive")
			else()
				set(FILETYPE "Executable")
			endif()
		elseif(${url_extension} STREQUAL ".gz")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".js")
			set(FILETYPE "Javascript")
		elseif(${url_extension} STREQUAL ".pkg")
			set(FILETYPE "Executable")
		elseif(${url_extension} STREQUAL ".rar")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".tar")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".tar.gz")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".tgz")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".xz")
			set(FILETYPE "Archive")
		elseif(${url_extension} STREQUAL ".zip")
			set(FILETYPE "Archive")
		endif()
	endif()
	# If the file type is unknown, we'll still try to extract it like a compressed file anyway
	# It's better the have a chance at success.
	dk_debug("The Downloaded file ${${dl_filename}} is a ${FILETYPE} file ${url_extension}")
	if(${FILETYPE} STREQUAL "UNKNOWN")
		set(FILETYPE "Archive")
		dk_debug("We will try to extract it in case it's an archive, but it may fail.")
	endif()
	if(${FILETYPE} STREQUAL "Archive")
		dk_info("Extracting ${dl_filename}")
		dk_delete(${DKDOWNLOAD_DIR}/UNZIPPED NO_HALT)
		dk_extract(${DKDOWNLOAD_DIR}/${dl_filename} ${DKDOWNLOAD_DIR}/UNZIPPED)
		# We either have a root folder in /UNZIPPED, or multiple files without a root folder
		file(GLOB items RELATIVE "${DKDOWNLOAD_DIR}/UNZIPPED/" "${DKDOWNLOAD_DIR}/UNZIPPED/*")
		list(LENGTH items count)
		if(${count} GREATER 2) ##NOTE: This should be "${count} GREATER 1" but msys has a readme file in it next to the inner msys folder and that messes things up for more than 1
			#vZip extracted with no root folder, Rename UNZIPPED and move to 3rdParty
			dk_rename(${DKDOWNLOAD_DIR}/UNZIPPED ${dest_path} OVERWRITE)
		else()
			if(EXISTS ${DKDOWNLOAD_DIR}/UNZIPPED/${dest_filename}) ##Zip extracted to expected folder. Move the folder to 3rdParty
				dk_rename(${DKDOWNLOAD_DIR}/UNZIPPED/${dest_filename} ${dest_path} OVERWRITE)
				dk_delete(${DKDOWNLOAD_DIR}/UNZIPPED)
			else() #vZip extracted to a root folder, but not named what we expected. Rename and move folder to 3rdParty
				foreach(item ${items})
					if(NOT IS_DIRECTORY ${DKDOWNLOAD_DIR}/UNZIPPED/${item})
						list(REMOVE_ITEM items ${item}) #remove any readme.txt or other non-directory items
					endif()
				endforeach()
				#dk_printVar(dest_path)
				#dk_wait()
				dk_rename(${DKDOWNLOAD_DIR}/UNZIPPED/${items} ${dest_path} OVERWRITE)
				dk_delete(${DKDOWNLOAD_DIR}/UNZIPPED)
			endif() 
		endif()
	elseif(${FILETYPE} STREQUAL "Executable")
		dk_cd(${DKDOWNLOAD_DIR})
		dk_set(QUEUE_BUILD ON)
		dk_assertPath(${DKDOWNLOAD_DIR}/${dl_filename})
		
		if(${url_extension} STREQUAL ".pkg")
			if(MAC_HOST)
				dk_validate(SUDO "dk_depend(sudo)")
				dk_executeProcess(chmod 777 ${DKDOWNLOAD_DIR}/${dl_filename})
				dk_executeProcess(${SUDO} -s installer -pkg ${DKDOWNLOAD_DIR}/${dl_filename} -target /)
			endif()
		else()
			dk_executeProcess(${DKDOWNLOAD_DIR}/${dl_filename})
		endif()
	elseif(${FILETYPE} STREQUAL "BYPASS")
		# (BYPASS) do nothing
	else() #NOT ARCHIVE, just copy the file into it's 3rdParty folder
		dk_assertPath(${DKDOWNLOAD_DIR}/${dl_filename})
		dk_copy(${DKDOWNLOAD_DIR}/${dl_filename} ${dest_path}/${dl_filename} OVERWRITE)
		dk_debug("dk_copy(${DKDOWNLOAD_DIR}/${dl_filename} ${dest_path}/${dl_filename} OVERWRITE)")
	endif()
	
	string(FIND "${ARGN}" "PATCH" index)
	if(${index} GREATER -1)
	#if("PATCH" IN_LIST ARGN)
		dk_patch(${plugin} ${dest_path})
	else()
		file(GLOB ITEMS ${DKIMPORTS_DIR}/${plugin}/*)
		list(LENGTH ITEMS count)
		if(${count} GREATER 1)
			dk_notice(" Found ${count} items in the ${plugin} import folder. dk_install has not requested to PATCH the installed files. If needed, add PATCH as the last argument to the dk_install or dk_import command in ${DKIMPORTS_DIR}/${plugin}/DKMAKE.cmake ")
		endif()
	endif()
	
	dk_fileWrite(${dest_path}/installed "${dest_filename} ")
	
	if(DELETE_DOWNLOADS) # conserve disk space 
		dk_info("deleting ${DKDOWNLOAD_DIR}/${dl_filename}. . .")
		dk_delete(${DKDOWNLOAD_DIR}/${dl_filename})
	endif()
endfunction()
dk_createOsMacros("dk_install" "NO_DEBUG_RELEASE_TAGS")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()