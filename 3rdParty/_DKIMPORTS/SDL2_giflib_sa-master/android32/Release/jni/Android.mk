SDL := SDL2-2.0.4
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := SDL2
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../../../$(SDL)/android32/Release/libs/armeabi-v7a/libSDL2.so
include $(PREBUILT_SHARED_LIBRARY)
		
include $(CLEAR_VARS)
LOCAL_SRC_FILES:= \
	../../../gif_func_rw2.c \
	../../../gif_funcs2.c \
	../../../gif_user2.c \
	../../../gifToSurface2.c \
	../../../rwtypes.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../..
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(SDL)/include
	
LOCAL_CFLAGS := -DANDROID
LOCAL_CFLAGS += -O3 -fstrict-aliasing -fprefetch-loop-arrays

#LOCAL_STATIC_LIBRARIES := stl
LOCAL_SHARED_LIBRARIES := SDL2
LOCAL_MODULE := SDL2_gif
include $(BUILD_STATIC_LIBRARY)