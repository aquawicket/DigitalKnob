#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ opencv ############
# https://sourceforge.net/projects/opencvlibrary/files/opencv-unix/3.4.1/opencv-3.4.1.zip
# https://github.com/opencv/opencv/archive/refs/tags/4.5.3.zip
dk_load(dk_builder)

### DEPEND ###
dk_depend(jasper)
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(libwebp)
dk_depend(nasm)
dk_depend(python3)
dk_depend(tiff)
dk_depend(vfw32)
dk_depend(zlib)

### IMPORT ###
dk_import(https://github.com/opencv/opencv/archive/94d5ad09.zip)
dk_set(OPENCV_VERSION 470)

### LINK ###
dk_include(${OPENCV})
dk_include(${OPENCV_TRIPLE})
dk_include(${OPENCV_CONFIG_DIR})
dk_include(${OPENCV}/modules/calib3d/include)
dk_include(${OPENCV}/modules/core/include)
dk_include(${OPENCV}/modules/dnn/include)
dk_include(${OPENCV}/modules/features2d/include)
dk_include(${OPENCV}/modules/flann/include)
dk_include(${OPENCV}/modules/highgui/include)
dk_include(${OPENCV}/modules/imgcodecs/include)
dk_include(${OPENCV}/modules/imgproc/include)
dk_include(${OPENCV}/modules/ml/include)
dk_include(${OPENCV}/modules/objdetect/include)
dk_include(${OPENCV}/modules/photo/include)
dk_include(${OPENCV}/modules/stitching/include)
dk_include(${OPENCV}/modules/video/include)
dk_include(${OPENCV}/modules/videoio/include)

dk_enable(ALL_LIBS)
if(ALL_LIBS)
	dk_enable(opencv_calib3d)
	dk_enable(opencv_core)
	dk_enable(opencv_dnn)
	dk_enable(opencv_features2d)
	dk_enable(opencv_flann)
	dk_enable(opencv_gapi)
	dk_enable(opencv_highgui)
	dk_enable(opencv_imgcodecs)
	dk_enable(opencv_imgproc)
	dk_enable(opencv_ml)
	dk_enable(opencv_objdetect)
	dk_enable(opencv_photo)
	dk_enable(opencv_stitching)
	dk_enable(opencv_ts)
	dk_enable(opencv_video)
	dk_enable(opencv_videoio)
	
	# opencv 3rdparty
	dk_enable(opencv_ade)
	#dk_enable(opencv_ffmpeg)
	dk_enable(opencv_ilmimf)
	dk_enable(opencv_ippicv)
	dk_enable(opencv_ippiw)
	dk_enable(opencv_ittnotify)
	#dk_enable(opencv_libjasper)
	#dk_enable(opencv_libjpeg-turbo)
	#dk_enable(opencv_libpng)
	#dk_enable(opencv_libtiff)
	#dk_enable(opencv_libwebp)
	dk_enable(opencv_openexr)
	#dk_enable(opencv_openjpeg)
	#dk_enable(opencv_protobuf)
	dk_enable(opencv_quirc)
	#dk_enable(opencv_zlib)
endif()
if(opencv_calib3d)
	if(MSVC)
		dk_libDebug			(${OPENCV_CONFIG_DIR}/lib/${DEBUG_DIR}/opencv_calib3d${OPENCV_VERSION}d.lib)
		dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/${RELEASE_DIR}/opencv_calib3d${OPENCV_VERSION}.lib)
	else()
		dk_libDebug			(${OPENCV_CONFIG_DIR}/lib/libopencv_calib3d4100d.a)
		dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_calib3d4100.a)
	endif()
