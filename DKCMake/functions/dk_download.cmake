include_guard()

###############################################################################
# dk_download(src_path dest_path) #NOERROR
#
#	Download a file
#
#	@src_path	- The url of the file to download
#	@dest_path	- The path to download the file to
#   NOERROR     - if any of the parameters equals NOERROR, dk_error() messages will not be displayed
#
#	Notes: https://cmake.org/pipermail/cmake/2012-September/052205.html/
#
function(dk_download src_path) # ARGV1 = dest_path #NOERROR
	DKDEBUGFUNC(${ARGV})
	
	dk_get_option(NOERROR ${ARGV})
	
	#FIXME: Will not download if only 1 argument
	#TODO: Let's supply the ability to add a primary root address to download from,  for fast downloading from local hard drives or storage 
	#      we will also add a "backup" root address to download from. In case one of the internet download fails.
	#      Also, we will treat the url variable like a list. If it has more one item, treat them as alternative download links
#	if(NOT PrimaryDownloadServer)
#		dk_info("TODO: just set PrimaryDownloadServer to your mirror location and all file downoads will attempt that location first")
#	endif()
#	if(NOT SecondaryDownloadServer)
#		dk_info("TODO: just set SecondaryDownloadServer to your mirror location and all file downoads that fail will attempt secondary location next")
#	endif()

	set(dest_path ${ARGV1})
	
	# Setup all src_path variables
	if(NOT src_path)
		dk_error("src_path is invalid")
	endif()
	dk_debug(src_path)
	
	get_filename_component(src_dir ${src_path} DIRECTORY)
	if(NOT src_dir)
		dk_error("src_dir is invalid")
	endif()
	dk_debug(src_dir)
	
	get_filename_component(src_filename ${src_path} NAME)
	if(NOT src_filename)
		dk_error("src_filename is invalid")
	endif()
	dk_debug(src_filename)
	
	dk_getExtension(${src_path} src_ext)	
	if(NOT src_ext)
		dk_error("src_ext is invalid")
	endif()
	dk_debug(src_ext)
	
	# Setup all dest_path variables
	if(NOT dest_path)
		set(dest_path ${DKDOWNLOAD_DIR})
	endif()
	if(NOT dest_path)
		dk_error("dest_path is invalid")
	endif()	
	if(IS_DIRECTORY ${dest_path})
		set(dest_path "${dest_path}/${src_filename}")
	endif()
	dk_debug(dest_path)
	
	get_filename_component(dest_dir ${dest_path} DIRECTORY)
	if(NOT dest_dir)
		dk_error("dest_dir is invalid")
	endif()
	if(NOT EXISTS ${dest_dir})
		dk_notice("dest_dir:(${dest_dir}) does not exists. It will be created")
		dk_makeDirectory(${dest_dir})
	endif()
	dk_set(CURRENT_DIR ${dest_dir})
	dk_debug(dest_dir)
	
	get_filename_component(dest_filename ${dest_path} NAME)
	if(NOT dest_filename)
		dk_error("dest_filename is invalid")
		return()
	endif()
	dk_debug(dest_filename)
	
	dk_getExtension(${dest_path} dest_ext)
	if(NOT dest_ext)
		dk_error("dest_ext is invalid")
	endif()
	dk_debug(dest_ext)
	
	if(EXISTS ${dest_path})
		if(NOT NOERROR)
			dk_notice("dest_path:(${dest_path}) already exists")
		endif()
		return()
	endif()
	
	dk_debug("Downloading ${src_path}")
	dk_debug("      To -> ${dest_path}")
	
	# setup temp_path variables
	set(temp_filename "${dest_filename}.downloading")
	set(temp_path ${dest_dir}/${temp_filename})
	dk_debug(temp_path)
	if(EXISTS ${temp_path})
		dk_remove(${temp_path})
	endif()
	if(EXISTS ${temp_path})
		dk_error("temp_path:(${temp_path}) could not be removed")
	endif()
	
	dk_info("Downloading ${src_filename}. . . please wait")
	message("Downloading ${src_filename}. . . please wait")
	file(DOWNLOAD ${src_path} ${temp_path} 
		SHOW_PROGRESS 
		INACTIVITY_TIMEOUT 70
		STATUS status 
	)
	list(GET status 0 status_code) 
	list(GET status 1 status_string)
	if(NOT status_code EQUAL 0)
		dk_remove(${temp_path})
		dk_error("error: downloading ${src_path} \nstatus_code: ${status_code} \nstatus_string: ${status_string}")
	else()
		if(NOT EXISTS ${temp_path})
			dk_error("temp_path:(${temp_path}) could not locate temporary download file")
		endif()
		dk_rename(${temp_path} ${dest_path})
		if(NOT EXISTS ${dest_path})
			dk_error("dest_path:(${dest_path}) Could not locate downloaded file")
		endif()
		dk_info("${CLR}${green} Finnished downloading ${dest_filename}")
	endif() 
endfunction()
dk_createOsMacros("dk_download")
