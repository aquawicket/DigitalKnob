# https://web.archive.org/web/20200916125901if_/https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-20200831-4a11a6f-win32-static.zip

if(NOT WIN AND NOT MAC)
	return()
endif()

#dk_set(FFMPEG_VERSION 20200831-4a11a6f)
#dk_set(FFMPEG_NAME ffmpeg-${FFMPEG_VERSION}-${OS}-static)
#dk_set(FFMPEG_DL https://web.archive.org/web/20200916125901if_/https://ffmpeg.zeranoe.com/builds/${OS}/static/${FFMPEG_NAME}.zip)
#dk_set(FFMPEG ${3RDPARTY}/${FFMPEG_NAME})
### INSTALL ###
#dk_import(${FFMPEG_DL} ${FFMPEG})

WIN32_dk_import(https://web.archive.org/web/20200919011114mp_/https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-20200831-4a11a6f-win32-static.zip)
WIN64_dk_import(https://web.archive.org/web/20200919011114mp_/https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-20200831-4a11a6f-win64-static.zip)
MAC64_dk_import(https://web.archive.org/web/20200919011114mp_/https://ffmpeg.zeranoe.com/builds/macos64/static/ffmpeg-20200831-4a11a6f-macos64-static.zip)


### LINK ###
dk_define(__STDC_CONSTANT_MACROS)
if(DKAPP)
	dk_setPath(${DKPROJECT}/assets/DKFfmpeg)
	#dk_copy(${FFMPEG-STATIC}/bin/avcodec-56.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	#dk_copy(${FFMPEG-STATIC}/bin/avdevice-56.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	#dk_copy(${FFMPEG-STATIC}/bin/avfilter-5.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	#dk_copy(${FFMPEG-STATIC}/bin/avformat-56.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	#dk_copy(${FFMPEG-STATIC}/bin/avutil-54.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	#dk_copy(${FFMPEG-STATIC}/bin/postproc-53.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	#dk_copy(${FFMPEG-STATIC}/bin/swresample-1.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	#dk_copy(${FFMPEG-STATIC}/bin/swscale-3.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)

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
endif()

### 3RDPARTY LINK ###
# TODO
dk_set(FFMPEG-STATIC_CMAKE -DFFMPEG_INCLUDE_DIR=${FFMPEG-STATIC})
