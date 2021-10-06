if(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
	set(CMAKE_HOST_LINUX TRUE CACHE INTERNAL "")
endif()
set(dkdepend_disable_list "" CACHE INTERNAL "")


#####################################################################
###################         DKFUNCTIONS           ###################
#####################################################################
## TODO:    https://foonathan.net/2016/03/cmake-install/ 

## Example function that uses a result variable to retrun a value
# MyFunc("ABC" "123" 5 myResult)
# message(STATUS "return value = ${myResult}") # should print->  return value = ABC;123;5
function(MyFunc args result)
	set(args ${ARGV})
	list(GET args -1 result)
	list(REMOVE_AT args -1)
	#work with ${args} and set ${result} here
	set(${result} ${args} PARENT_SCOPE) #just relay the arguments
endfunction()


## Attempting to create dynamic functions
#function(CreateFunction name)
#	cmake_language(EVAL CODE "
#		function(${name}) 
#			DUMP(name)
#		endfunction()"
#	)
#endfunction()
#CreateFunction("Testies")
#Testies()


function(Wait)
	if(CMAKE_HOST_WIN32)	
		DKEXECUTE_PROCESS(echo press and key to continue && timeout /t 60 > nul WORKING_DIRECTORY C:/)
		return()
	endif()
	if(CMAKE_HOST_UNIX)
		execute_process(COMMAND bash -c "read -n 1 -s -r -p \"Press any key to continue\"" OUTPUT_VARIABLE outVar)
		#DKEXECUTE_PROCESS(read -n 1 -s -r -p "Press any key to continue" WORKING_DIRECTORY C:/)
		return()
	endif()	
	message(STATUS "Wait() Not implemented for this platform")
endfunction()


# WATCH( <variable_name> )
function(WATCH var)
	variable_watch(var varwatch)
endfunction()
function(varwatch var access val lst stack)
    message("Variable watch: var=${var} access=${access} val=${val} 1st=${1st} stack=${stack}")
	Wait()
endfunction()


# DUMP( <variable_name> )
function(DUMP dmpvar)
	message(STATUS "\n\n")
	message(STATUS "${dmpvar} = ${${dmpvar}}")
	if(NOT DEFINED ${dmpvar})
		message(STATUS "DUMP(${dmpvar}) variable not defined. The correct syntax is \"DUMP(varname)\", using the variable name")
		message(STATUS "DUMP(varname): CORRECT        DUMP(\${varname}): INCORRECT")
	endif()
	MESSAGE(status "\n\n")
	Wait()
endfunction()


function(dk_includes str substr result)
	#message(STATUS "dk_includes(${str} ${substr})")
	string(FIND "${str}" "${substr}" index)
	if(${index} GREATER -1)
		set(${result} true PARENT_SCOPE)
	else()
		set(${result} false PARENT_SCOPE)
	endif()
endfunction()


function(DKSET variable value)
	set(${variable} ${value} ${ARGN} CACHE INTERNAL "")
	#show library versions
	dk_includes(${variable} "_VERSION" result)
	if(${result})
		message(STATUS "${variable}: ${value}")
	endif()
endfunction()


function(DKUNSET variable)
	unset(${variable})
endfunction()


function(DELETE_CACHE)
	get_filename_component(DIGITALKNOB ${CMAKE_SOURCE_DIR} ABSOLUTE)
	message(STATUS "Deleteing CMake cache . . .")
	if(CMAKE_HOST_WIN32)
		# DKEXECUTE_PROCESS(for /r %i in (CMakeCache.*) do del "%i" WORKING_DIRECTORY ${DIGITALKNOB}) #does not work in batch files
        # DKEXECUTE_PROCESS(for /d /r %i in (*CMakeFiles*) do rmdir /s /Q "%i" WORKING_DIRECTORY ${DIGITALKNOB}) #does not work in batch files
		DKEXECUTE_PROCESS(for /r %%i in (CMakeCache.*) do del "%%i" WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i" WORKING_DIRECTORY ${DIGITALKNOB})
	else()
		DKEXECUTE_PROCESS(find . -name "CMakeCache.*" -delete WORKING_DIRECTORY ${DIGITALKNOB})
		DKEXECUTE_PROCESS(rm -rf `find . -type d -name CMakeFiles` WORKING_DIRECTORY ${DIGITALKNOB})
		# DKEXECUTE_PROCESS(find . -type d -name "CMakeFiles" -delete WORKING_DIRECTORY ${DIGITALKNOB}) #cannot delete non-empty directories
	endif()
endfunction()


function(DKSETENV name value)
	message(STATUS "DKSETENV(${name} ${value})")
	if(NOT "$ENV{${name}}" STREQUAL "${value}")
		if(CMAKE_HOST_WIN32)
			message(STATUS "Setting %${name}% environment variable to ${value}")
			#DKEXECUTE_PROCESS(setx ${name} ${value}) # https://stackoverflow.com/a/69246810
			DKEXECUTE_PROCESS(setx ${name} \"${value}\")
		else()
			message(STATUS "DKSETENV() not implemented on this system")
		endif()
	endif()
endfunction()


##https://cmake.org/pipermail/cmake/2012-September/052205.html/
function(DOWNLOAD url) # ARGV1 = dest_path
	#TODO: Let's supply the ability to add a primary root address to download from,  for fast downloading from local hard drives or storage 
	#      we will also add a "backup" root address to download from. In case one of the internet download fails.
	#      Also, we will treat the url variable like a list. If it has more one item, treat them as alternative download links
	if(NOT PrimaryDownloadServer)
		message(STATUS "TODO: just set PrimaryDownloadServer to your mirror location and all file downoads will attempt that location first")
	endif()
	if(NOT SecondaryDownloadServer)
		message(STATUS "TODO: just set SecondaryDownloadServer to your mirror location and all file downoads that fail will attempt secondary location next")
	endif()
	
	DKSET(CURRENT_DIR ${DKDOWNLOAD}) #set the default dl directory
	get_filename_component(src_filename ${url} NAME)
	if(${ARGC} GREATER 1)
		set(dest_path ${ARGV1})
		dk_getExtension(${dest_path} dest_ext)
		if(NOT dest_ext)
			message(STATUS "DKDOWNLOAD(): The destination path has no extension")
		else()
			message("extension = ${extension}")
		endif()
		if(IS_DIRECTORY ${dest_path})
			set(CURRENT_DIR ${dest_path})
		else()
			get_filename_component(dest_filename ${dest_path} NAME)
			get_filename_component(dest_dir ${dest_path} DIRECTORY)
			if(NOT dest_filename STREQUAL src_filename)
				#message("DKDOWNLOAD(${url}): The filenames are different")
				message("src_filename: ${src_filename}")
				message("dest_filename: ${dest_filename}")
				message("dest_dir: ${dest_dir}")
				#message(FATAL_ERROR "end")
			endif()
		endif()
	endif()
	if(NOT EXISTS ${CURRENT_DIR}/${dest_filename})
		message(STATUS "Downloading ${url}")
		message(STATUS "To -> ${CURRENT_DIR}/${dest_filename}")
		file(DOWNLOAD ${url} ${CURRENT_DIR}/${dest_filename} SHOW_PROGRESS 
			#no TIMEOUT
			STATUS status 
			#no LOG
		)
		list(GET status 0 status_code) 
		list(GET status 1 status_string)
		if(NOT status_code EQUAL 0)
			DKREMOVE(${CURRENT_DIR}/${dest_filename})
			message(FATAL_ERROR "error: downloading ${url} \n status_code: ${status_code} \n status_string: ${status_string}")
		else()
			message(STATUS "downloading... done")
		endif() 
	endif()
endfunction()


function(DKEXTRACT src dest)
	if(NOT EXISTS ${dest})
		dk_makeDirectory(${dest})
	endif()
	execute_process(COMMAND ${CMAKE_EXE} -E tar xvf ${src} WORKING_DIRECTORY ${dest})
endfunction()


function(DKZIP path)
	message(STATUS "Zipping: ${path}")
	if(NOT EXISTS ${path})
		message(FATAL_ERROR "ERROR: DKZIP(): the path ${path} does not exist")
	endif()
	execute_process(COMMAND ${CMAKE_EXE} -E tar "cfv" "${DKPROJECT}/assets.zip" --format=zip "." WORKING_DIRECTORY ${path}/)
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
					execute_process(COMMAND ${CMAKE_EXE} -E compare_files ${sourcefile} ${destinationfile} RESULT_VARIABLE compare_result)
					if(compare_result EQUAL 1)
						execute_process(COMMAND ${CMAKE_EXE} -E copy ${sourcefile} ${destinationfile})
						message(STATUS "COPIED: ${sourcefile} to ${destinationfile}")
					elseif(compare_result EQUAL 0)
						#message(STATUS "${sourcefile} No Copy, The files are identical.")
					else()
						message(WARNING "DKCOPY(${from} ${to} ${overwrite}): \n ERROR: compare_result = ${compare_result}")
					endif()
				elseif(NOT EXISTS ${destinationfile})
					execute_process(COMMAND ${CMAKE_EXE} -E copy ${sourcefile} ${destinationfile})
					message(STATUS "COPIED: ${sourcefile} to ${destinationfile}")
				endif()
			endforeach()
		else()
			if(overwrite)
				execute_process(COMMAND ${CMAKE_EXE} -E copy ${from} ${to})
				message(STATUS "COPIED: ${from} to ${to}")
			elseif(NOT EXISTS ${to})
				execute_process(COMMAND ${CMAKE_EXE} -E copy ${from} ${to})
				message(STATUS "COPIED: ${from} to ${to}")
			endif()
		endif()
	else()
		message(STATUS !WARNING! "DKCOPY(): The source path does not exist.\n (${from})\n")
	endif()
endfunction()


function(DKCOMPAREFILES fileA fileB)
	execute_process(COMMAND ${CMAKE_EXE} -E compare_files ${fileA} ${fileB} RESULT_VARIABLE compare_result)
	if(compare_result EQUAL 0)
		message(STATUS "The files are identical.")
	elseif(compare_result EQUAL 1)
		message(STATUS "The files are different.")
	else()
		message(STATUS "Error while comparing the files.")
	endif()
endfunction()


function(DKRENAME from to)
	message(STATUS "Renameing ${from} to ${to}")
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
			execute_process(COMMAND ${CMAKE_EXE} -E remove_directory ${path})
		else()
			execute_process(COMMAND ${CMAKE_EXE} -E remove ${path})
		endif()
	endif()
endfunction()


function(UPX_COMPRESS path)
	message(STATUS "UPX compressing ${path}...")
	message(STATUS "Please wait...")
	DKEXECUTE_PROCESS("${UPX_EXE} -9 -v ${path}")
endfunction()


function(DKENABLE plugin)
	if(NOT ${plugin})
		DKSET(${plugin} ON)
		DKSET(USE_${plugin} ON)
		DKDEFINE(USE_${plugin})
	endif()
endfunction()


function(DKDISABLE plugin)
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE} AND NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPROJECT}) # /DKCMake or /App directory only
		message(FATAL_ERROR "\n! WARNING !\n DKDISABLE() Can only be used from the DKCMake/DISABLED.cmake file. This is to avoid having disabled libraries hideing everywhere.\n")
	endif()
	DKUNSET(${plugin})
	DKUNSET(USE_${plugin})
	DKUNDEFINE(USE_${plugin})
	DKUNDEPEND(${plugin})
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
	if(NOT DKDEFINES_LIST)
		return()
	endif()
	list(REMOVE_ITEM DKDEFINES_LIST ${str})
	remove_definitions(-D${str})
