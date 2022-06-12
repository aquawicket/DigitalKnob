DKLoad(Color)

# DKTRACE(msg)
#
macro(DKTRACE msg)
	DKCall(dk_updateLogInfo)
	message(WARNING "${H_black}${STACK_HEADER}${CLR}${B_blue}${msg}${CLR}")
endmacro()