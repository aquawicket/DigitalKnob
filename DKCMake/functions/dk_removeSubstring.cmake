include_guard()

###############################################################################
# dk_removeSubstring(removethis fromthis RESULT)
#
#	TODO
#
#	@removethis		- TODO
#	@fromthis		- TODO
#	@RESULT			- TODO
#
function(dk_removeSubstring removethis fromthis RESULT)
	DKDEBUGFUNC(${ARGV})
	dk_dump(removethis)
	dk_dump(fromthis)
	#foreach(item ${fromthis})
	#	string(REPLACE ${removethis} "" item ${item})
	#	list(APPEND rtn ${item})
	#endforeach()
	string(REPLACE ${removethis} "" rtn "${fromthis}")
	string(REPLACE "  " " " rtn "${rtn}") #replace doube spaces with single space
	set(${RESULT} "${rtn}" PARENT_SCOPE) #return RESULT
	dk_dump(rtn)
	#dk_wait()
endfunction()
dk_createOsMacros("dk_removeSubstring")