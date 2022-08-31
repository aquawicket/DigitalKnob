# https://web.archive.org/web/20200919011114/https://ffmpeg.zeranoe.com/builds/
# https://web.archive.org/web/20200918193207/https://ffmpeg.zeranoe.com/builds/win32/shared/ffmpeg-20200831-4a11a6f-win32-shared.zip
# https://web.archive.org/web/20200916073634/https://ffmpeg.zeranoe.com/builds/win64/shared/ffmpeg-20200828-ccc7120-win64-shared.zip
# https://web.archive.org/web/20200919011114mp_/https://ffmpeg.zeranoe.com/builds/macos64/shared/ffmpeg-20200831-4a11a6f-macos64-shared.zip

#dk_set(FFMPEG-SHARED_VERSION 20200831-4a11a6f)
#dk_set(FFMPEG-SHARED_NAME ffmpeg-${FFMPEG-SHARED_VERSION}-${OS}-shared)
#WIN32_dk_set(FFMPEG-SHARED_DL https://web.archive.org/web/20200918193207/https://ffmpeg.zeranoe.com/builds/win32/shared/ffmpeg-20200831-4a11a6f-win32-shared.zip)
#WIN64_dk_set(FFMPEG-SHARED_DL https://web.archive.org/web/20200916073634/https://ffmpeg.zeranoe.com/builds/win64/shared/ffmpeg-20200828-ccc7120-win64-shared.zip)
#MAC64_dk_set(FFMPEG-SHARED_DL https://web.archive.org/web/20200919011114mp_/https://ffmpeg.zeranoe.com/builds/macos64/shared/ffmpeg-20200831-4a11a6f-macos64-shared.zip)
#dk_set(FFMPEG-SHARED ${3RDPARTY}/${FFMPEG-SHARED_NAME})

### INSTALL ###
#dk_import(${FFMPEG-SHARED_DL} ${FFMPEG-SHARED})

WIN32_dk_import(https://web.archive.org/web/20200918193207/https://ffmpeg.zeranoe.com/builds/win32/shared/ffmpeg-20200831-4a11a6f-win32-shared.zip)
WIN64_dk_import(https://web.archive.org/web/20200916073634/https://ffmpeg.zeranoe.com/builds/win64/shared/ffmpeg-20200828-ccc7120-win64-shared.zip)
MAC64_dk_import(https://web.archive.org/web/20200919011114mp_/https://ffmpeg.zeranoe.com/builds/macos64/shared/ffmpeg-20200831-4a11a6f-macos64-shared.zip)


### LINK ###
dk_define(__STDC_CONSTANT_MACROS)
IF(DKAPP)
	dk_setPath(${DKPROJECT}/assets/DKFfmpeg)
	dk_copy(${FFMPEG-SHARED}/bin/avcodec-56.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	dk_copy(${FFMPEG-SHARED}/bin/avdevice-56.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	dk_copy(${FFMPEG-SHARED}/bin/avfilter-5.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	dk_copy(${FFMPEG-SHARED}/bin/avformat-56.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	dk_copy(${FFMPEG-SHARED}/bin/avutil-54.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	dk_copy(${FFMPEG-SHARED}/bin/postproc-53.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	dk_copy(${FFMPEG-SHARED}/bin/swresample-1.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	dk_copy(${FFMPEG-SHARED}/bin/swscale-3.dll ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	LIST(APPEND DEBUG_LINK_FLAGS /DELAY:UNLOAD)
	LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:avcodec-56.dll)
	LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:avdevice-56.dll)
	LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:avformat-56.dll)
	LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:avutil-54.dll)
	LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:swresample-1.dll)
	LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:swscale-3.dll)
	## LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:avfilter-5.dll)
	## LIST(APPEND DEBUG_LINK_FLAGS /DELAYLOAD:postproc-53.dll)
	LIST(APPEND RELEASE_LINK_FLAGS /DELAY:UNLOAD)
	LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:avcodec-56.dll)
	LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:avdevice-56.dll)
	LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:avformat-56.dll)
	LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:avutil-54.dll)
	LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:swresample-1.dll)
	LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:swscale-3.dll)
	## LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:avfilter-5.dll)
	## LIST(APPEND RELEASE_LINK_FLAGS /DELAYLOAD:postproc-53.dll)
ENDIF()