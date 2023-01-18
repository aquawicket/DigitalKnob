# https://web.archive.org/web/20200916125901if_/https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-20200831-4a11a6f-win32-static.zip
if(NOT WIN AND NOT MAC)
	dk_undepend(ffmpeg-static)
	return()
endif()


### IMPORT ###
MAC64_dk_import(https://web.archive.org/web/20200919011114mp_/https://ffmpeg.zeranoe.com/builds/macos64/static/ffmpeg-20200831-4a11a6f-macos64-static.zip)
WIN32_dk_import(https://web.archive.org/web/20200919011114mp_/https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-20200831-4a11a6f-win32-static.zip)
WIN64_dk_import(https://web.archive.org/web/20200919011114mp_/https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-20200831-4a11a6f-win64-static.zip)


### LINK ###
dk_define(__STDC_CONSTANT_MACROS)
if(DKAPP AND WIN)
	dk_setPath(${DKPROJECT}/assets/DKFfmpeg)
	dk_copy(${FFMPEG-STATIC}/bin/ffmpeg.exe ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	dk_copy(${FFMPEG-STATIC}/bin/ffplay.exe ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
	dk_copy(${FFMPEG-STATIC}/bin/ffprobe.exe ${DKPROJECT}/assets/DKFfmpeg OVERWRITE)
endif()

### 3RDPARTY LINK ###
dk_set(FFMPEG-STATIC_CMAKE -DFFMPEG_INCLUDE_DIR=${FFMPEG-STATIC})
