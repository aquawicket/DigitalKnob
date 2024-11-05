#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_DK3RDPARTY_DIR()
#
#
function(dk_DK3RDPARTY_DIR)
	dk_debugFunc()
	
	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	dk_dirname(${CMAKE_CURRENT_LIST_DIR} FOLDER)
	dk_set(DKBRANCH "Development")
	
	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
	if(EXISTS "${DIGITALKNOB_DIR}/${DKBRANCH}/.git")
#		BRANCH="$(${GIT_EXE} rev-parse --abbrev-ref HEAD)"
#		if [ "${BRANCH}" = "${FOLDER}" ]; then
#			DKBRANCH="${FOLDER}"
#		fi
	endif()
	#dk_printVar(DKBRANCH)
	
	dk_set(DKBRANCH_DIR "${DIGITALKNOB_DIR}/${DKBRANCH}")
	set(ENV{DKBRANCH_DIR} "${DIGITALKNOB_DIR}/${DKBRANCH}")
	#dk_printVar(DKBRANCH_DIR)
		
		dk_set(DK3RDPARTY_DIR "${DKBRANCH_DIR}/3rdParty")
		set(ENV{DK3RDPARTY_DIR} "${DKBRANCH_DIR}/3rdParty")
		#dk_printVar(DK3RDPARTY_DIR)
			
			dk_set(DKIMPORTS_DIR "${DK3RDPARTY_DIR}/_DKIMPORTS")
			set(ENV{DKIMPORTS_DIR} "${DK3RDPARTY_DIR}/_DKIMPORTS")
			#dk_printVar(DKIMPORTS_DIR)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_DK3RDPARTY_DIR()
endfunction()
