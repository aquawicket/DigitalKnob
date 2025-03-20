#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

if(NOT DEFINED BACKUP_DL_SERVER)
	dk_set(BACKUP_DL_SERVER "http://aquawicket.com/download")
endif()
if(NOT DEFINED TEST_BACKUP_DL_SERVER)
	dk_set(TEST_BACKUP_DL_SERVER 0)
endif()
###############################################################################
# dk_download(url) dest_path NO_HALT
#
#	Download a file
#
#	@url		- The url of the file to download
#	@dest_path	- The path to download the file to
#   NO_HALT     - if any of the parameters equals NO_HALT, dk_fatal() messages will not be displayed
#
#	Notes: https://cmake.org/pipermail/cmake/2012-September/052205.html/
#
function(dk_download) # dest_path #NO_HALT
	dk_debugFunc(1 3)
	
	set(url "${ARGV0}")
	set(dest_path "${ARGV1}")
	dk_getOption(NO_HALT REMOVE)
	
	
	# Setup all url variables
	#if(NOT url)
	#	dk_fatal("url:${url} is invalid")
	#endif()
    #dk_assertVar(url)
	#dk_printVar(url)							# https://aquawicket.com/download/myFile.txt
	
	dk_dirname(${url} url_dir)
	if(NOT url_dir)
		dk_fatal("url_dir:${url_dir} is invalid")
	endif()
	#dk_printVar(url_dir)						# https://aquawicket.com/download
	
	dk_basename(${url} url_filename)
	if(NOT url_filename)
		dk_fatal("url_filename:${url_filename} is invalid")
	endif()
	#dk_printVar(url_filename)					# myFile.txt
	
	dk_getExtension(${url} url_ext)	
	if(NOT url_ext)
		dk_fatal("url_ext:${url_ext} is invalid")
	endif()
	#dk_printVar(url_ext)						# .txt
	
	
	# Setup all dest_path variables
	if(NOT dest_path)
		dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
		set(dest_path "$ENV{DKDOWNLOAD_DIR}")
	endif()
	if(NOT dest_path)
		dk_fatal("dest_path:${dest_path} is invalid")
	endif()	
	if(IS_DIRECTORY ${dest_path})
		set(dest_path "${dest_path}/${url_filename}")
	endif()
	dk_printVar(dest_path)						# C:/Users/Administrator/Downloads/myFile.txt
	
	dk_dirname("${dest_path}" dest_dir)			# C:/Users/Administrator/Downloads
	if(NOT dest_dir)
		dk_fatal("dest_dir:${dest_dir} is invalid")
	endif()
	if(NOT EXISTS ${dest_dir})
		dk_notice("dest_dir:${dest_dir} does not exists. It will be created")
		dk_makeDirectory("${dest_dir}")
	endif()
	dk_cd("${dest_dir}")
	#dk_printVar(dest_dir)
	
	dk_basename("${dest_path}" dest_filename)	# myFile.txt
	if(NOT dest_filename)
		dk_fatal("dest_filename:${dest_filename} is invalid")
		return()
	endif()
	#dk_printVar(dest_filename)
	
	dk_getExtension(${dest_path} dest_ext)		# .txt
	if(NOT dest_ext)
		dk_fatal("dest_ext:${dest_ext} is invalid")
	endif()
	#dk_printVar(dest_ext)
	
	if(EXISTS "${dest_path}")
		if(NOT NO_HALT)
			dk_notice("dest_path:${dest_path} already exists")
		endif()
		return()
	endif()
	
	
	
	# Use BACKUP_DL_SERVER only
	if(TEST_BACKUP_DL_SERVER)
		set(url "${BACKUP_DL_SERVER}/${url_filename}")
		dk_info("Using Backup Server url:${url} . . .")
	
	# Test that url exists, if not try BACKUP_DL_SERVER
	else()
		dk_assertVar(url)
		dk_urlExists(${url} result)
		if(NOT result)
			dk_warning("url:${url} NOT FOUND")
			set(url "${BACKUP_DL_SERVER}/${url_filename}")
			dk_info("Trying Backup Server url:${url} . . .")
		endif()
	endif()

	dk_debug("Downloading ${url}")
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
	
	set(FETCHCONTENT_QUIET FALSE) #FIX download progress 
	
	message("Downloading ${url_filename}. . . please wait")
	file(DOWNLOAD ${url} "${temp_path}"
		SHOW_PROGRESS 
		STATUS status 
	)
	list(GET status 0 status_code) 
	list(GET status 1 status_string)
	if(NOT status_code EQUAL 0)
		dk_delete(${temp_path})
		dk_fatal("error: downloading ${url} \nstatus_code: ${status_code} \nstatus_string: ${status_string}")
	else()
		if(NOT EXISTS ${temp_path})
			dk_fatal("temp_path:${temp_path} could not locate temporary download file")
		endif()
		dk_rename(${temp_path} ${dest_path})
		if(NOT EXISTS ${dest_path})
			dk_fatal("dest_path:${dest_path} Could not locate downloaded file")
		endif()
		dk_info("${clr}${green} Finnished downloading ${dest_filename}")
	endif() 
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	#dk_download("https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBuilder.ps1" $ENV{DKDOWNLOAD_DIR})
	
	dk_download("https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBuilder.ps1")
endfunction()
