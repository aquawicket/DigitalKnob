#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

if(NOT BACKUP_DL_SERVER)
	dk_set(BACKUP_DL_SERVER "http://aquawicket.com/download")
endif()
if(NOT TEST_BACKUP_DL_SERVER)
	dk_set(TEST_BACKUP_DL_SERVER 0)
endif()
###############################################################################
# dk_download(src_path dest_path) #NO_HALT
#
#	Download a file
#
#	@src_path	- The url of the file to download
#	@dest_path	- The path to download the file to
#   NO_HALT     - if any of the parameters equals NO_HALT, dk_fatal() messages will not be displayed
#
#	Notes: https://cmake.org/pipermail/cmake/2012-September/052205.html/
#
function(dk_download src_path) # ARGV1 = dest_path #NO_HALT
	dk_debugFunc()
	
	dk_getOption(NO_HALT ${ARGV})

	set(dest_path ${ARGV1})						# C:/Users/Administrator/Downloads
	
	# Setup all src_path variables
	#if(NOT src_path)
	#	dk_fatal("src_path is invalid")
	#endif()
    #dk_assertVar(src_path)
	#dk_printVar(src_path)						# https://aquawicket.com/download/myFile.txt
	
	dk_dirname(${src_path} src_dir)
	if(NOT src_dir)
		dk_fatal("src_dir is invalid")
	endif()
	#dk_printVar(src_dir)						# https://aquawicket.com/download
	
	dk_basename(${src_path} src_filename)
	if(NOT src_filename)
		dk_fatal("src_filename is invalid")
	endif()
	#dk_printVar(src_filename)					# myFile.txt
	
	dk_getExtension(${src_path} src_ext)	
	if(NOT src_ext)
		dk_fatal("src_ext is invalid")
	endif()
	#dk_printVar(src_ext)						# .txt
	
	# Setup all dest_path variables
	if(NOT dest_path)
		set(dest_path "${DKDOWNLOAD_DIR}")
	endif()
	if(NOT dest_path)
		dk_fatal("dest_path is invalid")
	endif()	
	if(IS_DIRECTORY ${dest_path})
		set(dest_path "${dest_path}/${src_filename}")
	endif()
	#dk_printVar(dest_path)						# C:/Users/Administrator/Downloads/myFile.txt
	
	dk_dirname("${dest_path}" dest_dir)			# C:/Users/Administrator/Downloads
	if(NOT dest_dir)
		dk_fatal("dest_dir is invalid")
	endif()
	if(NOT EXISTS ${dest_dir})
		dk_notice("dest_dir:(${dest_dir}) does not exists. It will be created")
		dk_makeDirectory("${dest_dir}")
	endif()
	dk_cd("${dest_dir}")
	#dk_printVar(dest_dir)
	
	dk_basename("${dest_path}" dest_filename)	# myFile.txt
	if(NOT dest_filename)
		dk_fatal("dest_filename is invalid")
		return()
	endif()
	#dk_printVar(dest_filename)
	
	dk_getExtension(${dest_path} dest_ext)		# .txt
	if(NOT dest_ext)
		dk_fatal("dest_ext is invalid")
	endif()
	#dk_printVar(dest_ext)
	
	if(EXISTS "${dest_path}")
		if(NOT NO_HALT)
			dk_notice("dest_path:(${dest_path}) already exists")
		endif()
		return()
	endif()
	
	
	
	# Use BACKUP_DL_SERVER only
	if(TEST_BACKUP_DL_SERVER)
		set(src_path "${BACKUP_DL_SERVER}/${src_filename}")
		dk_info("Using Backup Server src_path:${src_path} . . .")
	
	# Test that url exists, if not try BACKUP_DL_SERVER
	else()
		dk_assertVar(src_path)
		dk_urlExists(${src_path} result)
		if(NOT result)
			dk_warning("src_path:${src_path} NOT FOUND")
			set(src_path "${BACKUP_DL_SERVER}/${src_filename}")
			dk_info("Trying Backup Server src_path:${src_path} . . .")
		endif()
	endif()

	dk_debug("Downloading ${src_path}")
	dk_debug("      To -> ${dest_path}")
	
	# setup temp_path variables
	set(temp_filename "${dest_filename}.downloading")
	set(temp_path "${dest_dir}/${temp_filename}")
	#dk_printVar(temp_path)
	if(EXISTS "${temp_path}")
		dk_delete("${temp_path}")
	endif()
	if(EXISTS "${temp_path}")
		dk_fatal("temp_path:(${temp_path}) could not be removed")
	endif()
	
	dk_info("Downloading ${src_filename}. . . please wait")
	file(DOWNLOAD ${src_path} "${temp_path}"
		SHOW_PROGRESS 
		#INACTIVITY_TIMEOUT 70
		STATUS status 
	)
	list(GET status 0 status_code) 
	list(GET status 1 status_string)
	if(NOT status_code EQUAL 0)
		dk_delete(${temp_path})
		dk_fatal("error: downloading ${src_path} \nstatus_code: ${status_code} \nstatus_string: ${status_string}")
	else()
		if(NOT EXISTS ${temp_path})
			dk_fatal("temp_path:(${temp_path}) could not locate temporary download file")
		endif()
		dk_rename(${temp_path} ${dest_path})
		if(NOT EXISTS ${dest_path})
			dk_fatal("dest_path:(${dest_path}) Could not locate downloaded file")
		endif()
		dk_info("${clr}${green} Finnished downloading ${dest_filename}")
	endif() 
endfunction()
dk_createOsMacros("dk_download")






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_validate(DKDOWNLOAD_DIR "dk_DIGITALKNOB_DIR()")
	dk_download("https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBuilder.ps1" ${DKDOWNLOAD_DIR})
endfunction()
