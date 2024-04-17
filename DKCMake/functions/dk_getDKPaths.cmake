include_guard()

###############################################################################
# dk_getDKPaths()
#
#	Fill the cashe variables with DigitalKnob specfic directories
#
function(dk_getDKPaths)
	DKDEBUGFUNC(${ARGV})
	
	###### Get DKBRANCH_DIR ######
	#dk_debug(CMAKE_SOURCE_DIR)
	#dk_debug(CMAKE_CURRENT_LIST_DIR)
	string(COMPARE GREATER ${CMAKE_CURRENT_LIST_DIR} ${CMAKE_SOURCE_DIR} CURRENT_DIR_LONGER)
	if(CURRENT_DIR_LONGER)
		set(DKBRANCH_DIR ${CMAKE_CURRENT_LIST_DIR})
	else()
		set(DKBRANCH_DIR ${CMAKE_SOURCE_DIR})
	endif()
	get_filename_component(DIGITALKNOB_DIR ${DKBRANCH_DIR} DIRECTORY)
	get_filename_component(DIGITALKNOB ${DIGITALKNOB_DIR} NAME)
	while(NOT ${DIGITALKNOB} STREQUAL "digitalknob")
		get_filename_component(DKBRANCH_DIR ${DKBRANCH_DIR} DIRECTORY)
		get_filename_component(DIGITALKNOB_DIR ${DKBRANCH_DIR} DIRECTORY)
		get_filename_component(DIGITALKNOB ${DIGITALKNOB_DIR} NAME)
		if(${DKBRANCH_DIR} STREQUAL ${DIGITALKNOB_DIR})
			dk_error("could not locate digitalknob")
		endif()
	endwhile()
	if(NOT EXISTS "${DKBRANCH_DIR}/.git")
		dk_error("Could not locate a .git folder in the branch directory")
	endif()
	get_filename_component(DKBRANCH ${DKBRANCH_DIR} NAME)

	set(DKBRANCH ${DKBRANCH} CACHE INTERNAL "" FORCE)
	set(DKBRANCH_DIR ${DKBRANCH_DIR} CACHE INTERNAL "" FORCE)
	set(DIGITALKNOB_DIR ${DIGITALKNOB_DIR} CACHE INTERNAL "" FORCE)
	
	dk_debug(DKBRANCH_DIR)
	dk_debug(DKBRANCH)
	dk_debug(DIGITALKNOB_DIR)
	dk_debug(DIGITALKNOB)
	
	##### Set DKCMAKE_DIR ######
	set(DKCMAKE_DIR ${DKBRANCH_DIR}/DKCMake CACHE INTERNAL "" FORCE)
	set(ENV{DKCMAKE_DIR} ${DKCMAKE_DIR})
	dk_debug(DKCMAKE_DIR)
	
	##### Set DKTOOLS_DIR ######
	set(DKTOOLS_DIR ${DIGITALKNOB_DIR}/DKTools CACHE INTERNAL "" FORCE)
	dk_debug(DKTOOLS_DIR)

	##### Set DK3RDPARTY_DIR ######
	set(DK3RDPARTY_DIR ${DKBRANCH_DIR}/3rdParty CACHE INTERNAL "" FORCE)
	dk_debug(DK3RDPARTY_DIR)

	###### Set DKIMPORTS_DIR ######
	set(DKIMPORTS_DIR ${DK3RDPARTY_DIR}/_DKIMPORTS CACHE INTERNAL "" FORCE)
	dk_debug(DKIMPORTS_DIR)

	###### Set DKAPPS_DIR ######
	set(DKAPPS_DIR ${DKBRANCH_DIR}/DKApps CACHE INTERNAL "" FORCE)
	dk_debug(DKAPPS_DIR)

	###### Set DKPLUGINS_DIR ######
	set(DKPLUGINS_DIR ${DKBRANCH_DIR}/DKPlugins CACHE INTERNAL "" FORCE)
	dk_debug(DKPLUGINS_DIR)

	###### Set DKDOWNLOAD_DIR ######
	set(DKDOWNLOAD_DIR ${DIGITALKNOB_DIR}/download CACHE INTERNAL "" FORCE)
	dk_debug(DKDOWNLOAD_DIR)

	###### Set DKWEB ######
	set(DKWEB "http://127.0.0.1" CACHE INTERNAL "" FORCE)
	dk_debug(DKWEB)
	
endfunction()
