ZLIB := zlib-1.2.8
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE    := zlib
LIBDIR := /obj/local/armeabi
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
LIBDIR := /obj/local/armeabi-v7a
endif
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../../../$(ZLIB)/android32/Debug/$(LIBDIR)/libzlib.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libarchive
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	$(LOCAL_PATH)/../../../../libarchive_fe/err.c \
	$(LOCAL_PATH)/../../../../libarchive_fe/line_reader.c \

FILE_LIST := $(wildcard $(LOCAL_PATH)/../../../libarchive/*.c)
LOCAL_SRC_FILES += $(FILE_LIST:$(LOCAL_PATH)/%=%)

LOCAL_SRC_FILES += $(LOCAL_PATH)/../../../../android32/Debug/jni/mbtowc.c

LOCAL_CFLAGS := -DPLATFORM_CONFIG_H=\"$(LOCAL_PATH)/../../../../android32/Debug/jni/config.h\"
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../../libarchive $(LOCAL_PATH)/../../../../libarchive_fe

LOCAL_STATIC_LIBRARIES := zlib

include $(BUILD_STATIC_LIBRARY)