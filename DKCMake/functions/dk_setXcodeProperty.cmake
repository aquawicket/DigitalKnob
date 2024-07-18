include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##############################################################################
# dk_setXcodeProperty(TARGET property value)
# 
#	Set a XCode specific property
#
#   @TARGET		- The project target name to set the property for
#	@property	- The name of the property to set
#   @value		- The value to set the property to
#
function(dk_setXcodeProperty TARGET property value)
	dk_debugFunc(${ARGV})
	
    set_property(TARGET ${TARGET} PROPERTY XCODE_ATTRIBUTE_${property} ${value})
endfunction()







function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()