#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


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
	
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL $ENV{DKCMAKE_DIR})
		if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${Target_App_Dir})
			if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL $ENV{DKIMPORTS_DIR}/${plugin})
				if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCPP_PLUGINS_DIR}/${plugin})
					dk_fatal("dk_disable() Can only be used from the DKCMake/DKDisabled.cmake file. This is to avoid having disabled libraries hideing everywhere")
				endif()
			endif()
		endif()
	endif()
	
	dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
	if(NOT EXISTS $ENV{DKIMPORTS_DIR}/${plugin}/DKINSTALL.cmake)
		if(NOT EXISTS ${DKCPP_PLUGINS_DIR}/${plugin}/DKINSTALL.cmake)
			dk_warning("dk_disable(${plugin}):  unable to locate plugin in /3rdParty/_DKIMPORTS  or /DKCpp/plugins")
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
	dk_debugFunc(0)
	
	dk_disable(zlib)
endfunction()