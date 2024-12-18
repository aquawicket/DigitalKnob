#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### bullet3 ######
# https://github.com/bulletphysics/bullet3.git
# https://code.google.com/archive/p/bullet
# https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bullet/bullet-2.82-r2704.zip

### IMPORT ###
dk_load(dk_builder)

dk_getFileParam(${DKIMPORTS_DIR}/bullet3/dkconfig.txt BULLET3_DL)
dk_import("${BULLET3_DL}")

### LINK ###
dk_enable(ALL_LIBS)
if(ALL_LIBS)
	dk_enable(Bullet3Collision)
	dk_enable(Bullet3Common)
	dk_enable(Bullet3Dynamics)
	dk_enable(Bullet3Geometry)
	#dk_enable(Bullet3OpenCL)
	#dk_enable(Bullet3Serialize)
	dk_enable(BulletCollision)
	dk_enable(BulletDynamics)
	dk_enable(BulletInverseDynamics)
	dk_enable(BulletSoftBody)
	dk_enable(LinearMath)
endif(ALL_LIBS)


dk_include					(${BULLET3_DIR}/src																BULLET_INCLUDE_DIR)

if(Bullet3Collision)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/Bullet3Collision_Debug.lib)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/Bullet3Collision.lib)
		else()
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/Bullet3Collision/libBullet3Collision_Debug.a)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/Bullet3Collision/libBullet3Collision.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_DEBUG_DIR}/lib/libBullet3Collision_Debug.a)
		dk_libRelease		(${BULLET3_RELEASE_DIR}/lib/libBullet3Collision.a)
	endif()
endif()
if(Bullet3Common)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/${DEBUG_DIR}/Bullet3Common_Debug.lib)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/${RELEASE_DIR}/Bullet3Common.lib)
		else()
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/Bullet3Common/${DEBUG_DIR}/libBullet3Common_Debug.a)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/Bullet3Common/${RELEASE_DIR}/libBullet3Common.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_DEBUG_DIR}/lib/libBullet3Common_Debug.a)
		dk_libRelease		(${BULLET3_RELEASE_DIR}/lib/libBullet3Common.a)
	endif()
endif()
if(Bullet3Dynamics)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/${DEBUG_DIR}/Bullet3Dynamics_Debug.lib)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/${RELEASE_DIR}/Bullet3Dynamics.lib)
		else()
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/Bullet3Dynamics/${DEBUG_DIR}/libBullet3Dynamics_Debug.a)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/Bullet3Dynamics/${RELEASE_DIR}/libBullet3Dynamics.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_DEBUG_DIR}/lib/libBullet3Dynamics_Debug.a)
		dk_libRelease		(${BULLET3_RELEASE_DIR}/lib/libBullet3Dynamics.a)
	endif()
endif()
if(Bullet3Geometry)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/${DEBUG_DIR}/Bullet3Geometry_Debug.lib)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/${RELEASE_DIR}/Bullet3Geometry.lib)
		else()
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/Bullet3Geometry/${DEBUG_DIR}/libBullet3Geometry_Debug.a)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/Bullet3Geometry/${RELEASE_DIR}/libBullet3Geometry.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_DEBUG_DIR}/lib/libBullet3Geometry_Debug.a)
		dk_libRelease		(${BULLET3_RELEASE_DIR}/lib/libBullet3Geometry.a)
	endif()	
endif()
if(Bullet3OpenCL)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/${DEBUG_DIR}/Bullet3OpenCL_clew_Debug.lib)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/${RELEASE_DIR}/Bullet3OpenCL_clew.lib)
		else()
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/Bullet3OpenCL/${DEBUG_DIR}/libBullet3OpenCL_clew_Debug.a)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/Bullet3OpenCL/${RELEASE_DIR}/libBullet3OpenCL_clew.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_DEBUG_DIR}/lib/libBullet3OpenCL_clew_Debug.a)
		dk_libRelease		(${BULLET3_RELEASE_DIR}/lib/libBullet3OpenCL_clew.a)
	endif()
