#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_DKBASH_DIR()
#
#
function(dk_DKBASH_DIR)
	dk_debugFunc()

	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
		
		dk_set(DKBASH_DIR "${DKBRANCH_DIR}/DKBash")
		set(ENV{DKBASH_DIR} "${DKBRANCH_DIR}/DKBash")
		#dk_printVar(DKBASH_DIR)
			dk_set(DKBASH_FUNCTIONS_DIR "${DKBASH_DIR}/functions")
			set(ENV{DKBASH_FUNCTIONS_DIR} "${DKBASH_DIR}/functions")
			#dk_printVar(DKBASH_FUNCTIONS_DIR)
			dk_set(DKBASH_FUNCTIONS_DIR_ "${DKBASH_DIR}/functions/")
			set(ENV{DKBASH_FUNCTIONS_DIR_} "${DKBASH_DIR}/functions/")
			#dk_printVar(DKBASH_FUNCTIONS_DIR_)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_DKBASH_DIR()
	dk_printVar(DKBASH_DIR)
	dk_printVar(DKBASH_FUNCTIONS_DIR)
	dk_printVar(DKBASH_FUNCTIONS_DIR_)
endfunction()
