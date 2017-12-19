SDL := SDL2-2.0.4
FREETYPE := freetype-2.5.5
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES:= \
	../../../SDL_ttf.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../..
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(SDL)/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(FREETYPE)/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(FREETYPE)/android32/Release/jni
	
LOCAL_CFLAGS := -DLOAD_FREETYPE
LOCAL_CFLAGS += -O3 -fstrict-aliasing -fprefetch-loop-arrays

LOCAL_STATIC_LIBRARIES := stl
LOCAL_SHARED_LIBRARIES := SDL2
LOCAL_MODULE := SDL2_ttf
include $(BUILD_STATIC_LIBRARY)