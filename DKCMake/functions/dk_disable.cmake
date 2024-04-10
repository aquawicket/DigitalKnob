include_guard()

###############################################################################
# dk_disable(plugin) #target
#
#	TODO
#
#	@plugin				- TODO
#	@target:(optional)	- TODO
#
function(dk_disable plugin)
	DKDEBUGFUNC(${ARGV})
	
	if(BYPASS_DISABLE)
		dk_info("* dk_disable(${plugin}) ignored.  BYPASS_DISABLE is set to ON. ${plugin} will not be disabled *")
		return()
	endif()
	
	if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKCMAKE_DIR})
		if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DK_PROJECT_DIR})
			if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKIMPORTS_DIR}/${plugin})
				if(NOT ${CMAKE_CURRENT_LIST_DIR} STREQUAL ${DKPLUGINS_DIR}/${plugin})
					dk_error("dk_disable() Can only be used from the DKCMake/DKDisabled.cmake file. This is to avoid having disabled libraries hideing everywhere")
				endif()
			endif()
		endif()
	endif()
	
	if(NOT EXISTS ${DKIMPORTS_DIR}/${plugin}/DKMAKE.cmake)
		if(NOT EXISTS ${DKPLUGINS_DIR}/${plugin}/DKMAKE.cmake)
			dk_warning("dk_disable(${plugin}):  unable to locate plugin in /3rdParty/_DKIMPORTS  or /DKPlugins")
			return()
		endif()
	endif()
	
	if(${ARGC} GREATER 1)
		dk_unset(${ARGV1})
		dk_unset(HAVE_${ARGV1})
		string(MAKE_C_IDENTIFIER ${ARGV1} argv1_macro)		# In c/c++ we can't use certian symbals in the preprocess or for macros. I.E. - must be turned to _
		dk_undefine(HAVE_${argv1_macro})
		dk_undepend(${ARGV1})
	else()
		dk_unset(${plugin})
		dk_unset(HAVE_${plugin})
		string(MAKE_C_IDENTIFIER ${plugin} plugin_macro)	# In c/c++ we can't use certian symbals in the preprocess or for macros. I.E. - must be turned to _
		dk_undefine(HAVE_${plugin_macro})
		dk_undepend(${plugin})
	endif()
endfunction()