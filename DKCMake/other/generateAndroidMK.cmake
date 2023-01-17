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

function(generateAndroidMK)
	if(ANDROID_LIBMK)
		dk_set(CURRENT_DIR ${plugin_path}/${OS})
		dk_makeDirectory(${CURRENT_DIR})
		if(DEBUG)
			message(STATUS "Creating DEBUG Application.mk file for ${plugin}....")
			dk_set(CURRENT_DIR ${plugin_path}/${OS}/Debug)
			dk_makeDirectory(${CURRENT_DIR})
			dk_makeDirectory(${CURRENT_DIR}/jni)
			
			dk_set(APPMK_FILE "APP_PLATFORM := android-15 \n")
			dk_set(APPMK_FILE ${APPMK_FILE} "APP_ABI      := armeabi-v7a \n")
			dk_set(APPMK_FILE ${APPMK_FILE} "APP_STL      := gnustl_static \n")
			dk_set(APPMK_FILE ${APPMK_FILE} "APP_OPTIM    := debug \n")
			dk_set(APPMK_FILE ${APPMK_FILE} "APP_CPPFLAGS := -fexceptions -frtti\n")
			file(WRITE ${CURRENT_DIR}/jni/Application.mk ${APPMK_FILE})
			
			message(STATUS "Creating DEBUG Android.mk file for ${plugin}....")
			foreach(each_define ${DKDEFINES_LIST})
		        dk_set(ANDROID_LIBMK "${ANDROID_LIBMK} "LOCAL_LDFLAGS += ${each_define}\n")
	        endforeach()
			dk_set(ANDROID_LIBMK ${ANDROID_LIBMK} "LOCAL_C_INCLUDES += ${DKPLUGINS}\n")
			foreach(each_include ${DKINCLUDES_LIST})
				dk_set(ANDROID_LIBMK "${ANDROID_LIBMK} "LOCAL_C_INCLUDES += ${each_include}\n")
			endforeach()
			dk_set(ANDROID_LIBMK ${ANDROID_LIBMK} "include $(BUILD_STATIC_LIBRARY) \n\n")
			file(WRITE ${CURRENT_DIR}/jni/Android.mk ${ANDROID_LIBMK})
			if(WIN_HOST)
				EXECUTE_PROCESS(COMMAND ${ANDROID-NDK}/ndk-build.cmd NDK_DEBUG=1 WORKING_DIRECTORY ${CURRENT_DIR})
			endif()
			if(UNIX_HOST)
				EXECUTE_PROCESS(COMMAND ${ANDROID-NDK}/ndk-build NDK_DEBUG=1 WORKING_DIRECTORY ${CURRENT_DIR})
			endif()
		endif()
		if(RELEASE)
			message(STATUS "Creating RELEASE Application.mk file for ${plugin}....")
			dk_set(CURRENT_DIR ${plugin_path}/${OS}/Release)
			dk_makeDirectory(${CURRENT_DIR})
			dk_makeDirectory(${CURRENT_DIR}/jni)
			
			dk_set(APPMK_FILE "APP_PLATFORM := android-15 \n")
			dk_set(APPMK_FILE ${APPMK_FILE} "APP_ABI      := armeabi-v7a \n")
			dk_set(APPMK_FILE ${APPMK_FILE} "APP_STL      := gnustl_static \n")
			dk_set(APPMK_FILE ${APPMK_FILE} "APP_OPTIM    := release \n")
			dk_set(APPMK_FILE ${APPMK_FILE} "APP_CPPFLAGS := -fexceptions -frtti\n")
			file(WRITE ${CURRENT_DIR}/jni/Application.mk ${APPMK_FILE})
			
			message(STATUS "Creating RELEASE Android.mk file for ${plugin}....")
           foreach(each_define ${DKDEFINES_LIST})
		        dk_set(ANDROID_LIBMK "${ANDROID_LIBMK} "LOCAL_LDFLAGS += ${each_define}\n")
	        endforeach()
			dk_set(ANDROID_LIBMK ${ANDROID_LIBMK} "LOCAL_C_INCLUDES += ${DKPLUGINS}\n")
			foreach(each_include ${DKINCLUDES_LIST})
				dk_set(ANDROID_LIBMK "${ANDROID_LIBMK} "LOCAL_C_INCLUDES += ${each_include}\n")
			endforeach()
			dk_set(ANDROID_LIBMK ${ANDROID_LIBMK} "include $(BUILD_STATIC_LIBRARY) \n\n")
			file(WRITE ${CURRENT_DIR}/jni/Android.mk ${ANDROID_LIBMK})
			if(WIN_HOST)
				EXECUTE_PROCESS(COMMAND ${ANDROID-NDK}/ndk-build.cmd NDK_DEBUG=0 WORKING_DIRECTORY ${CURRENT_DIR})
			endif()
			if(UNIX_HOST)
				EXECUTE_PROCESS(COMMAND ${ANDROID-NDK}/ndk-build NDK_DEBUG=0 WORKING_DIRECTORY ${CURRENT_DIR})
			endif()
		endif()
	endif()
endfunction()
