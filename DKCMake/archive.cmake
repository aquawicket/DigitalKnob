# Depeciated and archived cmake code

# https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609
#add_custom_command(TARGET ${APP_NAME}
#    # Run after all other rules within the target have been executed
#    POST_BUILD
#    COMMAND echo -e "\texecuting a POST_BUILD command"
#    COMMENT "This command will be executed after building bar"
#    VERBATIM
#)

#add_custom_command(TARGET ${APP_NAME}
#   # Run after all other rules within the target have been executed
#    POST_BUILD
#    COMMAND "${3RDPARTY}/upx-3.96/upx.exe" "-9 -v ${DKPROJECT}/${OS}/Release/${APP_NAME}.exe"
#    COMMENT "This command will be executed after building bar"
#    VERBATIM
#)

###########
## Create Android.mk file
#if(ANDROID)
#   message(STATUS "Creating Android.mk file for ${APP_NAME}....")
#	#update app name
#	DKUPDATE_ANDROID_NAME(${APP_NAME})
#	
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_PATH := $(call my-dir)\n")
#	if(SDL)
#		message(STATUS "USING SDL FOR ANDROID")
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "include $(CLEAR_VARS)\n")
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_MODULE := SDL2\n")
#	if(DEBUG)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SRC_FILES := ${SDL}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libSDL2.so\n")
#	endif()
#	if(RELEASE)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SRC_FILES := ${SDL}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libSDL2.so\n")
#	endif()
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "include $(PREBUILT_SHARED_LIBRARY)\n")
#	endif()
#	
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "include $(CLEAR_VARS)\n")
#	if(DEBUG)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "BUILD_TYPE := Debug\n\n")
#	endif()
#	if(RELEASE)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "BUILD_TYPE := Release\n\n")
#	endif()
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_MODULE := DKAndroid\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "SRC_DIR := $(LOCAL_PATH)/../../..\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "DK_DIR := C:/Users/$ENV{USERNAME}/digitalknob\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "NDKLIBDIR := ${ANDROIDNDK}/sources/cxx-stl/gnu-libstdc++/4.8/libs/armeabi-v7a\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "DKPLUGINS := $(DK_DIR)/DKPlugins\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "3RDPARTY := $(DKPLUGINS)/3rdParty\n\n")
#
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_C_INCLUDES := $(LOCAL_PATH)\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_C_INCLUDES += $(SRC_DIR)\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CFLAGS := -fno-short-enums -fpermissive -fuse-ld=bfd\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDLIBS := -llog -lGLESv1_CM -lz -landroid\n")
#	#if(OPENGL2)
#	#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDLIBS := -llog -lGLESv2 -lz\n")
#	#else()
#	#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDLIBS := -llog -lGLESv1_CM -lz\n")
#	#endif()
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "APP_SRC := $(wildcard $(SRC_DIR)/*.cpp)\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "APP_SRC += $(wildcard $(SRC_DIR)/*.c)\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SRC_FILES := $(APP_SRC:$(LOCAL_PATH)/%=%)\n\n")
#
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS := -DANDROID\n")
#	if(ANDROID_32)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -DANDROID32\n")
#	endif()
#	if(ANDROID_64)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -DANDROID64\n")
#	endif()
#	#DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -D__ANDROID__\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -DDKAPP\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "ifeq ($(BUILD_TYPE),Debug)\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "	LOCAL_CPPFLAGS += -DDEBUG\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "else\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "	LOCAL_CPPFLAGS += -DNDEBUG\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "endif\n")
#
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LIBDIR := $(BUILD_TYPE)/obj/local/armeabi\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "	LOCAL_ARM_NEON := true\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "	LIBDIR := $(BUILD_TYPE)/obj/local/armeabi-v7a\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "endif\n\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDFLAGS :=\n\n")
#   foreach(each_define ${DKDEFINES_LIST})
#		DKSET(ANDROID_LIBMK "${ANDROID_LIBMK} "LOCAL_LDFLAGS += ${each_define}\n")
#	endforeach()
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_C_INCLUDES += ${DKPLUGINS}\n")
#	foreach(each_include ${DKINCLUDES_LIST})
#		DKSET(ANDROID_LIBMK "${ANDROID_LIBMK} "LOCAL_C_INCLUDES += ${each_include}\n")
#	endforeach()
#	#list(REVERSE DKLIBRARIES)
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} ${DKLIBRARIES})
#			
#	if(SDL)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SHARED_LIBRARIES := SDL2\n")
#	endif()
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "include $(BUILD_SHARED_LIBRARY)\n\n")
#	
#	if(DEBUG)
#		file(WRITE ${DKPROJECT}/${OS}/${DEBUG_DIR}/jni/Android.mk ${ANDROID_APPMK})
#	endif()
#	if(RELEASE)
#		file(WRITE ${DKPROJECT}/${OS}/${RELEASE_DIR}/jni/Android.mk ${ANDROID_APPMK})
#	endif()
#endif()