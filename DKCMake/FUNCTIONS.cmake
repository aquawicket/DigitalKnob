## TODO:    https://foonathan.net/2016/03/cmake-install/ 

#####################################################################
###################         DKFUNCTIONS           ###################
#####################################################################

if(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
	set(CMAKE_HOST_LINUX TRUE)
endif()


function(WaitForEnter)
	if(CMAKE_HOST_WIN32)	
		message("Press ENTER to continue . . .")
		execute_process(COMMAND cmd /c set /p DUMMY=. WORKING_DIRECTORY C:/)
		return()
	endif()
		message("WaitForEnter() Not implemented for this platform")
endfunction()


set(dkdepend_disable_list "" CACHE INTERNAL "")
set(UPX ON)


## Example creating CMake functions that return values
##
##		VAR_EXISTS("myVarName", result)
##		if(NOT result)
##			message(WARN "The variable does not exist")
##			return()
##		endif()
##		message("The name of the variable is ${result}")
##
function(VAR_EXISTS varname result)
    if(NOT DEFINED ${varname})
      message(SEND_ERROR "Error: the variable ${varname} is not defined!")
	  return()
    endif()
    set (${result} ${varname} PARENT_SCOPE)
endfunction()

function(DUMP variable)
	message("variable = ${variable}")
	WaitForEnter()
endfunction()

function(DKSET variable value)
	set(extra_args ${ARGN})
	list(LENGTH extra_args num_extra_args)
	if(${num_extra_args} GREATER 0)
		list(GET extra_args 0 arg3)
		set(${variable} ${value} ${extra_args} CACHE INTERNAL "")
	else()
		set(${variable} ${value} CACHE INTERNAL "")
	endif()
endfunction()


function(DKUNSET variable)
	unset(${variable})  #TODO
	#Unset a variable, cache variable, or environment variable.
	#Removes the specified variable causing it to become undefined. If CACHE is present then the variable is removed from the cache instead of the current scope.
	#If PARENT_SCOPE is present then the variable is removed from the scope above the current scope. See the same option in the set() command for further details.
endfunction()


function(DKDOWNLOAD url)
	##https://cmake.org/pipermail/cmake/2012-September/052205.html/
	if(${ARGC} EQUAL 1)
		get_filename_component(filename ${url} NAME)
	endif()
	if(${ARGC} EQUAL 2)
		set(filename ${ARGV1})
	endif()
	if(NOT EXISTS ${CURRENT_DIR}/${filename})
		message(STATUS "downloading... ${url}")
		file(DOWNLOAD ${url} ${CURRENT_DIR}/${filename} SHOW_PROGRESS 
			#no TIMEOUT
			STATUS status 
			#no LOG
		)
		
		list(GET status 0 status_code) 
		list(GET status 1 status_string)
		
		if(NOT status_code EQUAL 0)
			DKREMOVE(${CURRENT_DIR}/${filename})
			message(" ")
			message("*********************************************")
			message("CMAKE SOMETIMES FAILS TO DOWNLOAD LARGE FILES")
			message("PLEASE DOWNLOAD THE FILE TO THE digitalknob/Download direcotry")
			message("THE URL IS: ${url}") 
			message("*********************************************")
			message(" ")
			## TODO - copy the url to the clipboard and notify the user
			message(FATAL_ERROR "error: downloading ${filename} status_code: ${status_code} status_string: ${status_string}")
			
			##Download with DKCurl
			##message("Attempting to download with DKCurl...")
			##DKSET(QUEUE_BUILD ON)
			##WIN_COMMAND("${DIGITALKNOB}/DKCMake/DKCurl.exe ${url} ${CURRENT_DIR}/${filename}")
		else()
			message(STATUS "downloading... done")
		endif() 
	endif()
endfunction()


function(DKEXTRACT src dest)
	if(NOT EXISTS ${dest})
		file(MAKE_DIRECTORY ${dest})
	endif()
	execute_process(COMMAND ${CMAKE_COMMAND} -E tar xvf ${src} WORKING_DIRECTORY ${dest})
endfunction()


function(DKZIP path)
	message("Zipping: ${path}")
	execute_process(COMMAND ${CMAKE_COMMAND} -E tar "cfv" "${DKPROJECT}/assets.zip" --format=zip "." WORKING_DIRECTORY ${path}/)
endfunction()


function(DKCOPY from to overwrite)
	if(EXISTS ${from})
		if(IS_DIRECTORY ${from})
			file(GLOB_RECURSE allfiles RELATIVE "${from}/" "${from}/*")
			foreach(each_file ${allfiles})
				if(${each_file} STREQUAL "DKMAKE.cmake")
					continue()
				endif()
				set(sourcefile "${from}/${each_file}")
				set(destinationfile "${to}/${each_file}")
				if(overwrite)
					execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files ${sourcefile} ${destinationfile} RESULT_VARIABLE compare_result)
					if(compare_result EQUAL 1)
						execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${sourcefile} ${destinationfile})
						message("COPIED: ${sourcefile} to ${destinationfile}")
					elseif(compare_result EQUAL 0)
						#message("${sourcefile} No Copy, The files are identical.")
					else()
						message("Error while comparing the files.")
					endif()
				elseif(NOT EXISTS ${destinationfile})
					execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${sourcefile} ${destinationfile})
					message("COPIED: ${sourcefile} to ${destinationfile}")
				endif()
			endforeach()
		else()
			if(overwrite)
				execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${from} ${to})
				message("COPIED: ${from} to ${to}")
			elseif(NOT EXISTS ${to})
				execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${from} ${to})
				message("COPIED: ${from} to ${to}")
			endif()
		endif()
	endif()
endfunction()


function(DKCOMPAREFILES fileA fileB)
	execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files ${fileA} ${fileB} RESULT_VARIABLE compare_result)
	if(compare_result EQUAL 0)
		message("The files are identical.")
	elseif(compare_result EQUAL 1)
		message("The files are different.")
	else()
		message("Error while comparing the files.")
	endif()
endfunction()


function(DKRENAME from to)
	message("Renameing ${from} to ${to}")
	if(EXISTS ${from})
		if(EXISTS ${to})
			return()
		endif()
		file(RENAME ${from} ${to})
	endif()
endfunction()


function(DKREMOVE path)
	if(EXISTS ${path})
		if(IS_DIRECTORY ${path})
			execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${path})
		else()
			execute_process(COMMAND ${CMAKE_COMMAND} -E remove ${path})
		endif()
	endif()
endfunction()


function(UPX_COMPRESS path)
	if(UPX AND CMAKE_HOST_WIN32)
		message("UPX compressing ${path}...")
		message("Please wait...")
		execute_process(COMMAND cmd /c "${3RDPARTY}/upx392w/upx.exe -9 -v ${path}")
	endif()
endfunction()


function(DKENABLE plugin)
	DKSET(${plugin} ON)
	DKDEFINE(USE_${plugin})
endfunction()


function(DKDISABLE plugin)
	DKUNSET(${plugin})
	DKUNDEFINE(USE_${plugin})
endfunction()


function(DKDEFINE str)
	list(FIND DKDEFINES_LIST "${str}" index)
	if(${index} GREATER -1)
		return() ## already in the list, return.
	endif()
	DKSET(DKDEFINES_LIST ${DKDEFINES_LIST} ${str})
	add_definitions(-D${str})
endfunction()


function(DKUNDEFINE str)
	list(REMOVE_ITEM DKDEFINES_LIST ${str})
	remove_definitions(-D${str})
endfunction()


function(DKINCLUDE path)
	list(FIND DKINCLUDES_LIST "${path}" index)
	if(${index} GREATER -1)
		return() ## If the include is already in the list, return.
	endif()
	DKSET(DKINCLUDES_LIST ${DKINCLUDES_LIST} ${path})
	include_directories(${path})
endfunction()


function(DKLINKDIR path)
	list(FIND DKLINKDIRS_LIST "${path}" index)
	if(${index} GREATER -1)
		return() ## If the include is already in the list, return.
	endif()
	DKSET(DKLINKDIRS_LIST ${DKLINKDIRS_LIST} ${path})
	link_directories(${path})
endfunction()


function(dk_getExtension path result)
	##message("dk_getExtension(${path})")
	string(FIND ${path} "." index REVERSE)
	string(SUBSTRING ${path} ${index} -1 ext) 
    set(${result} ${ext} PARENT_SCOPE)
endfunction()


function(dk_dirIsEmpty path result)
	if(EXISTS ${path})
		file(GLOB items RELATIVE "${path}/" "${path}/*")
		list(LENGTH items count)
		if(${count} GREATER 0)
			set(${result} false PARENT_SCOPE)
			return()
		endif()
	endif()
	set(${result} true PARENT_SCOPE)
endfunction()


function(DKREFRESH_ICONS)
	DKEXECUTE_PROCESS(COMMAND ie4uinit.exe -ClearIconCache)
	##ie4uinit.exe -show   ##Windows 10
endfunction()