endfunction()


function(DKINCLUDE path)
	list(FIND DKINCLUDES_LIST "${path}" index)
	if(${index} GREATER -1)
		return() ## If the include is already in the list, return.
	endif()
	#if(NOT EXISTS ${path})
	#	message(WARNING "Error in call to: DKINCLUDE(): the path ${path} does not exist") #sometimes the os directory won't exist yet
	#endif()
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


function(dk_makeDirectory path)
	message(STATUS "dk_makeDirectory(${path})")
	string(REPLACE "/" ";" path_list ${path})
	if(CMAKE_HOST_APPLE)
		file(MAKE_DIRECTORY ${path}) #FIXME: temporary fix for mac
	endif()
	foreach(item ${path_list})
		string(REPLACE "home" "/home" item ${item})
		#DUMP(item)
		if(path2)
			set(path2 "${path2}/${item}")
			if(NOT EXISTS ${path2})
				file(MAKE_DIRECTORY ${path2})
			endif()
		else()
			set(path2 "${item}")
		endif()
	endforeach()
endfunction()


function(dk_getDirectory path result)
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
		return() #no path dividers found
	endif()
	string(SUBSTRING ${path} 0 ${index} directory) 
    set(${result} ${directory} PARENT_SCOPE)
endfunction()

function(dk_getFilename path result)
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
		return() #no path dividers found
	endif()
	MATH(EXPR index "${index}+1")
	string(SUBSTRING ${path} ${index} -1 filename) 
    set(${result} ${filename} PARENT_SCOPE)
endfunction()

function(dk_getExtension path result)
	# WHY A NEW GET EXTENSION FUNCTION ?
	# get_filename_component(extension ${url} EXT)       #Gets the large part of the extension of everything after the first .
	# get_filename_component(extension ${url} LAST_EXT)  #LAST_EXT only available with cmake 3.14+ 
	# cmake_path(GET url EXTENSION LAST_ONLY extension)  #LAST_ONLY only available with cmake 3.19+
	string(FIND ${path} "." index REVERSE)
	if(${index} EQUAL -1)
		return() # no extension found
	endif()
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
	DKEXECUTE_PROCESS(ie4uinit.exe -ClearIconCache)
	##ie4uinit.exe -show   ##Windows 10
endfunction()

# For archive files such as libraries and assets, the arguments are:  The download src_path, the name of its _DKIMPORTS folder, The name given to the installed 3rdParty/folder  
# For executable files such as software amd IDE's the arguments are:  The download src_path, the name of the final name of the dl file, The installation path to check for installation.
function(DKINSTALL src_path import_path dest_path)
	message(STATUS "\n")
	message(STATUS "DKINSTALL(${src_path} ${import_path} ${dest_path})")
	message(STATUS "\n")
	string(TOLOWER ${import_path} import_path_lower)
	if(NOT ${import_path} STREQUAL ${import_path_lower})
		message(FATAL_ERROR "ERROR: 2nd parameter in DKINSTALL() (${import_path}) must be all lowercase")
	endif()
	if(NOT EXISTS ${DKIMPORTS}/${import_path})
		message(FATAL_ERROR "ERROR: 2nd parameter in DKINSTALL() (${DKIMPORTS}/${import_path}) does not exist")
	endif()
	if(EXISTS ${dest_path}/installed)
		message(STATUS "${import_path} installed")
		return()
	endif()
	message(STATUS "\n")
	message(STATUS "src_path: ${src_path}")
	dk_getDirectory(${src_path} src_directory)
	message(STATUS "src_directory: ${src_directory}")
	dk_getFilename(${src_path} src_filename)
	message(STATUS "src_filename: ${src_filename}")
	dk_getExtension(${src_filename} src_extension)
	message(STATUS "src_extension: ${src_extension}")
	message(STATUS "\n")
	message(STATUS "dest_path: ${dest_path}")
	dk_getDirectory(${dest_path} dest_directory)
	message(STATUS "dest_directory: ${dest_directory}")
	dk_getFilename(${dest_path} dest_filename)
	message(STATUS "dest_filename: ${dest_filename}")
	dk_getExtension(${dest_filename} dest_extension)
	message(STATUS "dest_extension: ${dest_extension}")
	message(STATUS "\n")
	dkSet(CURRENT_DIR ${DKDOWNLOAD})
	dk_makeDirectory(${DKDOWNLOAD})
	#rename src_filename to dest_filename + src_extension as we download to avoid duiplicate name conflicts
	dkSet(dl_filename "${dest_filename}${src_extension}")
	download(${src_path} ${dl_filename})
	dkset(FILETYPE "UNKNOWN")
	if(NOT ${src_extension} STREQUAL "")
		if(${src_extension} STREQUAL ".bz")
			DKSET(FILETYPE "Archive")
		endif()
		if(${src_extension} STREQUAL ".bz2")
			DKSET(FILETYPE "Archive")
		endif()
		if(${src_extension} STREQUAL ".exe")
			DKSET(FILETYPE "Executable")
		endif()
		if(${src_extension} STREQUAL ".gz")
			DKSET(FILETYPE "Archive")
		endif()
		if(${src_extension} STREQUAL ".js")
			DKSET(FILETYPE "Javascript")
		endif()
		if(${src_extension} STREQUAL ".rar")
			DKSET(FILETYPE "Archive")
		endif()
		if(${src_extension} STREQUAL ".tar")
			DKSET(FILETYPE "Archive")
		endif()
		if(${src_extension} STREQUAL ".xz")
			DKSET(FILETYPE "Archive")
		endif()
		if(${src_extension} STREQUAL ".zip")
			DKSET(FILETYPE "Archive")
		endif()
		if(${src_extension} STREQUAL ".AppImage")
			DKSET(FILETYPE "Executable")
		endif()
	endif()
	##If the file type is unknown, we'll still try to extract it like a compressed file anyway
	##It's better the have a chance at success.
	message(STATUS "The Downloaded file ${${dl_filename}} is a ${FILETYPE} file ${src_extension}")
	if(${FILETYPE} STREQUAL "UNKNOWN")
		DKSET(FILETYPE "Archive")
		message(STATUS "We will try to extract it in case it's an archive, but it may fail.")
	endif()

	if(${FILETYPE} STREQUAL "Archive")
		DKREMOVE(${DIGITALKNOB}/Download/UNZIPPED)
		DKEXTRACT(${DIGITALKNOB}/Download/${dl_filename} ${DIGITALKNOB}/Download/UNZIPPED)
		#We either have a root folder in /UNZIPPED, or multiple files without a root folder
		file(GLOB items RELATIVE "${DIGITALKNOB}/Download/UNZIPPED/" "${DIGITALKNOB}/Download/UNZIPPED/*")
		list(LENGTH items count)
		if(${count} GREATER 2) ##NOTE: This should be "${count} GREATER 1" but msys has a readme file in it next to the inner msys folder and that messes things up for more than 1
			#Zip extracted with no root folder, Rename UNZIPPED and move to 3rdParty
			DKRENAME(${DIGITALKNOB}/Download/UNZIPPED ${dest_path})
		else()
			if(EXISTS ${DIGITALKNOB}/Download/UNZIPPED/${dest_filename}) ##Zip extracted to expected folder. Move the folder to 3rdParty
				DKRENAME(${DIGITALKNOB}/Download/UNZIPPED/${dest_filename} ${dest_path})
				DKREMOVE(${DIGITALKNOB}/Download/UNZIPPED)
			else() #Zip extracted to a root folder, but not named what we expected. Rename and move folder to 3rdParty
				foreach(item ${items})
					if(NOT IS_DIRECTORY ${DIGITALKNOB}/Download/UNZIPPED/${item})
						list(REMOVE_ITEM items ${item}) #remove any readme.txt or other non-directory items
					endif()
				endforeach()
				DKRENAME(${DIGITALKNOB}/Download/UNZIPPED/${items} ${dest_path})
				DKREMOVE(${DIGITALKNOB}/Download/UNZIPPED)
			endif() 
		endif()
	#elseif(${FILETYPE} STREQUAL "Executable")
	#	DKSETPATH(${DIGITALKNOB}/Download)
	#	DKSET(QUEUE_BUILD ON)
	#	DKEXECUTE(${DIGITALKNOB}/Download/${src_filename})
	else() #NOT ARCHIVE, just copy the file into it's 3rdParty folder
		DKCOPY(${DIGITALKNOB}/Download/${dl_filename} ${dest_path}/${dl_filename} TRUE)
	endif()
	if("${ARGN}" STREQUAL "NOPATCH")
		message(STATUS "\n ** DKINSTALL has requested a NOPATCH to the install files. The install may not work. Please review ** \n")
	else()
		message(STATUS "COPYING PATCH FILES FROM _IMPORTS/${import_path} TO COMPLETE INSTALL.")
		message(STATUS "To stop patch files from overwrites install files, add a \"NOPATCH\" argument to the end of the DKINSTALL command")
		DKCOPY(${DKIMPORTS}/${import_path}/ ${dest_path}/ TRUE)
	endif()
	file(WRITE ${dest_path}/installed "${dest_filename}")
endfunction()

function(dk_validatePath path result)
	get_filename_component(path ${path} ABSOLUTE)
	set(${result} ${path} PARENT_SCOPE)
endfunction()

function(dk_getShortPath path result)
	if(CMAKE_HOST_WIN32)
		execute_process(COMMAND ${DKCMAKE}/getShortPath.cmd ${path} OUTPUT_VARIABLE path WORKING_DIRECTORY ${DIGITALKNOB})
		string(REPLACE "\\" "/" path ${path})
		string(REPLACE "\n" "" path ${path})
		set(${result} ${path} PARENT_SCOPE)
	endif()
endfunction()

function(DKEXECUTE_PROCESS fullcmnd)
	#math(EXPR index "${ARGC}-1")
	#list(GET ARGV ${index} CDIR)
	message(STATUS "")
	message(STATUS "*** Commands ***")
	##message(STATUS ">  cd ${CDIR}")
	set(cmnd ${fullcmnd} ${ARGN})
	#string(REPLACE "COMMAND" "" var2 "${cmnd}")
	#string(REPLACE "command" "" var3 "${var2}")
	#string(REPLACE "WORKING_DIRECTORY" " " var4 "${var3}")
	#string(REPLACE "working_directory" " " var5 "${var4}")
	#string(REPLACE "${CDIR}" " " var6 "${var5}")
	#string(REPLACE ";" " " cmndstr "${var6}")
	#message(STATUS "> ${cmndstr}")
	message(STATUS "> ${cmnd}")
	message(STATUS "")
	if(CMAKE_HOST_WIN32)
		execute_process(COMMAND cmd /c ${cmnd} RESULT_VARIABLE result)
	else()
		execute_process(COMMAND ${cmnd} RESULT_VARIABLE result)
	endif()
	if(NOT ${result} EQUAL 0)
		if(CMAKE_HOST_WIN32)
			execute_process(COMMAND timeout /t 2 /nobreak OUTPUT_QUIET WORKING_DIRECTORY ${DIGITALKNOB}) ##wait 2 seconds for the stdout to flush before printing error
		else()
			execute_process(COMMAND sleep 2 WORKING_DIRECTORY ${DIGITALKNOB}) ##wait for unix
		endif()
		message(FATAL_ERROR "\n\n *** DKEXECUTE_PROCESS(${fullcmnd}): -> returned ${result} *** \n\n")
	endif()
