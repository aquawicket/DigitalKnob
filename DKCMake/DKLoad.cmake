##################################################################################
# DKLoad(filename)
#
#	load a ${filename}.cmake file located in the DKCMake path 
#
macro(DKLoad filename)
	include(${DIGITALKNOB}/DK/DKCMake/${filename}.cmake)
endmacro()