endif()
if(opencv_core)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_core.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_core.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_core.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_core.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_core.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_core.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_core.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_core.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_core.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_core.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_core${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_core${OPENCV_VERSION}.lib)
endif()
if(opencv_dnn)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_dnn.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_dnn.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_dnn.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_dnn.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_dnn.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_dnn.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_dnn.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_dnn.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_dnn.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_dnn.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_dnn${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_dnn${OPENCV_VERSION}.lib)
endif()
if(opencv_features2d)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_features2d.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_features2d.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_features2d.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_features2d.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_features2d.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_features2d.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_features2d.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_features2d.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_features2d.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_features2d.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_features2d${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_features2d${OPENCV_VERSION}.lib)
endif()
if(opencv_flann)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_flann.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_flann.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_flann.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_flann.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_flann.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_flann.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_flann.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_flann.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_flann.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_flann.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_flann${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_flann${OPENCV_VERSION}.lib)
endif()
if(opencv_gapi)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_gapi.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_gapi.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_gapi.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_gapi.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_gapi.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_gapi.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_gapi.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_gapi.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_gapi.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_gapi.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_gapi${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_gapi${OPENCV_VERSION}.lib)
endif()
if(opencv_highgui)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_highgui.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_highgui.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_highgui.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_highgui.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_highgui.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_highgui.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_highgui.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_highgui.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_highgui.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_highgui.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_highgui${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_highgui${OPENCV_VERSION}.lib)
endif()
if(opencv_imgcodecs)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_imgcodecs.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_imgcodecs.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_imgcodecs.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_imgcodecs.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_imgcodecs.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_imgcodecs.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_imgcodecs.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_imgcodecs.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_imgcodecs.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_imgcodecs.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_imgcodecs${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_imgcodecs${OPENCV_VERSION}.lib)
endif()
if(opencv_imgproc)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_imgproc.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_imgproc.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_imgproc.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_imgproc.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_imgproc.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_imgproc.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_imgproc.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_imgproc.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_imgproc.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_imgproc.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_imgproc${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_imgproc${OPENCV_VERSION}.lib)
endif()
if(opencv_ml)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_ml.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_ml.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_ml.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_ml.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_ml.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_ml.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_ml.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_ml.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_ml.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_ml.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_ml${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_ml${OPENCV_VERSION}.lib)
endif()
if(opencv_objdetect) 
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_objdetect.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_objdetect.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_objdetect.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_objdetect.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_objdetect.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_objdetect.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_objdetect.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_objdetect.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_objdetect.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_objdetect.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_objdetect${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_objdetect${OPENCV_VERSION}.lib)
endif()
if(opencv_photo)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_photo.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_photo.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_photo.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_photo.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_photo.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_photo.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_photo.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_photo.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_photo.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_photo.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_photo${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_photo${OPENCV_VERSION}.lib)
endif()
if(opencv_stitching)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_stitching.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_stitching.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_stitching.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_stitching.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_stitching.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_stitching.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_stitching.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_stitching.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_stitching.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_stitching.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_stitching${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_stitching${OPENCV_VERSION}.lib)
endif()
if(opencv_ts)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_ts.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_ts.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_ts.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_ts.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_ts.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_ts.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_ts.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_ts.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_ts.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_ts.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_ts${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_ts${OPENCV_VERSION}.lib)
endif()
if(opencv_video)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_video.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_video.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_video.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_video.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_video.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_video.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_video.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_video.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_video.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_video.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_video${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_video${OPENCV_VERSION}.lib)
endif()
if(opencv_videoio)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_videoio.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_videoio.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/libopencv_videoio.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/libopencv_videoio.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_videoio.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/lib/libopencv_videoio.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/lib/libopencv_videoio.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/lib/libopencv_videoio.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/lib/libopencv_videoio.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/lib/libopencv_videoio.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/lib/${DEBUG_DIR}/opencv_videoio${OPENCV_VERSION}d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/lib/${RELEASE_DIR}/opencv_videoio${OPENCV_VERSION}.lib)
endif()
if(opencv_ade)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libade.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libade.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libade.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libade.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libade.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libade.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libade.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libade.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libade.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libade.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/aded.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/ade.lib)
endif()
if(opencv_ffmpeg)
	# TODO
endif()
if(opencv_ilmimf)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libIlmImf.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libIlmImf.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libIlmImf.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libIlmImf.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libIlmImf.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libIlmImf.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libIlmImf.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libIlmImf.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libIlmImf.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libIlmImf.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/IlmImfd.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/IlmImf.lib)
endif()
if(opencv_ippicv)
	ANDROID_ARM32_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/ippicv/ippicv_android/lib/arm32/libippicv.a)
	ANDROID_ARM32_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/ippicv/ippicv_android/lib/arm32/libippicv.a)
	ANDROID_ARM64_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/ippicv/ippicv_android/lib/arm64/libippicv.a)
	ANDROID_ARM64_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/ippicv/ippicv_android/lib/arm64/libippicv.a)
	APPLE32_dk_libDebug				(${OPENCV_TRIPLE}/3rdparty/ippicv/ippicv_mac/icv/lib/intel32/libippicv.a)
	APPLE32_dk_libRelease			(${OPENCV_TRIPLE}/3rdparty/ippicv/ippicv_mac/icv/lib/intel32/libippicv.a)
	APPLE64_dk_libDebug				(${OPENCV_TRIPLE}/3rdparty/ippicv/ippicv_mac/icv/lib/intel64/libippicv.a)
	APPLE64_dk_libRelease			(${OPENCV_TRIPLE}/3rdparty/ippicv/ippicv_mac/icv/lib/intel64/libippicv.a)
	EMSCRIPTEN_dk_libDebug			(${OPENCV_CONFIG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/ia32/libippicv.a)
	EMSCRIPTEN_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/ia32/libippicv.a)
	LINUX_X86_dk_libDebug			(${OPENCV_CONFIG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/ia32/libippicv.a)
	LINUX_X86_dk_libRelease			(${OPENCV_CONFIG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/ia32/libippicv.a)
	LINUX_X86_64_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/intel64/libippicv.a)
	LINUX_X86_64_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/intel64/libippicv.a)
	RASPBERRY_ARM32_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/ia32/libippicv.a)
	RASPBERRY_ARM32_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/ia32/libippicv.a)
	RASPBERRY_ARM64_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/intel64/libippicv.a)
	RASPBERRY_ARM64_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/intel64/libippicv.a)
	WIN_X86_dk_libDebug				(${OPENCV_TRIPLE}/3rdparty/ippicv/ippicv_win/icv/lib/ia32/ippicvmt.lib)
	WIN_X86_dk_libRelease			(${OPENCV_TRIPLE}/3rdparty/ippicv/ippicv_win/icv/lib/ia32/ippicvmt.lib)
	WIN_X86_64_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/ippicv/ippicv_win/icv/lib/intel64/ippicvmt.lib)
	WIN_X86_64_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/ippicv/ippicv_win/icv/lib/intel64/ippicvmt.lib)
