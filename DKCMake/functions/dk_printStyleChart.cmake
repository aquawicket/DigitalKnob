include(${DKCMAKE_DIR}/functions/DK.cmake)
include_guard()

###############################################################################
# dk_printStyleChart()
#
#	TODO
#
function(dk_printStyleChart)
	dk_debugFunc(${ARGV})
	
	message(" ")
	message(       "Style Chart")
	message(       "${ESC_0}     ESC_0         ${clr}")
	message(       "${ESC_1}     ESC_1         ${clr}")
	message(       "${ESC_2}     ESC_2         ${clr}")
	message(       "${ESC_3}     ESC_3         ${clr}")
	message(       "${ESC_4}     ESC_4         ${clr}")
	message(       "${ESC_5}     ESC_5         ${clr}")
	message(       "${ESC_6}     ESC_6         ${clr}")
	message(       "${ESC_7}     ESC_7         ${clr}")
	message(       "${ESC_8}     ESC_8         ${clr}")
	message(       "${ESC_9}     ESC_9         ${clr}")
	message(      "${ESC_10}     ESC_10        ${clr}")
endfunction()
