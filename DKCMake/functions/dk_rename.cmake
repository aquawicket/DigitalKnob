include_guard()

###############################################################################
# dk_rename(from to) OVERWRITE NOERROR
#
#	Rename file or directory or move a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing files is enabled
#   NOERROR     - if any of the parameters equals NOERROR, dk_error() messages will not be displayed
#
function(dk_rename from to) # FLAGS: OVERWRITE, NOERROR
	DKDEBUGFUNC(${ARGV})
	dk_get_option(OVERWRITE ${ARGV})
	dk_get_option(NOERROR ${ARGV})
	
	dk_info("Renameing ${from} to ${to}")
	if(NOT EXISTS ${from})
		#if(NOT noerror)
		if(NOT NOERROR)
			dk_error("from:${from} not found")
		endif()
		return()
	endif()
	if(EXISTS ${to})
		#if(NOT ${overwrite})
		if(NOT OVERWRITE)
			dk_error("Cannot rename file. Destiantion exists and not set to overwrite")
		endif()
		dk_remove(${to})
	endif()
	
	#FIXME: the base directory of the ${to} path must exist.    
	# EXAMPLE:   to = MyDir/Something/MustExist/myfile.text
	#							or
	#		     to = MyDir/Something/MustExist/newdir
	#
	# So we need to get path one level up..   MyDir/Something/MustExist
	# then make sure it exists, and if it doesn't, we need to create it. 
	
	file(RENAME ${from} ${to})
endfunction()
dk_createOsMacros("dk_rename")
