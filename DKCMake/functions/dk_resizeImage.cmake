include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_resizeImage(inpath width height outpath)
#
#	@inpath		- Full path of the image file to resize
#	@width		- The number of pixels in with to resize to 
#	@height		- The number of pixels in height to resize to
#	@outpath	- Full path of the output file to save to
#
function(dk_resizeImage inpath width height outpath)
	dk_debugFunc(${ARGV})
	
	dk_dirname(${outpath} outdir)
	dk_assert(outdir)

	dk_makeDirectory(${outdir})

	if(MAC_HOST)
		dk_executeProcess(sips -z ${width} ${height} ${inpath} --out ${outpath})
	else()
		dk_load(${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake)
		if(NOT IMAGEMAGICK_CONVERT_EXE)
			dk_warning("IMAGEMAGICK_CONVERT_EXE is invalid!")
			return()
		endif()
		dk_executeProcess(${IMAGEMAGICK_CONVERT_EXE} ${inpath} -resize ${width}x${height} ${outpath})
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()