endif()
if(Bullet3Serialize)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/${DEBUG_DIR}/BulletFileLoader_Debug.lib)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/${RELEASE_DIR}/BulletFileLoader.lib)
		else()
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/Bullet3Serialize/Bullet2FileLoader/${DEBUG_DIR}/libBullet2FileLoader_Debug.a)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/Bullet3Serialize/Bullet2FileLoader/${RELEASE_DIR}/libBullet2FileLoader.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_DEBUG_DIR}/lib/libBullet2FileLoader_Debug.a)
		dk_libRelease		(${BULLET3_RELEASE_DIR}/lib/libBullet2FileLoader.a)
	endif()
endif()
if(BulletCollision)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/${DEBUG_DIR}/BulletCollision_Debug.lib				BULLET_COLLISION_DEBUG_LIBRARY)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/${RELEASE_DIR}/BulletCollision.lib					BULLET_COLLISION_RELEASE_LIBRARY)
		else()
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/BulletCollision/${DEBUG_DIR}/libBulletCollision_Debug.a	BULLET_COLLISION_DEBUG_LIBRARY)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/BulletCollision/${RELEASE_DIR}/libBulletCollision.a		BULLET_COLLISION_RELEASE_LIBRARY)
		endif()
	else()
		dk_libDebug			(${BULLET3_DEBUG_DIR}/lib/libBulletCollision_Debug.a							BULLET_COLLISION_DEBUG_LIBRARY)
		dk_libRelease		(${BULLET3_RELEASE_DIR}/lib/libBulletCollision.a								BULLET_COLLISION_RELEASE_LIBRARY)
	endif()
endif()
if(BulletDynamics)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/${DEBUG_DIR}/BulletDynamics_Debug.lib					BULLET_DYNAMICS_DEBUG_LIBRARY)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/${RELEASE_DIR}/BulletDynamics.lib					BULLET_DYNAMICS_RELEASE_LIBRARY)
		else()
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/BulletDynamics/${DEBUG_DIR}/libBulletDynamics_Debug.a	BULLET_DYNAMICS_DEBUG_LIBRARY)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/BulletDynamics/${RELEASE_DIR}/libBulletDynamics.a	BULLET_DYNAMICS_RELEASE_LIBRARY)
		endif()
	else()
		dk_libDebug			(${BULLET3_DEBUG_DIR}/lib/libBulletDynamics_Debug.a								BULLET_DYNAMICS_DEBUG_LIBRARY)
		dk_libRelease		(${BULLET3_RELEASE_DIR}/lib/libBulletDynamics.a									BULLET_DYNAMICS_RELEASE_LIBRARY)
	endif()
endif()
if(BulletInverseDynamics)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/${DEBUG_DIR}/BulletInverseDynamics_Debug.lib			BULLET_INVERSEDYNAMICS_DEBUG_LIBRARY)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/${RELEASE_DIR}/BulletInverseDynamics.lib			BULLET_INVERSEDYNAMICS_RELEASE_LIBRARY)
		else()
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/${DEBUG_DIR}/libBulletInverseDynamics_Debug.a			BULLET_INVERSEDYNAMICS_DEBUG_LIBRARY)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/${RELEASE_DIR}/libBulletInverseDynamics.a			BULLET_INVERSEDYNAMICS_RELEASE_LIBRARY)
		endif()
	else()
		dk_libDebug			(${BULLET3_DEBUG_DIR}/lib/libBulletInverseDynamics_Debug.a						BULLET_INVERSEDYNAMICS_DEBUG_LIBRARY)
		dk_libRelease		(${BULLET3_RELEASE_DIR}/lib/libBulletInverseDynamics.a							BULLET_INVERSEDYNAMICS_RELEASE_LIBRARY)
	endif()
