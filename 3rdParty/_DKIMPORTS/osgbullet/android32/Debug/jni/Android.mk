OSG := OpenSceneGraph-3.4.0
OSGWORKS := osgworks-master
BULLET := bullet-2.82-r2704
LOCAL_PATH:= $(call my-dir)

########################
include $(CLEAR_VARS)
LOCAL_MODULE    := BulletCollision
LIBDIR := obj/local/armeabi
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
LIBDIR := obj/local/armeabi-v7a
endif
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../../../$(BULLET)/android32/Debug/$(LIBDIR)/libBulletCollision.a
include $(PREBUILT_STATIC_LIBRARY)

########################
include $(CLEAR_VARS)
LOCAL_MODULE    := BulletDynamics
LIBDIR := obj/local/armeabi
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
LIBDIR := obj/local/armeabi-v7a
endif
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../../../$(BULLET)/android32/Debug/$(LIBDIR)/libBulletDynamics.a
include $(PREBUILT_STATIC_LIBRARY)

########################
include $(CLEAR_VARS)
LOCAL_MODULE    := BulletMultiThreaded
LIBDIR := obj/local/armeabi
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
LIBDIR := obj/local/armeabi-v7a
endif
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../../../$(BULLET)/android32/Debug/$(LIBDIR)/libBulletMultiThreaded.a
include $(PREBUILT_STATIC_LIBRARY)

########################
include $(CLEAR_VARS)
LOCAL_MODULE    := BulletSoftBody
LIBDIR := obj/local/armeabi
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
LIBDIR := obj/local/armeabi-v7a
endif
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../../../$(BULLET)/android32/Debug/$(LIBDIR)/libBulletSoftBody.a
include $(PREBUILT_STATIC_LIBRARY)

########################
include $(CLEAR_VARS)
LOCAL_MODULE    := LinearMath
LIBDIR := obj/local/armeabi
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
LIBDIR := obj/local/armeabi-v7a
endif
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../../../$(BULLET)/android32/Debug/$(LIBDIR)/libLinearMath.a
include $(PREBUILT_STATIC_LIBRARY)

########################
include $(CLEAR_VARS)
LOCAL_MODULE    := MiniCL
LIBDIR := obj/local/armeabi
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
LIBDIR := obj/local/armeabi-v7a
endif
LOCAL_SRC_FILES := $(LOCAL_PATH)/../../../../../$(BULLET)/android32/Debug/$(LIBDIR)/libMiniCL.a
include $(PREBUILT_STATIC_LIBRARY)



########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgbCollision

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/osgbCollision/BoundingCone.cpp \
	../../../src/osgbCollision/BoundingCylinder.cpp \
	../../../src/osgbCollision/Chart.cpp \
	../../../src/osgbCollision/CollectVerticesVisitor.cpp \
	../../../src/osgbCollision/CollisionShapes.cpp \
	../../../src/osgbCollision/ComputeCylinderVisitor.cpp \
	../../../src/osgbCollision/ComputeShapeVisitor.cpp \
	../../../src/osgbCollision/ComputeTriMeshVisitor.cpp \
	../../../src/osgbCollision/GLDebugDrawer.cpp \
	../../../src/osgbCollision/Utils.cpp \
	../../../src/osgbCollision/Version.cpp \
	../../../src/osgbCollision/VertexAggOp.cpp

LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC
LOCAL_CPPFLAGS += -DOSGWORKS_STATIC
LOCAL_CPPFLAGS += -DOSGBULLET_STATIC
LOCAL_CPPFLAGS += -DOSGBCOLLISION_LIBRARY

LOCAL_STATIC_LIBRARIES := BulletCollision BulletDynamics BulletMultiThreaded BulletSoftBody LinearMath MiniCL

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../../$(OSG)/include \
	$(LOCAL_PATH)/../../../../$(OSG)/android32/Debug/armeabi-v7a/include \
	$(LOCAL_PATH)/../../../../$(OSGWORKS)/include \
	$(LOCAL_PATH)/../../../../$(BULLET)/src

include $(BUILD_STATIC_LIBRARY)





########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgbDynamics

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/osgbDynamics/Constraints.cpp \
	../../../src/osgbDynamics/CreationRecord.cpp \
	../../../src/osgbDynamics/GroundPlane.cpp \
	../../../src/osgbDynamics/MotionState.cpp \
	../../../src/osgbDynamics/PhysicsState.cpp \
	../../../src/osgbDynamics/PhysicsThread.cpp \
	../../../src/osgbDynamics/RigidBody.cpp \
	../../../src/osgbDynamics/RigidBodyAnimation.cpp \
	../../../src/osgbDynamics/TripleBuffer.cpp

LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC
LOCAL_CPPFLAGS += -DOSGWORKS_STATIC
LOCAL_CPPFLAGS += -DOSGBULLET_STATIC
LOCAL_CPPFLAGS += -DOSGBDYNAMICS_LIBRARY

LOCAL_STATIC_LIBRARIES := BulletCollision BulletDynamics BulletMultiThreaded BulletSoftBody LinearMath MiniCL

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../../$(OSG)/include \
	$(LOCAL_PATH)/../../../../$(OSG)/android32/Debug/armeabi-v7a/include \
	$(LOCAL_PATH)/../../../../$(OSGWORKS)/include \
	$(LOCAL_PATH)/../../../../$(BULLET)/src

include $(BUILD_STATIC_LIBRARY)







########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgbInteraction

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/osgbInteraction/ArticulationRecord.cpp \
	../../../src/osgbInteraction/DragHandler.cpp \
	../../../src/osgbInteraction/GestureHandler.cpp \
	../../../src/osgbInteraction/HandNode.cpp \
	../../../src/osgbInteraction/HandTestEventHandler.cpp \
	../../../src/osgbInteraction/LaunchHandler.cpp \
	../../../src/osgbInteraction/SaveRestoreHandler.cpp
	
LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC
LOCAL_CPPFLAGS += -DOSGWORKS_STATIC
LOCAL_CPPFLAGS += -DOSGBULLET_STATIC
LOCAL_CPPFLAGS += -DOSGBINTERACTION_LIBRARY

LOCAL_STATIC_LIBRARIES := BulletCollision BulletDynamics BulletMultiThreaded BulletSoftBody LinearMath MiniCL

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../../$(OSG)/include \
	$(LOCAL_PATH)/../../../../$(OSG)/android32/Debug/armeabi-v7a/include \
	$(LOCAL_PATH)/../../../../$(OSGWORKS)/include \
	$(LOCAL_PATH)/../../../../$(BULLET)/src

include $(BUILD_STATIC_LIBRARY)






########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgdb_osgbdynamics

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/plugins/osgdb_osgbDynamics/dotosgArticulationRecord.cpp \
	../../../src/plugins/osgdb_osgbDynamics/dotosgConstraints.cpp \
	../../../src/plugins/osgdb_osgbDynamics/dotosgCreationRecord.cpp \
	../../../src/plugins/osgdb_osgbDynamics/dotosgMatrixIO.cpp \
	../../../src/plugins/osgdb_osgbDynamics/dotosgPhysicsData.cpp

LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC
LOCAL_CPPFLAGS += -DOSGWORKS_STATIC
LOCAL_CPPFLAGS += -DOSGBULLET_STATIC
LOCAL_CPPFLAGS += -DOSGBDYNAMICS_LIBRARY

LOCAL_STATIC_LIBRARIES := BulletCollision BulletDynamics BulletMultiThreaded BulletSoftBody LinearMath MiniCL

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../../$(OSG)/include \
	$(LOCAL_PATH)/../../../../$(OSG)/android32/Debug/armeabi-v7a/include \
	$(LOCAL_PATH)/../../../../$(OSGWORKS)/include \
	$(LOCAL_PATH)/../../../../$(BULLET)/src

include $(BUILD_STATIC_LIBRARY)




########################################
include $(CLEAR_VARS)
LOCAL_MODULE := osgdb_sgb

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../src/plugins/osgdb_sgb/ReaderWriterSGB.cpp

LOCAL_CPPFLAGS := -DOSG_LIBRARY_STATIC
LOCAL_CPPFLAGS += -DOSGWORKS_STATIC
LOCAL_CPPFLAGS += -DOSGBULLET_STATIC

LOCAL_STATIC_LIBRARIES := BulletCollision BulletDynamics BulletMultiThreaded BulletSoftBody LinearMath MiniCL

LOCAL_C_INCLUDES :=  \
	$(LOCAL_PATH)/../../../include \
	$(LOCAL_PATH)/../../../../$(OSG)/include \
	$(LOCAL_PATH)/../../../../$(OSG)/android32/Debug/armeabi-v7a/include \
	$(LOCAL_PATH)/../../../../$(OSGWORKS)/include \
	$(LOCAL_PATH)/../../../../$(BULLET)/src

include $(BUILD_STATIC_LIBRARY)