function(DKINSTALL url import_folder 3rdparty_folder)
	if(EXISTS ${3RDPARTY}/${3rdparty_folder}/installed)
		return()
	endif()

	DKSET(CURRENT_DIR ${DIGITALKNOB}/Download)
	file(MAKE_DIRECTORY ${CURRENT_DIR})
	DKDOWNLOAD(${url})
		
	##get_filename_component(extension ${url} EXT)       #linux32 latest cmake version is 3.10
	##get_filename_component(extension ${url} LAST_EXT)  #LAST_EXT only available with cmake 3.14+ 
	##cmake_path(GET url EXTENSION LAST_ONLY extension)  #LAST_ONLY only available with cmake 3.19+
	dk_getExtension(${url} extension)	
	
	DKSET(FILETYPE "UNKNOWN")
	if(NOT ${extension} STREQUAL "")
		if(${extension} STREQUAL ".bz")
			DKSET(FILETYPE "Archive")
		endif()
		if(${extension} STREQUAL ".bz2")
			DKSET(FILETYPE "Archive")
		endif()
		if(${extension} STREQUAL ".exe")
			DKSET(FILETYPE "Executable")
		endif()
		if(${extension} STREQUAL ".gz")
			DKSET(FILETYPE "Archive")
		endif()
		if(${extension} STREQUAL ".js")
			DKSET(FILETYPE "Javascript")
		endif()
		if(${extension} STREQUAL ".rar")
			DKSET(FILETYPE "Archive")
		endif()
		if(${extension} STREQUAL ".tar")
			DKSET(FILETYPE "Archive")
		endif()
		if(${extension} STREQUAL ".xz")
			DKSET(FILETYPE "Archive")
		endif()
		if(${extension} STREQUAL ".zip")
			DKSET(FILETYPE "Archive")
		endif()
	endif()
	get_filename_component(filename ${url} NAME)
	##If the file type is unknown, we'll still try to extract it like a compressed file anyway
	##It's better the have a chance at success.
	message("The Downloaded file (${filename}) is a ${FILETYPE} file ${extension}")
	
	if(${FILETYPE} STREQUAL "UNKNOWN")
		DKSET(FILETYPE "Archive")
		message("We will try to extract it in case it's an archive, but it may fail.")
	endif()
		
	if(${FILETYPE} STREQUAL "Archive")
		DKEXTRACT(${DIGITALKNOB}/Download/${filename} ${3RDPARTY}/UNZIPPED)
		#We either have a root folder in /UNZIPPED, or multiple files without a root folder
		file(GLOB items RELATIVE "${3RDPARTY}/UNZIPPED/" "${3RDPARTY}/UNZIPPED/*")
		list(LENGTH items count)
		if(${count} GREATER 1)
			#Zip extracted with no root folder, Rename UNZIPPED and move to 3rdParty
			file(RENAME ${3RDPARTY}/UNZIPPED ${3RDPARTY}/${3rdparty_folder})
		else()
			if(EXISTS ${3RDPARTY}/UNZIPPED/${3rdparty_folder}) ##Zip extracted to expected folder. Move the folder to 3rdParty
				file(RENAME ${3RDPARTY}/UNZIPPED/${3rdparty_folder} ${3RDPARTY}/${3rdparty_folder})
				DKREMOVE(${3RDPARTY}/UNZIPPED)
			else() #Zip extracted to a root folder, but not named what we expected. Rename and move folder to 3rdParty
				file(RENAME ${3RDPARTY}/UNZIPPED/${items} ${3RDPARTY}/${3rdparty_folder})
				DKREMOVE(${3RDPARTY}/UNZIPPED)
			endif() 
		endif()
	else() #NOT ARCHIVE, just copy the file into it's 3rdParty folder
		DKCOPY(${DIGITALKNOB}/Download/${filename} ${3RDPARTY}/${3rdparty_folder}/${filename} TRUE)
	endif()

	DKCOPY(${DKIMPORTS}/${import_folder}/ ${3RDPARTY}/${3rdparty_folder}/ TRUE)
	file(WRITE ${3RDPARTY}/${3rdparty_folder}/installed "${3rdparty_folder}")
endfunction()


function(DKWINSHORTPATH path)
	get_filename_component(shortpath ${path} ABSOLUTE)  #Get the windows short filepath
	message("SHORTPATH = ${shortpath}")
endfunction()


function(DKEXECUTE_PROCESS fullcmnd)
	math(EXPR _index "${ARGC}-1")
	list(GET ARGV ${_index} CDIR)
	message("")
	message("*** Commands ***")
	message(">  cd ${CDIR}")
	set(cmnd ${fullcmnd} ${ARGN})
	string(REPLACE "COMMAND" "" var2 "${cmnd}")
	string(REPLACE "command" "" var3 "${var2}")
	string(REPLACE "WORKING_DIRECTORY" " " var4 "${var3}")
	string(REPLACE "working_directory" " " var5 "${var4}")
	string(REPLACE "${CDIR}" " " var6 "${var5}")
	string(REPLACE ";" " " cmndstr "${var6}")
	message("> ${cmndstr}")
	message("")
	execute_process(${cmnd})
endfunction()


###############################################################
#############   Platform specific functions  ##################
###############################################################

###################### DK_PATH ####################
function(DKSETPATH path)
	if(path STREQUAL "OFF")
		return() 
	endif()	
	DKSET(CURRENT_DIR ${path})
	if(NOT EXISTS ${CURRENT_DIR})
		file(MAKE_DIRECTORY ${CURRENT_DIR})
	endif()
endfunction()

#######################
function(WIN_PATH path)
	if(WIN)
		DKSETPATH(${path})
	endif()
endfunction()

