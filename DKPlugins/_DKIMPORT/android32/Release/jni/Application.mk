#ANDROID APPLICATION MAKEFILE
APP_BUILD_SCRIPT := $(call my-dir)/Android.mk

APP_OPTIM := release

APP_PLATFORM 	:= android-19
APP_STL 		:= c++_static
APP_CPPFLAGS 	:= -fexceptions -frtti
APP_ABI 		:= armeabi-v7a
APP_MODULES     := DKAndroid