endif()
if(BulletSoftBody)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/${DEBUG_DIR}/BulletSoftBody_Debug.lib					BULLET_SOFTBODY_DEBUG_LIBRARY)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/${RELEASE_DIR}/BulletSoftBody.lib					BULLET_SOFTBODY_RELEASE_LIBRARY)
		else()
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/BulletSoftBody/${DEBUG_DIR}/libBulletSoftBody_Debug.a	BULLET_SOFTBODY_DEBUG_LIBRARY)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/BulletSoftBody/${RELEASE_DIR}/libBulletSoftBody.a	BULLET_SOFTBODY_RELEASE_LIBRARY)
		endif()
	else()
		dk_libDebug			(${BULLET3_DEBUG_DIR}/lib/libBulletSoftBody_Debug.a								BULLET_SOFTBODY_DEBUG_LIBRARY)
		dk_libRelease		(${BULLET3_RELEASE_DIR}/lib/libBulletSoftBody.a									BULLET_SOFTBODY_RELEASE_LIBRARY)
	endif()
endif()
if(LinearMath)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/${DEBUG_DIR}/LinearMath_Debug.lib						BULLET_MATH_DEBUG_LIBRARY)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/${RELEASE_DIR}/LinearMath.lib						BULLET_MATH_RELEASE_LIBRARY)
		else()
			dk_libDebug		(${BULLET3_DEBUG_DIR}/lib/LinearMath/${DEBUG_DIR}/libLinearMath_Debug.a			BULLET_MATH_DEBUG_LIBRARY)
			dk_libRelease	(${BULLET3_RELEASE_DIR}/lib/LinearMath/${RELEASE_DIR}/libLinearMath.a			BULLET_MATH_RELEASE_LIBRARY)
		endif()
	else()
		dk_libDebug			(${BULLET3_DEBUG_DIR}/lib/libLinearMath_Debug.a									BULLET_MATH_DEBUG_LIBRARY)
		dk_libRelease		(${BULLET3_RELEASE_DIR}/lib/libLinearMath.a										BULLET_MATH_RELEASE_LIBRARY)
	endif()	
endif(LinearMath)
if(DEBUG)
	set(BULLET_COLLISION_LIBRARY 		${BULLET_COLLISION_DEBUG_LIBRARY})
	set(BULLET_DYNAMICS_LIBRARY 		${BULLET_DYNAMICS_DEBUG_LIBRARY})
	set(BULLET_INVERSEDYNAMICS_LIBRARY	${BULLET_INVERSEDYNAMICS_DEBUG_LIBRARY})
	set(BULLET_SOFTBODY_LIBRARY 		${BULLET_SOFTBODY_DEBUG_LIBRARY})
	set(BULLET_MATH_LIBRARY 			${BULLET_MATH_DEBUG_LIBRARY})
endif()
if(RELEASE)
	set(BULLET_COLLISION_LIBRARY 		${BULLET_COLLISION_RELEASE_LIBRARY})
	set(BULLET_DYNAMICS_LIBRARY 		${BULLET_DYNAMICS_RELEASE_LIBRARY})
	set(BULLET_INVERSEDYNAMICS_LIBRARY	${BULLET_INVERSEDYNAMICS_RELEASE_LIBRARY})
	set(BULLET_SOFTBODY_LIBRARY 		${BULLET_SOFTBODY_RELEASE_LIBRARY})
	set(BULLET_MATH_LIBRARY 			${BULLET_MATH_RELEASE_LIBRARY})
endif()

### 3RDPARTY LINK ###
dk_set(BULLET3_CMAKE
	-DBULLET_INCLUDE_DIR=${BULLET_INCLUDE_DIR}
	-DBULLET_DYNAMICS_LIBRARY=${BULLET_DYNAMICS_LIBRARY}
	-DBULLET_COLLISION_LIBRARY=${BULLET_COLLISION_LIBRARY}
	-DBULLET_MATH_LIBRARY=${BULLET_MATH_LIBRARY}
	-DBULLET_SOFTBODY_LIBRARY=${BULLET_SOFTBODY_LIBRARY})

