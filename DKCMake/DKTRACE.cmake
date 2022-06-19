dk_load(Color)

# DKTRACE(msg)
#
macro(DKTRACE msg)
	dk_call(dk_updateLogInfo)
	message(WARNING "${H_black}${STACK_HEADER}${CLR}${B_blue}${msg}${CLR}")
endmacro()