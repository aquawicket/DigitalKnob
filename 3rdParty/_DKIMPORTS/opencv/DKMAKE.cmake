# https://sourceforge.net/projects/opencvlibrary/files/opencv-unix/3.4.1/opencv-3.4.1.zip
# https://github.com/opencv/opencv/archive/refs/tags/4.5.3.zip


### DEPEND ###
dk_depend(python)
dk_depend(libjpeg-turbo)
dk_depend(tiff)
dk_depend(libpng)
dk_depend(vfw32.lib)


### IMPORT ###
dk_import(https://github.com/opencv/opencv.git)
dk_set(OPENCV_VERSION 460)


### LINK ###
dk_include(${OPENCV})
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
dk_include(${OPENCV}/${OS})
dk_include(${OPENCV}/${OS}/${DEBUG_DIR})
dk_include(${OPENCV}/${OS}/${RELEASE_DIR})

dk_enable(ALL_LIBS)
if(ALL_LIBS)
	dk_enable(opencv_core)
endif()
# opencv_core
WIN_dk_libDebug			(${OPENCV}/${OS}/lib/${DEBUG_DIR}/opencv_core${OPENCV_VERSION}d.lib)
WIN_dk_libRelease		(${OPENCV}/${OS}/lib/${RELEASE_DIR}/opencv_core${OPENCV_VERSION}.lib)
APPLE_dk_libDebug		(${OPENCV}/${OS}/lib/${DEBUG_DIR}/libopencv_core.a)
APPLE_dk_libRelease		(${OPENCV}/${OS}/lib/${RELEASE_DIR}/libopencv_core.a)
LINUX_dk_libDebug		(${OPENCV}/${OS}/${DEBUG_DIR}/lib/libopencv_core.a)
LINUX_dk_libRelease		(${OPENCV}/${OS}/${RELEASE_DIR}/lib/libopencv_core.a)
RASPBERRY_dk_libDebug	(${OPENCV}/${OS}/${DEBUG_DIR}/lib/libopencv_core.a)
RASPBERRY_dk_libRelease	(${OPENCV}/${OS}/${RELEASE_DIR}/lib/libopencv_core.a)
ANDROID_dk_libDebug		(${OPENCV}/${OS}/lib/${DEBUG_DIR}/libopencv_core.a)
ANDROID_dk_libRelease	(${OPENCV}/${OS}/lib/${RELEASE_DIR}/libopencv_core.a)
#ANDROID_dk_libDebug	(${OPENCV}/${OS}/lib/${DEBUG_DIR}/obj/local/armeabi-v7a/libopencv_core.a)
#ANDROID_dk_libRelease	(${OPENCV}/${OS}/lib/${RELEASE_DIR}/obj/local/armeabi-v7a/libopencv_core.a)

# opencv_imgcodecs
WIN_dk_libDebug			(${OPENCV}/${OS}/lib/${DEBUG_DIR}/opencv_imgcodecs${OPENCV_VERSION}d.lib)
WIN_dk_libRelease		(${OPENCV}/${OS}/lib/${RELEASE_DIR}/opencv_imgcodecs${OPENCV_VERSION}.lib)
APPLE_dk_libDebug		(${OPENCV}/${OS}/lib/${DEBUG_DIR}/libopencv_imgcodecs.a)
APPLE_dk_libRelease		(${OPENCV}/${OS}/lib/${RELEASE_DIR}/libopencv_imgcodecs.a)
LINUX_dk_libDebug		(${OPENCV}/${OS}/${DEBUG_DIR}/lib/libopencv_imgcodecs.a)
LINUX_dk_libRelease		(${OPENCV}/${OS}/${RELEASE_DIR}/lib/libopencv_imgcodecs.a)
RASPBERRY_dk_libDebug	(${OPENCV}/${OS}/${DEBUG_DIR}/lib/libopencv_imgcodecs.a)
RASPBERRY_dk_libRelease	(${OPENCV}/${OS}/${RELEASE_DIR}/lib/libopencv_imgcodecs.a)
ANDROID_dk_libDebug		(${OPENCV}/${OS}/lib/${DEBUG_DIR}/libopencv_imgcodecs.a)
ANDROID_dk_libRelease	(${OPENCV}/${OS}/lib/${RELEASE_DIR}/libopencv_imgcodecs.a)

# opencv_imgproc
WIN_dk_libDebug			(${OPENCV}/${OS}/lib/${DEBUG_DIR}/opencv_imgproc${OPENCV_VERSION}d.lib)
WIN_dk_libRelease		(${OPENCV}/${OS}/lib/${RELEASE_DIR}/opencv_imgproc${OPENCV_VERSION}.lib)
APPLE_dk_libDebug		(${OPENCV}/${OS}/lib/${DEBUG_DIR}/libopencv_imgproc.a)
APPLE_dk_libRelease		(${OPENCV}/${OS}/lib/${RELEASE_DIR}/libopencv_imgproc.a)
LINUX_dk_libDebug		(${OPENCV}/${OS}/${DEBUG_DIR}/lib/libopencv_imgproc.a)
LINUX_dk_libRelease		(${OPENCV}/${OS}/${RELEASE_DIR}/lib/libopencv_imgproc.a)
RASPBERRY_dk_libDebug	(${OPENCV}/${OS}/${DEBUG_DIR}/lib/libopencv_imgproc.a)
RASPBERRY_dk_libRelease	(${OPENCV}/${OS}/${RELEASE_DIR}/lib/libopencv_imgproc.a)
ANDROID_dk_libDebug		(${OPENCV}/${OS}/lib/${DEBUG_DIR}/libopencv_imgproc.a)
ANDROID_dk_libRelease	(${OPENCV}/${OS}/lib/${RELEASE_DIR}/libopencv_imgproc.a)

# opencv_videoio
WIN_dk_libDebug			(${OPENCV}/${OS}/lib/${DEBUG_DIR}/opencv_videoio${OPENCV_VERSION}d.lib)
WIN_dk_libRelease		(${OPENCV}/${OS}/lib/${RELEASE_DIR}/opencv_videoio${OPENCV_VERSION}.lib)
APPLE_dk_libDebug		(${OPENCV}/${OS}/lib/${DEBUG_DIR}/libopencv_videoio.a)
APPLE_dk_libRelease		(${OPENCV}/${OS}/lib/${RELEASE_DIR}/libopencv_videoio.a)
LINUX_dk_libDebug		(${OPENCV}/${OS}/${DEBUG_DIR}/lib/libopencv_videoio.a)
LINUX_dk_libRelease		(${OPENCV}/${OS}/${RELEASE_DIR}/lib/libopencv_videoio.a)
RASPBERRY_dk_libDebug	(${OPENCV}/${OS}/${DEBUG_DIR}/lib/libopencv_videoio.a)
RASPBERRY_dk_libRelease	(${OPENCV}/${OS}/${RELEASE_DIR}/lib/libopencv_videoio.a)
ANDROID_dk_libDebug		(${OPENCV}/${OS}/lib/${DEBUG_DIR}/libopencv_videoio.a)
ANDROID_dk_libRelease	(${OPENCV}/${OS}/lib/${RELEASE_DIR}/libopencv_videoio.a)

# jasper
#WIN_dk_libDebug		(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/libjasperd.lib)
#WIN_dk_libRelease		(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/libjasper.lib)
#APPLE_dk_libDebug		(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/liblibjasper.a)
#APPLE_dk_libRelease	(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/liblibjasper.a)
#LINUX_dk_libDebug		(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/lib/liblibjasper.a)
#LINUX_dk_libRelease	(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/lib/liblibjasper.a)
#RASPBERRY_dk_libDebug	(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/lib/liblibjasper.a)
#RASPBERRY_dk_libRelease(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/lib/liblibjasper.a)
ANDROID_dk_libDebug		(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/liblibjasper.a)
ANDROID_dk_libRelease	(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/liblibjasper.a)

# ippiw
WIN32_dk_libDebug		(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/ippiwd.lib)
WIN32_dk_libRelease		(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/ippiw.lib)
APPLE_dk_libDebug		(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/libippiw.a)
APPLE_dk_libRelease		(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/libippiw.a)
LINUX_dk_libDebug		(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/lib/libippiw.a)
LINUX_dk_libRelease		(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/lib/libippiw.a)
#RASPBERRY_dk_libDebug	(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/lib/libippiw.a)
#RASPBERRY_dk_libRelease(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/lib/libippiw.a)
ANDROID_dk_libDebug		(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/libippiw.a)
ANDROID_dk_libRelease	(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/libippiw.a)

# webp
WIN_dk_libDebug			(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/libwebpd.lib)
WIN_dk_libRelease		(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/libwebp.lib)
APPLE_dk_libDebug		(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/liblibwebp.a)
APPLE_dk_libRelease		(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/liblibwebp.a)
LINUX_dk_libDebug		(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/lib/liblibwebp.a)
LINUX_dk_libRelease		(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/lib/liblibwebp.a)
RASPBERRY_dk_libDebug	(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/lib/liblibwebp.a)
RASPBERRY_dk_libRelease	(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/lib/liblibwebp.a)
ANDROID_dk_libDebug		(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/liblibwebp.a)
ANDROID_dk_libRelease	(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/liblibwebp.a)

# ittnotify
WIN_dk_libDebug			(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/ittnotifyd.lib)
WIN_dk_libRelease		(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/ittnotify.lib)
APPLE_dk_libDebug		(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/libittnotify.a)
APPLE_dk_libRelease		(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/libittnotify.a)
LINUX_dk_libDebug		(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/lib/libittnotify.a)
LINUX_dk_libRelease		(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/lib/libittnotify.a)
#RASPBERRY_dk_libDebug	(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/lib/libittnotify.a)
#RASPBERRY_dk_libRelease(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/lib/libittnotify.a)
ANDROID_dk_libDebug		(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/libittnotify.a)
ANDROID_dk_libRelease	(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/libittnotify.a)

# Ilmimf
WIN_dk_libDebug			(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/IlmImfd.lib)
WIN_dk_libRelease		(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/IlmImf.lib)
APPLE_dk_libDebug		(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/libIlmImf.a)
APPLE_dk_libRelease		(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/libIlmImf.a)
LINUX_dk_libDebug		(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/lib/libIlmImf.a)
LINUX_dk_libRelease		(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/lib/libIlmImf.a)
RASPBERRY_dk_libDebug	(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/lib/libIlmImf.a)
RASPBERRY_dk_libRelease	(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/lib/libIlmImf.a)
ANDROID_dk_libDebug		(${OPENCV}/${OS}/3rdparty/lib/${DEBUG_DIR}/libIlmImf.a)
ANDROID_dk_libRelease	(${OPENCV}/${OS}/3rdparty/lib/${RELEASE_DIR}/libIlmImf.a)

# ippicv
WIN32_dk_libDebug			(${OPENCV}/${OS}/3rdparty/ippicv/ippicv_win/icv/lib/ia32/ippicvmt.lib)
WIN32_dk_libRelease			(${OPENCV}/${OS}/3rdparty/ippicv/ippicv_win/icv/lib/ia32/ippicvmt.lib)
WIN64_dk_libDebug			(${OPENCV}/${OS}/3rdparty/ippicv/ippicv_win/icv/lib/intel64/ippicvmt.lib)
WIN64_dk_libRelease			(${OPENCV}/${OS}/3rdparty/ippicv/ippicv_win/icv/lib/intel64/ippicvmt.lib)
APPLE32_dk_libDebug			(${OPENCV}/${OS}/3rdparty/ippicv/ippicv_mac/icv/lib/intel32/libippicv.a)
APPLE32_dk_libRelease		(${OPENCV}/${OS}/3rdparty/ippicv/ippicv_mac/icv/lib/intel32/libippicv.a)
APPLE64_dk_libDebug			(${OPENCV}/${OS}/3rdparty/ippicv/ippicv_mac/icv/lib/intel64/libippicv.a)
APPLE64_dk_libRelease		(${OPENCV}/${OS}/3rdparty/ippicv/ippicv_mac/icv/lib/intel64/libippicv.a)
LINUX32_dk_libDebug			(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/ia32/libippicv.a)
LINUX32_dk_libRelease		(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/ia32/libippicv.a)
LINUX64_dk_libDebug			(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/intel64/libippicv.a)
LINUX64_dk_libRelease		(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/intel64/libippicv.a)
RASPBERRY32_dk_libDebug		(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/ia32/libippicv.a)
RASPBERRY32_dk_libRelease	(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/ia32/libippicv.a)
RASPBERRY64_dk_libDebug		(${OPENCV}/${OS}/${DEBUG_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/intel64/libippicv.a)
RASPBERRY64_dk_libRelease	(${OPENCV}/${OS}/${RELEASE_DIR}/3rdparty/ippicv/ippicv_lnx/icv/lib/intel64/libippicv.a)
ANDROID32_dk_libDebug		(${OPENCV}/${OS}/3rdparty/ippicv/ippicv_android/lib/arm32/libippicv.a)
ANDROID32_dk_libRelease		(${OPENCV}/${OS}/3rdparty/ippicv/ippicv_android/lib/arm32/libippicv.a)
ANDROID64_dk_libDebug		(${OPENCV}/${OS}/3rdparty/ippicv/ippicv_android/lib/arm64/libippicv.a)
ANDROID64_dk_libRelease		(${OPENCV}/${OS}/3rdparty/ippicv/ippicv_android/lib/arm64/libippicv.a)



### GENERATE ###
dk_setPath							(${OPENCV}/${BUILD_DIR})

string(REPLACE "/std:c++17" "" OPENCV_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "  " " " OPENCV_BUILD "${OPENCV_BUILD}")
WIN32_dk_queueCommand				(${OPENCV_BUILD} ${OPENCV})
WIN64_dk_queueCommand				(${OPENCV_BUILD} -DCV_DISABLE_OPTIMIZATION=ON -DCPU_BASELINE="" -DCPU_DISPATCH="" ${OPENCV})

MAC_dk_queueCommand					(${DKCMAKE_BUILD} "-DCMAKE_CXX_FLAGS=-stdlib=libc++" ${OPENCV})
IOS_dk_queueCommand					(${DKCMAKE_BUILD} ${OPENCV})
IOSSIM_dk_queueCommand				(${DKCMAKE_BUILD} ${OPENCV})
LINUX_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} ${OPENCV})
LINUX_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} ${OPENCV})
RASPBERRY_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DWITH_IPP=ON ${OPENCV})
RASPBERRY_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DWITH_IPP=ON ${OPENCV})
ANDROID_dk_queueCommand				(${DKCMAKE_BUILD} ${OPENCV})


### COMPILE ###
dk_visualStudio	(${OPENCV_NAME}) # windows, android
dk_xcode		(${OPENCV_NAME}) # mac, ios, iossim
dk_make			(${OPENCV_NAME}) # linux, raspberry
#dk_xcode		(${OPENCV_NAME} opencv_core)		# mac, ios, iossim
#dk_xcode		(${OPENCV_NAME} opencv_imgcodecs)	# mac, ios, iossim
#dk_xcode		(${OPENCV_NAME} opencv_videoio)		# mac, ios, iossim
#dk_make		(${OPENCV_NAME} opencv_core)		# linux, raspberry
#dk_make		(${OPENCV_NAME} opencv_imgcodecs)	# linux, raspberry
#dk_make		(${OPENCV_NAME} opencv_videoio)		# linux, raspberry
