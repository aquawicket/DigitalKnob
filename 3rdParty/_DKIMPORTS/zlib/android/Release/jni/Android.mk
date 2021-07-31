LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := zlib

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
../../../adler32.c \
../../../compress.c \
../../../crc32.c \
../../../deflate.c \
../../../gzclose.c \
../../../gzlib.c \
../../../gzread.c \
../../../gzwrite.c \
../../../infback.c \
../../../inffast.c \
../../../inflate.c \
../../../inftrees.c \
../../../trees.c \
../../../uncompr.c \
../../../zutil.c

LOCAL_CFLAGS := -DUSE_MMAP

LOCAL_C_INCLUDES :=  $(LOCAL_PATH) \
../../../android32/Release/jni


include $(BUILD_STATIC_LIBRARY)
