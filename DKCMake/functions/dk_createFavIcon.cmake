include_guard()

###############################################################################
# dk_createFavIcon()
#
#	@inpath		- Full path of the image file to use (.png)
#	@outpath	- Full path of the output file to save to (.ico)
#
function(dk_createFavIcon inpath outpath)
	DKDEBUGFUNC(${ARGV})
	#include("${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake")
	dk_load(imagemagick)
	if(IMAGEMAGICK_CONVERT)
		dk_executeProcess(${IMAGEMAGICK_CONVERT} ${inpath} -define icon:auto-resize=16 ${outpath})
	else()
		dk_error("IMAGEMAGICK_CONVERT is invalid!")
	endif()
endfunction()