include_guard()

###############################################################################
# dk_listReplace(LIST old_value new_value)
#  
#	Replace a list item with a new value
#
#	@LIST		- TODO
#	@old_value	- The value to replace
#	@new_value	- The new value to replace with
#
macro(dk_listReplace LIST old_value new_value)
	#DKDEBUGFUNC(${ARGV})
    list(FIND ${LIST} ${old_value} old_value_INDEX)
    if(old_value_INDEX GREATER_EQUAL 0)
        list(REMOVE_AT ${LIST} ${old_value_INDEX})
        list(INSERT ${LIST} ${old_value_INDEX} ${new_value})
    endif()
endmacro()
