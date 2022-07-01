# dk_import(url) details
#
#	*** Variables ***
#
#	url (required)
#		*** variations ***
#		https://github.com/orginization/library.git     * Git repository link
#		https://github.com/orginization/library         * Git page
#		https://website.com/library.zip					* library source code 
#		https://website.com/executable.exe              * executable file
#
#
#	plugin - The name of the plugin
#		obtained: 1. from current cmake directory name
#				  2. from github url 4th node
#				  3. from filename in url minus version and extension
#				  4. Supplied by user in dk_import() call   I.E. dk_import(url PLUGIN MyLib)
#	plugin_path - The full path to the plugin
#		obtained: 1. from current cmake directory

###############################################################################
# dk_import2(url)
#
#	Rework of dk_import()
#
#	@url	- TODO
#
function(dk_import2 PLUGIN_URL)
	DKDEBUGFUNC(${ARGV})

	### POPULATE VARIABLES ###
	# PLUGIN_URL				- from arguments
	# PLUGIN_URL_FILENAME   	- from PLUGIN_URL
	# PLUGIN_GITHUB_FILENAME	- from PLUGIN_URL
	# PLUGIN_GITHUB_NAME		- from PLUGIN_GITHUB_FILENAME
	# PLUGIN_URL_EXTENSION  	- from PLUGIN_URL_FILENAME
	# PLUGIN_URL_NAME      		- from PLUGIN_URL_FILENAME
	# PLUGIN_URL_NAME_LOWER 	- from PLUGIN_URL_NAME
	# PLUGIN_IMPORT_PATH		- from CMAKE_CURRENT_LIST_DIR
	# PLUGIN_NAME				- from PLUGIN_IMPORT_PATH
	# PLUGIN_NAME_LOWER			- from PLUGIN_NAME
	# PLUGIN_VERSION			- from PLUGIN_URL_NAME_LOWER and PLUGIN_NAME_LOWER
	# PLUGIN_INSTALL_PATH		- from PLUGIN_URL_NAME and PLUGIN_VERSION
	
	
	#string(FIND ${CMAKE_CURRENT_LIST_DIR} ${DKIMPORTS} PLUGIN_IS_IMPORT) 
	#if(${PLUGIN_IS_IMPORT} GREATER -1)
	dk_includes(${CMAKE_CURRENT_LIST_DIR} ${DKIMPORTS} PLUGIN_IS_IMPORT)	# PLUGIN_IS_IMPORT 
	if(PLUGIN_IS_IMPORT)
		set(PLUGIN_IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})					# PLUGIN_IMPORT_PATH
		#dk_getFilename(${PLUGIN_IMPORT_PATH} PLUGIN_NAME)		
	endif()
	if(PLUGIN_IMPORT_PATH)
		get_filename_component(PLUGIN_NAME ${PLUGIN_IMPORT_PATH} NAME)		# PLUGIN_NAME
	endif()
	if(PLUGIN_NAME)
		string(TOLOWER ${PLUGIN_NAME} PLUGIN_NAME_LOWER)					# PLUGIN_NAME_LOWER
	endif()
	if(PLUGIN_URL)
		get_filename_component(PLUGIN_URL_FILENAME ${PLUGIN_URL} NAME)		# PLUGIN_URL_FILENAME
		string(REPLACE "/" ";" PLUGIN_URL_LIST ${PLUGIN_URL})				# PLUGIN_URL_LIST
		dk_includes(${PLUGIN_URL} https://github.com PLUGIN_GITHUB)			# PLUGIN_GITHUB
	endif()
	if(PLUGIN_URL_FILENAME)
		dk_getExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_EXTENSION)		# PLUGIN_URL_EXTENSION
		dk_removeExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_NAME)			# PLUGIN_URL_NAME
	endif()
	if(PLUGIN_URL_NAME)
		string(TOLOWER ${PLUGIN_URL_NAME} PLUGIN_URL_NAME_LOWER)			# PLUGIN_URL_NAME_LOWER
	endif()
	if(PLUGIN_URL_LIST)
		# split the url into list converting / to divider ;
		set(index 0 )
		foreach(PLUGIN_URL_ITEM ${PLUGIN_URL_LIST})							# PLUGIN_URL_ITEM
			set(PLUGIN_URL_NODE${index} ${PLUGIN_URL_ITEM})					# PLUGIN_URL_NODE(n)
			dk_debug(${PLUGIN_URL_NODE${index}})
		endforeach()
		list(LENGTH PLUGIN_URL_LIST PLUGIN_URL_LENGTH)						# PLUGIN_URL_LENGTH
	endif()
	if(PLUGIN_GITHUB)
		#dk_debug("This is a github address")
		list(GET PLUGIN_URL_LIST 4 PLUGIN_GITHUB_FILENAME)					# PLUGIN_GITHUB_FILENAME
		dk_removeExtension(${PLUGIN_GITHUB_FILENAME} PLUGIN_GITHUB_NAME)	# PLUGIN_GITHUB_NAME
	endif()
	if(PLUGIN_URL_NAME_LOWER)
		# deduct the plugin version
		string(REPLACE ${PLUGIN_NAME_LOWER} "" PLUGIN_VERSION ${PLUGIN_URL_NAME_LOWER})	
		if(${PLUGIN_NAME_LOWER} STREQUAL ${PLUGIN_URL_NAME_LOWER})
			set(PLUGIN_VERSION "none")
		endif()
		string(FIND ${PLUGIN_VERSION} - index)
		if(${index} EQUAL 0)
			string(SUBSTRING ${PLUGIN_VERSION} 1 -1 PLUGIN_VERSION)
		endif()
		string(FIND ${PLUGIN_VERSION} _ index)
		if(${index} EQUAL 0)
			string(SUBSTRING ${PLUGIN_VERSION} 1 -1 PLUGIN_VERSION)
		endif()
	endif()																	# PLUGIN_VERSION
	if(PLUGIN_VERSION)
		set(PLUGIN_INSTALL_NAME ${PLUGIN_NAME}-${PLUGIN_VERSION})			# PLUGIN_INSTALL_NAME
	endif()
	if(3RDPARTY)
		set(PLUGIN_INSTALL_PATH ${3RDPARTY}/${PLUGIN_INSTALL_NAME})			# PLUGIN_INSTALL_PATH
	endif()
			
	dk_debug(PLUGIN_IS_IMPORT)
	dk_debug(PLUGIN_IMPORT_PATH)
	dk_debug(PLUGIN_NAME)
	dk_debug(PLUGIN_NAME_LOWER)
	dk_debug(PLUGIN_URL)
	dk_debug(PLUGIN_URL_LIST)
	dk_debug(PLUGIN_URL_LENGTH)
	dk_debug(PLUGIN_URL_NODE0)
	dk_debug(PLUGIN_URL_NODE1)
	dk_debug(PLUGIN_URL_NODE2)
	dk_debug(PLUGIN_URL_NODE3)
	dk_debug(PLUGIN_URL_NODE4)
	dk_debug(PLUGIN_URL_NODE5)
	dk_debug(PLUGIN_URL_FILENAME)
	dk_debug(PLUGIN_URL_EXTENSION)
	dk_debug(PLUGIN_URL_NAME)
	dk_debug(PLUGIN_URL_NAME_LOWER)
	dk_debug(PLUGIN_URL_LENGTH)
	dk_debug(PLUGIN_URL_NAME_LOWER)
	dk_debug(PLUGIN_GITHUB)
	dk_debug(PLUGIN_GITHUB_FILENAME)
	dk_debug(PLUGIN_GITHUB_NAME)
	dk_debug(PLUGIN_VERSION)
	
	## Create Plugin Variables
	
	
	
