LOCAL_PATH:= $(call my-dir)

########################################
include $(CLEAR_VARS)
LOCAL_MODULE := openalpp

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

## include all .cpp files
FILE_LIST := $(wildcard $(LOCAL_PATH)/../../../src/openalpp/*.cpp)
FILE_LIST := $(filter-out $(LOCAL_PATH)/../../../src/openalpp/NoStreaming.cpp, $(FILE_LIST))
LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)


LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../android32 \
	$(LOCAL_PATH)/../../../../OpenAL-android/include \
	$(LOCAL_PATH)/../../../../OpenAL-android/include/AL \
	$(LOCAL_PATH)/../../../../freealut-master/include \
	$(LOCAL_PATH)/../../../../libvorbis-1.3.5/include \
	$(LOCAL_PATH)/../../../../libogg-1.3.2/include \
	$(LOCAL_PATH)/../../../../libogg-1.3.2/android32 \
	$(LOCAL_PATH)/../../../../OpenSceneGraph-3.4.0/include \
	$(LOCAL_PATH)/../../../../OpenSceneGraph-3.4.0/android32/Release/armeabi-v7a/include

include $(BUILD_STATIC_LIBRARY)




########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgdb_osgAudio

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

## include all .cpp files
FILE_LIST := $(wildcard $(LOCAL_PATH)/../../../src/osgAudio/*.cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/../../../src/osgAudio/BackendOpenALpp/*.cpp)
##FILE_LIST := $(filter-out $(LOCAL_PATH)/../../../src/osgAudio/file???.cpp, $(FILE_LIST))
LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)


LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../android32 \
	$(LOCAL_PATH)/../../../../OpenAL-android/include \
	$(LOCAL_PATH)/../../../../OpenAL-android/include/AL \
	$(LOCAL_PATH)/../../../../freealut-master/include \
	$(LOCAL_PATH)/../../../../libvorbis-1.3.5/include \
	$(LOCAL_PATH)/../../../../libogg-1.3.2/include \
	$(LOCAL_PATH)/../../../../libogg-1.3.2/android32 \
	$(LOCAL_PATH)/../../../../OpenSceneGraph-3.4.0/include \
	$(LOCAL_PATH)/../../../../OpenSceneGraph-3.4.0/android32/Release/armeabi-v7a/include

include $(BUILD_STATIC_LIBRARY)






########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgAudio

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

## include all .cpp files
FILE_LIST := $(wildcard $(LOCAL_PATH)/../../../src/osgPlugin/*.cpp)
##FILE_LIST := $(filter-out $(LOCAL_PATH)/../../../src/osgPlugin/file???.cpp, $(FILE_LIST))
LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)

LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../android32 \
	$(LOCAL_PATH)/../../../../OpenAL-android/include \
	$(LOCAL_PATH)/../../../../OpenAL-android/include/AL \
	$(LOCAL_PATH)/../../../../freealut-master/include \
	$(LOCAL_PATH)/../../../../libvorbis-1.3.5/include \
	$(LOCAL_PATH)/../../../../libogg-1.3.2/include \
	$(LOCAL_PATH)/../../../../libogg-1.3.2/android32 \
	$(LOCAL_PATH)/../../../../OpenSceneGraph-3.4.0/include \
	$(LOCAL_PATH)/../../../../OpenSceneGraph-3.4.0/android32/Release/armeabi-v7a/include

include $(BUILD_STATIC_LIBRARY)


