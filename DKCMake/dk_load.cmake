include_guard()

##################################################################################
# dk_load(filename)
#
#	load a ${filename}.cmake file located in the DKCMake path 
#
macro(dk_load filename)
	include(${DKCMAKE}/${filename}.cmake)
endmacro()
