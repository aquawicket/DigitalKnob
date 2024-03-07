include_guard()

##############################################################################
# dk_setXcodeProperty(TARGET property value)
# 
#	Set a XCode specific property
#
#   @TARGET		- The project target name to set the property for
#	@property	- The name of the property to set
#   @value		- The value to set the property to
#
macro(dk_setXcodeProperty TARGET property value)
	DKDEBUGFUNC(${ARGV})
    set_property(TARGET ${TARGET} PROPERTY XCODE_ATTRIBUTE_${property} ${value})
endmacro()