endfunction()

###############################################################
#############   Platform specific functions  ##################
###############################################################

####################### DKSET ###########
# FIXME: These set functions are mixing and matching Host vs Target.   the style should follow WIN64HOST_SET and WIN64_SET patterns 
function(WIN_DKSET)
	if(CMAKE_HOST_WIN32)
		DKSET(${ARGV})
	endif()
endfunction()

function(WIN32_DKSET)
	if(WIN_32)
		WIN_DKSET(${ARGV})
	endif()
endfunction()

function(WIN64_DKSET)
	if(WIN_64)
		WIN_DKSET(${ARGV})
	endif()
endfunction()

function(MAC_DKSET)
	if(CMAKE_HOST_APPLE)
		DKSET(${ARGV})
	endif()
endfunction()

function(MAC32_DKSET)
	if(MAC_32)
		MAC_DKSET(${ARGV})
	endif()
endfunction()

function(MAC64_DKSET)
	if(MAC_64)
		MAC_DKSET(${ARGV})
	endif()
endfunction()

function(LINUX_DKSET)
	if(CMAKE_HOST_LINUX)
		DKSET(${ARGV})
	endif()
endfunction()

function(LINUX32_DKSET)
	if(LINUX_32)
		LINUX_DKSET(${ARGV})
	endif()
endfunction()

function(LINUX64_DKSET)
	if(LINUX_64)
		LINUX_DKSET(${ARGV})
	endif()
endfunction()

function(RASPBERRY_DKSET)
	if(CMAKE_HOST_LINUX)
		DKSET(${ARGV})
	endif()
endfunction()

function(RASPBERRY32_DKSET)
	if(RASPBERRY_32)
		RASPBERRY_DKSET(${ARGV})
	endif()
endfunction()

function(RASPBERRY64_DKSET)
	if(RASPBERRY_64)
		RASPBERRY_DKSET(${ARGV})
	endif()
endfunction()

###################### DK_PATH ####################
function(DKSETPATH path)
	if(path STREQUAL "OFF")
		return() 
	endif()	
	DKSET(CURRENT_DIR ${path})
	if(NOT EXISTS ${CURRENT_DIR})
		dk_makeDirectory(${CURRENT_DIR})
	endif()
endfunction()