endfunction()


function(printARGVdata ARGC ARGV)
	dk_debug(" ")
	dk_debug(" ")
	dk_debug("************************************************************")
	dk_debug("	dk_import2(${ARGV})")
	dk_debug(" ")
	dk_debug(CMAKE_CURRENT_LIST_DIR)
	dk_debug("*** ARG Variables ***")
	dk_debug(ARGC)
	dk_debug(ARGN)
	dk_debug(ARGV)	
	dk_debug(ARGV0)
	dk_debug(ARGV1)
	math(EXPR ARGC_LAST "${ARGC}-1")
	dk_debug(ARGC_LAST)
	set(ARGV_LAST ${ARGV${ARGC_LAST}})
	dk_debug(ARGV_LAST)
	dk_debug(" ")
endfunction()

function(printUrlData url)
	if(NOT url)
		dk_assert("url invalid")
	endif()
	dk_debug("*** url Variables ***")
	dk_debug(url)
	string(REPLACE "/" ";" PLUGIN_URL_LIST ${url}) # seperate the url nodes into a list 
	dk_debug(PLUGIN_URL_LIST)
	list(LENGTH PLUGIN_URL_LIST PLUGIN_URL_LENGTH)
	dk_debug(PLUGIN_URL_LENGTH)
	set(n -1)
	foreach(PLUGIN_URL_ITEM ${PLUGIN_URL_LIST})
		math(EXPR n "${n}+1")
		set(url_${n} ${PLUGIN_URL_ITEM})
		dk_debug(url_${n})
		set(url_last ${url_${n}})
	endforeach()
	dk_debug(url_last)
	dk_getFileType(${url} url_filetype)
	dk_debug(url_filetype)
endfunction()

###############################################################################
# dk_import(url) #args
#
#	github GIT:	https://github.com/orginization/library.git		dk_importGit(url) #branch/tag #PATCH
#	github DL:	https://github.com/orginization/library			dk_importGit(url) #branch/tag #PATCH
#	lib url DL:	https://website.com/library.zip					dk_importDownload(url) #PATCH
#	exe url DL:	https://website.com/executable.exe 				dk_importDownload(url) #PATCH
#
#	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
#
#function(dk_import url) #Lib #tag #Patch
#	DKDEBUGFUNC(${ARGV})
#	dk_import2(${ARGV})
#	#set(url ${ARGV0})
#	string(FIND ${url} ".git" dotgit)
#	if(${dotgit} GREATER -1)
#		dk_importGit(${ARGV})
#	else()
#		dk_importDownload(${ARGV})
#	endif()
#endfunction()

#dk_import2(https://github.com/madler/zlib.git)
#dk_depend(dktest)
