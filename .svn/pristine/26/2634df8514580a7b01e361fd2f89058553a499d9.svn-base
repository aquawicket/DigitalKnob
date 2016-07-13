LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE    := ogg
LIBDIR := /obj/local/armeabi
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
LIBDIR := /obj/local/armeabi-v7a
endif
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../../../ogg/android32/Debug/$(LIBDIR)/libogg.a

include $(PREBUILT_STATIC_LIBRARY)
include $(CLEAR_VARS)



ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif
	
LOCAL_SRC_FILES := \
	$(LOCAL_PATH)/../../../../lib/mdct.c \
	$(LOCAL_PATH)/../../../../lib/smallft.c \
	$(LOCAL_PATH)/../../../../lib/block.c \
	$(LOCAL_PATH)/../../../../lib/envelope.c \
	$(LOCAL_PATH)/../../../../lib/window.c \
	$(LOCAL_PATH)/../../../../lib/lsp.c \
	$(LOCAL_PATH)/../../../../lib/lpc.c \
	$(LOCAL_PATH)/../../../../lib/analysis.c \
	$(LOCAL_PATH)/../../../../lib/synthesis.c \
	$(LOCAL_PATH)/../../../../lib/psy.c \
	$(LOCAL_PATH)/../../../../lib/info.c \
	$(LOCAL_PATH)/../../../../lib/floor1.c \
	$(LOCAL_PATH)/../../../../lib/floor0.c \
	$(LOCAL_PATH)/../../../../lib/res0.c \
	$(LOCAL_PATH)/../../../../lib/mapping0.c \
	$(LOCAL_PATH)/../../../../lib/registry.c \
	$(LOCAL_PATH)/../../../../lib/codebook.c \
	$(LOCAL_PATH)/../../../../lib/sharedbook.c	\
	$(LOCAL_PATH)/../../../../lib/lookup.c	\
	$(LOCAL_PATH)/../../../../lib/bitrate.c \
	$(LOCAL_PATH)/../../../../lib/vorbisfile.c	\
	$(LOCAL_PATH)/../../../../lib/vorbisenc.c

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../lib \
	$(LOCAL_PATH)/../../../android32 \
	$(LOCAL_PATH)/../../../../ogg/include \
	$(LOCAL_PATH)/../../../../ogg/android32
	

LOCAL_CFLAGS += -ffast-math -fsigned-char
ifeq ($(TARGET_ARCH),arm)
	LOCAL_CFLAGS += -march=armv6 -marm -mfloat-abi=softfp -mfpu=vfp
endif

LOCAL_STATIC_LIBRARIES := ogg

LOCAL_MODULE:= vorbis

include $(BUILD_STATIC_LIBRARY)




	