# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
include_guard()

# Depeciated and archived cmake code

# https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609
#add_custom_command(TARGET ${APP_NAME}
#    # Run after all other rules within the target have been executed
#    POST_BUILD
#    COMMAND echo -e "\texecuting a POST_BUILD command"
#    COMMENT "This command will be executed after building target"
#    VERBATIM
#)

#add_custom_command(TARGET ${APP_NAME}
#   # Run after all other rules within the target have been executed
#    POST_BUILD
#    COMMAND "${3RDPARTY}/upx-3.96/upx.exe" "-9 -v ${DK_PROJECT_DIR}/${OS}/Release/${APP_NAME}.exe"
#    COMMENT "This command will be executed after building target"
#    VERBATIM
#)

###########
## Create Android.mk file
#if(ANDROID)
#   message(STATUS "Creating Android.mk file for ${APP_NAME}....")
#	#update app name
#	dk_updateAndroidName(${APP_NAME})
#	
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_PATH := $(call my-dir)\n")
#	if(SDL)
#		message(STATUS "USING SDL FOR ANDROID")
#		dk_set(ANDROID_APPMK ${ANDROID_APPMK} "include $(CLEAR_VARS)\n")
#		dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_MODULE := SDL2\n")
#	if(DEBUG)
#		dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SRC_FILES := ${SDL}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libSDL2.so\n")
#	endif()
#	if(RELEASE)
#		dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SRC_FILES := ${SDL}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libSDL2.so\n")
#	endif()
#		dk_set(ANDROID_APPMK ${ANDROID_APPMK} "include $(PREBUILT_SHARED_LIBRARY)\n")
#	endif()
#	
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "include $(CLEAR_VARS)\n")
#	if(DEBUG)
#		dk_set(ANDROID_APPMK ${ANDROID_APPMK} "BUILD_TYPE := Debug\n\n")
#	endif()
#	if(RELEASE)
#		dk_set(ANDROID_APPMK ${ANDROID_APPMK} "BUILD_TYPE := Release\n\n")
#	endif()
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_MODULE := DKAndroid\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "SRC_DIR := $(LOCAL_PATH)/../../..\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "DK_DIR := C:/Users/$ENV{USERNAME}/digitalknob\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "NDKLIBDIR := ${ANDROID_NDK}/sources/cxx-stl/gnu-libstdc++/4.8/libs/armeabi-v7a\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "DKPLUGINS := $(DK_DIR)/DKPlugins\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "3RDPARTY := $(DKPLUGINS)/3rdParty\n\n")
#
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_C_INCLUDES := $(LOCAL_PATH)\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_C_INCLUDES += $(SRC_DIR)\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CFLAGS := -fno-short-enums -fpermissive -fuse-ld=bfd\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDLIBS := -llog -lGLESv1_CM -lz -landroid\n")
#	#if(OPENGL2)
#	#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDLIBS := -llog -lGLESv2 -lz\n")
#	#else()
#	#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDLIBS := -llog -lGLESv1_CM -lz\n")
#	#endif()
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "APP_SRC := $(wildcard $(SRC_DIR)/*.cpp)\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "APP_SRC += $(wildcard $(SRC_DIR)/*.c)\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SRC_FILES := $(APP_SRC:$(LOCAL_PATH)/%=%)\n\n")
#
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS := -DANDROID\n")
#	if(ANDROID_ARM32)
#		dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -DANDROID_ARM32\n")
#	endif()
#	if(ANDROID_ARM64)
#		dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -DANDROID_ARM64\n")
#	endif()
#	#dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -D__ANDROID__\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -DDKAPP\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "ifeq ($(BUILD_TYPE),Debug)\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "	LOCAL_CPPFLAGS += -DDEBUG\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "else\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "	LOCAL_CPPFLAGS += -DNDEBUG\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "endif\n")
#
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LIBDIR := $(BUILD_TYPE)/obj/local/armeabi\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "	LOCAL_ARM_NEON := true\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "	LIBDIR := $(BUILD_TYPE)/obj/local/armeabi-v7a\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "endif\n\n")
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDFLAGS :=\n\n")
#   foreach(each_define ${DKDEFINES_LIST})
#		dk_set(ANDROID_LIBMK "${ANDROID_LIBMK} "LOCAL_LDFLAGS += ${each_define}\n")
#	endforeach()
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_C_INCLUDES += ${DKPLUGINS}\n")
#	foreach(each_include ${DKINCLUDES_LIST})
#		dk_set(ANDROID_LIBMK "${ANDROID_LIBMK} "LOCAL_C_INCLUDES += ${each_include}\n")
#	endforeach()
#	#list(REVERSE DKLIBRARIES)
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} ${DKLIBRARIES})
#			
#	if(SDL)
#		dk_set(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SHARED_LIBRARIES := SDL2\n")
#	endif()
#	dk_set(ANDROID_APPMK ${ANDROID_APPMK} "include $(BUILD_SHARED_LIBRARY)\n\n")
#	
#	if(DEBUG)
#		file(WRITE ${DK_PROJECT_DIR}/${OS}/${DEBUG_DIR}/jni/Android.mk ${ANDROID_APPMK})
#	endif()
#	if(RELEASE)
#		file(WRITE ${DK_PROJECT_DIR}/${OS}/${RELEASE_DIR}/jni/Android.mk ${ANDROID_APPMK})
#	endif()
#endif()