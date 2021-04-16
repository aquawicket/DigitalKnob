LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../lib/dgif_lib.c \
	../../../lib/gifalloc.c \
	../../../lib/gif_err.c

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../../../lib
	
LOCAL_CFLAGS += -Wno-format -DHAVE_CONFIG_H

LOCAL_MODULE:= libgif

include $(BUILD_STATIC_LIBRARY)