### GENERATE ###
dk_configure(${BULLET3_DIR}
			-DBUILD_BULLET2_DEMOS=OFF
			-DBUILD_CLSOCKET=ON
			-DBUILD_CPU_DEMOS=OFF
			-DBUILD_EGL=ON
			-DBUILD_ENET=ON
			-DBUILD_EXTRAS=OFF
			-DBUILD_OPENGL3_DEMOS=OFF
			-DBUILD_PYBULLET=OFF
			-DBUILD_PYBULLET_CLSOCKET=ON
			-DBUILD_PYBULLET_ENET=ON
			-DBUILD_PYBULLET_MAC_USE_PYTHON_FRAMEWORK=OFF
			-DBUILD_PYBULLET_NUMPY=OFF
			-DBUILD_PYBULLET_SHOW_PY_VERSION=OFF
			-DBULLET2_MULTITHREADING=OFF
			-DBULLET2_USE_OPEN_MP_MULTITHREADING=OFF
			-DBULLET2_USE_PPL_MULTITHREADING=OFF
			-DBULLET2_USE_TBB_MULTITHREADING=OFF
			-DCLAMP_VELOCITIES=0
			-DCMAKE_DEBUG_POSTFIX=_Debug
			-DCMAKE_MINSIZEREL_POSTFIX=_MinsizeRel
			-DCMAKE_RELWITHDEBINFO_POSTFIX=_RelWithDebugInfo
			-DENABLE_VHACD=ON
			-DEXACT_PYTHON_VERSION=OFF
			-DINSTALL_CMAKE_FILES=OFF
			-DINSTALL_EXTRA_LIBS=OFF
			-DINSTALL_LIBS=OFF
			-DINTERNAL_ADD_POSTFIX_EXECUTABLE_NAMES=OFF
			-DINTERNAL_CREATE_DISTRIBUTABLE_MSVC_PROJECTFILES=OFF
			-DINTERNAL_CREATE_MSVC_RELATIVE_PATH_PROJECTFILES=OFF
			-DINTERNAL_UPDATE_SERIALIZATION_STRUCTURES=OFF
			-DUSE_DOUBLE_PRECISION=OFF
			-DUSE_GLUT=OFF
			-DUSE_GRAPHICAL_BENCHMARK=ON
			-DUSE_MSVC_AVX=OFF
			-DUSE_MSVC_COMDAT_FOLDING=ON
			-DUSE_MSVC_DISABLE_RTTI=OFF
			-DUSE_MSVC_EXEPTIONS=OFF
			-DUSE_MSVC_FAST_FLOATINGPOINT=ON
			-DUSE_MSVC_FUNCTION_LEVEL_LINKING=ON
			-DUSE_MSVC_INCREMENTAL_LINKING=OFF
			-DUSE_MSVC_RELEASE_RUNTIME_ALWAYS=OFF
			-DUSE_MSVC_RUNTIME_LIBRARY_DLL=ON
			-DUSE_MSVC_SSE2=ON
			-DUSE_MSVC_SSE=OFF
			-DUSE_MSVC_STRING_POOLING=ON
			-DUSE_OPENVR=OFF
			-DUSE_SOFT_BODY_MULTI_BODY_DYNAMICS_WORLD=ON)

### COMPILE ###
#dk_build(${BULLET3_DIR})
if(Bullet3Collision)
	dk_build(${BULLET3_DIR} Bullet3Collision)
endif()
if(Bullet3Common)
	dk_build(${BULLET3_DIR} Bullet3Common)
endif()
if(Bullet3Dynamics)
	dk_build(${BULLET3_DIR} Bullet3Dynamics)
endif()
if(Bullet3Geometry)
	dk_build(${BULLET3_DIR} Bullet3Geometry)
endif()
if(Bullet3OpenCL)
	dk_build(${BULLET3_DIR} Bullet3OpenCL)
endif()
if(Bullet3Serialize)
	dk_build(${BULLET3_DIR} Bullet3Serialize)
endif()
if(BulletCollision)
	dk_build(${BULLET3_DIR} BulletCollision)
endif()
if(BulletDynamics)
	dk_build(${BULLET3_DIR} BulletDynamics)
endif()
if(BulletInverseDynamics)
	dk_build(${BULLET3_DIR} BulletInverseDynamics)
endif()
if(BulletSoftBody)
	dk_build(${BULLET3_DIR} BulletSoftBody)
endif()
if(LinearMath)
	dk_build(${BULLET3_DIR} LinearMath)
endif()

	

