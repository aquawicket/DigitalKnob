OSG := OpenSceneGraph-3.4.0
LOCAL_PATH:= $(call my-dir)

########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgwControls

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/osgwControls/SliderControl.cpp

LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC
LOCAL_CPPFLAGS += -DOSGWORKS_STATIC

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../../$(OSG)/include \
	$(LOCAL_PATH)/../../../../$(OSG)/android32/Release/armeabi-v7a/include

include $(BUILD_STATIC_LIBRARY)




########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgwMx

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/osgwMx/CameraUpdateCallback.cpp \
	../../../src/osgwMx/MxCore.cpp \
	../../../src/osgwMx/MxEventHandler.cpp \
	../../../src/osgwMx/MxGamePad.cpp \
	../../../src/osgwMx/MxSpaceBall.cpp \
	../../../src/osgwMx/MxUtils.cpp

LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC
LOCAL_CPPFLAGS += -DOSGWORKS_STATIC

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../../$(OSG)/include \
	$(LOCAL_PATH)/../../../../$(OSG)/android32/Release/armeabi-v7a/include

include $(BUILD_STATIC_LIBRARY)






########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgwQuery

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/osgwQuery/QueryAPI.cpp \
	../../../src/osgwQuery/QueryBenchmarks.cpp \
	../../../src/osgwQuery/QueryComputation.cpp \
	../../../src/osgwQuery/QueryObject.cpp \
	../../../src/osgwQuery/QueryStats.cpp \
	../../../src/osgwQuery/QueryUtils.cpp\

LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC
LOCAL_CPPFLAGS += -DOSGWORKS_STATIC

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../../$(OSG)/include \
	$(LOCAL_PATH)/../../../../$(OSG)/android32/Release/armeabi-v7a/include

include $(BUILD_STATIC_LIBRARY)






########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgwTools

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/osgwTools/AbsoluteModelTransform.cpp \
	../../../src/osgwTools/CallbackSupport.cpp \
	../../../src/osgwTools/CameraConfigObject.cpp \
	../../../src/osgwTools/Capabilities.cpp \
	../../../src/osgwTools/CollapseLOD.cpp \
	../../../src/osgwTools/CountsVisitor.cpp \
	../../../src/osgwTools/FBOUtils.cpp \
	../../../src/osgwTools/FindNamedNode.cpp \
	../../../src/osgwTools/ForceFlattenTransforms.cpp \
	../../../src/osgwTools/GeometryModifier.cpp \
	../../../src/osgwTools/GeometryOperation.cpp \
	../../../src/osgwTools/InsertRemove.cpp \
	../../../src/osgwTools/LODCreationNodeVisitor.cpp \
	../../../src/osgwTools/MultiCameraProjectionMatrix.cpp \
	../../../src/osgwTools/NodePathUtils.cpp \
	../../../src/osgwTools/NodeUtils.cpp \
	../../../src/osgwTools/Orientation.cpp \
	../../../src/osgwTools/ParallelVisitor.cpp \
	../../../src/osgwTools/PluginLoader.cpp \
	../../../src/osgwTools/PrimitiveSetConversion.cpp \
	../../../src/osgwTools/Quat.cpp \
	../../../src/osgwTools/ReadFile.cpp \
	../../../src/osgwTools/ReducerOp.cpp \
	../../../src/osgwTools/RefID.cpp \
	../../../src/osgwTools/RemoveData.cpp \
	../../../src/osgwTools/RemoveLOD.cpp \
	../../../src/osgwTools/RemoveProgram.cpp \
	../../../src/osgwTools/ScreenCapture.cpp \
	../../../src/osgwTools/Shapes.cpp \
	../../../src/osgwTools/SimplifierOp.cpp \
	../../../src/osgwTools/StateSetUtils.cpp \
	../../../src/osgwTools/StateTrackingNodeVisitor.cpp \
	../../../src/osgwTools/Transform.cpp \
	../../../src/osgwTools/TransformUtils.cpp \
	../../../src/osgwTools/TransparencyUtils.cpp \
	../../../src/osgwTools/Trianglizer.cpp \
	../../../src/osgwTools/Uniqifier.cpp \
	../../../src/osgwTools/Version.cpp

LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC
LOCAL_CPPFLAGS += -DOSGWORKS_STATIC

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../../$(OSG)/include \
	$(LOCAL_PATH)/../../../../$(OSG)/android32/Release/armeabi-v7a/include

include $(BUILD_STATIC_LIBRARY)





########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgdb_osgobjects

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/plugins/osgobjects/ReaderWriterOSGObjects.cpp \

LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC
LOCAL_CPPFLAGS += -DOSGWORKS_STATIC

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../../$(OSG)/include \
	$(LOCAL_PATH)/../../../../$(OSG)/android32/Release/armeabi-v7a/include

include $(BUILD_STATIC_LIBRARY)





########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgdb_osgwTools

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/plugins/osgwTools/dotosgAbsoluteModelTransform.cpp \
	../../../src/plugins/osgwTools/dotosgCameraConfigObject.cpp \
	../../../src/plugins/osgwTools/dotosgFunctionalMap.cpp \
	../../../src/plugins/osgwTools/dotosgRefID.cpp

LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC
LOCAL_CPPFLAGS += -DOSGWORKS_STATIC

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../../$(OSG)/include \
	$(LOCAL_PATH)/../../../../$(OSG)/android32/Release/armeabi-v7a/include

include $(BUILD_STATIC_LIBRARY)





########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgdb_skeleton

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/plugins/skeleton/ReaderWriterSkeleton.cpp

LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC
LOCAL_CPPFLAGS += -DOSGWORKS_STATIC

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../../$(OSG)/include \
	$(LOCAL_PATH)/../../../../$(OSG)/android32/Release/armeabi-v7a/include

include $(BUILD_STATIC_LIBRARY)



