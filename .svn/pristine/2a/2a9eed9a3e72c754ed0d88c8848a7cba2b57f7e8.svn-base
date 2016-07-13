LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/alutBufferData.c \
	../../../src/alutCodec.c \
	../../../src/alutError.c \
	../../../src/alutInit.c \
	../../../src/alutInputStream.c \
	../../../src/alutLoader.c \
	../../../src/alutOutputStream.c \
	../../../src/alutUtil.c \
	../../../src/alutVersion.c \
	../../../src/alutWaveform.c

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../../../../freealut-master/include \
	$(LOCAL_PATH)/../../../../OpenAL-android/include

LOCAL_MODULE:= alut

include $(BUILD_STATIC_LIBRARY)