endif()
if(opencv_ippiw)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libippiw.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libippiw.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libippiw.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libippiw.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libippiw.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libippiw.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libippiw.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libippiw.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libippiw.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libippiw.a)
	WIN_X86_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/ippiwd.lib)
	WIN_X86_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/ippiw.lib)
endif()
if(opencv_ittnotify)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libittnotify.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libittnotify.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libittnotify.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libittnotify.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libittnotify.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libittnotify.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libittnotify.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libittnotify.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libittnotify.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libittnotify.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/ittnotifyd.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/ittnotify.lib)
endif()
if(opencv_libjasper)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libjasper.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libjasper.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libjasper.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libjasper.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libjasper.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libjasper.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libjasper.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libjasper.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libjasper.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libjasper.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libjasperd.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libjasper.lib)
endif()
if(opencv_libjpeg-turbo)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libjpeg-turbo.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libjpeg-turbo.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libjpeg-turbo.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libjpeg-turbo.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libjpeg-turbo.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libjpeg-turbo.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libjpeg-turbo.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libjpeg-turbo.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libjpeg-turbo.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libjpeg-turbo.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libjpeg-turbod.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libjpeg-turbo.lib)
endif()
if(opencv_libpng)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libpng.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libpng.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libpng.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libpng.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libpng.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libpng.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libpng.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libpng.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libpng.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libpng.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libpngd.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libpng.lib)
endif()
if(opencv_libtiff)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libtiff.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libtiff.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libtiff.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libtiff.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libtiff.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libtiff.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libtiff.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libtiff.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libtiff.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libtiff.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libtiffd.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libtiff.lib)
endif()
if(opencv_libwebp)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libwebp.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libwebp.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libwebp.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libwebp.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libwebp.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libwebp.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libwebp.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libwebp.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libwebp.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libwebp.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libwebpd.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libwebp.lib)
endif()
if(opencv_openexr)
	#TODO
endif()
if(opencv_openjpeg)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libopenjp2.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libopenjp2.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libopenjp2.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libopenjp2.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libopenjp2.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libopenjp2.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libopenjp2.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libopenjp2.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libopenjp2.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libopenjp2.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libopenjp2d.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libopenjp2.lib)
endif()
if(opencv_protobuf)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libprotobuf.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libprotobuf.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libprotobuf.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libprotobuf.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libprotobuf.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libprotobuf.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libprotobuf.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libprotobuf.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libprotobuf.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libprotobuf.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libprotobufd.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libprotobuf.lib)
endif()
if(opencv_quirc)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libquirc.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libquirc.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libquirc.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libquirc.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libquirc.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libquirc.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libquirc.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libquirc.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libquirc.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libquirc.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/quircd.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/quirc.lib)
endif()
if(opencv_zlib)
	ANDROID_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libzlib.a)
	ANDROID_dk_libRelease	(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libzlib.a)
	APPLE_dk_libDebug		(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/libzlib.a)
	APPLE_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/libzlib.a)
	EMSCRIPTEN_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libzlib.a)
	EMSCRIPTEN_dk_libRelease(${OPENCV_CONFIG_DIR}/3rdparty/lib/libzlib.a)
	LINUX_dk_libDebug		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libzlib.a)
	LINUX_dk_libRelease		(${OPENCV_CONFIG_DIR}/3rdparty/lib/libzlib.a)
	RASPBERRY_dk_libDebug	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libzlib.a)
	RASPBERRY_dk_libRelease	(${OPENCV_CONFIG_DIR}/3rdparty/lib/libzlib.a)
	WIN_dk_libDebug			(${OPENCV_TRIPLE}/3rdparty/lib/${DEBUG_DIR}/zlibd.lib)
	WIN_dk_libRelease		(${OPENCV_TRIPLE}/3rdparty/lib/${RELEASE_DIR}/zlib.lib)
