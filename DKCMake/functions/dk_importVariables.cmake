include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
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
# dk_importVariables(url RESULT)
#
#	Rework of dk_import()
#
#	@url	- TODO
#
function(dk_importVariables PLUGIN_URL RESULT)
	dk_debugFunc(${ARGV})
	
	##### Test that we dont have any non-alphanumeric characters ######
	#dk_convertToCIdentifier(${PLUGIN_URL} PLUGIN_URL_TEST)
	#if(NOT ${PLUGIN_URL} STREQUAL ${PLUGIN_URL_TEST})
	#	dk_error("${PLUGIN_URL} contains non-alphanumeric characters")
	#	dk_convertToCIdentifier(${PLUGIN_URL} PLUGIN_URL)
	#endif()
	###################################################################
	
	#dk_printVar(ARGV)
	### POPULATE VARIABLES ###
	# PLUGIN_URL				- from arguments
	# PLUGIN_URL_LIST
	# PLUGIN_URL_LENGTH
	# PLUGIN_URL_NODE(n)
	# PLUGIN_URL_FILENAME   	- from PLUGIN_URL
	# PLUGIN_URL_EXTENSION  	- from PLUGIN_URL_FILENAME
	# PLUGIN_URL_FILE      		- from PLUGIN_URL_FILENAME
	# PLUGIN_URL_FILE_LOWER 	- from PLUGIN_URL_FILE
	# PLUGIN_URL_FILE_UPPER 	- from PLUGIN_URL_FILE
	
	# PLUGIN_IMPORT
	# PLUGIN_IMPORT_PATH		- from CMAKE_CURRENT_LIST_DIR
	# PLUGIN_IMPORT_NAME		- from PLUGIN_IMPORT_PATH
	# PLUGIN_IMPORT_NAME_LOWER	- from PLUGIN_IMPORT_NAME
	# PLUGIN_IMPORT_NAME_UPPER	- from PLUGIN_IMPORT_NAME
	
	# PLUGIN_GIT
	# PLUGIN_GIT_FILENAME		- from PLUGIN_URL
	# PLUGIN_GIT_NAME			- from PLUGIN_GIT_FILENAME
	# PLUGIN_GIT_NAME_LOWER 	- from PLUGIN_GIT_NAME
	# PLUGIN_GIT_NAME_UPPER 	- from PLUGIN_GIT_NAME
	
	# PLUGIN_INSTALL_NAME
	# PLUGIN_INSTALL_NAME_LOWER
	# PLUGIN_INSTALL_NAME_UPPER
	# PLUGIN_INSTALL_VERSION	- from PLUGIN_URL_FILE_LOWER and PLUGIN_IMPORT_NAME_LOWER
	# PLUGIN_INSTALL_FOLDER
	# PLUGIN_INSTALL_PATH		- from PLUGIN_URL_FILE and PLUGIN_INSTALL_VERSION
	
	# PLUGIN_VAR_PREFIX			- from PLUGIN_IMPORT_NAME
	
	dk_getParameter(NAME PLUGIN_INSTALL_NAME ${ARGV})
	dk_getParameter(VERSION PLUGIN_INSTALL_VERSION ${ARGV})
	dk_getParameter(FOLDER PLUGIN_INSTALL_FOLDER ${ARGV})
	dk_getParameter(PATH PLUGIN_INSTALL_PATH ${ARGV})
	dk_getParameter(BRANCH PLUGIN_GIT_BRANCH ${ARGV})
	dk_getParameter(TAG PLUGIN_GIT_TAG ${ARGV})

	dk_set(PLUGIN_INSTALL_NAME ${NAME})
	
	if(PLUGIN_URL)																# PLUGIN_URL
		dk_printVar(PLUGIN_URL)
		get_filename_component(PLUGIN_URL_FILENAME ${PLUGIN_URL} NAME)			# PLUGIN_URL_FILENAME
		dk_printVar(PLUGIN_URL_FILENAME)
		string(REPLACE "/" ";" PLUGIN_URL_LIST ${PLUGIN_URL})					# PLUGIN_URL_LIST
		dk_printVar(PLUGIN_URL_LIST)
		dk_includes(${PLUGIN_URL} https://github.com PLUGIN_GIT)				# PLUGIN_GIT
		dk_printVar(PLUGIN_GIT)
	endif()
	if(PLUGIN_URL_FILENAME)
		dk_getExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_EXTENSION)			# PLUGIN_URL_EXTENSION
		dk_printVar(PLUGIN_URL_EXTENSION)
		dk_removeExtension(${PLUGIN_URL_FILENAME} PLUGIN_URL_FILE)				# PLUGIN_URL_FILE
		dk_printVar(PLUGIN_URL_FILE)
	endif()
	if(PLUGIN_URL_FILE)
		dk_toLower(${PLUGIN_URL_FILE} PLUGIN_URL_FILE_LOWER)				# PLUGIN_URL_FILE_LOWER
		dk_toUpper(${PLUGIN_URL_FILE} PLUGIN_URL_FILE_UPPER)				# PLUGIN_URL_FILE_UPPER
	endif()
	if(PLUGIN_URL_LIST)
		# split the url into list converting / to divider ;
		set(index 0)
		foreach(PLUGIN_URL_ITEM ${PLUGIN_URL_LIST})								# PLUGIN_URL_ITEM
			set(PLUGIN_URL_NODE${index} ${PLUGIN_URL_ITEM})						# PLUGIN_URL_NODE(n)
			dk_printVar(PLUGIN_URL_NODE${index})
			math(EXPR index ${index}+1)
		endforeach()
		list(LENGTH PLUGIN_URL_LIST PLUGIN_URL_LENGTH)							# PLUGIN_URL_LENGTH
		dk_printVar(PLUGIN_URL_LENGTH)
	endif()

	dk_validate(DKIMPORTS_DIR "dk_getDKPaths()") 
	dk_includes(${CMAKE_CURRENT_LIST_DIR} ${DKIMPORTS_DIR} PLUGIN_IMPORT)		# PLUGIN_IMPORT
	#if(${DKIMPORTS_DIR} IN_LIST CMAKE_CURRENT_LIST_DIR)
	#	set(PLUGIN_IMPORT 1)
	#endif()
	
	if(NOT PLUGIN_IMPORT)
		dk_error("PLUGIN_IMPORT invalid")
	endif()
	
	if(PLUGIN_IMPORT)
		set(PLUGIN_IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})						# PLUGIN_IMPORT_PATH
		dk_printVar(PLUGIN_IMPORT_PATH)		
	endif()
	if(PLUGIN_IMPORT_PATH)
		get_filename_component(PLUGIN_IMPORT_NAME ${PLUGIN_IMPORT_PATH} NAME)	# PLUGIN_IMPORT_NAME
		dk_printVar(PLUGIN_IMPORT_NAME)		
	endif()
	if(PLUGIN_IMPORT_NAME)
		dk_toLower(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_LOWER)			# PLUGIN_IMPORT_NAME_LOWER
		dk_toUpper(${PLUGIN_IMPORT_NAME} PLUGIN_IMPORT_NAME_UPPER)			    # PLUGIN_IMPORT_NAME_UPPER
	endif()

	if(PLUGIN_GIT)
		list(GET PLUGIN_URL_LIST 4 PLUGIN_GIT_FILENAME)							# PLUGIN_GIT_FILENAME
		dk_printVar(PLUGIN_GIT_FILENAME)	
		string(REPLACE ".git" "" PLUGIN_GIT_NAME ${PLUGIN_GIT_FILENAME})		# PLUGIN_GIT_NAME
		dk_printVar(PLUGIN_GIT_NAME)	
		#dk_getGitBranchName(${PLUGIN_URL} PLUGIN_GIT_BRANCH)					# PLUGIN_GIT_BRANCH
		if(NOT PLUGIN_GIT_BRANCH)
			set(PLUGIN_GIT_BRANCH master)
		endif()
	endif()
	if(PLUGIN_GIT_NAME)
		dk_toLower(${PLUGIN_GIT_NAME} PLUGIN_GIT_NAME_LOWER)				# PLUGIN_GIT_NAME_LOWER
		dk_toUpper(${PLUGIN_GIT_NAME} PLUGIN_GIT_NAME_UPPER)				# PLUGIN_GIT_NAME_UPPER
	endif()
	
	### PLUGIN_INSTALL VARIABLES ###
	if(NOT PLUGIN_INSTALL_URL)
		set(PLUGIN_INSTALL_URL ${PLUGIN_URL})
		dk_printVar(PLUGIN_INSTALL_URL)
	endif()
	if(NOT PLUGIN_INSTALL_NAME)
		if(PLUGIN_IMPORT_NAME)
			set(PLUGIN_INSTALL_NAME ${PLUGIN_IMPORT_NAME})
		elseif(PLUGIN_GIT_NAME)
			set(PLUGIN_INSTALL_NAME ${PLUGIN_GIT_NAME})
		elseif(PLUGIN_URL_NAME)
			set(PLUGIN_INSTALL_NAME ${PLUGIN_URL_NAME})
		endif()
		dk_printVar(PLUGIN_INSTALL_NAME)
	endif()
	
	if(PLUGIN_INSTALL_NAME)
		dk_toLower(${PLUGIN_INSTALL_NAME} PLUGIN_INSTALL_NAME_LOWER)			# PLUGIN_INSTALL_NAME_LOWER
		dk_toUpper(${PLUGIN_INSTALL_NAME} PLUGIN_INSTALL_NAME_UPPER)				# PLUGIN_INSTALL_NAME_UPPER
	endif()
	if(NOT PLUGIN_INSTALL_VERSION)
		if(PLUGIN_IMPORT_NAME_LOWER AND PLUGIN_URL_FILE_LOWER)
			# deduct the plugin version		
			string(REPLACE ${PLUGIN_IMPORT_NAME_LOWER} "" PLUGIN_INSTALL_VERSION ${PLUGIN_URL_FILE_LOWER})	
			if(${PLUGIN_IMPORT_NAME_LOWER} STREQUAL ${PLUGIN_URL_FILE_LOWER})
				if(PLUGIN_GIT_TAG)
					set(PLUGIN_INSTALL_VERSION ${PLUGIN_GIT_TAG})
				elseif(PLUGIN_GIT_BRANCH)
					set(PLUGIN_INSTALL_VERSION ${PLUGIN_GIT_BRANCH})
				else()
					set(PLUGIN_INSTALL_VERSION master)
				endif()
			endif()
			
			string(FIND ${PLUGIN_INSTALL_VERSION} - index)
			if(${index} EQUAL 0)
				string(SUBSTRING ${PLUGIN_INSTALL_VERSION} 1 -1 PLUGIN_INSTALL_VERSION)
			endif()
			
			string(FIND ${PLUGIN_INSTALL_VERSION} _ index)
			if(${index} EQUAL 0)
				string(SUBSTRING ${PLUGIN_INSTALL_VERSION} 1 -1 PLUGIN_INSTALL_VERSION)
			endif()
		endif()
		dk_printVar(PLUGIN_INSTALL_VERSION)
	endif()																				# PLUGIN_INSTALL_VERSION
	if(NOT PLUGIN_INSTALL_FOLDER)		
		if(PLUGIN_INSTALL_VERSION)
			set(PLUGIN_INSTALL_FOLDER ${PLUGIN_INSTALL_NAME}-${PLUGIN_INSTALL_VERSION})	# PLUGIN_INSTALL_FOLDER
		endif()
		dk_printVar(PLUGIN_INSTALL_FOLDER)
	endif()
	if(NOT PLUGIN_INSTALL_URL)
		if(DK3RDPARTY_DIR)
			set(PLUGIN_INSTALL_URL ${PLUGIN_URL})										# PLUGIN_INSTALL_PATH
		endif()
		dk_printVar(PLUGIN_INSTALL_URL)
	endif()
	if(NOT PLUGIN_INSTALL_PATH)
		if(DK3RDPARTY_DIR)
			set(PLUGIN_INSTALL_PATH ${DK3RDPARTY_DIR}/${PLUGIN_INSTALL_FOLDER})				# PLUGIN_INSTALL_PATH
		endif()
		dk_printVar(PLUGIN_INSTALL_PATH)
	endif()
	if(NOT PLUGIN_INSTALL_BRANCH)
		if(PLUGIN_GIT_BRANCH)
			set(PLUGIN_INSTALL_BRANCH ${PLUGIN_GIT_BRANCH})
		else()
			set(PLUGIN_INSTALL_BRANCH master)
		endif()
		dk_printVar(PLUGIN_INSTALL_BRANCH)
	endif()

	if(NOT PLUGIN_INSTALL_TAG)
		if(PLUGIN_GIT_TAG)
			set(PLUGIN_INSTALL_TAG ${PLUGIN_GIT_TAG})
		endif()
		dk_printVar(PLUGIN_INSTALL_TAG)
	endif()

	#dk_printVar(PLUGIN_URL)
	#dk_printVar(PLUGIN_URL_LIST)
	#dk_printVar(PLUGIN_URL_LENGTH)
	#dk_printVar(PLUGIN_URL_NODE0)
	#dk_printVar(PLUGIN_URL_NODE1)
	#dk_printVar(PLUGIN_URL_NODE2)
	#dk_printVar(PLUGIN_URL_NODE3)
	#dk_printVar(PLUGIN_URL_NODE4)
	#dk_printVar(PLUGIN_URL_NODE5)
	#dk_printVar(PLUGIN_URL_FILENAME)
	#dk_printVar(PLUGIN_URL_EXTENSION)
	#dk_printVar(PLUGIN_URL_FILE)
	#dk_printVar(PLUGIN_URL_FILE_LOWER)
	#dk_printVar(PLUGIN_URL_FILE_UPPER)
	#dk_printVar(PLUGIN_URL_LENGTH)
	#dk_printVar(PLUGIN_IMPORT)
	#dk_printVar(PLUGIN_IMPORT_PATH)
	#dk_printVar(PLUGIN_IMPORT_NAME)
	#dk_printVar(PLUGIN_IMPORT_NAME_LOWER)
	#dk_printVar(PLUGIN_IMPORT_NAME_UPPER)
	#dk_printVar(PLUGIN_GIT)
	#dk_printVar(PLUGIN_GIT_FILENAME)
	#dk_printVar(PLUGIN_GIT_NAME)
	#dk_printVar(PLUGIN_GIT_NAME_LOWER)
	#dk_printVar(PLUGIN_GIT_NAME_UPPER)
	#dk_printVar(PLUGIN_GIT_BRANCH)
	#dk_printVar(PLUGIN_GIT_TAG)
	#dk_printVar(PLUGIN_INSTALL)
	#dk_printVar(PLUGIN_INSTALL_URL)
	#dk_printVar(PLUGIN_INSTALL_NAME)
	#dk_printVar(PLUGIN_INSTALL_VERSION)
	#dk_printVar(PLUGIN_INSTALL_FOLDER)
	#dk_printVar(PLUGIN_INSTALL_PATH)
	
	if(PLUGIN_IMPORT AND PLUGIN_GIT)
		if(NOT ${PLUGIN_IMPORT_NAME_LOWER} STREQUAL ${PLUGIN_GIT_NAME_LOWER})
			dk_warning("PLUGIN_IMPORT_NAME_LOWER:${PLUGIN_IMPORT_NAME_LOWER} and PLUGIN_GIT_NAME_LOWER:${PLUGIN_GIT_NAME_LOWER} do not match ")
		endif()
	endif()

	## Setup the PLUGIN_VAR_PREFIX
	dk_set(PLUGIN_VAR_PREFIX ${PLUGIN_IMPORT_NAME_UPPER})
	#dk_printVar(PLUGIN_VAR_PREFIX)
	
	##### Warn if there are any non-alphanumeric characters in the PLUGIN_IMPORT_NAME ######
	dk_convertToCIdentifier(${PLUGIN_IMPORT_NAME_UPPER} PLUGIN_VAR_PREFIX)
	if(NOT ${PLUGIN_IMPORT_NAME_UPPER} STREQUAL ${PLUGIN_VAR_PREFIX})
		dk_notice("${PLUGIN_IMPORT_NAME_UPPER} contains non-alphanumeric characters and is changed to ${PLUGIN_VAR_PREFIX}")
	endif()
	if(PLUGIN_INSTALL_PATH)
		dk_set(${PLUGIN_VAR_PREFIX} ${PLUGIN_INSTALL_PATH})
		#dk_printVar(${PLUGIN_VAR_PREFIX})
	endif()
	if(PLUGIN_INSTALL_URL)
		dk_set(${PLUGIN_VAR_PREFIX}_URL ${PLUGIN_INSTALL_URL})
		#dk_printVar(${PLUGIN_VAR_PREFIX}_URL)
	endif()
	if(PLUGIN_INSTALL_VERSION)
		dk_set(${PLUGIN_VAR_PREFIX}_VERSION ${PLUGIN_INSTALL_VERSION})
		#dk_printVar(${PLUGIN_VAR_PREFIX}_VERSION)
	endif()
	if(PLUGIN_INSTALL_FOLDER)
		dk_set(${PLUGIN_VAR_PREFIX}_FOLDER ${PLUGIN_INSTALL_FOLDER})
		#dk_printVar(${PLUGIN_VAR_PREFIX}_FOLDER)
	endif()
	if(PLUGIN_INSTALL_FOLDER)
		dk_set(${PLUGIN_VAR_PREFIX}_NAME ${PLUGIN_INSTALL_FOLDER})
		#dk_printVar(${PLUGIN_VAR_PREFIX}_NAME)
	endif()
	if(PLUGIN_INSTALL_BRANCH)
		dk_set(${PLUGIN_VAR_PREFIX}_BRANCH ${PLUGIN_INSTALL_BRANCH})
		#dk_printVar(${PLUGIN_VAR_PREFIX}_BRANCH)
	endif()
	if(PLUGIN_INSTALL_TAG)
		dk_set(${PLUGIN_VAR_PREFIX}_TAG ${PLUGIN_INSTALL_TAG})
		#dk_printVar(${PLUGIN_VAR_PREFIX}_TAG)
	endif()
	
	set(${RESULT} ${PLUGIN_IMPORT_NAME_LOWER} PARENT_SCOPE)
endfunction()







function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)