#######################
function(WIN_PATH path)
	if(WIN)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(WIN_DEBUG_PATH)
	if(WIN AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(WIN_RELEASE_PATH)
	if(WIN AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(WIN32_PATH)
	if(WIN_32)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(WIN32_DEBUG_PATH)
	if(WIN_32 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(WIN32_RELEASE_PATH)
	if(WIN_32 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(WIN64_PATH)
	if(WIN_64)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(WIN64_DEBUG_PATH)
	if(WIN_64 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(WIN64_RELEASE_PATH)
	if(WIN_64 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(MAC_PATH)
	if(MAC)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(MAC_DEBUG_PATH)
	if(MAC AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(MAC_RELEASE_PATH)
	if(MAC AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(MAC32_PATH)
	if(MAC_32)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(MAC32_DEBUG_PATH)
	if(MAC_32 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(MAC32_RELEASE_PATH)
	if(MAC_32 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(MAC64_PATH)
	if(MAC_64)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(MAC64_DEBUG_PATH)
	if(MAC_64 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(MAC64_RELEASE_PATH)
	if(MAC_64 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOS_PATH)
	if(IOS)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOS_DEBUG_PATH)
	if(IOS AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOS_RELEASE_PATH)
	if(IOS AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOS32_PATH)
	if(IOS_32)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOS32_DEBUG_PATH)
	if(IOS_32 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOS32_RELEASE_PATH)
	if(IOS_32 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOS64_PATH)
	if(IOS_64)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOS64_DEBUG_PATH)
	if(IOS_64 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOS64_RELEASE_PATH)
	if(IOS_64 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOSSIM_PATH)
	if(IOSSIM)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOSSIM_DEBUG_PATH)
	if(IOSSIM AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOSSIM_RELEASE_PATH)
	if(IOSSIM AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOSSIM32_PATH)
	if(IOSSIM_32)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOSSIM32_DEBUG_PATH)
	if(IOSSIM_32 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOSSIM32_RELEASE_PATH)
	if(IOSSIM_32 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOSSIM64_PATH)
	if(IOSSIM_64)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOSSIM64_DEBUG_PATH)
	if(IOSSIM_64 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(IOSSIM64_RELEASE_PATH)
	if(IOSSIM_64 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(LINUX_PATH)
	if(LINUX)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(LINUX_DEBUG_PATH)
	if(LINUX AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(LINUX_RELEASE_PATH)
	if(LINUX AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(LINUX32_PATH)
	if(LINUX_32)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(LINUX32_DEBUG_PATH)
	if(LINUX_32 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(LINUX32_RELEASE_PATH)
	if(LINUX_32 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(LINUX64_PATH)
	if(LINUX_64)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(LINUX64_DEBUG_PATH)
	if(LINUX_64 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(LINUX64_RELEASE_PATH)
	if(LINUX_64 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(ANDROID_PATH)
	if(ANDROID)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(ANDROID_DEBUG_PATH)
	if(ANDROID AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(ANDROID_RELEASE_PATH)
	if(ANDROID AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(ANDROID32_PATH)
	if(ANDROID_32)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(ANDROID32_DEBUG_PATH)
	if(ANDROID_32 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(ANDROID32_RELEASE_PATH)
	if(ANDROID_32 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(ANDROID64_PATH)
	if(ANDROID_64)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(ANDROID64_DEBUG_PATH)
	if(ANDROID_64 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(ANDROID64_RELEASE_PATH)
	if(ANDROID_64 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(RASPBERRY_PATH)
	if(RASPBERRY)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(RASPBERRY_DEBUG_PATH)
	if(RASPBERRY AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(RASPBERRY_RELEASE_PATH)
	if(RASPBERRY AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(RASPBERRY32_PATH)
	if(RASPBERRY_32)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(RASPBERRY32_DEBUG_PATH)
	if(RASPBERRY_32 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(RASPBERRY32_RELEASE_PATH)
	if(RASPBERRY_32 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(RASPBERRY64_PATH)
	if(RASPBERRY_64)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(RASPBERRY64_DEBUG_PATH)
	if(RASPBERRY_64 AND DEBUG)
		DKSETPATH(${ARGV})
	endif()
endfunction()

function(RASPBERRY64_RELEASE_PATH)
	if(RASPBERRY_64 AND RELEASE)
		DKSETPATH(${ARGV})
	endif()
endfunction()

###################  BASH  ######################
function(WIN_BASH str)
	if(WIN AND QUEUE_BUILD)
		string(REPLACE ":/" "/" str ${str})
		file(WRITE ${MSYS}/dkscript.tmp ${str})
		message(STATUS "BASH -> ${str}")
		execute_process(COMMAND cmd /c ${MSYS}/bin/bash ${MSYS}/dkscript.tmp WORKING_DIRECTORY ${MSYS})
	endif()
endfunction()

function(WIN_DEBUG_BASH str)
	if(WIN AND DEBUG)
		WIN_BASH(${str})
	endif()
endfunction()

function(WIN_RELEASE_BASH str)
	if(WIN AND RELEASE)
		WIN_BASH(${str})
	endif()
endfunction()


function(WIN32_BASH str)
	if(WIN_32)
		WIN_BASH(${str})
	endif()
endfunction()


function(WIN32_DEBUG_BASH str)
	if(WIN_32 AND DEBUG)
		WIN_BASH(${str})
	endif()
endfunction()


function(WIN32_RELEASE_BASH str)
	if(WIN_32 AND RELEASE)
		WIN_BASH(${str})
	endif()
endfunction()


function(WIN64_BASH str)
	if(WIN_64)
		WIN_BASH(${str})
	endif()
endfunction()


function(WIN64_DEBUG_BASH str)
	if(WIN_64 AND DEBUG)
		WIN_BASH(${str})
	endif()
endfunction()


function(WIN64_RELEASE_BASH str)
	if(WIN_64 AND RELEASE)
		WIN_BASH(${str})
	endif()
endfunction()


function(ANDROID_BASH str)
	if(ANDROID AND QUEUE_BUILD)
		string(REPLACE ":/" "/" str ${str})
		file(WRITE ${MSYS}/dkscript.tmp ${str})
		message(STATUS "BASH-> ${str}")
		DKEXECUTE_PROCESS(${MSYS}/bin/bash ${MSYS}/dkscript.tmp WORKING_DIRECTORY ${MSYS})
	endif()
endfunction()


function(ANDROID32_BASH str)
	if(ANDROID_32)
		set(str ${str} ${ARGN})
		ANDROID_BASH(${str})
	endif()
endfunction()


function(ANDROID64_BASH str)
	if(ANDROID_64)
		set(str ${str} ${ARGN})
		ANDROID_BASH(${str})
	endif()
endfunction()


################### COMMAND ########################
function(DKMERGE_FLAGS args result)
	set(args ${args} ${result} ${ARGN})
	list(GET args -1 result)
	list(REMOVE_AT args -1)
	
	#work with ${args} and set ${result} here
	set(search "-DCMAKE_C_FLAGS=" "-DCMAKE_C_FLAGS_DEBUG=" "-DCMAKE_C_FLAGS_RELEASE=" "-DCMAKE_CXX_FLAGS=" "-DCMAKE_CXX_FLAGS_DEBUG=" "-DCMAKE_CXX_FLAGS_RELEASE=")
	foreach(word ${search})
		set(DK_${word} "${word}")
		set(index 0)
		set(placeholder 0)
		foreach(arg ${args})
			math(EXPR index "${index}+1")
			string(FIND ${arg} ${word} hasWord)
			if(${hasWord} GREATER -1)
				if(${placeholder} EQUAL 0)
					math(EXPR placeholder "${index}-1")
					#set(placeholder ${index})
				endif()				
				list(REMOVE_ITEM args ${arg})
				string(REPLACE ${word} "" arg ${arg})
				set(DK_${word} "${DK_${word}}${arg} ")
			endif()
		endforeach()
		if(${placeholder} GREATER 0)
			list(INSERT args ${placeholder} "${DK_${word}}")
		endif()
	endforeach()
	set(${result} ${args} PARENT_SCOPE)
endfunction()


function(DKCOMMAND)
	DKMERGE_FLAGS(${ARGV} merged_args)
	if(CMAKE_HOST_WIN32)
		DKEXECUTE_PROCESS(${merged_args} WORKING_DIRECTORY ${CURRENT_DIR})
	endif()
	if(CMAKE_HOST_APPLE)
		DKEXECUTE_PROCESS(${merged_args} WORKING_DIRECTORY ${CURRENT_DIR})
	endif()
	if(CMAKE_HOST_LINUX)
		DKEXECUTE_PROCESS(${merged_args} WORKING_DIRECTORY ${CURRENT_DIR})
	endif()
endfunction()


#####################
function(WIN_COMMAND)
	if(WIN AND QUEUE_BUILD)
		DKCOMMAND(${ARGV})
	endif()	
endfunction()


function(WIN32_COMMAND)
	if(WIN_32)
		WIN_COMMAND(${ARGV})
	endif()	
endfunction()


function(WIN32_DEBUG_COMMAND)
	if(WIN_32 AND DEBUG)
		WIN_COMMAND(${ARGV})
	endif()	
endfunction()


function(WIN32_RELEASE_COMMAND)
	if(WIN_32 AND RELEASE)
		WIN_COMMAND(${ARGV})
	endif()	
endfunction()


function(WIN64_COMMAND)
	if(WIN_64)
		WIN_COMMAND(${ARGV})
	endif()
endfunction()


function(WIN64_DEBUG_COMMAND)
	if(WIN_64 AND DEBUG)
		WIN_COMMAND(${ARGV})
	endif()	
endfunction()


function(WIN64_RELEASE_COMMAND)
	if(WIN_64 AND RELEASE)
		WIN_COMMAND(${ARGV})
	endif()	
endfunction()


#####################
function(MAC_COMMAND)
	if(MAC AND QUEUE_BUILD)
		DKCOMMAND(${ARGV})
	endif()
endfunction()


function(MAC_DEBUG_COMMAND)
	if(MAC AND DEBUG)
		MAC_COMMAND(${ARGV})
	endif()
endfunction()


function(MAC_RELEASE_COMMAND)
	if(MAC AND RELEASE)
		MAC_COMMAND(${ARGV})
	endif()
endfunction()


function(MAC32_COMMAND)
	if(MAC_32)
		MAC_COMMAND(${ARGV})
	endif()
endfunction()


function(MAC32_DEBUG_COMMAND)
	if(MAC_32 AND DEBUG)
		MAC_COMMAND(${ARGV})
	endif()
endfunction()


function(MAC32_RELEASE_COMMAND)
	if(MAC_32 AND RELEASE)
		MAC_COMMAND(${ARGV})
	endif()
endfunction()


function(MAC64_COMMAND)
	if(MAC_64)
		MAC_COMMAND(${ARGV})
	endif()
endfunction()


function(MAC64_DEBUG_COMMAND)
	if(MAC_64 AND DEBUG)
		MAC_COMMAND(${ARGV})
	endif()
endfunction()


function(MAC64_RELEASE_COMMAND)
	if(MAC_64 AND RELEASE)
		MAC_COMMAND(${ARGV})
	endif()
endfunction()


#####################
function(IOS_COMMAND)
	if(IOS AND QUEUE_BUILD)
		DKCOMMAND(${ARGV})
	endif()
endfunction()


function(IOS_DEBUG_COMMAND)
	if(IOS AND DEBUG)
		IOS_COMMAND(${ARGV})
	endif()
endfunction()


function(IOS_RELEASE_COMMAND)
	if(IOS AND RELEASE)
		IOS_COMMAND(${ARGV})
	endif()
endfunction()


function(IOS32_COMMAND)
	if(IOS_32)
		IOS_COMMAND(${ARGV})
	endif()
endfunction()


function(IOS64_COMMAND)
	if(IOS_64)
		IOS_COMMAND(${ARGV})
	endif()
endfunction()


########################
function(IOSSIM_COMMAND)
	if(IOSSIM AND QUEUE_BUILD)
		DKCOMMAND(${ARGV})
	endif()
endfunction()


function(IOSSIM_DEBUG_COMMAND)
	if(IOSSIM AND DEBUG)
		IOSSIM_COMMAND(${ARGV})
	endif()
endfunction()


function(IOSSIM_RELEASE_COMMAND)
	if(IOSSIM AND RELEASE)
		IOSSIM_COMMAND(${ARGV})
	endif()
endfunction()


function(IOSSIM32_COMMAND)
	if(IOSSIM_32)
		IOSSIM_COMMAND(${ARGV})
	endif()
endfunction()


function(IOSSIM64_COMMAND)
	if(IOSSIM_64)
		IOSSIM_COMMAND(${ARGV})
	endif()
endfunction()


#######################
function(LINUX_COMMAND)
	if(LINUX AND QUEUE_BUILD)
		DKCOMMAND(${ARGV})
	endif()
endfunction()


function(LINUX_DEBUG_COMMAND)
	if(LINUX AND DEBUG)
		LINUX_COMMAND(${ARGV})
	endif()
endfunction()


function(LINUX_RELEASE_COMMAND)
	if(LINUX AND RELEASE)
		LINUX_COMMAND(${ARGV})
	endif()
endfunction()


function(LINUX32_COMMAND)
	if(LINUX_32)
		LINUX_COMMAND(${ARGV})
	endif()
endfunction()


function(LINUX32_DEBUG_COMMAND)
	if(LINUX_32 AND DEBUG)
		LINUX_COMMAND(${ARGV})
	endif()
endfunction()


function(LINUX32_RELEASE_COMMAND)
	if(LINUX_32 AND RELEASE)
		LINUX_COMMAND(${ARGV})
	endif()
endfunction()


function(LINUX64_COMMAND)
	if(LINUX_64)
		LINUX_COMMAND(${ARGV})
	endif()
endfunction()


function(LINUX64_DEBUG_COMMAND)
	if(LINUX_64 AND DEBUG)
		LINUX_COMMAND(${ARGV})
	endif()
endfunction()


function(LINUX64_RELEASE_COMMAND)
	if(LINUX_64 AND RELEASE)
		LINUX_COMMAND(${ARGV})
	endif()
endfunction()


###########################
function(RASPBERRY_COMMAND)
	if(RASPBERRY AND QUEUE_BUILD)
		DKCOMMAND(${ARGV})
	endif()
endfunction()


function(RASPBERRY_DEBUG_COMMAND)
	if(RASPBERRY AND DEBUG)
		RASPBERRY_COMMAND(${ARGV})
	endif()
endfunction()


function(RASPBERRY_RELEASE_COMMAND)
	if(RASPBERRY AND RELEASE)
		RASPBERRY_COMMAND(${ARGV})
	endif()
endfunction()


function(RASPBERRY32_COMMAND)
	if(RASPBERRY_32)
		RASPBERRY_COMMAND(${ARGV})
	endif()
endfunction()


function(RASPBERRY32_DEBUG_COMMAND)
	if(RASPBERRY_32 AND DEBUG)
		RASPBERRY_COMMAND(${ARGV})
	endif()
endfunction()


function(RASPBERRY32_RELEASE_COMMAND)
	if(RASPBERRY_32 AND RELEASE)
		RASPBERRY_COMMAND(${ARGV})
	endif()
endfunction()


function(RASPBERRY64_COMMAND)
	if(RASPBERRY_64)
		RASPBERRY_COMMAND(${ARGV})
	endif()
endfunction()


function(RASPBERRY64_DEBUG_COMMAND)
	if(RASPBERRY_64 AND DEBUG)
		RASPBERRY_COMMAND(${ARGV})
	endif()
endfunction()


function(RASPBERRY64_RELEASE_COMMAND)
	if(RASPBERRY_64 AND RELEASE)
		RASPBERRY_COMMAND(${ARGV})
	endif()
endfunction()


function(ANDROID_COMMAND)
	if(ANDROID AND QUEUE_BUILD)
		DKCOMMAND(${ARGV})
	endif()
endfunction()


function(ANDROID_DEBUG_COMMAND)
	if(ANDROID AND DEBUG)
		ANDROID_COMMAND(${ARGV})
	endif()
endfunction()


function(ANDROID_RELEASE_COMMAND)
	if(ANDROID AND RELEASE)
		ANDROID_COMMAND(${ARGV})
	endif()
endfunction()


function(ANDROID32_COMMAND)
	if(ANDROID_32)
		ANDROID_COMMAND(${ARGV})
	endif()
endfunction()


function(ANDROID32_DEBUG_COMMAND)
	if(ANDROID_32 AND DEBUG)
		ANDROID_COMMAND(${ARGV})
	endif()
endfunction()


function(ANDROID32_RELEASE_COMMAND)
	if(ANDROID_32 AND RELEASE)
		ANDROID_COMMAND(${ARGV})
	endif()
endfunction()


function(ANDROID64_COMMAND)
	if(ANDROID_64)
		ANDROID_COMMAND(${ARGV})
	endif()
endfunction()


function(ANDROID64_DEBUG_COMMAND)
	if(ANDROID_64 AND DEBUG)
		ANDROID_COMMAND(${ARGV})
	endif()
endfunction()


function(ANDROID64_RELEASE_COMMAND)
	if(ANDROID_64 AND RELEASE)
		ANDROID_COMMAND(${ARGV})
	endif()
endfunction()


##################### MinGW Build ####################
function(WIN_MINGW_DEBUG arg arg2)
	if(WIN AND DEBUG AND QUEUE_BUILD)
		#TODO
	endif()
endfunction()



################# Visual Studio Build ################
function(WIN_VS_DEBUG folder sln_file)
	if(WIN AND DEBUG AND QUEUE_BUILD)
		if(NOT EXISTS ${3RDPARTY}/${folder}/${OS}/${sln_file})
			message(FATAL_ERROR "CANNOT FIND: ${3RDPARTY}/${folder}/${OS}/${sln_file}" )
		endif()
		#DKEXECUTE_PROCESS("set _CL_=/MTd" WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		if(${ARGC} GREATER 2)
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV2} /p:Configuration=Debug)
		else()
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /p:Configuration=Debug)
		endif()
		DKEXECUTE_PROCESS(${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
	endif()
endfunction()

function(WIN_VS_RELEASE folder sln_file)
	if(WIN AND RELEASE AND QUEUE_BUILD)
		if(NOT EXISTS ${3RDPARTY}/${folder}/${OS}/${sln_file})
			message(FATAL_ERROR "CANNOT FIND: ${3RDPARTY}/${folder}/${OS}/${sln_file}" )
		endif()
		#DKEXECUTE_PROCESS("set _CL_=/MT" WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		if(${ARGC} GREATER 2)
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV2} /p:Configuration=Release)
		else()
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /p:Configuration=Release)
		endif()
		DKEXECUTE_PROCESS(${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
	endif()
endfunction()


function(WIN_VS)
	if(WIN)
		WIN_VS_DEBUG(${ARGV})
		WIN_VS_RELEASE(${ARGV})
	endif()
endfunction()


function(WIN32_VS_DEBUG)
	if(WIN_32)
		WIN_VS_DEBUG(${ARGV})
	endif()
endfunction()


function(WIN32_VS_RELEASE)
	if(WIN_32)
		WIN_VS_RELEASE(${ARGV})
	endif()
endfunction()


function(WIN32_VS)
	if(WIN_32)
		WIN_VS_DEBUG(${ARGV})
		WIN_VS_RELEASE(${ARGV})
	endif()
endfunction()


function(WIN64_VS_DEBUG)
	if(WIN_64)
		WIN_VS_DEBUG(${ARGV})
	endif()
endfunction()


function(WIN64_VS_RELEASE)
	if(WIN_64)
		WIN_VS_RELEASE(${ARGV})
	endif()
endfunction()


function(WIN64_VS)
	if(WIN64)
		WIN_VS_DEBUG(${ARGV})
		WIN_VS_RELEASE(${ARGV})
	endif()
endfunction()


function(ANDROID_VS_DEBUG folder sln_file)
	if(ANDROID AND DEBUG AND QUEUE_BUILD)
		if(NOT EXISTS ${3RDPARTY}/${folder}/${OS}/${sln_file})
			message(FATAL_ERROR "CANNOT FIND: ${3RDPARTY}/${folder}/${OS}/${sln_file}" )
		endif()

		
		if(${ARGC} GREATER 2)
			
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV2} /p:Configuration=Debug)
		else()
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /p:Configuration=Debug)
		endif()
		DKEXECUTE_PROCESS(${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
	endif()
endfunction()


function(ANDROID_VS_RELEASE folder sln_file)
	if(ANDROID AND RELEASE AND QUEUE_BUILD)
		if(NOT EXISTS ${3RDPARTY}/${folder}/${OS}/${sln_file})
			message(FATAL_ERROR "CANNOT FIND: ${3RDPARTY}/${folder}/${OS}/${sln_file}" )
		endif()

		
		if(${ARGC} GREATER 2)
			
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /t:${ARGV2} /p:Configuration=Release)
		else()
			set(EXECUTE_COMMAND ${MSBUILD} ${3RDPARTY}/${folder}/${OS}/${sln_file} /p:Configuration=Release)
		endif()
		DKEXECUTE_PROCESS(${EXECUTE_COMMAND} WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
	endif()
endfunction()


function(ANDROID_VS)
	if(ANDROID)
		ANDROID_VS_DEBUG(${ARGV})
		ANDROID_VS_RELEASE(${ARGV})
	endif()
endfunction()


function(ANDROID32_VS_DEBUG)
	if(ANDROID_32)
		ANDROID_VS_DEBUG(${ARGV})
	endif()
endfunction()


function(ANDROID32_VS_RELEASE)
	if(ANDROID_32)
		ANDROID_VS_RELEASE(${ARGV})
	endif()
endfunction()


function(ANDROID32_VS)
	if(ANDROID_32)
		ANDROID_VS_DEBUG(${ARGV})
		ANDROID_VS_RELEASE(${ARGV})
	endif()
endfunction()


function(ANDROID64_VS_DEBUG)
	if(ANDROID_64)
		ANDROID_VS_DEBUG(${ARGV})
	endif()
endfunction()


function(ANDROID64_VS_RELEASE)
	if(ANDROID_64)
		ANDROID_VS_RELEASE(${ARGV})
	endif()
endfunction()


function(ANDROID64_VS)
	if(ANDROID64)
		ANDROID_VS_DEBUG(${ARGV})
		ANDROID_VS_RELEASE(${ARGV})
	endif()
endfunction()


################### Xcode Build ###################
function(MAC_XCODE_DEBUG folder)
	if(MAC AND DEBUG AND QUEUE_BUILD)
		if(${ARGC} GREATER 1)
			DKEXECUTE_PROCESS(xcodebuild -target ${ARGV1} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		else()
			DKEXECUTE_PROCESS(xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		endif()
	endif()
endfunction()


function(MAC_XCODE_RELEASE folder)
	if(MAC AND RELEASE AND QUEUE_BUILD)
		
		if(${ARGC} GREATER 1)
			
			DKEXECUTE_PROCESS(xcodebuild -target ${ARGV1} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		else()
			DKEXECUTE_PROCESS(xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		endif()
	endif()
endfunction()


function(MAC_XCODE)
	if(MAC)
		MAC_XCODE_DEBUG(${ARGV})
		MAC_XCODE_RELEASE(${ARGV})
	endif()
endfunction()


function(MAC32_XCODE_DEBUG)
	if(MAC_32)
		MAC_XCODE_DEBUG(${ARGV})
	endif()
endfunction()


function(MAC32_XCODE_RELEASE)
	if(MAC_32)
		MAC_XCODE_RELEASE(${ARGV})
	endif()
endfunction()


function(MAC64_XCODE_DEBUG)
	if(MAC_64)
		MAC_XCODE_DEBUG(${ARGV})
	endif()
endfunction()


function(MAC64)
	if(MAC_64)
		MAC_XCODE_RELEASE(${ARGV})
	endif()
endfunction()


function(IOS_XCODE_DEBUG folder)
	if(IOS AND DEBUG AND QUEUE_BUILD)

		
		if(${ARGC} GREATER 1)
			
			DKEXECUTE_PROCESS(xcodebuild -target ${ARGV1} -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		else()
			DKEXECUTE_PROCESS(xcodebuild -configuration Debug build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		endif()
	endif()
endfunction()


function(IOS_XCODE_RELEASE folder)
	if(IOS AND RELEASE AND QUEUE_BUILD)

		
		if(${ARGC} GREATER 1)
			
			DKEXECUTE_PROCESS(xcodebuild -target ${ARGV1} -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		else()
			DKEXECUTE_PROCESS(xcodebuild -configuration Release build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		endif()
	endif()
endfunction()


function(IOS_XCODE)
	if(IOS)
		IOS_XCODE_DEBUG(${ARGV})
		IOS_XCODE_RELEASE(${ARGV})
	endif()
endfunction()


function(IOS32_XCODE_DEBUG)
	if(IOS_32)
		IOS_XCODE_DEBUG(${ARGV})
	endif()
endfunction()


function(IOS32_XCODE_RELEASE)
	if(IOS_32)
		IOS_XCODE_RELEASE(${ARGV})
	endif()
endfunction()


function(IOS64_XCODE_DEBUG)
	if(IOS_64)
		IOS_XCODE_DEBUG(${ARGV})
	endif()
endfunction()


function(IOS64_XCODE_RELEASE)
	if(IOS64)
		IOS_XCODE_RELEASE(${ARGV})
	endif()
endfunction()


function(IOSSIM_XCODE_DEBUG folder)
	if(IOSSIM AND DEBUG AND QUEUE_BUILD)

		
		if(${ARGC} GREATER 1)
			
			DKEXECUTE_PROCESS(xcodebuild -target ${ARGV1} -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		else()
			DKEXECUTE_PROCESS(xcodebuild -configuration Debug build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		endif()
	endif()
endfunction()


function(IOSSIM_XCODE_RELEASE folder)
	if(IOSSIM AND RELEASE AND QUEUE_BUILD)

		
		if(${ARGC} GREATER 1)
			
			DKEXECUTE_PROCESS(xcodebuild -target ${ARGV1} -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		else()
			DKEXECUTE_PROCESS(xcodebuild -configuration Release build -sdk iphonesimulator11.2 WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS})
		endif()
	endif()
endfunction()


function(IOSSIM_XCODE)
	if(IOSSIM)
		IOSSIM_XCODE_DEBUG(${ARGV})
		IOSSIM_XCODE_RELEASE(${ARGV})
	endif()
endfunction()


function(IOSSIM32_XCODE_DEBUG)
	if(IOSSIM_32)
		IOSSIM_XCODE_DEBUG(${ARGV})
	endif()
endfunction()


function(IOSSIM32_XCODE_RELEASE)
	if(IOSSIM_32)
		IOSSIM_XCODE_RELEASE(${ARGV})
	endif()
endfunction()


function(IOSSIM64_XCODE_DEBUG)
	if(IOSSIM_64)
		IOSSIM_XCODE_DEBUG(${ARGV})
	endif()
endfunction()


function(IOSSIM64_XCODE_RELEASE)
	if(IOSSIM_64)
		IOSSIM_XCODE_RELEASE(${ARGV})
	endif()
endfunction()


####################### Android NDK Build #################
function(ANDROID_NDK_DEBUG folder)
	if(ANDROID AND DEBUG AND QUEUE_BUILD)
		if(CMAKE_HOST_WIN32)
			DKEXECUTE_PROCESS(${ANDROIDNDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Debug)
		endif()
		if(CMAKE_HOST_UNIX)
			DKEXECUTE_PROCESS(${ANDROIDNDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Debug)
		endif()
	endif()
endfunction()


function(ANDROID_NDK_RELEASE folder)
	if(ANDROID AND RELEASE AND QUEUE_BUILD)
		if(CMAKE_HOST_WIN32)
			DKEXECUTE_PROCESS(${ANDROIDNDK}/ndk-build.cmd WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Release)
		endif()
		if(CMAKE_HOST_UNIX)
			DKEXECUTE_PROCESS(${ANDROIDNDK}/ndk-build WORKING_DIRECTORY ${3RDPARTY}/${folder}/${OS}/Release)
		endif()
	endif()
endfunction()


function(ANDROID_NDK)
	if(ANDROID)
		ANDROID_NDK_DEBUG(${ARGV})
		ANDROID_NDK_RELEASE(${ARGV})
	endif()
endfunction()


function(ANDROID32_NDK_DEBUG)
	if(ANDROID_32)
		ANDROID_NDK_DEBUG(${ARGV})
	endif()
endfunction()


function(ANDROID32_NDK_RELEASE)
	if(ANDROID_32)
		ANDROID_NDK_RELEASE(${ARGV})
	endif()
endfunction()


function(ANDROID64_NDK_DEBUG)
	if(ANDROID_64)
		ANDROID_NDK_DEBUG(${ARGV})
	endif()
endfunction()


function(ANDROID64_NDK_RELEASE)
	if(ANDROID_64)
		ANDROID_NDK_RELEASE(${ARGV})
	endif()
endfunction()


###################### DKPlugin Link Libraries #####################
function(DK_LIB lib_path)
	#DKSET(LIBLIST "${LIBLIST} ${lib_path}") ## used for double checking
	string(FIND "${LIBS}" "${lib_path}" index)
	if(NOT ${index} EQUAL -1)
		return() ## The library is already in the list
	endif()
	DKSET(LIBS "${LIBS};${lib_path}")
endfunction()

function(DKDEBUG_LIB lib_path)
	if(NOT DEBUG)
		return()
	endif()	
	DKSET(LIBLIST ${LIBLIST} ${lib_path}) ## used for double checking
	if(NOT EXISTS ${lib_path})
		message(STATUS "MISSING: ${lib_path}")
		DKSET(QUEUE_BUILD ON) 
	endif()
	string(FIND "${DEBUG_LIBS}" "${lib_path}" index)
	if(NOT ${index} EQUAL -1)
		return() ## The library is already in the list
	endif()
	if(LINUX OR RASPBERRY OR ANDROID)
		DKSET(DEBUG_LIBS debug ${lib_path} ${DEBUG_LIBS})  #Add to beginning of list
	else()
		DKSET(DEBUG_LIBS ${DEBUG_LIBS} debug ${lib_path})  #Add to end of list
	endif()
endfunction()

function(DKRELEASE_LIB lib_path)
	if(NOT RELEASE)
		return()
	endif()
	DKSET(LIBLIST ${LIBLIST} ${lib_path}) ## used for double checking
	if(NOT EXISTS ${lib_path})
		message(STATUS "MISSING: ${lib_path}")
		DKSET(QUEUE_BUILD ON)
	endif()
	string(FIND "${RELEASE_LIBS}" "${lib_path}" index)
	if(NOT ${index} EQUAL -1)
		return() ## The library is already in the list
	endif()	
	if(LINUX OR RASPBERRY OR ANDROID)
		DKSET(RELEASE_LIBS optimized ${lib_path} ${RELEASE_LIBS})  #Add to beginning of list
	else()
		DKSET(RELEASE_LIBS ${RELEASE_LIBS} optimized ${lib_path})  #Add to end of list
	endif()
endfunction()


function(WIN_LIB)
	if(WIN)
		DK_LIB(${ARGV})
	endif()
endfunction()

function(WIN_DEBUG_LIB)
	if(WIN)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(WIN_RELEASE_LIB)
	if(WIN)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(WIN32_LIB)
	if(WIN_32)
		DK_LIB(${ARGV})
	endif()
endfunction()

function(WIN32_DEBUG_LIB)
	if(WIN_32)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(WIN32_RELEASE_LIB)
	if(WIN_32)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(WIN64_LIB)
	if(WIN_64)
		DK_LIB(${ARGV})
	endif()
endfunction()

function(WIN64_DEBUG_LIB)
	if(WIN_64)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()


function(WIN64_RELEASE_LIB)
	if(WIN_64)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(APPLE_LIB)
	if(MAC OR IOS OR IOSSIM)
		DK_LIB(${ARGV})
	endif()
endfunction()

function(APPLE_DEBUG_LIB)
	if(MAC OR IOS OR IOSSIM)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(APPLE_RELEASE_LIB)
	if(MAC OR IOS OR IOSSIM)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(APPLE32_LIB)
	if(MAC_32 OR IOS_32 OR IOSSIM_32)
		DK_LIB(${ARGV})
	endif()
endfunction()

function(APPLE32_DEBUG_LIB)
	if(MAC_32 OR IOS_32 OR IOSSIM_32)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(APPLE32_RELEASE_LIB)
	if(MAC_32 OR IOS_32 OR IOSSIM_32)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(APPLE64_LIB)
	if(MAC_64 OR IOS_64 OR IOSSIM_64)
		DK_LIB(${ARGV})
	endif()
endfunction()

function(APPLE64_DEBUG_LIB)
	if(MAC_64 OR IOS_64 OR IOSSIM_64)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(APPLE64_RELEASE_LIB)
	if(MAC_64 OR IOS_64 OR IOSSIM_64)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(MAC_LIB)
	if(MAC)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(MAC_DEBUG_LIB)
	if(MAC)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(MAC_RELEASE_LIB)
	if(MAC)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(MAC32_LIB)
	if(MAC_32)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(MAC32_DEBUG_LIB)
	if(MAC_32)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(MAC32_RELEASE_LIB)
	if(MAC_32)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(MAC64_LIB)
	if(MAC_64)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(MAC64_DEBUG_LIB)
	if(MAC_64)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(MAC64_RELEASE_LIB)
	if(MAC_64)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(IOS_LIB)
	if(IOS)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(IOS_DEBUG_LIB)
	if(IOS)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(IOS_RELEASE_LIB)
	if(IOS)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(IOS32_LIB)
	if(IOS_32)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(IOS32_DEBUG_LIB)
	if(IOS_32)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(IOS32_RELEASE_LIB)
	if(IOS_32)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(IOS64_LIB)
	if(IOS_64)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(IOS64_DEBUG_LIB)
	if(IOS_64)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(IOS64_RELEASE_LIB)
	if(IOS_64)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(IOSSIM_LIB)
	if(IOSSIM)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(IOSSIM_DEBUG_LIB)
	if(IOSSIM)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(IOSSIM_RELEASE_LIB)
	if(IOSSIM)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(IOSSIM32_LIB)
	if(IOSSIM_32)
		DK_LIB(${ARGV})
	endif()
endfunction()

function(IOSSIM32_DEBUG_LIB)
	if(IOSSIM_32)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(IOSSIM32_RELEASE_LIB)
	if(IOSSIM_32)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(LINUX_LIB)
	if(LINUX)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(LINUX_DEBUG_LIB)
	if(LINUX AND DEBUG)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(LINUX_RELEASE_LIB)
	if(LINUX AND RELEASE)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(LINUX32_LIB)
	if(LINUX_32)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(LINUX32_DEBUG_LIB)
	if(LINUX32 AND DEBUG)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(LINUX32_RELEASE_LIB)
	if(LINUX32 AND RELEASE)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(LINUX64_LIB)
	if(LINUX_64)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(LINUX64_DEBUG_LIB)
	if(LINUX64 AND DEBUG)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(LINUX64_RELEASE_LIB)
	if(LINUX64 AND RELEASE)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(RASPBERRY_LIB)
	if(RASPBERRY)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(RASPBERRY_DEBUG_LIB)
	if(RASPBERRY AND DEBUG)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(RASPBERRY_RELEASE_LIB)
	if(RASPBERRY AND RELEASE)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(RASPBERRY32_LIB)
	if(RASPBERRY_32)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(RASPBERRY32_DEBUG_LIB)
	if(RASPBERRY32 AND DEBUG)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(RASPBERRY32_RELEASE_LIB)
	if(RASPBERRY32 AND RELEASE)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(RASPBERRY64_LIB)
	if(RASPBERRY_64)
		DK_LIB(${ARGV})
	endif()
endfunction() 

function(RASPBERRY64_DEBUG_LIB)
	if(RASPBERRY64 AND DEBUG)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(RASPBERRY64_RELEASE_LIB)
	if(RASPBERRY64 AND RELEASE)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(ANDROID_LIB)
	if(ANDROID)
		DK_LIB(${ARGV})
	endif()
endfunction()

function(ANDROID_DEBUG_LIB)
	if(ANDROID AND DEBUG)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(ANDROID_RELEASE_LIB)
	if(ANDROID AND RELEASE)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(ANDROID32_LIB)
	if(ANDROID_32)
		DK_LIB(${ARGV})
	endif()
endfunction()

function(ANDROID32_DEBUG_LIB)
	if(ANDROID_32 AND DEBUG)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(ANDROID32_RELEASE_LIB)
	if(ANDROID_32 AND RELEASE)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()

function(ANDROID64_LIB)
	if(ANDROID_64)
		DK_LIB(${ARGV})
	endif()
endfunction()

function(ANDROID64_DEBUG_LIB)
	if(ANDROID_64 AND DEBUG)
		DKDEBUG_LIB(${ARGV})
	endif()
endfunction()

function(ANDROID64_RELEASE_LIB)
	if(ANDROID_64 AND RELEASE)
		DKRELEASE_LIB(${ARGV})
	endif()
endfunction()


####################### Include Directories ###################
function(WIN_INCLUDE)
	if(WIN)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(WIN32_INCLUDE)
	if(WIN_32)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(WIN64_INCLUDE)
	if(WIN_64)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


#######################
function(APPLE_INCLUDE)
	if(CMAKE_HOST_APPLE)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(MAC_INCLUDE)
	if(MAC)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(MAC32_INCLUDE)
	if(MAC_32)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(MAC64_INCLUDE)
	if(MAC_64)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(IOS_INCLUDE)
	if(IOS)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(IOS32_INCLUDE)
	if(IOS_32)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(IOS64_INCLUDE)
	if(IOS_64)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(IOSSIM_INCLUDE)
	if(IOSSIM)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(IOSSIM32_INCLUDE)
	if(IOSSIM_32)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(IOSSIM64_INCLUDE)
	if(IOSSIM_64)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


#######################
function(LINUX_INCLUDE)
	if(LINUX)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(LINUX32_INCLUDE)
	if(LINUX_32)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(LINUX64_INCLUDE)
	if(LINUX_64)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(LINUX_DEBUG_INCLUDE)
	if(DEBUG)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(LINUX_RELEASE_INCLUDE)
	if(RELEASE)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(LINUX32_DEBUG_INCLUDE)
	if(LINUX_32 AND DEBUG)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(LINUX32_RELEASE_INCLUDE)
	if(LINUX_32 AND RELEASE)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(LINUX64_DEBUG_INCLUDE)
	if(LINUX_64 AND DEBUG)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(LINUX64_RELEASE_INCLUDE)
	if(LINUX_64 AND RELEASE)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


############################
function(RASPBERRY_INCLUDE)
	if(RASPBERRY)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(RASPBERRY32_INCLUDE)
	if(RASPBERRY_32)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(RASPBERRY64_INCLUDE)
	if(RASPBERRY_64)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(RASPBERRY_DEBUG_INCLUDE)
	if(RASPBERRY AND DEBUG)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(RASPBERRY_RELEASE_INCLUDE)
	if(RASPBERRY AND RELEASE)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(RASPBERRY32_DEBUG_INCLUDE)
	if(RASPBERRY_32 AND DEBUG)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(RASPBERRY32_RELEASE_INCLUDE)
	if(RASPBERRY_32 AND RELEASE)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(RASPBERRY64_DEBUG_INCLUDE)
	if(RASPBERRY_64 AND DEBUG)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(RASPBERRY64_RELEASE_INCLUDE)
	if(RASPBERRY_64 AND RELEASE)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


#########################
function(ANDROID_INCLUDE)
	if(ANDROID)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(ANDROID_DEBUG_INCLUDE)
	if(ANDROID AND DEBUG)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(ANDROID_RELEASE_INCLUDE)
	if(ANDROID AND RELEASE)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(ANDROID32_INCLUDE)
	if(ANDROID_32)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(ANDROID32_DEBUG_INCLUDE)
	if(ANDROID_32 AND DEBUG)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(ANDROID32_RELEASE_INCLUDE)
	if(ANDROID_32 AND RELEASE)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(ANDROID64_INCLUDE)
	if(ANDROID_64)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(ANDROID64_DEBUG_INCLUDE)
	if(ANDROID_64 AND DEBUG)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(ANDROID64_RELEASE_INCLUDE)
	if(ANDROID_64 AND RELEASE)
		DKINCLUDE(${ARGV})
	endif()
endfunction()


function(DKPLUGIN name)
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT plugin_path)
		message(FATAL_ERROR "DKPLUGIN(): ${name} plugin not found")
		return()
	endif()
	
	DKINCLUDE(${DIGITALKNOB}/DKPlugins)
	
	##Create CmakeLists.txt file
	DKSET(CMAKE_FILE "### This file is generated by DKCMake. Any Changes here, will be overwritten. ###\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}### ${name} ###\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}cmake_minimum_required(VERSION 3.10)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}cmake_policy(SET CMP0054 NEW)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}include(${DKCMAKE}/FUNCTIONS.cmake)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}include(${DKCMAKE}/OPTIONS.cmake)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}set(CMAKE_CXX_STANDARD 17)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}set(CMAKE_CXX_STANDARD_REQUIRED ON)\n")
	
	DKSET(CMAKE_FILE "${CMAKE_FILE}if(ANDROID)\n")
	#DKSET(CMAKE_FILE "${CMAKE_FILE}		set(CMAKE_CXX_STANDARD_REQUIRED OFF)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		set(CMAKE_SYSTEM_NAME Android)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		set(CMAKE_SYSTEM_VERSION 26)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		set(CMAKE_ANDROID_ARCH_ABI armeabi-v7a)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		set(CMAKE_ANDROID_NDK ${ANDROIDNDK})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		set(CMAKE_ANDROID_STL_TYPE c++_static)\n")
	#DKSET(CMAKE_FILE "${CMAKE_FILE}		set(CMAKE_CXX_STANDARD 17)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		set(CMAKE_CXX_EXTENSIONS OFF)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}endif()\n")
	
	DKSET(CMAKE_FILE "${CMAKE_FILE}if(IOS)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		set(IOS_PLATFORM OS)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		include(${DKCMAKE}/iOS.cmake)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		add_definitions(-DIOS)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}endif()\n")
	
	DKSET(CMAKE_FILE "${CMAKE_FILE}if(IOSSIM)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		set(IOS_PLATFORM SIMULATOR)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		include(${DKCMAKE}/iOS.cmake)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		add_definitions(-DIOS)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}endif()\n")
	
	DKSET(CMAKE_FILE "${CMAKE_FILE}project(${name})\n")
	
	foreach(each_include ${DKINCLUDES_LIST})
		DKSET(CMAKE_FILE "${CMAKE_FILE}include_directories(${each_include})\n")
	endforeach()
	foreach(each_define ${DKDEFINES_LIST})
		DKSET(CMAKE_FILE "${CMAKE_FILE}add_definitions(-D${each_define})\n")
	endforeach()
	foreach(each_linkdir ${DKLINKDIRS_LIST})
		DKSET(CMAKE_FILE "${CMAKE_FILE}link_directories(${each_linkdir})\n")
	endforeach()
	
	DKSET(CMAKE_FILE "${CMAKE_FILE}file(GLOB ${name}_SRC\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}${plugin_path}/*.h\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}${plugin_path}/*.c\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}${plugin_path}/*.cpp\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE})\n")
	
	#DKSET(CMAKE_FILE "${CMAKE_FILE}DUMP(WIN)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}if(WIN)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}file(GLOB WIN_SRC\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${plugin_path}/*.rc\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${plugin_path}/*.manifest\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}list(APPEND ${name}_SRC \${WIN_SRC})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}endif()\n")
	
	DKSET(CMAKE_FILE "${CMAKE_FILE}if(IOS)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}file(GLOB IOS_SRC\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		${plugin_path}/*.mm\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}list(APPEND ${name}_SRC \${IOS_SRC})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}endif()\n")
	
	DKSET(CMAKE_FILE "${CMAKE_FILE}if(IOSSIM)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}file(GLOB IOS_SRC\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		${plugin_path}/*.mm\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}list(APPEND ${name}_SRC \${IOS_SRC})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}endif()\n")
	
	DKSET(CMAKE_FILE "${CMAKE_FILE}add_library(${name} STATIC \${${name}_SRC})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}target_compile_options(${name} PRIVATE ${FLAGS})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}if(CMAKE_HOST_WIN32)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}		set_target_properties(${name} PROPERTIES LINKER_LANGUAGE CPP)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}endif()\n")	
	
	DKSET(DKCPPPLUGS ${DKCPPPLUGS} ${name})  #Add to list
	
	##add headers to DKPlugins.h
	if(${name} STREQUAL DK OR STATIC)
		file(GLOB HEADER_FILES RELATIVE ${DIGITALKNOB}/DKPlugins ${plugin_path}/*.h)
		foreach(header ${HEADER_FILES})
			string(FIND "${PLUGINS_FILE}" "${header}" index)
			if(${index} EQUAL -1)
				message(STATUS "Adding ${header} to header file.")
				DKSET(PLUGINS_FILE ${PLUGINS_FILE} "#include \"${header}\"\\n")
			endif()
		endforeach()
	endif()
endfunction()


function(DKDLL name)
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT plugin_path)
		message("DKDLL(): ${name} plugin not found")
		return()
	endif()
	DKINCLUDE(${plugin_path})
			
	##Create CmakeLists.txt file
	DKSET(CMAKE_FILE "### ${name} ###\n")
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
	DKSET(CMAKE_FILE "${CMAKE_FILE}PROJECT(${name})\n")
	foreach(each_include ${DKINCLUDES_LIST})
		DKSET(CMAKE_FILE "${CMAKE_FILE}include_directories(${each_include})\n")
	endforeach()
	foreach(each_define ${DKDEFINES_LIST})
		DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_DEFINITIONS(-D${each_define})\n")
	endforeach()
	foreach(each_linkdir ${DKLINKDIRS_LIST})
		DKSET(CMAKE_FILE "${CMAKE_FILE}link_directories(${each_linkdir})\n")
	endforeach()
	DKSET(CMAKE_FILE "${CMAKE_FILE}file(GLOB ${name}_SRC \n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}	   ${plugin_path}/*.h\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${plugin_path}/*.c\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${plugin_path}/*.cpp\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${plugin_path}/*.rc\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    ${plugin_path}/*.manifest\n")
	if(IOS OR IOSSIM)
		DKSET(CMAKE_FILE "${CMAKE_FILE}    ${plugin_path}/*.mm\n")
	endif()
	DKSET(CMAKE_FILE "${CMAKE_FILE})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_LIBRARY(${name} SHARED \${${name}_SRC})\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}ADD_DEFINITIONS(-D_WIN32_WINNT=0x0600)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}SET_TARGET_PROPERTIES(${name} PROPERTIES LINK_FLAGS_DEBUG \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMTD.lib /SAFESEH:NO\" LINK_FLAGS \"/NODEFAULTLIB:libc.lib /NODEFAULTLIB:LIBCMT.lib /SAFESEH:NO\") \n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}target_compile_options(${name} PRIVATE $<$<CONFIG:Debug>:/MDd /Od /Ob0 /EHsc /Zi /RTC1 /DDEBUG /D_DEBUG> $<$<CONFIG:Release>:/MD /O2 /Ob2 /EHsc /DNDEBUG>)\n")
	if(DEBUG_LIBS)
		string(REPLACE "debug" " debug " DLL_DEBUG_LIBS ${DEBUG_LIBS})
	endif()
	if(RELEASE_LIBS)
		string(REPLACE "optimized" " optimized " DLL_RELEASE_LIBS ${RELEASE_LIBS})
	endif()
	if(LIBS)
		string(REPLACE ".lib" ".lib " DLL_LIBS ${LIBS})
	endif()
	if(DLL_DEBUG_LIBS AND DLL_RELEASE_LIBS)
		#DKSET(CMAKE_FILE "${CMAKE_FILE}TARGET_LINK_LIBRARIES(${name} debug ${DKPLUGINS}/DK/${OS}/${DEBUG_DIR}/DK.lib optimized ${DKPLUGINS}/DK/${OS}/${RELEASE_DIR}/DK.lib) \n")
		DKSET(CMAKE_FILE "${CMAKE_FILE}TARGET_LINK_LIBRARIES(${name} ${DLL_DEBUG_LIBS} ${DLL_RELEASE_LIBS} ${DLL_LIBS}) \n")
	endif()
	DKSET(CMAKE_FILE "${CMAKE_FILE}if(CMAKE_HOST_WIN32)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}    SET_TARGET_PROPERTIES(${name} PROPERTIES LINKER_LANGUAGE CPP)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}endif()\n")	
	DKSET(DKCPPPLUGS ${DKCPPPLUGS} ${name})  #Add to list	
endfunction()


function(DKEXECUTABLE name)
	##Create CmakeLists.txt file
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT plugin_path)
		message(FATAL_ERROR "DKEXECUTABLE(): ${name} plugin not found")
		return()
	endif()
	DKINCLUDE(${plugin_path})
	DKSET(CMAKE_FILE "### ${name} ###\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}CMAKE_MINIMUM_REQUIRED(VERSION 3.0)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/FUNCTIONS.cmake)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}INCLUDE(${DKCMAKE}/OPTIONS.cmake)\n")
	DKSET(CMAKE_FILE "${CMAKE_FILE}PROJECT(${name})\n")
endfunction()


function(DKAPPEND_CMAKE str)
	DKSET(CMAKE_FILE "${CMAKE_FILE}${str}")
endfunction()


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


# Add a library's files to the App's assets
function(DKASSETS name)
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT plugin_path)
		message(FATAL_ERROR "${name} plugin not found")
		return()
	endif()
	message(STATUS "Importing ${name} assets...")
	file(COPY ${plugin_path} DESTINATION ${DKPROJECT}/assets ${ASSETS})
endfunction()


function(dk_getPathToPlugin name result)
	file(GLOB children RELATIVE ${DKPATH} ${DKPATH}/*)
 	foreach(child ${children})
		if(EXISTS ${DKPATH}/${child}/3rdParty/_DKIMPORTS/${name}/DKMAKE.cmake)
			#message(STATUS "FOUND ${name} Plugin at ${DKPATH}/${child}/3rdParty/_DKIMPORTS/${name}")
			set(${result} "${DKPATH}/${child}/3rdParty/_DKIMPORTS/${name}" PARENT_SCOPE)
			return()
    	endif()
		if(EXISTS ${DKPATH}/${child}/DKPlugins/${name}/DKMAKE.cmake)
			#message(STATUS "FOUND ${name} Plugin at ${DKPATH}/${child}/DKPlugins/${name}")
			set(${result} "${DKPATH}/${child}/DKPlugins/${name}" PARENT_SCOPE)
			return()
    	endif()
  	endforeach()
	message(FATAL_ERROR "Could not find ${name} Plugin.")
endfunction()


# Add a library or plugin to the dependency list
function(DKDEPEND name)
	list(FIND dkdepend_disable_list "${name}" index)
	if(${index} GREATER -1)
		message(STATUS "${name} IS DISABLED")
		return()
	endif()
			
	# If DKDEPEND had second variable (a sub library), set that variable to ON
	# if(${ARGC} GREATER 1)
	#	list(FIND dkdepend_list "${name} ${args}" index)
	#	if(${index} GREATER -1) #library is already in the list
	#		return()
	#	endif()
	# else()
	#	list(FIND dkdepend_list "${name}" index)
	#	if(${index} GREATER -1)
	#		return() #library is already in the list
	#	endif()
	# endif()
		
	list(FIND dkdepend_list "${name}" index)
	if(${index} GREATER -1) #library is already in the list
		return()
	endif()
	
	DKRUNDEPENDS(${ARGV}) # strip everything from the file except if() else() elseif() endif() and DKDEPEND() before sorting.
	# else()
	#	list(FIND dkdepend_list "${name}" index)
	#	if(${index} GREATER -1)
	#		return() #library is already in the list
	#	endif()
	#	DKRUNDEPENDS(${name}) # strip everything from the file except if() else() elseif() endif() and DKDEPEND() before sorting.
	# endif()
	
endfunction()


# Remove a library or plugin from the dependency list
function(DKUNDEPEND name)
	## Only allow DKUNDEPEND command from these filters	
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE} AND NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPROJECT}) # /DKCMake or /App directory only
		message(FATAL_ERROR "\n! WARNING !\n DKUNDEPEND() Can only be used from the DKCMake/DISABLED.cmake file. This is to avoid having disabled libraries hideing everywhere.\n")
	endif()
	message(STATUS "DISABLING ${name}")
	DKSET(dkdepend_disable_list ${dkdepend_disable_list} ${name})
endfunction()


### DKRUNDEPENDS() will strip everything from the library's DKMAKE.cmake file except DKDEPEND() commands AND conditionals.
### Conditionals such as if(), else(), elseif(), endif(), return() will remain included during the sorting process. 
### WARNING: BE CAREFULL WRITING NEW VARIABLES TO USE WITH CONDITIONALS, AS THEY MIGHT BE IGNORED 
##########################
function(DKRUNDEPENDS name)
	dk_getPathToPlugin(${name} plugin_path)
	if(NOT plugin_path)
		message(FATAL_ERROR "DKRUNDEPENDS() ${name} plugin not found")
		return()
	endif()
	#message(STATUS "FOUND ${name} DK makefile at ${plugin_path}")
	
	file(STRINGS ${plugin_path}/DKMAKE.cmake lines)
	unset(disable_script)
	unset(depends_script)
	unset(index)
	
	foreach(line ${lines})
		string(FIND "${line}" "if(" index)
		if(${index} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		string(FIND "${line}" "IF(" index)
		if(${index} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		## elseif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		string(FIND "${line}" "else(" index)
		if(${index} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		string(FIND "${line}" "ELSE(" index)
		if(${index} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		## endif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		string(FIND "${line}" "return(" index)
		if(${index} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		string(FIND "${line}" "RETURN(" index)
		if(${index} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		string(FIND "${line}" "DKDISABLE(" index)
		if(${index} GREATER -1)
			set(disable_script "${disable_script}${line}\n")
		endif()
		
		#string(FIND "${line}" "DKSET(" index)
		#if(${index} GREATER -1)
		#	set(disable_script "${disable_script}${line}\n")
		#endif()
		
		## DKDISABLE(
		##NOTE: The 'DKDEPEND(' search commands take care of 'DISABLE_DKDEPEND(' since 'DKDEPEND' is already in the word
	endforeach()
	
	foreach(line ${lines})
		string(FIND "${line}" "if(" index)
		if(${index} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		string(FIND "${line}" "IF(" index)
		if(${index} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		## elseif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		string(FIND "${line}" "else(" index)
		if(${index} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		string(FIND "${line}" "ELSE(" index)
		if(${index} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		## endif(
		##NOTE: The 'if(' search commands take care of elseif() and endif() since 'if' is already in those words 
		
		string(FIND "${line}" "return(" index)
		if(${index} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		string(FIND "${line}" "RETURN(" index)
		if(${index} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		string(FIND "${line}" "DKENABLE(" index)
		if(${index} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		string(FIND "${line}" "DKDISABLE(" index)
		if(${index} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()	
		
		string(FIND "${line}" "DKDEPEND(" index)
		if(${index} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		
		string(FIND "${line}" "DKSET(" index)
		string(FIND "${line}" ")" indexB) 
		if(${index} GREATER -1)
		if(${indexB} GREATER -1)
			set(depends_script "${depends_script}${line}\n")
		endif()
		endif()
		
		# NOTE: The 'DKDEPEND(' search commands take care of 'DISABLE_DKDEPEND(' since 'DKDEPEND' is already a substring
	endforeach()
	
	if(disable_script)
		file(WRITE ${plugin_path}/DISABLES.TMP "${disable_script}")
		INCLUDE(${plugin_path}/DISABLES.TMP)
		#cmake_language(EVAL CODE "${disable_script}")   #cmake 3.18+
		DKREMOVE(${plugin_path}/DISABLES.TMP)
	endif()
	
	if(depends_script)
		if(${ARGC} GREATER 1)
			DKENABLE(${ARGV1})
		endif()
		file(WRITE ${plugin_path}/DEPENDS.TMP "${depends_script}")
		INCLUDE(${plugin_path}/DEPENDS.TMP)
		#cmake_language(EVAL CODE "${depends_script}")    #cmake 3.18+
		DKREMOVE(${plugin_path}/DEPENDS.TMP)
		if(${ARGC} GREATER 1)
			DKSET(${ARGV1} OFF)
		endif()
	endif()
	
	if(${ARGC} GREATER 1)
		list(FIND dkdepend_list "${name} ${ARGV1}" index)
		if(${index} GREATER -1)
			return()
		endif()
	else()
		list(FIND dkdepend_list "${name}" index)
		if(${index} GREATER -1)
			return() # already on the list
		endif()
	endif()
	
	if(${ARGC} GREATER 1)
		DKSET(dkdepend_list ${dkdepend_list} "${name} ${ARGV1}")  #Add sublibrary to list
	else()
		DKSET(dkdepend_list ${dkdepend_list} ${name})  #Add library to list
	endif()	
	list(REMOVE_DUPLICATES dkdepend_list)
endfunction()


function(DKDEPEND_ALL)
	message(STATUS "***** DKDEPEND_ALL() *****")
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
	file(GLOB children RELATIVE ${DKPATH}/ ${DKPATH}/*)
  	foreach(child ${children})
		if(EXISTS ${DKPATH}/${child}/DKPlugins)
			file(GLOB plugins RELATIVE ${DKPATH}/${child}/DKPlugins/ ${DKPATH}/${child}/DKPlugins/*)
			foreach(plugin ${plugins})
				if(EXISTS ${DKPATH}/${child}/DKPlugins/${plugin}/DKMAKE.cmake)
					if(NOT ${plugin} STREQUAL "_DKIMPORT")
						DKSET(DEPENDALL_FILE ${DEPENDALL_FILE} "DKDEPEND(${plugin})\n")
					endif()
				endif()
			endforeach()
		endif()
  	endforeach()
	
	#To exclude libraries, use DKDISABLE(lib) in your app DKMAKE.cmake file or in DKCMake/DISABLED.cmake
	string (REPLACE ";" "" DEPENDALL_FILE "${DEPENDALL_FILE}")
	file(WRITE ${DKPROJECT}/DEPEND_ALL.txt "${DEPENDALL_FILE}")
	INCLUDE(${DKPROJECT}/DEPEND_ALL.txt)
endfunction()


function (dkFileReplace filePath find replace)
	file(READ ${filePath} fileString)
	string(FIND "${fileString}" "${find}" index)
	if(${index} GREATER -1)
		string(REPLACE "${find}" "${replace}" fileString "${fileString}")
		file(WRITE ${filePath} "${fileString}")
	else()
		message(STATUS "WARNING: cannot find \"${find}\"  in  (${filePath})")
	endif()
endfunction()


function(DKUPDATE_ANDROID_NAME name)
	
	string(TOLOWER ${name} name)
	if(ANDROID)
		## update all files and folders recursivley
		file(GLOB_RECURSE allfiles LIST_DIRECTORIES true RELATIVE "${DKPROJECT}/${OS}/" "${DKPROJECT}/${OS}/*")
		#message(STATUS "\n Getting a list of files in ${DKPROJECT}/${OS} \n")
		list(REVERSE allfiles)
		foreach(each_file ${allfiles})
			##message(STATUS "#####  each_file = ${each_file}")
			set(filepath "${DKPROJECT}/${OS}/${each_file}")
			##message(STATUS "### each_file = ${each_file}")
			
			if(NOT IS_DIRECTORY ${filepath})
				string(FIND "${each_file}" "opendb" indexD)
				if(${indexD} GREATER -1)
					continue()
				endif()
				string(FIND "${each_file}" ".log" indexD)
				if(${indexD} GREATER -1)
					continue()
				endif()
				file(READ ${filepath} filestring)
				string(FIND "${filestring}" "dkapp" index)
				if(${index} GREATER -1)
					message(STATUS "Replacing 'dkapp' with '${name}' in ${filepath}")
					string(REPLACE "dkapp" "${name}" filestring "${filestring}")
					file(WRITE ${filepath} "${filestring}")
				endif()
			endif()
			
			get_filename_component(fname ${each_file} NAME)
			string(FIND "${fname}" "dkapp" indexB)
			if(${indexB} GREATER -1)
				set(new_name ${each_file})
				string(REPLACE "dkapp" "${name}" new_name "${new_name}")
				message(STATUS "Renaming ${each_file} to ${new_name}")
				DKRENAME(${DKPROJECT}/${OS}/${each_file} ${DKPROJECT}/${OS}/${new_name})
			endif()
		endforeach()
	endif()
endfunction()


function(DKUPDATE_INFO_PLIST name)
	if(MAC)
		## FIXME
		message(STATUS "Updating MAC info.plist . . .")
		if(DEBUG)
			if(EXISTS ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Contents/info.plist)
				file(READ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Contents/info.plist plist)
				string(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				string(REPLACE "<string>logo</string>" "" plist ${plist})
				string(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				file(WRITE "${plist}" ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Contents/info.plist)
			endif()
		endif()
		
		if(RELEASE)
			if(EXISTS ${DKPROJECT}/${OS}/${RELEASE_DIR}/${name}.app/Contents/info.plist)
				file(READ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${name}.app/Contents/info.plist plist)
				string(REPLACE "<key>CFBundleIconFile</key>" "" plist ${plist})
				string(REPLACE "<string>logo</string>" "" plist ${plist})
				string(REPLACE "<dict>" "<dict><key>CFBundleIconFile</key><string>logo</string>" plist ${plist})
				file(WRITE "${plist}" ${DKPROJECT}/${OS}/${RELEASE_DIR}/${name}.app/Contents/info.plist)
			endif()	
		endif()
	endif()
	if(IOS OR IOSSIM)
		message(STATUS "Updating IOS Info.plist . . .")
		message(STATUS "CHECKING FOR... ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Info.plist")
		if(EXISTS ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Info.plist)
			message(STATUS "Updating IOS Debug Info.plist . . .")
			file(READ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Info.plist plist)
			string(REPLACE "<dict>" "<dict>\n<key>Icon files</key>\n<array>\n<string>Icon.png</string>\n<string>Icon@2x.png</string>\n<string>Icon-72.png</string>\n<string>Icon-Small-50.png</string>\n<string>Icon-Small.png</string>\n<string>Icon-Small@2x.png</string>\n</array>\n" plist ${plist})
			file(WRITE "${plist}" ${DKPROJECT}/${OS}/${DEBUG_DIR}/${name}.app/Info.plist)
		endif()
	endif()
endfunction()

function(DKBUILD_LOG entry)
	DKSET(DKBUILD_LOG_FILE "${DKBUILD_LOG_FILE}${entry}\n")
	message(STATUS "buildlog->  ${entry}")
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