endif()


### GENERATE ###
if(WIN)
	string(REPLACE "/std:c++17" "" 	DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "  " " " 		DKCMAKE_BUILD "${DKCMAKE_BUILD}")
endif()
ANDROID_dk_configure	(${OPENCV_DIR})
EMSCRIPTEN_dk_configure	(${OPENCV_DIR})
IOSSIM_dk_configure		(${OPENCV_DIR})
IOS_dk_configure		(${OPENCV_DIR})
LINUX_dk_configure		(${OPENCV_DIR})
MAC_dk_configure		(${OPENCV_DIR} "-DCMAKE_CXX_FLAGS=-stdlib=libc++")
RASPBERRY_dk_configure	(${OPENCV_DIR} -DWITH_IPP=ON)
WIN_X86_dk_configure	(${OPENCV_DIR})
WIN_X86_64_dk_configure	(${OPENCV_DIR} -DCV_DISABLE_OPTIMIZATION=ON -DCPU_BASELINE="" -DCPU_DISPATCH="")


### COMPILE ###
dk_build(${OPENCV_DIR})
#if(opencv_calib3d)
#	dk_build(${OPENCV} opencv_calib3d)
#endif()
#if(opencv_core)
#	dk_build(${OPENCV} opencv_core)
#endif()
#if(opencv_dnn)
#	dk_build(${OPENCV} opencv_dnn)
#endif()
#if(opencv_features2d)
#	dk_build(${OPENCV} opencv_features2d)
#endif()	
#if(opencv_flann)
#	dk_build(${OPENCV} opencv_flann)
#endif()	
#if(opencv_gapi)
#	dk_build(${OPENCV} opencv_gapi)
#endif()	
#if(opencv_highgui)
#	dk_build(${OPENCV} opencv_highgui)
#endif()	
#if(opencv_imgcodecs)
#	dk_build(${OPENCV} opencv_imgcodecs)
#endif()	
#if(opencv_imgproc)
#	dk_build(${OPENCV} opencv_imgproc)
#endif()	
#if(opencv_ml)
#	dk_build(${OPENCV} opencv_ml)
#endif()	
#if(opencv_objdetect)
#	dk_build(${OPENCV} opencv_objdetect)
#endif()
#if(opencv_photo)
#	dk_build(${OPENCV} opencv_photo)
#endif()
#if(opencv_stitching)
#	dk_build(${OPENCV} opencv_stitching)
#endif()
#if(opencv_ts)
#	dk_build(${OPENCV} opencv_ts)
#endif()
#if(opencv_video)
#	dk_build(${OPENCV} opencv_video)
#endif()
#if(opencv_videoio)
#	dk_build(${OPENCV} opencv_videoio)
#endif()	
#if(opencv_ade)
#	dk_build(${OPENCV} ade)
#endif()	
#if(opencv_ffmpeg)
#	dk_build(${OPENCV} opencv_ffmpeg)
#endif()	
#if(opencv_ilmimf)
#	dk_build(${OPENCV} opencv_ilmimf)
#endif()	
#if(opencv_ippicv)
#	dk_build(${OPENCV} opencv_ippicv)
#endif()	
#if(opencv_ippiw)
#	dk_build(${OPENCV} opencv_ippiw)
#endif()	
#if(opencv_ittnotify)
#	dk_build(${OPENCV} opencv_ittnotify)
#endif()	
#if(opencv_libjasper)
#	dk_build(${OPENCV} opencv_libjasper)
#endif()	
#if(opencv_libjpeg-turbo)
#	dk_build(${OPENCV} opencv_libjpeg-turbo)
#endif()	
#if(opencv_libpng)
#	dk_build(${OPENCV} opencv_libpng)
#endif()	
#if(opencv_libtiff)
#	dk_build(${OPENCV} opencv_libtiff)
#endif()	
#if(opencv_libwebp)
#	dk_build(${OPENCV} opencv_libwebp)
#endif()	
#if(opencv_openexr)
#	dk_build(${OPENCV} opencv_openexr)
#endif()	
#if(opencv_openjpeg)
#	dk_build(${OPENCV} opencv_openjpeg)
#endif()	
#if(opencv_protobuf)
#	dk_build(${OPENCV} opencv_protobuf)
#endif()	
#if(opencv_quirc)
#	dk_build(${OPENCV} opencv_quirc)
#endif()
#if(opencv_zlib)
#	dk_build(${OPENCV} opencv_zlib)
#endif()
