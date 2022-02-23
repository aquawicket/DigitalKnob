LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

	
LOCAL_SRC_FILES := \
    ../../../src/bitwise.c \
    ../../../src/framing.c 

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../android32
	
LOCAL_CFLAGS    := \
    -DFIXED_POINT -DUSE_KISS_FFT -DEXPORT="" -UHAVE_CONFIG_H \
    -D_ANDROID

LOCAL_MODULE:= ogg

include $(BUILD_STATIC_LIBRARY)