function(WIN_DEBUG_PATH path)
	if(WIN AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(WIN_RELEASE_PATH path)
	if(WIN AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(WIN32_PATH path)
	if(WIN_32)
		DKSETPATH(${path})
	endif()
endfunction()

function(WIN32_DEBUG_PATH path)
	if(WIN_32 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(WIN32_RELEASE_PATH path)
	if(WIN_32 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(WIN64_PATH path)
	if(WIN_64)
		DKSETPATH(${path})
	endif()
endfunction()

function(WIN64_DEBUG_PATH path)
	if(WIN_64 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(WIN64_RELEASE_PATH path)
	if(WIN_64 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(MAC_PATH path)
	if(MAC)
		DKSETPATH(${path})
	endif()
endfunction()

function(MAC_DEBUG_PATH path)
	if(MAC AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(MAC_RELEASE_PATH path)
	if(MAC AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(MAC32_PATH path)
	if(MAC_32)
		DKSETPATH(${path})
	endif()
endfunction()

function(MAC32_DEBUG_PATH path)
	if(MAC_32 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(MAC32_RELEASE_PATH path)
	if(MAC_32 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(MAC64_PATH path)
	if(MAC_64)
		DKSETPATH(${path})
	endif()
endfunction()

function(MAC64_DEBUG_PATH path)
	if(MAC_64 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(MAC64_RELEASE_PATH path)
	if(MAC_64 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOS_PATH path)
	if(IOS)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOS_DEBUG_PATH path)
	if(IOS AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOS_RELEASE_PATH path)
	if(IOS AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOS32_PATH path)
	if(IOS_32)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOS32_DEBUG_PATH path)
	if(IOS_32 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOS32_RELEASE_PATH path)
	if(IOS_32 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOS64_PATH path)
	if(IOS_64)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOS64_DEBUG_PATH path)
	if(IOS_64 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOS64_RELEASE_PATH path)
	if(IOS_64 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOSSIM_PATH path)
	if(IOSSIM)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOSSIM_DEBUG_PATH path)
	if(IOSSIM AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOSSIM_RELEASE_PATH path)
	if(IOSSIM AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOSSIM32_PATH path)
	if(IOSSIM_32)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOSSIM32_DEBUG_PATH path)
	if(IOSSIM_32 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOSSIM32_RELEASE_PATH path)
	if(IOSSIM_32 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOSSIM64_PATH path)
	if(IOSSIM_64)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOSSIM64_DEBUG_PATH path)
	if(IOSSIM_64 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(IOSSIM64_RELEASE_PATH path)
	if(IOSSIM_64 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(LINUX_PATH path)
	if(LINUX)
		DKSETPATH(${path})
	endif()
endfunction()

function(LINUX_DEBUG_PATH path)
	if(LINUX AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(LINUX_RELEASE_PATH path)
	if(LINUX AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(LINUX32_PATH path)
	if(LINUX_32)
		DKSETPATH(${path})
	endif()
endfunction()

function(LINUX32_DEBUG_PATH path)
	if(LINUX_32 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(LINUX32_RELEASE_PATH path)
	if(LINUX_32 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(LINUX64_PATH path)
	if(LINUX_64)
		DKSETPATH(${path})
	endif()
endfunction()

function(LINUX64_DEBUG_PATH path)
	if(LINUX_64 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(LINUX64_RELEASE_PATH path)
	if(LINUX_64 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(ANDROID_PATH path)
	if(ANDROID)
		DKSETPATH(${path})
	endif()
endfunction()

function(ANDROID_DEBUG_PATH path)
	if(ANDROID AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(ANDROID_RELEASE_PATH path)
	if(ANDROID AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(ANDROID32_PATH path)
	if(ANDROID_32)
		DKSETPATH(${path})
	endif()
endfunction()

function(ANDROID32_DEBUG_PATH path)
	if(ANDROID_32 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(ANDROID32_RELEASE_PATH path)
	if(ANDROID_32 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(ANDROID64_PATH path)
	if(ANDROID_64)
		DKSETPATH(${path})
	endif()
endfunction()

function(ANDROID64_DEBUG_PATH path)
	if(ANDROID_64 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(ANDROID64_RELEASE_PATH path)
	if(ANDROID_64 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(RASPBERRY_PATH path)
	if(RASPBERRY)
		DKSETPATH(${path})
	endif()
endfunction()

function(RASPBERRY_DEBUG_PATH path)
	if(RASPBERRY AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(RASPBERRY_RELEASE_PATH path)
	if(RASPBERRY AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(RASPBERRY32_PATH path)
	if(RASPBERRY_32)
		DKSETPATH(${path})
	endif()
endfunction()

function(RASPBERRY32_DEBUG_PATH path)
	if(RASPBERRY_32 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(RASPBERRY32_RELEASE_PATH path)
	if(RASPBERRY_32 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()

function(RASPBERRY64_PATH path)
	if(RASPBERRY_64)
		DKSETPATH(${path})
	endif()
endfunction()

function(RASPBERRY64_DEBUG_PATH path)
	if(RASPBERRY_64 AND DEBUG)
		DKSETPATH(${path})
	endif()
endfunction()

function(RASPBERRY64_RELEASE_PATH path)
	if(RASPBERRY_64 AND RELEASE)
		DKSETPATH(${path})
	endif()
endfunction()


###################  BASH  ######################
function(WIN_BASH arg)
	if(WIN AND QUEUE_BUILD)
		string(REPLACE ":/" "/" arg ${arg})
		file(WRITE ${MSYS}/dkscript.tmp ${arg})
		message("BASH -> ${arg}")
		DKEXECUTE_PROCESS(COMMAND cmd /c ${3RDPARTY}/mingw/msys/bin/bash ${MSYS}/dkscript.tmp)
	endif()
endfunction()

function(WIN_DEBUG_BASH arg)
	if(WIN AND DEBUG)
		WIN_BASH(${arg})
	endif()
endfunction()

function(WIN_RELEASE_BASH arg)
	if(WIN AND RELEASE)
		WIN_BASH(${arg})
	endif()
endfunction()

function(WIN32_BASH arg)
	if(WIN_32)
		WIN_BASH(${arg})
	endif()
endfunction()

function(WIN32_DEBUG_BASH arg)
	if(WIN_32 AND DEBUG)
		WIN_BASH(${arg})
	endif()
endfunction()

function(WIN32_RELEASE_BASH arg)
	if(WIN_32 AND RELEASE)
		WIN_BASH(${arg})
	endif()
endfunction()

function(WIN64_BASH arg)
	if(WIN_64)
		WIN_BASH(${arg})
	endif()
endfunction()

function(WIN64_DEBUG_BASH arg)
	if(WIN_64 AND DEBUG)
		WIN_BASH(${arg})
	endif()
endfunction()

function(WIN64_RELEASE_BASH arg)
	if(WIN_64 AND RELEASE)
		WIN_BASH(${arg})
	endif()
endfunction()

function(ANDROID_BASH arg)
	if(ANDROID AND QUEUE_BUILD)
		string(REPLACE ":/" "/" arg ${arg})
		file(WRITE ${MSYS}/dkscript.tmp ${arg})
		message("BASH-> ${arg}")
		DKEXECUTE_PROCESS(COMMAND cmd /c ${3RDPARTY}/mingw/msys/bin/bash ${MSYS}/dkscript.tmp)
	endif()
endfunction()

function(ANDROID32_BASH arg)
	if(ANDROID_32)
		set(arg2 ${arg} ${ARGN})
		ANDROID_BASH(${arg2})
	endif()
endfunction()

function(ANDROID64_BASH arg)
	if(ANDROID_64)
		set(arg2 ${arg} ${ARGN})
		ANDROID_BASH(${arg2})
	endif()
endfunction()


################### COMMAND ########################
#########################
function(WIN_COMMAND arg)
	if(WIN AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		DKEXECUTE_PROCESS(COMMAND cmd /c ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	endif()	
endfunction()

function(WIN32_COMMAND arg)
	if(WIN_32 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		WIN_COMMAND(${arg2})
	endif()	
endfunction()

function(WIN32_DEBUG_COMMAND arg)
	if(WIN_32 AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		WIN_COMMAND(${arg2})
	endif()	
endfunction()

function(WIN32_RELEASE_COMMAND arg)
	if(WIN_32 AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		WIN_COMMAND(${arg2})
	endif()	
endfunction()

function(WIN64_COMMAND arg)
	if(WIN_64 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		WIN_COMMAND(${arg2})
	endif()
endfunction()

function(WIN64_DEBUG_COMMAND arg)
	if(WIN_64 AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		WIN_COMMAND(${arg2})
	endif()	
endfunction()

function(WIN64_RELEASE_COMMAND arg)
	if(WIN_64 AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		WIN_COMMAND(${arg2})
	endif()	
endfunction()

#########################
function(MAC_COMMAND arg)
	if(MAC AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		DKEXECUTE_PROCESS(COMMAND ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	endif()
endfunction()

function(MAC_DEBUG_COMMAND arg)
	if(MAC AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		MAC_COMMAND(${arg2})
	endif()
endfunction()

function(MAC_RELEASE_COMMAND arg)
	if(MAC AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		MAC_COMMAND(${arg2})
	endif()
endfunction()

function(MAC32_COMMAND arg)
	if(MAC_32 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		MAC_COMMAND(${arg2})
	endif()
endfunction()

function(MAC32_DEBUG_COMMAND arg)
	if(MAC_32 AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		MAC_COMMAND(${arg2})
	endif()
endfunction()

function(MAC32_RELEASE_COMMAND arg)
	if(MAC_32 AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		MAC_COMMAND(${arg2})
	endif()
endfunction()

function(MAC64_COMMAND arg)
	if(MAC_64 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		MAC_COMMAND(${arg2})
	endif()
endfunction()

function(MAC64_DEBUG_COMMAND arg)
	if(MAC_64 AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		MAC_COMMAND(${arg2})
	endif()
endfunction()

function(MAC64_RELEASE_COMMAND arg)
	if(MAC_64 AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		MAC_COMMAND(${arg2})
	endif()
endfunction()


#########################
function(IOS_COMMAND arg)
	if(IOS AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		DKEXECUTE_PROCESS(COMMAND ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	endif()
endfunction()

function(IOS_DEBUG_COMMAND arg)
	if(IOS AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		IOS_COMMAND(${arg2})
	endif()
endfunction()

function(IOS_RELEASE_COMMAND arg)
	if(IOS AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		IOS_COMMAND(${arg2})
	endif()
endfunction()

function(IOS32_COMMAND arg)
	if(IOS_32 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		IOS_COMMAND(${arg2})
	endif()
endfunction()

function(IOS64_COMMAND arg)
	if(IOS_64 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		IOS_COMMAND(${arg2})
	endif()
endfunction()

############################
function(IOSSIM_COMMAND arg)
	if(IOSSIM AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		DKEXECUTE_PROCESS(COMMAND ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	endif()
endfunction()

function(IOSSIM_DEBUG_COMMAND arg)
	if(IOSSIM AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		IOSSIM_COMMAND(${arg2})
	endif()
endfunction()

function(IOSSIM_RELEASE_COMMAND arg)
	if(IOSSIM AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		IOSSIM_COMMAND(${arg2})
	endif()
endfunction()

function(IOSSIM32_COMMAND arg)
	if(IOSSIM_32 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		IOSSIM_COMMAND(${arg2})
	endif()
endfunction()

function(IOSSIM64_COMMAND arg)
	if(IOSSIM_64 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		IOSSIM_COMMAND(${arg2})
	endif()
endfunction()

###########################
function(LINUX_COMMAND arg)
	if(LINUX AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		DKEXECUTE_PROCESS(COMMAND ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	endif()
endfunction()

function(LINUX_DEBUG_COMMAND arg)
	if(LINUX AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		LINUX_COMMAND(${arg2})
	endif()
endfunction()

function(LINUX_RELEASE_COMMAND arg)
	if(LINUX AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		LINUX_COMMAND(${arg2})
	endif()
endfunction()

function(LINUX32_COMMAND arg)
	if(LINUX_32 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		LINUX_COMMAND(${arg2})
	endif()
endfunction()

function(LINUX32_DEBUG_COMMAND arg)
	if(LINUX_32 AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		LINUX_COMMAND(${arg2})
	endif()
endfunction()

function(LINUX32_RELEASE_COMMAND arg)
	if(LINUX_32 AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		LINUX_COMMAND(${arg2})
	endif()
endfunction()

function(LINUX64_COMMAND arg)
	if(LINUX_64 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		LINUX_COMMAND(${arg2})
	endif()
endfunction()

function(LINUX64_DEBUG_COMMAND arg)
	if(LINUX_64 AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		LINUX_COMMAND(${arg2})
	endif()
endfunction()

function(LINUX64_RELEASE_COMMAND arg)
	if(LINUX_64 AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		LINUX_COMMAND(${arg2})
	endif()
endfunction()

###############################
function(RASPBERRY_COMMAND arg)
	if(RASPBERRY AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		DKEXECUTE_PROCESS(COMMAND ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	endif()
endfunction()

function(RASPBERRY_DEBUG_COMMAND arg)
	if(RASPBERRY AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		RASPBERRY_COMMAND(${arg2})
	endif()
endfunction()

function(RASPBERRY_RELEASE_COMMAND arg)
	if(RASPBERRY AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		RASPBERRY_COMMAND(${arg2})
	endif()
endfunction()

function(RASPBERRY32_COMMAND arg)
	if(RASPBERRY_32 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		RASPBERRY_COMMAND(${arg2})
	endif()
endfunction()

function(RASPBERRY32_DEBUG_COMMAND arg)
	if(RASPBERRY_32 AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		RASPBERRY_COMMAND(${arg2})
	endif()
endfunction()

function(RASPBERRY32_RELEASE_COMMAND arg)
	if(RASPBERRY_32 AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		RASPBERRY_COMMAND(${arg2})
	endif()
endfunction()

function(RASPBERRY64_COMMAND arg)
	if(RASPBERRY_64 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		RASPBERRY_COMMAND(${arg2})
	endif()
endfunction()

function(RASPBERRY64_DEBUG_COMMAND arg)
	if(RASPBERRY_64 AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		RASPBERRY_COMMAND(${arg2})
	endif()
endfunction()

function(RASPBERRY64_RELEASE_COMMAND arg)
	if(RASPBERRY_64 AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		RASPBERRY_COMMAND(${arg2})
	endif()
endfunction()

#############################
function(ANDROID_COMMAND arg)
	if(ANDROID AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		DKEXECUTE_PROCESS(COMMAND cmd /c ${arg2} WORKING_DIRECTORY ${CURRENT_DIR})
	endif()
endfunction()

function(ANDROID_DEBUG_COMMAND arg)
	if(ANDROID AND DEBUG AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		ANDROID_COMMAND(${arg2})
	endif()
endfunction()

function(ANDROID_RELEASE_COMMAND arg)
	if(ANDROID AND RELEASE AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		ANDROID_COMMAND(${arg2})
	endif()
endfunction()

function(ANDROID32_COMMAND arg)
	if(ANDROID_32 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		ANDROID_COMMAND(${arg2})
	endif()
endfunction()

function(ANDROID32_DEBUG_COMMAND arg)
	if(ANDROID_32 AND DEBUG)
		set(arg2 ${arg} ${ARGN})
		ANDROID_COMMAND(${arg2})
	endif()
endfunction()

function(ANDROID32_RELEASE_COMMAND arg)
	if(ANDROID_32 AND RELEASE)
		set(arg2 ${arg} ${ARGN})
		ANDROID_COMMAND(${arg2})
	endif()
endfunction()

function(ANDROID64_COMMAND arg)
	if(ANDROID_64 AND QUEUE_BUILD)
		set(arg2 ${arg} ${ARGN})
		ANDROID_COMMAND(${arg2})
	endif()
endfunction()

function(ANDROID64_DEBUG_COMMAND arg)
	if(ANDROID_64 AND DEBUG)
		set(arg2 ${arg} ${ARGN})
		ANDROID_COMMAND(${arg2})
	endif()
endfunction()

function(ANDROID64_RELEASE_COMMAND arg)
	if(ANDROID_64 AND RELEASE)
		set(arg2 ${arg} ${ARGN})
		ANDROID_COMMAND(${arg2})
	endif()
endfunction()


################# Visual Studio Build ################
function(WIN_VS_DEBUG arg arg2)
	if(WIN AND DEBUG AND QUEUE_BUILD)
		if(NOT EXISTS ${3RDPARTY}/${arg}/${OS}/${arg2})
			message(FATAL_ERROR "CANNOT FIND: ${3RDPARTY}/${arg}/${OS}/${arg2}" )
		endif()
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg3)
			set(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /t:${arg3} /p:Configuration=Debug)
		else()
			set(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /p:Configuration=Debug)
		endif()
		DKEXECUTE_PROCESS(COMMAND cmd /c ${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
	endif()
endfunction()

function(WIN_VS_RELEASE arg arg2)
	if(WIN AND RELEASE AND QUEUE_BUILD)
		if(NOT EXISTS ${3RDPARTY}/${arg}/${OS}/${arg2})
			message(FATAL_ERROR "CANNOT FIND: ${3RDPARTY}/${arg}/${OS}/${arg2}" )
		endif()
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg3)
			set(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /t:${arg3} /p:Configuration=Release)
		else()
			set(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /p:Configuration=Release)
		endif()
		DKEXECUTE_PROCESS(COMMAND cmd /c ${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
	endif()
endfunction()

function(WIN_VS arg arg2)
	if(WIN AND QUEUE_BUILD)
		WIN_VS_DEBUG(${arg} ${arg2})
		WIN_VS_RELEASE(${arg} ${arg2})
	endif()
endfunction()

function(WIN32_VS_DEBUG arg arg2)
	if(WIN_32)
		WIN_VS_DEBUG(${arg} ${arg2})
	endif()
endfunction()

function(WIN32_VS_RELEASE arg arg2)
	if(WIN_32)
		WIN_VS_RELEASE(${arg} ${arg2})
	endif()
endfunction()

function(WIN32_VS arg arg2)
	if(WIN_32)
		WIN_VS_DEBUG(${arg} ${arg2})
		WIN_VS_RELEASE(${arg} ${arg2})
	endif()
endfunction()

function(WIN64_VS_DEBUG arg arg2)
	if(WIN_64)
		WIN_VS_DEBUG(${arg} ${arg2})
	endif()
endfunction()

function(WIN64_VS_RELEASE arg arg2)
	if(WIN_64)
		WIN_VS_RELEASE(${arg} ${arg2})
	endif()
endfunction()

function(WIN64_VS arg arg2)
	if(WIN64)
		WIN_VS_DEBUG(${arg} ${arg2})
		WIN_VS_RELEASE(${arg} ${arg2})
	endif()
endfunction()

function(ANDROID_VS_DEBUG arg arg2)
	if(ANDROID AND DEBUG AND QUEUE_BUILD)
		if(NOT EXISTS ${3RDPARTY}/${arg}/${OS}/${arg2})
			message(FATAL_ERROR "CANNOT FIND: ${3RDPARTY}/${arg}/${OS}/${arg2}" )
		endif()
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg3)
			set(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /t:${arg3} /p:Configuration=Debug)
		else()
			set(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /p:Configuration=Debug)
		endif()
		DKEXECUTE_PROCESS(COMMAND cmd /c ${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
	endif()
endfunction()

function(ANDROID_VS_RELEASE arg arg2)
	if(ANDROID AND RELEASE AND QUEUE_BUILD)
		if(NOT EXISTS ${3RDPARTY}/${arg}/${OS}/${arg2})
			message(FATAL_ERROR "CANNOT FIND: ${3RDPARTY}/${arg}/${OS}/${arg2}" )
		endif()
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg3)
			set(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /t:${arg3} /p:Configuration=Release)
		else()
			set(EXECUTE_COMMAND ${VC_EXE} ${3RDPARTY}/${arg}/${OS}/${arg2} /p:Configuration=Release)
		endif()
		DKEXECUTE_PROCESS(COMMAND cmd /c ${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
	endif()
endfunction()

function(ANDROID_VS arg arg2)
	if(ANDROID AND QUEUE_BUILD)
		ANDROID_VS_DEBUG(${arg} ${arg2})
		ANDROID_VS_RELEASE(${arg} ${arg2})
	endif()
endfunction()

function(ANDROID32_VS_DEBUG arg arg2)
	if(ANDROID_32)
		ANDROID_VS_DEBUG(${arg} ${arg2})
	endif()
endfunction()

function(ANDROID32_VS_RELEASE arg arg2)
	if(ANDROID_32)
		ANDROID_VS_RELEASE(${arg} ${arg2})
	endif()
endfunction()

function(ANDROID32_VS arg arg2)
	if(ANDROID_32)
		ANDROID_VS_DEBUG(${arg} ${arg2})
		ANDROID_VS_RELEASE(${arg} ${arg2})
	endif()
endfunction()

function(ANDROID64_VS_DEBUG arg arg2)
	if(ANDROID_64)
		ANDROID_VS_DEBUG(${arg} ${arg2})
	endif()
endfunction()

function(ANDROID64_VS_RELEASE arg arg2)
	if(ANDROID_64)
		ANDROID_VS_RELEASE(${arg} ${arg2})
	endif()
endfunction()

function(ANDROID64_VS arg arg2)
	if(ANDROID64)
		ANDROID_VS_DEBUG(${arg} ${arg2})
		ANDROID_VS_RELEASE(${arg} ${arg2})
	endif()
endfunction()



################### Xcode Build ###################
function(MAC_XCODE_DEBUG arg)
	if(MAC AND DEBUG AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

function(MAC_XCODE_RELEASE arg)
	if(MAC AND RELEASE AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

## UNTESTED
function(MAC_XCODE arg)
	if(MAC AND QUEUE_BUILD)
		MAC_XCODE_DEBUG(${arg})
		MAC_XCODE_RELEASE(${arg})
	endif()
endfunction()

function(MAC32_XCODE_DEBUG arg)
	if(MAC_32 AND DEBUG AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

function(MAC32_XCODE_RELEASE arg)
	if(MAC_32 AND RELEASE AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

function(MAC64_XCODE_DEBUG arg)
	if(MAC_64 AND DEBUG AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

function(MAC64_XCODE_RELEASE arg)
	if(MAC_64 AND RELEASE AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

#############################
function(IOS_XCODE_DEBUG arg)
	if(IOS AND DEBUG AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

function(IOS_XCODE_RELEASE arg)
	if(IOS AND RELEASE AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

## UNTESTED
function(IOS_XCODE arg)
	if(IOS AND QUEUE_BUILD)
		IOS_XCODE_DEBUG(${arg})
		IOS_XCODE_RELEASE(${arg})
	endif()
endfunction()

function(IOS32_XCODE_DEBUG arg)
	if(IOS_32 AND DEBUG AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

function(IOS32_XCODE_RELEASE arg)
	if(IOS_32 AND RELEASE AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

function(IOS64_XCODE_DEBUG arg)
	if(IOS_64 AND DEBUG AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

function(IOS64_XCODE_RELEASE arg)
	if(IOS64 AND RELEASE AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

################################
function(IOSSIM_XCODE_DEBUG arg)
	if(IOSSIM AND DEBUG AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

function(IOSSIM_XCODE_RELEASE arg)
	if(IOSSIM AND RELEASE AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

## UNTESTED
function(IOSSIM_XCODE arg)
	if(IOSSIM AND QUEUE_BUILD)
		IOSSIM_XCODE_DEBUG(${arg})
		IOSSIM_XCODE_RELEASE(${arg})
	endif()
endfunction()

function(IOSSIM32_XCODE_DEBUG arg)
	if(IOSSIM_32 AND DEBUG AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

function(IOSSIM32_XCODE_RELEASE arg)
	if(IOSSIM_32 AND RELEASE AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	ndif()
endfunction()

function(IOSSIM64_XCODE_DEBUG arg)
	if(IOSSIM_64 AND DEBUG AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()

function(IOSSIM64_XCODE_RELEASE arg)
	if(IOSSIM_64 AND RELEASE AND QUEUE_BUILD)
		set(extra_args ${ARGN})
		list(LENGTH extra_args num_extra_args)
		if(${num_extra_args} GREATER 0)
			list(GET extra_args 0 arg2)
			DKEXECUTE_PROCESS(COMMAND xcodebuild -target ${arg2} -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		else()
			DKEXECUTE_PROCESS(COMMAND xcodebuild -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS})
		endif()
	endif()
endfunction()


####################### Android NDK Build #################
function(ANDROID_NDK_DEBUG arg)
	if(ANDROID AND DEBUG AND QUEUE_BUILD)
		if(CMAKE_HOST_WIN32)
			DKEXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
		endif()
		if(CMAKE_HOST_UNIX)
			DKEXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
		endif()
	endif()
endfunction()

function(ANDROID_NDK_RELEASE arg)
	if(ANDROID AND RELEASE AND QUEUE_BUILD)
		if(CMAKE_HOST_WIN32)
			DKEXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
		endif()
		if(CMAKE_HOST_UNIX)
			DKEXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
		endif()
	endif()
endfunction()

## UNTESTED
function(ANDROID_NDK arg)
	if(ANDROID AND QUEUE_BUILD)
		ANDROID_NDK_DEBUG(${arg})
		ANDROID_NDK_RELEASE(${arg})
	endif()
endfunction()

function(ANDROID32_NDK_DEBUG arg)
	if(ANDROID_32 AND DEBUG AND QUEUE_BUILD)
		if(CMAKE_HOST_WIN32)
			DKEXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
		endif()
		if(CMAKE_HOST_UNIX)
			DKEXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
		endif()
	endif()
endfunction()

function(ANDROID32_NDK_RELEASE arg)
	if(ANDROID_32 AND RELEASE AND QUEUE_BUILD)
		if(CMAKE_HOST_WIN32)
			DKEXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
		endif()
		if(CMAKE_HOST_UNIX)
			DKEXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
		endif()
	endif()
endfunction()

function(ANDROID64_NDK_DEBUG arg)
	if(ANDROID_64 AND DEBUG AND QUEUE_BUILD)
		if(CMAKE_HOST_WIN32)
			DKEXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
		endif()
		if(CMAKE_HOST_UNIX)
			DKEXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Debug)
		endif()
	endif()
endfunction()

function(ANDROID64_NDK_RELEASE arg)
	if(ANDROID_64 AND RELEASE AND QUEUE_BUILD)
		if(CMAKE_HOST_WIN32)
			DKEXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
		endif()
		if(CMAKE_HOST_UNIX)
			DKEXECUTE_PROCESS(COMMAND ${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${arg}/${OS}/Release)
		endif()
	endif()
endfunction()



###################### DKPlugin Link Libraries #####################
function(DKDEBUG_LIB arg)
	if(NOT DEBUG)
		return()
	endif()	
	DKSET(LIBLIST ${LIBLIST} ${arg}) ## used for double checking
	if(NOT EXISTS ${arg})
		message("MISSING: ${arg}")
		DKSET(QUEUE_BUILD ON) 
	endif()
	string(FIND "${DEBUG_LIBS}" "${arg}" _indexa)
	if(NOT ${_indexa} EQUAL -1)
		return() ## The library is already in the list
	endif()
	if(LINUX OR RASPBERRY OR ANDROID)
		DKSET(DEBUG_LIBS debug ${arg} ${DEBUG_LIBS})  #Add to beginning of list
	else()
		DKSET(DEBUG_LIBS ${DEBUG_LIBS} debug ${arg})  #Add to end of list
	endif()
endfunction()

function(DKRELEASE_LIB arg)
	if(NOT RELEASE)
		return()
	endif()
	DKSET(LIBLIST ${LIBLIST} ${arg}) ## used for double checking
	if(NOT EXISTS ${arg})
		message("MISSING: ${arg}")
		DKSET(QUEUE_BUILD ON)
	endif()
	string(FIND "${RELEASE_LIBS}" "${arg}" _indexa)
	if(NOT ${_indexa} EQUAL -1)
		return() ## The library is already in the list
	endif()	
	if(LINUX OR RASPBERRY OR ANDROID)
		DKSET(RELEASE_LIBS optimized ${arg} ${RELEASE_LIBS})  #Add to beginning of list
	else()
		DKSET(RELEASE_LIBS ${RELEASE_LIBS} optimized ${arg})  #Add to end of list
	endif()
endfunction()

###########################
function(WIN_DEBUG_LIB arg)
	if(WIN)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(WIN_RELEASE_LIB arg)
	if(WIN)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(WIN32_DEBUG_LIB arg)
	if(WIN_32)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(WIN32_RELEASE_LIB arg)
	if(WIN_32)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(WIN64_DEBUG_LIB arg)
	if(WIN_64)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(WIN64_RELEASE_LIB arg)
	if(WIN_64)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

#############################
function(APPLE_DEBUG_LIB arg)
	if(CMAKE_HOST_APPLE)
		if(NOT ANDROID)
			DKDEBUG_LIB(${arg})
		endif()
	endif()
endfunction()

function(APPLE_RELEASE_LIB arg)
	if(CMAKE_HOST_APPLE)
		if(NOT ANDROID)
			DKRELEASE_LIB(${arg})
		endif()
	endif()
endfunction()

function(MAC_DEBUG_LIB arg)
	if(MAC)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(MAC_RELEASE_LIB arg)
	if(MAC)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(MAC32_DEBUG_LIB arg)
	if(MAC_32)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(MAC32_RELEASE_LIB arg)
	if(MAC_32)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(MAC64_DEBUG_LIB arg)
	if(MAC_64)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(MAC64_RELEASE_LIB arg)
	if(MAC_64)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

###########################
function(IOS_DEBUG_LIB arg)
	if(IOS)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(IOS_RELEASE_LIB arg)
	if(IOS)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(IOS32_DEBUG_LIB arg)
	if(IOS_32)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(IOS32_RELEASE_LIB arg)
	if(IOS_32)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(IOS64_DEBUG_LIB arg)
	if(IOS_64)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(IOS64_RELEASE_LIB arg)
	if(IOS_64)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

##############################
function(IOSSIM_DEBUG_LIB arg)
	if(IOSSIM)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(IOSSIM_RELEASE_LIB arg)
	if(IOSSIM)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(IOSSIM32_DEBUG_LIB arg)
	if(IOSSIM_32)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(IOSSIM32_RELEASE_LIB arg)
	if(IOSSIM_32)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

#############################
function(LINUX_DEBUG_LIB arg)
	if(LINUX AND DEBUG)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(LINUX_RELEASE_LIB arg)
	if(LINUX AND RELEASE)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(LINUX32_DEBUG_LIB arg)
	if(LINUX32 AND DEBUG)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(LINUX32_RELEASE_LIB arg)
	if(LINUX32 AND RELEASE)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(LINUX64_DEBUG_LIB arg)
	if(LINUX64 AND DEBUG)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(LINUX64_RELEASE_LIB arg)
	if(LINUX64 AND RELEASE)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

#################################
function(RASPBERRY_DEBUG_LIB arg)
	if(RASPBERRY AND DEBUG)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(RASPBERRY_RELEASE_LIB arg)
	if(RASPBERRY AND RELEASE)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(RASPBERRY32_DEBUG_LIB arg)
	if(RASPBERRY32 AND DEBUG)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(RASPBERRY32_RELEASE_LIB arg)
	if(RASPBERRY32 AND RELEASE)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(RASPBERRY64_DEBUG_LIB arg)
	if(RASPBERRY64 AND DEBUG)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(RASPBERRY64_RELEASE_LIB arg)
	if(RASPBERRY64 AND RELEASE)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

###############################
function(ANDROID_DEBUG_LIB arg)
	if(ANDROID AND DEBUG)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(ANDROID_RELEASE_LIB arg)
	if(ANDROID AND RELEASE)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(ANDROID32_DEBUG_LIB arg)
	if(ANDROID_32 AND DEBUG)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(ANDROID32_RELEASE_LIB arg)
	if(ANDROID_32 AND RELEASE)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()

function(ANDROID64_DEBUG_LIB arg)
	if(ANDROID_64 AND DEBUG)
		DKDEBUG_LIB(${arg})
	endif()
endfunction()

function(ANDROID64_RELEASE_LIB arg)
	if(ANDROID_64 AND RELEASE)
		DKRELEASE_LIB(${arg})
	endif()
endfunction()


####################### Include Directories ###################
function(WIN_INCLUDE arg)
	if(WIN)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(WIN32_INCLUDE arg)
	if(WIN_32)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(WIN64_INCLUDE arg)
	if(WIN_64)
		DKINCLUDE(${arg})
	endif()
endfunction()

###########################
function(APPLE_INCLUDE arg)
	if(CMAKE_HOST_APPLE)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(MAC_INCLUDE arg)
	if(MAC)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(MAC32_INCLUDE arg)
	if(MAC_32)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(MAC64_INCLUDE arg)
	if(MAC_64)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(IOS_INCLUDE arg)
	if(IOS)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(IOS32_INCLUDE arg)
	if(IOS_32)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(IOS64_INCLUDE arg)
	if(IOS_64)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(IOSSIM_INCLUDE arg)
	if(IOSSIM)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(IOSSIM32_INCLUDE arg)
	if(IOSSIM_32)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(IOSSIM64_INCLUDE arg)
	if(IOSSIM_64)
		DKINCLUDE(${arg})
	endif()
endfunction()

###########################
function(LINUX_INCLUDE arg)
	if(LINUX)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(LINUX32_INCLUDE arg)
	if(LINUX_32)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(LINUX64_INCLUDE arg)
	if(LINUX_64)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(LINUX_DEBUG_INCLUDE arg)
	if(DEBUG)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(LINUX_RELEASE_INCLUDE arg)
	if(RELEASE)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(LINUX32_DEBUG_INCLUDE arg)
	if(LINUX_32 AND DEBUG)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(LINUX32_RELEASE_INCLUDE arg)
	if(LINUX_32 AND RELEASE)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(LINUX64_DEBUG_INCLUDE arg)
	if(LINUX_64 AND DEBUG)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(LINUX64_RELEASE_INCLUDE arg)
	if(LINUX_64 AND RELEASE)
		DKINCLUDE(${arg})
	endif()
endfunction()

###############################
function(RASPBERRY_INCLUDE arg)
	if(RASPBERRY)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(RASPBERRY32_INCLUDE arg)
	if(RASPBERRY_32)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(RASPBERRY64_INCLUDE arg)
	if(RASPBERRY_64)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(RASPBERRY_DEBUG_INCLUDE arg)
	if(RASPBERRY AND DEBUG)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(RASPBERRY_RELEASE_INCLUDE arg)
	if(RASPBERRY AND RELEASE)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(RASPBERRY32_DEBUG_INCLUDE arg)
	if(RASPBERRY_32 AND DEBUG)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(RASPBERRY32_RELEASE_INCLUDE arg)
	if(RASPBERRY_32 AND RELEASE)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(RASPBERRY64_DEBUG_INCLUDE arg)
	if(RASPBERRY_64 AND DEBUG)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(RASPBERRY64_RELEASE_INCLUDE arg)
	if(RASPBERRY_64 AND RELEASE)
		DKINCLUDE(${arg})
	endif()
endfunction()

#############################
function(ANDROID_INCLUDE arg)
	if(ANDROID)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(ANDROID_DEBUG_INCLUDE arg)
	if(ANDROID AND DEBUG)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(ANDROID_RELEASE_INCLUDE arg)
	if(ANDROID AND RELEASE)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(ANDROID32_INCLUDE arg)
	if(ANDROID_32)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(ANDROID32_DEBUG_INCLUDE arg)
	if(ANDROID_32 AND DEBUG)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(ANDROID32_RELEASE_INCLUDE arg)
	if(ANDROID_32 AND RELEASE)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(ANDROID64_INCLUDE arg)
	if(ANDROID_64)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(ANDROID64_DEBUG_INCLUDE arg)
	if(ANDROID_64 AND DEBUG)
		DKINCLUDE(${arg})
	endif()
endfunction()

function(ANDROID64_RELEASE_INCLUDE arg)
	if(ANDROID_64 AND RELEASE)
		DKINCLUDE(${arg})
	endif()
endfunction()




###################### DKPLUGINS ####################
function(DKPLUGIN arg)
	DKSETPATHTOPLUGIN(${arg})
	if(NOT PATHTOPLUGIN)
		return()
	endif()
	
	if(ANDROID_TESTTESTTEST)
		DKSET(ANDROID_LIBMK ${ANDROID_LIBMK}
			"LOCAL_PATH:= $(call my-dir)\n"
			"include $(CLEAR_VARS)\n"
			"LOCAL_MODULE := ${arg}\n"
			"ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)\n"
			"    ARM_NEON := true\n"
			"endif\n"
			"LOCAL_SRC_FILES := $(wildcard ${PATHTOPLUGIN}/*.cpp)\n"
			"LOCAL_SRC_FILES += $(wildcard ${PATHTOPLUGIN}/*.c)\n\n"
			"LOCAL_CPPFLAGS := -DANDROID\n"
			"LOCAL_CPPFLAGS += -std=gnu++11\n"
			"LOCAL_LDFLAGS :=\n\n")
		DKINCLUDE(${PATHTOPLUGIN})
	else()
		DKINCLUDE(${DIGITALKNOB}/DKPlugins)
		##Create CmakeLists.txt file
		DKSET(CMAKE_FILE "### This file is generated by DKCMake. Any Changes here, will be overwritten. ###\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}### ${arg} ###\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}cmake_minimum_required(VERSION 3.10)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}cmake_policy(SET CMP0054 NEW)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}include(${DKCMAKE}/FUNCTIONS.cmake)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}include(${DKCMAKE}/OPTIONS.cmake)\n")
		if(IOS)
			DKSET(CMAKE_FILE "${CMAKE_FILE}set(IOS_PLATFORM OS)\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}include(${DKCMAKE}/iOS.cmake)\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}add_definitions(-DIOS)\n")
		endif()
		if(IOSSIM)
			DKSET(CMAKE_FILE "${CMAKE_FILE}set(IOS_PLATFORM SIMULATOR)\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}include(${DKCMAKE}/iOS.cmake)\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}add_definitions(-DIOS)\n")
		endif()
		if(ANDROID)
			DKSET(CMAKE_FILE "${CMAKE_FILE}set(CMAKE_CXX_FLAGS \"-std=c++14\")\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}set(CMAKE_ANDROID_STL_TYPE c++_static)\n")
		else()
			DKSET(CMAKE_FILE "${CMAKE_FILE}set(CMAKE_CXX_STANDARD 14)\n")
		endif()
		DKSET(CMAKE_FILE "${CMAKE_FILE}project(${arg})\n")
		foreach(each_include ${DKINCLUDES_LIST})
			DKSET(CMAKE_FILE "${CMAKE_FILE}include_directories(${each_include})\n")
		endforeach()
		foreach(each_define ${DKDEFINES_LIST})
			DKSET(CMAKE_FILE "${CMAKE_FILE}add_definitions(-D${each_define})\n")
	    endforeach()
		foreach(each_linkdir ${DKLINKDIRS_LIST})
			DKSET(CMAKE_FILE "${CMAKE_FILE}link_directories(${each_linkdir})\n")
	    endforeach()
		DKSET(CMAKE_FILE "${CMAKE_FILE}file(GLOB ${arg}_SRC \n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}	   ${PATHTOPLUGIN}/*.h\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.c\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.cpp\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.rc\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.manifest\n")
		if(IOS OR IOSSIM)
			DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.mm\n")
		endif()
		DKSET(CMAKE_FILE "${CMAKE_FILE})\n")
		if(STATIC)
			DKSET(CMAKE_FILE "${CMAKE_FILE}add_library(${arg} STATIC \${${arg}_SRC})\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}target_compile_options(${arg} PRIVATE ${FLAGS})\n")
		endif()
		if(SHARED)
			#if(${arg} STREQUAL DK)
			#	DKSET(CMAKE_FILE "${CMAKE_FILE}add_library(${arg} STATIC \${${arg}_SRC})\n")
			#else()
				DKSET(CMAKE_FILE "${CMAKE_FILE}add_library(${arg} SHARED \${${arg}_SRC})\n")
			#endif()
			DKSET(CMAKE_FILE "${CMAKE_FILE}add_definitions(-D_WIN32_WINNT=0x0600)\n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}set_target_properties(${arg} PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMTD.lib /SAFESEH:NO\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMT.lib /SAFESEH:NO\") \n")
			DKSET(CMAKE_FILE "${CMAKE_FILE}target_compile_options(${arg} PRIVATE $<$<CONFIG:Debug>:/MDd /Od /Ob0 /EHsc /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MD /O2 /Ob2 /EHsc /DNDEBUG>)\n")
			if(DEBUG_LIBS)
				string(REPLACE "debug" " debug " DLL_DEBUG_LIBS ${DEBUG_LIBS})
			endif()
			if(RELEASE_LIBS)
				string(REPLACE "optimized" " optimized " DLL_RELEASE_LIBS ${RELEASE_LIBS})
			endif()
			if(WIN_LIBS)
				string(REPLACE ".lib" ".lib " DLL_WIN_LIBS ${WIN_LIBS})
			endif()
			if(DLL_DEBUG_LIBS AND DLL_RELEASE_LIBS)
				#DKSET(CMAKE_FILE "${CMAKE_FILE}TARGET_LINK_LIBRARIES(${arg} debug ${DKPLUGINS}/DK/${OS}/${DEBUG_DIR}/DK.lib optimized ${DKPLUGINS}/DK/${OS}/${RELEASE_DIR}/DK.lib) \n")
				DKSET(CMAKE_FILE "${CMAKE_FILE}target_link_libraries(${arg} ${DLL_DEBUG_LIBS} ${DLL_RELEASE_LIBS} ${DLL_WIN_LIBS}) \n")
			endif()
		endif()
		DKSET(CMAKE_FILE "${CMAKE_FILE}if(CMAKE_HOST_WIN32)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}    set_target_properties(${arg} PROPERTIES LINKER_LANGUAGE CPP)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}endif()\n")	
	endif()
	
	DKSET(DKCPPPLUGS ${DKCPPPLUGS} ${arg})  #Add to list
	
	##add headers to DKPlugins.h
	if(${arg} STREQUAL DK OR STATIC)
		file(GLOB HEADER_FILES RELATIVE ${DIGITALKNOB}/DKPlugins ${PATHTOPLUGIN}/*.h)
		foreach(header ${HEADER_FILES})
			string(FIND "${PLUGINS_FILE}" "${header}" _indexa)
			if(${_indexa} EQUAL -1)
				message("Adding ${header} to header file.")
				DKSET(PLUGINS_FILE ${PLUGINS_FILE} "#include \"${header}\"\\n")
			endif()
		endforeach()
	endif()
endfunction()

###################
function(DKDLL arg)
	DKSETPATHTOPLUGIN(${arg})
	if(NOT PATHTOPLUGIN)
		return()
	endif()
	DKINCLUDE(${PATHTOPLUGIN})
			
	##Create CmakeLists.txt file
	DKSET(CMAKE_FILE "### ${arg} ###\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}CMAKE_MINIMUM_REQUIRED(VERSION 3.0)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/FUNCTIONS.cmake)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/OPTIONS.cmake)\n")
	if(IOS)
		DKSET(CMAKE_FILE "${CMAKE_FILE}SET(IOS_PLATFORM OS)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/iOS.cmake)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_DEFINITIONS(-DIOS)\n")
	endif()
	if(IOSSIM)
		DKSET(CMAKE_FILE "${CMAKE_FILE}SET(IOS_PLATFORM SIMULATOR)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/iOS.cmake)\n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_DEFINITIONS(-DIOS)\n")
	endif()
	DKSET(CMAKE_FILE "${CMAKE_FILE}PROJECT(${arg})\n")
	foreach(each_include ${DKINCLUDES_LIST})
		DKSET(CMAKE_FILE "${CMAKE_FILE}include_directories(${each_include})\n")
	endforeach()
	foreach(each_define ${DKDEFINES_LIST})
		DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_DEFINITIONS(-D${each_define})\n")
	endforeach()
	foreach(each_linkdir ${DKLINKDIRS_LIST})
		DKSET(CMAKE_FILE "${CMAKE_FILE}link_directories(${each_linkdir})\n")
	endforeach()
	DKSET(CMAKE_FILE "${CMAKE_FILE}file(GLOB ${arg}_SRC \n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}	   ${PATHTOPLUGIN}/*.h\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.c\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.cpp\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.rc\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.manifest\n")
	if(IOS OR IOSSIM)
		DKSET(CMAKE_FILE "${CMAKE_FILE}    ${PATHTOPLUGIN}/*.mm\n")
	endif()
	DKSET(CMAKE_FILE "${CMAKE_FILE})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_LIBRARY(${arg} SHARED \${${arg}_SRC})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_DEFINITIONS(-D_WIN32_WINNT=0x0600)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}SET_TARGET_PROPERTIES(${arg} PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMTD.lib /SAFESEH:NO\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMT.lib /SAFESEH:NO\") \n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}target_compile_options(${arg} PRIVATE $<$<CONFIG:Debug>:/MDd /Od /Ob0 /EHsc /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MD /O2 /Ob2 /EHsc /DNDEBUG>)\n")
	if(DEBUG_LIBS)
		string(REPLACE "debug" " debug " DLL_DEBUG_LIBS ${DEBUG_LIBS})
	endif()
	if(RELEASE_LIBS)
		string(REPLACE "optimized" " optimized " DLL_RELEASE_LIBS ${RELEASE_LIBS})
	endif()
	if(WIN_LIBS)
		string(REPLACE ".lib" ".lib " DLL_WIN_LIBS ${WIN_LIBS})
	endif()
	if(DLL_DEBUG_LIBS AND DLL_RELEASE_LIBS)
		#DKSET(CMAKE_FILE "${CMAKE_FILE}TARGET_LINK_LIBRARIES(${arg} debug ${DKPLUGINS}/DK/${OS}/${DEBUG_DIR}/DK.lib optimized ${DKPLUGINS}/DK/${OS}/${RELEASE_DIR}/DK.lib) \n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}TARGET_LINK_LIBRARIES(${arg} ${DLL_DEBUG_LIBS} ${DLL_RELEASE_LIBS} ${DLL_WIN_LIBS}) \n")
	endif()
	DKSET(CMAKE_FILE "${CMAKE_FILE}if(CMAKE_HOST_WIN32)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    SET_TARGET_PROPERTIES(${arg} PROPERTIES LINKER_LANGUAGE CPP)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}endif()\n")	
	DKSET(DKCPPPLUGS ${DKCPPPLUGS} ${arg})  #Add to list	
endfunction()


##########################
function(DKEXECUTABLE arg)
	##Create CmakeLists.txt file
	DKSETPATHTOPLUGIN(${arg})
	if(NOT PATHTOPLUGIN)
		return()
	endif()
	DKINCLUDE(${PATHTOPLUGIN})
	DKSET(CMAKE_FILE "### ${arg} ###\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}CMAKE_MINIMUM_REQUIRED(VERSION 3.0)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/FUNCTIONS.cmake)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/OPTIONS.cmake)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}PROJECT(${arg})\n")
endfunction()

############################
function(DKAPPEND_CMAKE arg)
	DKSET(CMAKE_FILE "${CMAKE_FILE} ${arg}")
endfunction()

########################
SET(ASSETS 
	PATTERN *.h EXCLUDE
	PATTERN *.c EXCLUDE
	PATTERN *.cpp EXCLUDE
	PATTERN *.manifest EXCLUDE
	PATTERN *.mm EXCLUDE
	PATTERN *.plist EXCLUDE
	PATTERN *.rc EXCLUDE
	PATTERN *.tmp EXCLUDE
	PATTERN *.TMP EXCLUDE
	PATTERN *.temp EXCLUDE
	PATTERN *.TEMP EXCLUDE
	PATTERN DKMAKE.cmake EXCLUDE
	PATTERN CMakeLists.txt EXCLUDE
	PATTERN DEPENDS.TMP EXCLUDE
	PATTERN temp.txt EXCLUDE
	PATTERN win32 EXCLUDE
	PATTERN win64 EXCLUDE
	PATTERN mac32 EXCLUDE
	PATTERN mac64 EXCLUDE
	PATTERN ios32 EXCLUDE
	PATTERN ios64 EXCLUDE
	PATTERN iossim32 EXCLUDE
	PATTERN iossim64 EXCLUDE
	PATTERN linux32 EXCLUDE
	PATTERN linux64 EXCLUDE
	PATTERN android32 EXCLUDE
	PATTERN android64 EXCLUDE
	PATTERN raspberry32 EXCLUDE
	PATTERN raspberry64 EXCLUDE
	PATTERN cefchild EXCLUDE
	PATTERN dktest EXCLUDE)
	##PATTERN README.txt EXCLUDE)

function(DKASSETS arg)
	DKSETPATHTOPLUGIN(${arg})
	if(NOT PATHTOPLUGIN)
		return()
	endif()
	message("Importing assets...")
	file(COPY ${PATHTOPLUGIN} DESTINATION ${DKPROJECT}/assets ${ASSETS})
endfunction()


## FIXME: This only works on DK/3rdParty/_DKIMPORT, it needs to work on sibling folders as well
## I.E.  MyApps/3rdParty/_DKIMPORT/libSomething_1.2b
function(DKSETPATHTOPLUGIN arg)
	DKSET(PATHTOPLUGIN "")
	if(EXISTS ${DKPLUGINS}/${arg}/DKMAKE.cmake)
		DKSET(PATHTOPLUGIN "${DKPLUGINS}/${arg}")
		message("FOUND ${arg} DKPlugin at ${PATHTOPLUGIN}")
		return()
	elseif(EXISTS ${DKIMPORTS}/${arg}/DKMAKE.cmake)
		DKSET(PATHTOPLUGIN "${DKIMPORTS}/${arg}")
		message("FOUND ${arg} DKImport at ${PATHTOPLUGIN}")
		return()
	endif()
	
	file(GLOB children RELATIVE ${DIGITALKNOB}/../ ${DIGITALKNOB}/../*)
  	foreach(child ${children})
		if(EXISTS ${DIGITALKNOB}/../${child}/DKPlugins/${arg}/DKMAKE.cmake)
			DKSET(PATHTOPLUGIN "${DIGITALKNOB}/../${child}/DKPlugins/${arg}")
			message("FOUND ${arg} Plugin at ${PATHTOPLUGIN}")
			return()
    	endif()
  	endforeach()
	message(FATAL_ERROR "Could not find ${arg} Plugin.")   ## FIXME - we only seem to look in the DK/3rdParty/_DKIMPORT for plugins
endfunction()


## Add a library or plugin to the dependency list
######################
function(DKDEPEND arg)
	list(FIND dkdepend_disable_list "${arg}" _index)
	if(${_index} GREATER -1)
		message("${arg} IS DISABLED")
		return()
	endif()
		
		
	## If DKDEPEND had second variable (a sub library), set that variable to ON
	set(extra_args ${ARGN})
	list(LENGTH extra_args num_extra_args)
	if(${num_extra_args} GREATER 0)
		list(GET extra_args 0 arg2)
		
		## If the library is already in the list, return.
		list(FIND dkdepend_list "${arg} ${args}" _index)
		if(${_index} GREATER -1)
			return()
		endif()
		
		#list(FIND dkdepend_disable_list "${arg} ${args}" _index)
		#if(${_index} GREATER -1)
		#	message("${arg} IS DISABLED")
		#	return()
		#endif()
		
		DKRUNDEPENDS(${arg} ${arg2})    ##strip everything from the file except if() else() elseif() endif() and DKDEPEND() before sorting.
		#DKBRUTEDEPENDS(${arg} ${arg2}) ##read ALL DKDEPENDS() commands from the file list.  -ignores if(), else().. and all found depends will be included.
	else()
		## If the library is already in the list, return.
		list(FIND dkdepend_list "${arg}" _index)
		if(${_index} GREATER -1)
			return()
		endif()
		
		DKRUNDEPENDS(${arg})  ##strip everything from the file except if() else() elseif() endif() and DKDEPEND() before sorting.
		#DKBRUTEDEPENDS(${arg}) ##read ALL DKDEPENDS() commands from the file list.  -ignores if(), else().. and all found depends will be included.
	endif()
endfunction()

## Remove a library or plugin from the dependency list
function(DISABLE_DKDEPEND arg)
	#list(REMOVE_ITEM dkdepend_list ${arg})
	#list(FIND dkdepend_disable_list ${arg} _index)
	#if(${_index} GREATER -1)
	#	return()  ##already in the list
	#endif()
		
	## Only allow DISABLE_DKDEPEND command from these filters
	
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE})                   ## DKCMake directory only
	##if(NOT ${CMAKE_CURRENT_LIST_FILE} STREQUAL ${DKCMAKE}/DKMake.cmake)   ## DKCMake/DISABLED.cmake file only
		message(FATAL_ERROR "\n\n!!!! WARNING !!!!\nDISABLE_DKDEPEND() Can only be used from the DKCMake/DISABLED.cmake file. This is to avoid the need to alter cmake files just to disable them and have disables hideing everywhere.\n\n\n")
	endif()
	message("DISABLING ${arg}")
	
	DKSET(dkdepend_disable_list ${dkdepend_disable_list} ${arg})
endfunction()


### NOTE:
### There are currently 2 methods of sorting dependencies throughout the DKMAKE.cmake files.

### 
### This first method, scans through the DKMAKE.cmake files and searches for DKDEPEND() commands.
### This loop will sort them from top to bottom, then they will be run.
### This is more of a brute-force method, all if(), else(), elif(), commands will be ignored and 
### all instances of DKDEPEND('lib') will be added to the list. 

### The second method will strip everything from the file except DKDEPEND('lib') commands AND conditionals.
### Conditionals such as if(), else(), elseif(), endif(), return() conditionals will be processed during the sort process. 
### WARNING: BE CAREFULL WRITING NEW VARIABLES TO USE WITH CONDITIONALS, AS THEY WILL BE IGNORED
### DO NOT CREATE NEW VARIABLES WITHIN THE DKMAKE.cmake FILES TO DETERMINE THE true/false of a conditional.  


## Sort dependencies by: Strip everything from the file except if() else() elseif() endif() and DKDEPEND() before sorting.
##########################
function(DKRUNDEPENDS arg)
	DKSETPATHTOPLUGIN(${arg})
	if(NOT PATHTOPLUGIN)
		return()
	endif()
	
	file(STRINGS ${PATHTOPLUGIN}/DKMAKE.cmake lines)
	unset(disable_script)
	unset(depends_script)
	unset(_indexa)
	
	foreach(line ${lines})
		string(FIND "${line}" "if(" _indexa)
		if(${_indexa} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		string(FIND "${line}" "IF(" _indexa)
		if(${_indexa} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		## elseif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		string(FIND "${line}" "else(" _indexa)
		if(${_indexa} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		string(FIND "${line}" "ELSE(" _indexa)
		if(${_indexa} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		## endif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		string(FIND "${line}" "return(" _indexa)
		if(${_indexa} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		string(FIND "${line}" "RETURN(" _indexa)
		if(${_indexa} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		string(FIND "${line}" "DISABLE_DKDEPEND(" _indexa)
		if(${_indexa} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		## DISABLE_DKDEPEND(
		##NOTE: The 'DKDEPEND(' search commands take care of 'DISABLE_DKDEPEND(' since 'DKDEPEND' is already in the word
		
	endforeach()
	
	foreach(line ${lines})
		string(FIND "${line}" "if(" _indexa)
		if(${_indexa} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		string(FIND "${line}" "IF(" _indexa)
		if(${_indexa} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		## elseif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		string(FIND "${line}" "else(" _indexa)
		if(${_indexa} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		string(FIND "${line}" "ELSE(" _indexa)
		if(${_indexa} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		## endif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		string(FIND "${line}" "return(" _indexa)
		if(${_indexa} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		string(FIND "${line}" "RETURN(" _indexa)
		if(${_indexa} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		string(FIND "${line}" "DKENABLE(" _indexa)
		if(${_indexa} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()	
		
		string(FIND "${line}" "DKDEPEND(" _indexa)
		if(${_indexa} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		## DISABLE_DKDEPEND(
		##NOTE: The 'DKDEPEND(' search commands take care of 'DISABLE_DKDEPEND(' since 'DKDEPEND' is already in the word
		
	endforeach()

	set(extra_args ${ARGN})
	list(LENGTH extra_args num_extra_args)
	if(${num_extra_args} GREATER 0)
		list(GET extra_args 0 arg2)
	endif()
	
	if(disable_script)
		file(WRITE ${PATHTOPLUGIN}/DISABLES.TMP "${disable_script}")
		INCLUDE(${PATHTOPLUGIN}/DISABLES.TMP)
		DKREMOVE(${PATHTOPLUGIN}/DISABLES.TMP)
	endif()
	
	if(depends_script)
		file(WRITE ${PATHTOPLUGIN}/DEPENDS.TMP "${depends_script}")
		if(${num_extra_args} GREATER 0)
			DKENABLE(${arg2})
		endif()
		INCLUDE(${PATHTOPLUGIN}/DEPENDS.TMP)
		if(${num_extra_args} GREATER 0)
			DKSET(${arg2} OFF)
		endif()
		DKREMOVE(${PATHTOPLUGIN}/DEPENDS.TMP)
	endif()
	
	list(FIND dkdepend_list "${arg} ${args}" _index)
	if(${_index} GREATER -1)
		return()
	endif()
		
	list(FIND dkdepend_list "${arg}" _index)
	if(${_index} GREATER -1)
		return() ## If the include is already in the list, return.
	endif()
	
	if(${num_extra_args} GREATER 0)
		DKSET(dkdepend_list ${dkdepend_list} "${arg} ${arg2}")  #Add to list
	else()
		DKSET(dkdepend_list ${dkdepend_list} ${arg})  #Add to list
	endif()	
	list(REMOVE_DUPLICATES dkdepend_list)
endfunction()

############################
function(DKBRUTEDEPENDS arg)
	################################################################
	## USE Brute force to search the file for DKDEPENDS() commands
	DKSETPATHTOPLUGIN(${arg})
	if(NOT PATHTOPLUGIN)
		return()
	endif()
	
	file(READ ${PATHTOPLUGIN}/DKMAKE.cmake data) ## read the file into a variable
	set(_index 0)
	string(FIND "${data}" "DKDEPEND(" _index) ## look for the first DKDEPEND( command
	while(${_index} GREATER -1)
		string(SUBSTRING ${data} ${_index} -1 data2)
		#message("DKDEPEND(${arg})")
		string(FIND ${data2} ")" _index)
		math(EXPR _index "${_index}-9")
		string(SUBSTRING ${data2} 9 ${_index} data3)
		
		#message("CHILD ${data3}")
		#IF ${data3} contains a space, split variable
		set(_space 0)
		string(FIND ${data3} " " _space)
		if(${_space} GREATER -1)
			string(SUBSTRING ${data3} 0 ${_space} firstvar)
			#message(${firstvar})
			math(EXPR _space "${_space}+1")
			string(SUBSTRING ${data3} ${_space} -1 secondvar)
			#message(${secondvar})
			DKDEPEND(${firstvar} ${secondvar})
		else()
			DKDEPEND(${data3})
		endif()

		math(EXPR _index "${_index}+10")
		string(SUBSTRING ${data2} ${_index} -1 data)
		string(FIND ${data} "DKDEPEND(" _index)
	endwhile()
	
	set(extra_args ${ARGN})
	list(LENGTH extra_args num_extra_args)
	if(${num_extra_args} GREATER 0)
		list(GET extra_args 0 arg2)
	endif()
	
	list(FIND dkdepend_list "${arg} ${args}" _index)
	if(${_index} GREATER -1)
		return()
	endif()
		
	list(FIND dkdepend_list "${arg}" _index)
	if(${_index} GREATER -1)
		return() ## If the include is already in the list, return.
	endif()
	
	if(${num_extra_args} GREATER 0)
		DKSET(dkdepend_list ${dkdepend_list} "${arg} ${arg2}")  #Add to list
	else()
		DKSET(dkdepend_list ${dkdepend_list} ${arg})  #Add to list
	endif()
	list(REMOVE_DUPLICATES dkdepend_list)
endfunction()

######################
FUNCTION(DKDEPEND_ALL)
	MESSAGE("DKDEPEND_ALL")
	
	##TODO - get a list of all DKPlugins and call DKPEPEND(DKPlugin) for each of them.
	message("***** DKDEPEND_ALL() *****")
	DKSET(DEPENDALL_FILE "")
	
	if(IS_DIRECTORY ${DKIMPORTS})
		file(GLOB allfiles RELATIVE "${DKIMPORTS}/" "${DKIMPORTS}/*")
		foreach(each_file ${allfiles})
			if(EXISTS ${DKIMPORTS}/${each_file}/DKMAKE.cmake)
				DKSET(DEPENDALL_FILE ${DEPENDALL_FILE} "DKDEPEND(${each_file})\n")
			endif()
		endforeach()
    endif()
	
	## Find all DKPlugins Folders from DK root
	file(GLOB children RELATIVE ${DIGITALKNOB}/../ ${DIGITALKNOB}/../*)
  	foreach(child ${children})
		if(EXISTS ${DIGITALKNOB}/../${child}/DKPlugins)
			file(GLOB plugins RELATIVE ${DIGITALKNOB}/../${child}/DKPlugins/ ${DIGITALKNOB}/../${child}/DKPlugins/*)
			foreach(plugin ${plugins})
				if(EXISTS ${DIGITALKNOB}/../${child}/DKPlugins/${plugin}/DKMAKE.cmake)
					if(NOT ${plugin} STREQUAL "_DKIMPORT")
						DKSET(DEPENDALL_FILE ${DEPENDALL_FILE} "DKDEPEND(${plugin})\n")
					endif()
				endif()
			endforeach()
    	endif()
  	endforeach()
	
	string (REPLACE ";" "" DEPENDALL_FILE "${DEPENDALL_FILE}")
	
	## The file will not be overwritten so you can comment out libraries that don't compile
	## Just remove or rename the file to have it regenerated. 
	if(NOT EXISTS ${DKPROJECT}/DEPEND_ALL.txt)
		file(WRITE ${DKPROJECT}/DEPEND_ALL.txt "${DEPENDALL_FILE}")
	endif()
	INCLUDE(${DKPROJECT}/DEPEND_ALL.txt)
endfunction()

###################################
function(DKUPDATE_ANDROID_NAME arg)
	
	string(TOLOWER ${arg} arg)
	if(ANDROID)
		## update all files and folders recursivley
		file(GLOB_RECURSE allfiles LIST_DIRECTORIES true RELATIVE "${DKPROJECT}/${OS}/" "${DKPROJECT}/${OS}/*")
		#message("\n Getting a list of files in ${DKPROJECT}/${OS} \n")
		list(REVERSE allfiles)
		foreach(each_file ${allfiles})
			##message("#####  each_file = ${each_file}")
			set(filepath "${DKPROJECT}/${OS}/${each_file}")
			message("### each_file = ${each_file}")
			
			if(NOT IS_DIRECTORY ${filepath})
				string(FIND "${each_file}" "opendb" indexD)
				if(${indexD} EQUAL -1)
				file(READ ${filepath} filestring)
				string(FIND "${filestring}" "dkapp" indexA)
				if(${indexA} GREATER -1)
					message("Replacing 'dkapp' with '${arg}' in ${filepath}")
					string(REPLACE "dkapp" "${arg}" filestring "${filestring}")
					file(WRITE ${filepath} "${filestring}")
				endif()
				endif()
			endif()
			
			get_filename_component(fname ${each_file} NAME)
			string(FIND "${fname}" "dkapp" indexB)
			if(${indexB} GREATER -1)
				set(new_name ${each_file})
				string(REPLACE "dkapp" "${arg}" new_name "${new_name}")
				message("Renaming ${each_file} to ${new_name}")
				DKRENAME(${DKPROJECT}/${OS}/${each_file} ${DKPROJECT}/${OS}/${new_name})
			endif()
		endforeach()
	endif()
endfunction()

#################################
function(DKUPDATE_INFO_PLIST arg)
	if(MAC)
		## FIXME
		message("Updating MAC info.plist . . .")
		if(DEBUG)
			if(EXISTS ${DKPROJECT}/${OS}/${DEBUG_DIR}/${arg}.app/Contents/info.plist)
				file(READ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${arg}.app/Contents/info.plist plist)
				string(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				string(REPLACE "<string>logo</string>" "" plist ${plist})
				string(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				file(WRITE "${plist}" ${DKPROJECT}/${OS}/${DEBUG_DIR}/${arg}.app/Contents/info.plist)
			endif()
		endif()
		
		if(RELEASE)
			if(EXISTS ${DKPROJECT}/${OS}/${RELEASE_DIR}/${arg}.app/Contents/info.plist)
				file(READ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${arg}.app/Contents/info.plist plist)
				string(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				string(REPLACE "<string>logo</string>" "" plist ${plist})
				string(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				file(WRITE "${plist}" ${DKPROJECT}/${OS}/${RELEASE_DIR}/${arg}.app/Contents/info.plist)
			endif()	
		endif()
	endif()
	if(IOS OR IOSSIM)
		message("Updating IOS Info.plist . . .")
		message("CHECKING FOR... ${DKPROJECT}/${OS}/${DEBUG_DIR}/${arg}.app/Info.plist")
		if(EXISTS ${DKPROJECT}/${OS}/${DEBUG_DIR}/${arg}.app/Info.plist)
			message("Updating IOS Debug Info.plist . . .")
			file(READ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${arg}.app/Info.plist plist)
			string(REPLACE "<dict>" "<dict>\n<key>Icon files</key>\n<array>\n<string>Icon.png</string>\n<string>Icon@2x.png</string>\n<string>Icon-72.png</string>\n<string>Icon-Small-50.png</string>\n<string>Icon-Small.png</string>\n<string>Icon-Small@2x.png</string>\n</array>\n" plist ${plist})
			file(WRITE "${plist}" ${DKPROJECT}/${OS}/${DEBUG_DIR}/${arg}.app/Info.plist)
		endif()
	endif()
endfunction()


# Function to wrap a given string into multiple lines at the given column position.
# Parameters:
#   VARIABLE    - The name of the CMake variable holding the string.
#   AT_COLUMN   - The column position at which string will be wrapped.
function(WRAP_STRING)
    set(oneValueArgs VARIABLE AT_COLUMN)
    cmake_parse_arguments(WRAP_STRING "${options}" "${oneValueArgs}" "" ${ARGN})
    string(LENGTH ${${WRAP_STRING_VARIABLE}} stringLength)
    math(EXPR offset "0")
    while(stringLength GREATER 0)
        if(stringLength GREATER ${WRAP_STRING_AT_COLUMN})
            math(EXPR length "${WRAP_STRING_AT_COLUMN}")
        else()
            math(EXPR length "${stringLength}")
        endif()
        string(SUBSTRING ${${WRAP_STRING_VARIABLE}} ${offset} ${length} line)
        set(lines "${lines}\n${line}")
        math(EXPR stringLength "${stringLength} - ${length}")
        math(EXPR offset "${offset} + ${length}")
    endwhile()
    set(${WRAP_STRING_VARIABLE} "${lines}" PARENT_SCOPE)
endfunction()



## https://gist.github.com/sivachandran/3a0de157dccef822a230#file-bin2h-cmake
# Function to embed contents of a file as byte array in C/C++ header file(.h). The header file
# will contain a byte array and integer variable holding the size of the array.
# Parameters
#   SOURCE_FILE     - The path of source file whose contents will be embedded in the header file.
#   VARIABLE_NAME   - The name of the variable for the byte array. The string "_SIZE" will be append
#                     to this name and will be used a variable name for size variable.
#   HEADER_FILE     - The path of header file.
#   APPEND          - If specified appends to the header file instead of overwriting it
#   NULL_TERMINATE  - If specified a null byte(zero) will be append to the byte array. This will be
#                     useful if the source file is a text file and we want to use the file contents
#                     as string. But the size variable holds size of the byte array without this
#                     null byte.
# Usage:
#   bin2h(SOURCE_FILE "Logo.png" HEADER_FILE "Logo.h" VARIABLE_NAME "LOGO_PNG")
function(BIN2H)
    set(options APPEND NULL_TERMINATE)
    set(oneValueArgs SOURCE_FILE VARIABLE_NAME HEADER_FILE)
    cmake_parse_arguments(BIN2H "${options}" "${oneValueArgs}" "" ${ARGN})
    # reads source file contents as hex string
    file(READ ${BIN2H_SOURCE_FILE} hexString HEX)
    string(LENGTH ${hexString} hexStringLength)
    # appends null byte if asked
    if(BIN2H_NULL_TERMINATE)
        set(hexString "${hexString}00")
    endif()
    # wraps the hex string into multiple lines at column 32(i.e. 16 bytes per line)
    ##wrap_string(VARIABLE hexString AT_COLUMN 32)
    math(EXPR arraySize "${hexStringLength} / 2")
    # adds '0x' prefix and comma suffix before and after every byte respectively
    ##string(REGEX REPLACE "([0-9a-f][0-9a-f])" "\\1" arrayValues ${hexString})
    # removes trailing comma
    ##string(REGEX REPLACE ", $" "" arrayValues ${arrayValues})
    # converts the variable name into proper C identifier
    string(MAKE_C_IDENTIFIER "${BIN2H_VARIABLE_NAME}" BIN2H_VARIABLE_NAME)
    string(TOUPPER "${BIN2H_VARIABLE_NAME}" BIN2H_VARIABLE_NAME)
    # declares byte array and the length variables
    set(arrayDefinition "std::string ${BIN2H_VARIABLE_NAME} = \"${hexString}\";")
    set(arraySizeDefinition "size_t ${BIN2H_VARIABLE_NAME}_SIZE = ${arraySize};")
    set(declarations "${arrayDefinition}\n\n${arraySizeDefinition}\n\n")
    if(BIN2H_APPEND)
        file(APPEND ${BIN2H_HEADER_FILE} "${declarations}")
    else()
        file(WRITE ${BIN2H_HEADER_FILE} "${declarations}")
    endif()
endfunction()
