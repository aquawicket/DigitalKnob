# https://web.archive.org/web/20200916125901if_/https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-20200831-4a11a6f-win32-static.zip

dk_set(FFMPEG_VERSION 20200831-4a11a6f)
dk_set(FFMPEG_NAME ffmpeg-${FFMPEG_VERSION}-${OS}-static)
dk_set(FFMPEG_DL https://web.archive.org/web/20200916125901if_/https://ffmpeg.zeranoe.com/builds/${OS}/static/${FFMPEG_NAME}.zip)
dk_set(FFMPEG ${3RDPARTY}/${FFMPEG_NAME})

### INSTALL ###
DKINSTALL(${FFMPEG_DL} ffmpeg_static ${FFMPEG})



### LINK ###
DKDEFINE(__STDC_CONSTANT_MACROS)
IF(DKAPP)
	DKSETPATH(${DKPROJECT}/assets/DKFfmpeg)
	#dk_copy(${FFMPEG_DLL}/bin/avcodec-56.dll ${DKPROJECT}/assets/DKFfmpeg TRUE)
	#dk_copy(${FFMPEG_DLL}/bin/avdevice-56.dll ${DKPROJECT}/assets/DKFfmpeg TRUE)
	#dk_copy(${FFMPEG_DLL}/bin/avfilter-5.dll ${DKPROJECT}/assets/DKFfmpeg TRUE)
	#dk_copy(${FFMPEG_DLL}/bin/avformat-56.dll ${DKPROJECT}/assets/DKFfmpeg TRUE)
	#dk_copy(${FFMPEG_DLL}/bin/avutil-54.dll ${DKPROJECT}/assets/DKFfmpeg TRUE)
	#dk_copy(${FFMPEG_DLL}/bin/postproc-53.dll ${DKPROJECT}/assets/DKFfmpeg TRUE)
	#dk_copy(${FFMPEG_DLL}/bin/swresample-1.dll ${DKPROJECT}/assets/DKFfmpeg TRUE)
	#dk_copy(${FFMPEG_DLL}/bin/swscale-3.dll ${DKPROJECT}/assets/DKFfmpeg TRUE)

	#LIST(APPEND DEBUG_LINK_FLAGS /DELAY:UNLOAD)
	#LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:avcodec-56.dll)
	#LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:avdevice-56.dll)
	#LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:avformat-56.dll)
	#LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:avutil-54.dll)
	#LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:swresample-1.dll)
	#LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:swscale-3.dll)
	## LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:avfilter-5.dll)
	## LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:postproc-53.dll)
	#LIST(APPEND RELEASE_LINK_FLAGS /DELAY:UNLOAD)
	#LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:avcodec-56.dll)
	#LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:avdevice-56.dll)
	#LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:avformat-56.dll)
	#LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:avutil-54.dll)
	#LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:swresample-1.dll)
	#LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:swscale-3.dll)
	## LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:avfilter-5.dll)
	## LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:postproc-53.dll)
ENDIF()