#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_disable(Plugin) #target
#
#	TODO:  Turn this into a macro. Then, if we disable a Plugin and while we are in that Plugin's current list file, we can automatically return
#
#	@Plugin				- TODO
#	@target:(optional)	- TODO
#
function(dk_disable Plugin)
	dk_debugFunc()
	
	#set(Plugin "${ARGV0}")
	if(BYPASS_DISABLE)
		dk_info("* dk_disable(${Plugin}) ignored.  BYPASS_DISABLE is set to ON. ${Plugin} will not be disabled *")
		dk_return()
	endif()
	
	#if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL "${DKCMAKE_DIR}")
	#	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL "${Target_App_Dir}")
	#		if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL "${DKIMPORTS_DIR}/${Plugin}")
	#			if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL "${DKCPP_PLUGINS_DIR}/${Plugin}")
	#				dk_fatal("dk_disable() Can only be used from the DKCMake/DKDisabled.cmake file. This is to avoid having disabled libraries hideing everywhere")
	#			endif()
	#		endif()
	#	endif()
	#endif()
	
	dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
	if(NOT EXISTS ${DKIMPORTS_DIR}/${Plugin}/DKINSTALL.cmake)
		if(NOT EXISTS ${DKCPP_PLUGINS_DIR}/${Plugin}/DKINSTALL.cmake)
			dk_warning("dk_disable(${Plugin}):  unable to locate Plugin in /3rdParty/_DKIMPORTS  or /DKCpp/plugins")
			return()
		endif()
	endif()
	
	if(${ARGC} GREATER 1)
		dk_unset(${ARGV1})
		dk_unset(HAVE_${ARGV1})
		dk_convertToCIdentifier(${ARGV1} argv1_macro)		# In c/c++ we can't use certian symbals in the preprocessor or in macros. I.E.    - characters'smust be turned to _
		dk_undefine(HAVE_${argv1_macro})
		dk_undepend(${ARGV1})
		#dk_notice("${ARGV1} set to DISABLED")
	else()
		dk_unset(${Plugin})
		dk_unset(HAVE_${Plugin})
		dk_convertToCIdentifier(${Plugin} Plugin_macro)	   # In c/c++ we can't use certian symbals in the preprocessor or in macros. I.E.     - characters's must be turned to _
		dk_undefine(HAVE_${Plugin_macro})
		dk_undepend(${Plugin})
		#dk_notice("${Plugin} set to DISABLED")
	endif()	
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_disable(zlib)
endfunction()