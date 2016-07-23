SDL := SDL2-2.0.4
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := SDL2
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../../../$(SDL)/android32/Release/libs/armeabi-v7a/libSDL2.so
include $(PREBUILT_SHARED_LIBRARY)
		
include $(CLEAR_VARS)
LOCAL_SRC_FILES:= \
	../../../audio/MPEGaudio.cpp \
	../../../audio/bitwindow.cpp \
	../../../audio/filter.cpp \
	../../../audio/filter_2.cpp \
	../../../audio/hufftable.cpp \
	../../../audio/mpeglayer1.cpp \
	../../../audio/mpeglayer2.cpp \
	../../../audio/mpeglayer3.cpp \
	../../../audio/mpegtable.cpp \
	../../../audio/mpegtoraw.cpp \
	../../../video/MPEGvideo.cpp \
	../../../video/decoders.cpp \
	../../../video/floatdct.cpp \
	../../../video/gdith.cpp \
	../../../video/jrevdct.cpp \
	../../../video/motionvec.cpp \
	../../../video/parseblock.cpp \
	../../../video/readfile.cpp \
	../../../video/util.cpp \
	../../../video/video.cpp \
	../../../MPEG.cpp \
	../../../MPEGlist.cpp \
	../../../MPEGring.cpp \
	../../../MPEGstream.cpp \
	../../../MPEGsystem.cpp \
	../../../smpeg.cpp

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../..
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(SDL)/include
	
LOCAL_CFLAGS := -DANDROID
LOCAL_CFLAGS += -DNOCONTROLS
LOCAL_CFLAGS += -O3 -fstrict-aliasing -fprefetch-loop-arrays

#LOCAL_STATIC_LIBRARIES := stl
LOCAL_SHARED_LIBRARIES := SDL2
LOCAL_MODULE := SMPEG
include $(BUILD_STATIC_LIBRARY)