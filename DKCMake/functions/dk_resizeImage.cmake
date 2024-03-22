include_guard()

###############################################################################
# dk_resizeImage(inpath width height outpath)
#
#	@inpath		- Full path of the image file to resize
#	@width		- The number of pixels in with to resize to 
#	@height		- The number of pixels in height to resize to
#	@outpath	- Full path of the output file to save to
#
function(dk_resizeImage inpath width height outpath)
	DKDEBUGFUNC(${ARGV})
	get_filename_component(outdir ${outpath} DIRECTORY)
	DK_ASSERT(outdir)

	dk_makeDirectory(${outdir})

	if(MAC_HOST)
		dk_executeProcess(sips -z ${width} ${height} ${inpath} --out ${outpath})
	else()
		dk_load(${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake)
		if(NOT IMAGEMAGICK_CONVERT)
			dk_warn("IMAGEMAGICK_CONVERT is invalid!")
			return()
		endif()
		dk_executeProcess(${IMAGEMAGICK_CONVERT} ${inpath} -resize ${width}x${height} ${outpath})
	endif()
endfunction()