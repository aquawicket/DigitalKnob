LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES:= \
	../../../src/Extensions.cpp \
	../../../src/Group.cpp \
	../../../src/HTTPSocket.cpp \
	../../../src/Hub.cpp \
	../../../src/Networking.cpp \
	../../../src/Node.cpp \
	../../../src/Socket.cpp \
	../../../src/WebSocket.cpp
	
LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../../../src

LOCAL_CFLAGS += -W -Wall
LOCAL_CFLAGS += -fPIC -DPIC
LOCAL_CFLAGS += -std=gnu++11

LOCAL_CFLAGS += -O2

LOCAL_MODULE:= libuWebSockets

include $(BUILD_STATIC_LIBRARY)