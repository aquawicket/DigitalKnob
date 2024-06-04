include(${DKCMAKE_DIR}/functions/DK.cmake)
include_guard()

##################################################################################
# dk_notice(msg)
#
#	Print a NOTICE message
#
#	@msg	- The message to print
#
function(dk_notice msg)
	dk_debugFunc(${ARGV})
	
	#dk_updateLogInfo()
	#message(NOTICE "${H_black}${STACK_HEADER}${clr}${B_yellow} ${msg} ${clr}")
	message(NOTICE "${B_yellow}${msg}${clr}")
endfunction()
