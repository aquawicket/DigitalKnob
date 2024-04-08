include_guard()

###############################################################################
# dk_createWindowsIcon()
#
#	@inpath		- Full path of the image file to use (.png)
#	@outpath	- Full path of the output file to save to (.ico)
#
function(dk_createWindowsIcon inpath outpath)
	DKDEBUGFUNC(${ARGV})
	
	dk_load(${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake)
	if(IMAGEMAGICK_CONVERT)
		dk_executeProcess(${IMAGEMAGICK_CONVERT} ${inpath} -define icon:auto-resize=256,128,64,48,32,16 ${outpath})
	else()
		dk_error("IMAGEMAGICK_CONVERT is invalid!")
	endif()
endfunction()