SDL := SDL2-2.0.4
PNG := libpng-1.7.0beta34
TIF := tiff-4.0.3
JPG := jpeg-6b
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES:= \
	../../../IMG.c \
	../../../IMG_bmp.c \
	../../../IMG_gif.c \
	../../../IMG_jpg.c \
	../../../IMG_lbm.c \
	../../../IMG_pcx.c \
	../../../IMG_png.c \
	../../../IMG_pnm.c \
	../../../IMG_tga.c \
	../../../IMG_tif.c \
	../../../IMG_webp.c \
	../../../IMG_xcf.c \
	../../../IMG_xpm.c \
	../../../IMG_xv.c \
	../../../IMG_xxx.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../..
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(SDL)/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(PNG)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(PNG)/android32/Release/jni
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(TIF)/libtiff
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(TIF)/android32/Release/jni
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(JPG)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../$(JPG)/android32/Release/jni
	
LOCAL_CFLAGS := -DLOAD_BMP -DLOAD_GIF -DLOAD_LBM -DLOAD_PCX -DLOAD_PNM \
                -DLOAD_TGA -DLOAD_XCF -DLOAD_XPM -DLOAD_XV -DLOAD_PNG -DLOAD_JPG -DLOAD_TIF
LOCAL_CFLAGS += -O3 -fstrict-aliasing -fprefetch-loop-arrays

LOCAL_STATIC_LIBRARIES := stl
LOCAL_SHARED_LIBRARIES := SDL2
LOCAL_MODULE := SDL2_image
include $(BUILD_STATIC_LIBRARY)