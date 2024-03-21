include_guard()

###############################################################################
# dk_getDKPaths()
#
#	Fill the cashe variables with DigitalKnob specfic directories
#
function(dk_getDKPaths)
	###### Get DKBRANCH_DIR ######
	#message(DEBUG "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")
	#message(DEBUG "CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")
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
	endwhile()
	if(NOT EXISTS "${DKBRANCH_DIR}/.git")
		message(FATAL_ERROR "Could not locate a .git folder in the branch directory")
	endif()
	get_filename_component(DKBRANCH ${DKBRANCH_DIR} NAME)

	set(DKBRANCH ${DKBRANCH} CACHE INTERNAL "" FORCE)
	set(DKBRANCH_DIR ${DKBRANCH_DIR} CACHE INTERNAL "" FORCE)
	set(DIGITALKNOB_DIR ${DIGITALKNOB_DIR} CACHE INTERNAL "" FORCE)
	
	message(DEBUG "DKBRANCH_DIR = ${DKBRANCH_DIR}")
	message(DEBUG "DKBRANCH = ${DKBRANCH}")
	message(DEBUG "DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}")
	message(DEBUG "DIGITALKNOB = ${DIGITALKNOB}")

	###### Set DKBRANCH_DIR ######
	#string(FIND "${DKCMAKE_DIR}" "DKCMake" pos)
	#math(EXPR pos "${pos}-1")
	#string(SUBSTRING ${DKCMAKE_DIR} 0 ${pos} BRANCH_DIR)
	#set(DKBRANCH_DIR ${BRANCH_DIR} CACHE INTERNAL "" FORCE)
	#message(DEBUG DKBRANCH_DIR)
	
	###### Set DIGITALKNOB_DIR ######
	#string(FIND "${DKBRANCH_DIR}" "digitalknob" pos)
	#string(SUBSTRING ${DKBRANCH_DIR} 0 ${pos} DK_DIR)
	#set(DIGITALKNOB_DIR ${DK_DIR}digitalknob CACHE INTERNAL "" FORCE)
	#message(DEBUG DIGITALKNOB_DIR)
	
	##### Set DKCMAKE_DIR ######
	set(DKCMAKE_DIR ${DKBRANCH_DIR}/DKCMake CACHE INTERNAL "" FORCE)
	set(ENV{DKCMAKE_DIR} ${DKCMAKE_DIR})
	message(DEBUG "DKCMAKE_DIR = ${DKCMAKE_DIR}")
	
	##### Set DKTOOLS_DIR ######
	set(DKTOOLS_DIR ${DIGITALKNOB_DIR}/DKTools CACHE INTERNAL "" FORCE)
	message(DEBUG "DKTOOLS_DIR = ${DKTOOLS_DIR}")

	##### Set DK3RDPARTY_DIR ######
	set(DK3RDPARTY_DIR ${DKBRANCH_DIR}/3rdParty CACHE INTERNAL "" FORCE)
	message(DEBUG "DK3RDPARTY_DIR = ${DK3RDPARTY_DIR}")

	###### Set DKIMPORTS_DIR ######
	set(DKIMPORTS_DIR ${DK3RDPARTY_DIR}/_DKIMPORTS CACHE INTERNAL "" FORCE)
	message(DEBUG "DKIMPORTS_DIR = ${DKIMPORTS_DIR}")

	###### Set DKAPPS_DIR ######
	set(DKAPPS_DIR ${DKBRANCH_DIR}/DKApps CACHE INTERNAL "" FORCE)
	message(DEBUG "DKAPPS_DIR = ${DKAPPS_DIR}")

	###### Set DKPLUGINS_DIR ######
	set(DKPLUGINS_DIR ${DKBRANCH_DIR}/DKPlugins CACHE INTERNAL "" FORCE)
	message(DEBUG "DKPLUGINS_DIR = ${DKPLUGINS_DIR}")

	###### Set DKDOWNLOAD_DIR ######
	set(DKDOWNLOAD_DIR ${DIGITALKNOB_DIR}/download CACHE INTERNAL "" FORCE)
	message(DEBUG "DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR}")

	###### Set DKWEB ######
	set(DKWEB "http://127.0.0.1" CACHE INTERNAL "" FORCE)
	message(DEBUG "DKWEB = ${DKWEB}")
	
endfunction()
