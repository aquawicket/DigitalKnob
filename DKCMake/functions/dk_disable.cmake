#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development


# TODO:  Turn this into a macro. Then, if we disable a plugin and while we are in that plugin's current list file, we can automatically return

###############################################################################
# dk_disable(plugin) #target
#
#	TODO
#
#	@plugin				- TODO
#	@target:(optional)	- TODO
#
function(dk_disable plugin)
	dk_debugFunc()
	
	if(BYPASS_DISABLE)
		dk_info("* dk_disable(${plugin}) ignored.  BYPASS_DISABLE is set to ON. ${plugin} will not be disabled *")
		dk_return()
	endif()
	
<<<<<<< HEAD
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE_DIR})
		if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DK_PROJECT_DIR})
			if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKIMPORTS_DIR}/${plugin})
				if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPLUGINS_DIR}/${plugin})
=======
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL $ENV{DKCMAKE_DIR})
		if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DK_Project_Dir})
			if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL $ENV{DKIMPORTS_DIR}/${plugin})
				if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCPP_PLUGINS_DIR}/${plugin})
>>>>>>> Development
					dk_fatal("dk_disable() Can only be used from the DKCMake/DKDisabled.cmake file. This is to avoid having disabled libraries hideing everywhere")
				endif()
			endif()
		endif()
	endif()
	
<<<<<<< HEAD
	dk_validate(DKPLUGINS_DIR "dk_DKPLUGINS_DIR()")
	if(NOT EXISTS ${DKIMPORTS_DIR}/${plugin}/DKMAKE.cmake)
		if(NOT EXISTS ${DKPLUGINS_DIR}/${plugin}/DKMAKE.cmake)
			dk_warning("dk_disable(${plugin}):  unable to locate plugin in /3rdParty/_DKIMPORTS  or /DKPlugins")
=======
	dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
	if(NOT EXISTS $ENV{DKIMPORTS_DIR}/${plugin}/DKINSTALL.cmake)
		if(NOT EXISTS ${DKCPP_PLUGINS_DIR}/${plugin}/DKINSTALL.cmake)
			dk_warning("dk_disable(${plugin}):  unable to locate plugin in /3rdParty/_DKIMPORTS  or /DKCpp/plugins")
>>>>>>> Development
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
		dk_unset(${plugin})
		dk_unset(HAVE_${plugin})
		dk_convertToCIdentifier(${plugin} plugin_macro)	   # In c/c++ we can't use certian symbals in the preprocessor or in macros. I.E.     - characters's must be turned to _
		dk_undefine(HAVE_${plugin_macro})
		dk_undepend(${plugin})
		#dk_notice("${plugin} set to DISABLED")
	endif()	
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_disable(zlib)
endfunction()