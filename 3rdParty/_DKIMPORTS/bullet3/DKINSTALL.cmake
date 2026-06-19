#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


###### bullet3 ######
# https://github.com/bulletphysics/bullet3.git
# https://code.google.com/archive/p/bullet
# https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bullet/bullet-2.82-r2704.zip

dk_import()

### LINK ###
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


dk_include					(${bullet3}/src																BULLET_INCLUDE_DIR)

if(Bullet3Collision)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${bullet3_Debug_Dir}/lib/Bullet3Collision_Debug.lib)
			dk_libRelease	(${bullet3_Release_Dir}/lib/Bullet3Collision.lib)
		else()
			dk_libDebug		(${bullet3_Debug_Dir}/lib/Bullet3Collision/libBullet3Collision_Debug.a)
			dk_libRelease	(${bullet3_Release_Dir}/lib/Bullet3Collision/libBullet3Collision.a)
		endif()
	else()
		dk_libDebug			(${bullet3_Debug_Dir}/lib/libBullet3Collision_Debug.a)
		dk_libRelease		(${bullet3_Release_Dir}/lib/libBullet3Collision.a)
	endif()
endif()
if(Bullet3Common)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${bullet3_Debug_Dir}/lib/${Debug_Dir}/Bullet3Common_Debug.lib)
			dk_libRelease	(${bullet3_Release_Dir}/lib/${Release_Dir}/Bullet3Common.lib)
		else()
			dk_libDebug		(${bullet3_Debug_Dir}/lib/Bullet3Common/${Debug_Dir}/libBullet3Common_Debug.a)
			dk_libRelease	(${bullet3_Release_Dir}/lib/Bullet3Common/${Release_Dir}/libBullet3Common.a)
		endif()
	else()
		dk_libDebug			(${bullet3_Debug_Dir}/lib/libBullet3Common_Debug.a)
		dk_libRelease		(${bullet3_Release_Dir}/lib/libBullet3Common.a)
	endif()
endif()
if(Bullet3Dynamics)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${bullet3_Debug_Dir}/lib/${Debug_Dir}/Bullet3Dynamics_Debug.lib)
			dk_libRelease	(${bullet3_Release_Dir}/lib/${Release_Dir}/Bullet3Dynamics.lib)
		else()
			dk_libDebug		(${bullet3_Debug_Dir}/lib/Bullet3Dynamics/${Debug_Dir}/libBullet3Dynamics_Debug.a)
			dk_libRelease	(${bullet3_Release_Dir}/lib/Bullet3Dynamics/${Release_Dir}/libBullet3Dynamics.a)
		endif()
	else()
		dk_libDebug			(${bullet3_Debug_Dir}/lib/libBullet3Dynamics_Debug.a)
		dk_libRelease		(${bullet3_Release_Dir}/lib/libBullet3Dynamics.a)
	endif()
endif()
if(Bullet3Geometry)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${bullet3_Debug_Dir}/lib/${Debug_Dir}/Bullet3Geometry_Debug.lib)
			dk_libRelease	(${bullet3_Release_Dir}/lib/${Release_Dir}/Bullet3Geometry.lib)
		else()
			dk_libDebug		(${bullet3_Debug_Dir}/lib/Bullet3Geometry/${Debug_Dir}/libBullet3Geometry_Debug.a)
			dk_libRelease	(${bullet3_Release_Dir}/lib/Bullet3Geometry/${Release_Dir}/libBullet3Geometry.a)
		endif()
	else()
		dk_libDebug			(${bullet3_Debug_Dir}/lib/libBullet3Geometry_Debug.a)
		dk_libRelease		(${bullet3_Release_Dir}/lib/libBullet3Geometry.a)
	endif()	
endif()
if(Bullet3OpenCL)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${bullet3_Debug_Dir}/lib/${Debug_Dir}/Bullet3OpenCL_clew_Debug.lib)
			dk_libRelease	(${bullet3_Release_Dir}/lib/${Release_Dir}/Bullet3OpenCL_clew.lib)
		else()
			dk_libDebug		(${bullet3_Debug_Dir}/lib/Bullet3OpenCL/${Debug_Dir}/libBullet3OpenCL_clew_Debug.a)
			dk_libRelease	(${bullet3_Release_Dir}/lib/Bullet3OpenCL/${Release_Dir}/libBullet3OpenCL_clew.a)
		endif()
	else()
		dk_libDebug			(${bullet3_Debug_Dir}/lib/libBullet3OpenCL_clew_Debug.a)
		dk_libRelease		(${bullet3_Release_Dir}/lib/libBullet3OpenCL_clew.a)
	endif()
endif()
if(Bullet3Serialize)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${bullet3_Debug_Dir}/lib/${Debug_Dir}/BulletFileLoader_Debug.lib)
			dk_libRelease	(${bullet3_Release_Dir}/lib/${Release_Dir}/BulletFileLoader.lib)
		else()
			dk_libDebug		(${bullet3_Debug_Dir}/lib/Bullet3Serialize/Bullet2FileLoader/${Debug_Dir}/libBullet2FileLoader_Debug.a)
			dk_libRelease	(${bullet3_Release_Dir}/lib/Bullet3Serialize/Bullet2FileLoader/${Release_Dir}/libBullet2FileLoader.a)
		endif()
	else()
		dk_libDebug			(${bullet3_Debug_Dir}/lib/libBullet2FileLoader_Debug.a)
		dk_libRelease		(${bullet3_Release_Dir}/lib/libBullet2FileLoader.a)
	endif()
endif()
if(BulletCollision)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${bullet3_Debug_Dir}/lib/${Debug_Dir}/BulletCollision_Debug.lib				BULLET_COLLISION_DEBUG_LIBRARY)
			dk_libRelease	(${bullet3_Release_Dir}/lib/${Release_Dir}/BulletCollision.lib					BULLET_COLLISION_RELEASE_LIBRARY)
		else()
			dk_libDebug		(${bullet3_Debug_Dir}/lib/BulletCollision/${Debug_Dir}/libBulletCollision_Debug.a	BULLET_COLLISION_DEBUG_LIBRARY)
			dk_libRelease	(${bullet3_Release_Dir}/lib/BulletCollision/${Release_Dir}/libBulletCollision.a		BULLET_COLLISION_RELEASE_LIBRARY)
		endif()
	else()
		dk_libDebug			(${bullet3_Debug_Dir}/lib/libBulletCollision_Debug.a							BULLET_COLLISION_DEBUG_LIBRARY)
		dk_libRelease		(${bullet3_Release_Dir}/lib/libBulletCollision.a								BULLET_COLLISION_RELEASE_LIBRARY)
	endif()
endif()
if(BulletDynamics)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${bullet3_Debug_Dir}/lib/${Debug_Dir}/BulletDynamics_Debug.lib					BULLET_DYNAMICS_DEBUG_LIBRARY)
			dk_libRelease	(${bullet3_Release_Dir}/lib/${Release_Dir}/BulletDynamics.lib					BULLET_DYNAMICS_RELEASE_LIBRARY)
		else()
			dk_libDebug		(${bullet3_Debug_Dir}/lib/BulletDynamics/${Debug_Dir}/libBulletDynamics_Debug.a	BULLET_DYNAMICS_DEBUG_LIBRARY)
			dk_libRelease	(${bullet3_Release_Dir}/lib/BulletDynamics/${Release_Dir}/libBulletDynamics.a	BULLET_DYNAMICS_RELEASE_LIBRARY)
		endif()
	else()
		dk_libDebug			(${bullet3_Debug_Dir}/lib/libBulletDynamics_Debug.a								BULLET_DYNAMICS_DEBUG_LIBRARY)
		dk_libRelease		(${bullet3_Release_Dir}/lib/libBulletDynamics.a									BULLET_DYNAMICS_RELEASE_LIBRARY)
	endif()
endif()
if(BulletInverseDynamics)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${bullet3_Debug_Dir}/lib/${Debug_Dir}/BulletInverseDynamics_Debug.lib			BULLET_INVERSEDYNAMICS_DEBUG_LIBRARY)
			dk_libRelease	(${bullet3_Release_Dir}/lib/${Release_Dir}/BulletInverseDynamics.lib			BULLET_INVERSEDYNAMICS_RELEASE_LIBRARY)
		else()
			dk_libDebug		(${bullet3_Debug_Dir}/lib/${Debug_Dir}/libBulletInverseDynamics_Debug.a			BULLET_INVERSEDYNAMICS_DEBUG_LIBRARY)
			dk_libRelease	(${bullet3_Release_Dir}/lib/${Release_Dir}/libBulletInverseDynamics.a			BULLET_INVERSEDYNAMICS_RELEASE_LIBRARY)
		endif()
	else()
		dk_libDebug			(${bullet3_Debug_Dir}/lib/libBulletInverseDynamics_Debug.a						BULLET_INVERSEDYNAMICS_DEBUG_LIBRARY)
		dk_libRelease		(${bullet3_Release_Dir}/lib/libBulletInverseDynamics.a							BULLET_INVERSEDYNAMICS_RELEASE_LIBRARY)
	endif()
endif()
if(BulletSoftBody)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${bullet3_Debug_Dir}/lib/${Debug_Dir}/BulletSoftBody_Debug.lib					BULLET_SOFTBODY_DEBUG_LIBRARY)
			dk_libRelease	(${bullet3_Release_Dir}/lib/${Release_Dir}/BulletSoftBody.lib					BULLET_SOFTBODY_RELEASE_LIBRARY)
		else()
			dk_libDebug		(${bullet3_Debug_Dir}/lib/BulletSoftBody/${Debug_Dir}/libBulletSoftBody_Debug.a	BULLET_SOFTBODY_DEBUG_LIBRARY)
			dk_libRelease	(${bullet3_Release_Dir}/lib/BulletSoftBody/${Release_Dir}/libBulletSoftBody.a	BULLET_SOFTBODY_RELEASE_LIBRARY)
		endif()
	else()
		dk_libDebug			(${bullet3_Debug_Dir}/lib/libBulletSoftBody_Debug.a								BULLET_SOFTBODY_DEBUG_LIBRARY)
		dk_libRelease		(${bullet3_Release_Dir}/lib/libBulletSoftBody.a									BULLET_SOFTBODY_RELEASE_LIBRARY)
	endif()
endif()
if(LinearMath)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${bullet3_Debug_Dir}/lib/${Debug_Dir}/LinearMath_Debug.lib						BULLET_MATH_DEBUG_LIBRARY)
			dk_libRelease	(${bullet3_Release_Dir}/lib/${Release_Dir}/LinearMath.lib						BULLET_MATH_RELEASE_LIBRARY)
		else()
			dk_libDebug		(${bullet3_Debug_Dir}/lib/LinearMath/${Debug_Dir}/libLinearMath_Debug.a			BULLET_MATH_DEBUG_LIBRARY)
			dk_libRelease	(${bullet3_Release_Dir}/lib/LinearMath/${Release_Dir}/libLinearMath.a			BULLET_MATH_RELEASE_LIBRARY)
		endif()
	else()
		dk_libDebug			(${bullet3_Debug_Dir}/lib/libLinearMath_Debug.a									BULLET_MATH_DEBUG_LIBRARY)
		dk_libRelease		(${bullet3_Release_Dir}/lib/libLinearMath.a										BULLET_MATH_RELEASE_LIBRARY)
	endif()	
endif(LinearMath)
if(Debug)
	set(BULLET_COLLISION_LIBRARY 		${BULLET_COLLISION_DEBUG_LIBRARY})
	set(BULLET_DYNAMICS_LIBRARY 		${BULLET_DYNAMICS_DEBUG_LIBRARY})
	set(BULLET_INVERSEDYNAMICS_LIBRARY	${BULLET_INVERSEDYNAMICS_DEBUG_LIBRARY})
	set(BULLET_SOFTBODY_LIBRARY 		${BULLET_SOFTBODY_DEBUG_LIBRARY})
	set(BULLET_MATH_LIBRARY 			${BULLET_MATH_DEBUG_LIBRARY})
endif()
if(Release)
	set(BULLET_COLLISION_LIBRARY 		${BULLET_COLLISION_RELEASE_LIBRARY})
	set(BULLET_DYNAMICS_LIBRARY 		${BULLET_DYNAMICS_RELEASE_LIBRARY})
	set(BULLET_INVERSEDYNAMICS_LIBRARY	${BULLET_INVERSEDYNAMICS_RELEASE_LIBRARY})
	set(BULLET_SOFTBODY_LIBRARY 		${BULLET_SOFTBODY_RELEASE_LIBRARY})
	set(BULLET_MATH_LIBRARY 			${BULLET_MATH_RELEASE_LIBRARY})
endif()

### 3RDPARTY LINK ###
dk_set(bullet3_CMAKE
	-DBULLET_INCLUDE_DIR=${BULLET_INCLUDE_DIR}
	-DBULLET_DYNAMICS_LIBRARY=${BULLET_DYNAMICS_LIBRARY}
	-DBULLET_COLLISION_LIBRARY=${BULLET_COLLISION_LIBRARY}
	-DBULLET_MATH_LIBRARY=${BULLET_MATH_LIBRARY}
	-DBULLET_SOFTBODY_LIBRARY=${BULLET_SOFTBODY_LIBRARY})

### GENERATE ###
dk_configure(${bullet3}
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
#dk_build()
if(Bullet3Collision)
	dk_build(${bullet3} Bullet3Collision)
endif()
if(Bullet3Common)
	dk_build(${bullet3} Bullet3Common)
endif()
if(Bullet3Dynamics)
	dk_build(${bullet3} Bullet3Dynamics)
endif()
if(Bullet3Geometry)
	dk_build(${bullet3} Bullet3Geometry)
endif()
if(Bullet3OpenCL)
	dk_build(${bullet3} Bullet3OpenCL)
endif()
if(Bullet3Serialize)
	dk_build(${bullet3} Bullet3Serialize)
endif()
if(BulletCollision)
	dk_build(${bullet3} BulletCollision)
endif()
if(BulletDynamics)
	dk_build(${bullet3} BulletDynamics)
endif()
if(BulletInverseDynamics)
	dk_build(${bullet3} BulletInverseDynamics)
endif()
if(BulletSoftBody)
	dk_build(${bullet3} BulletSoftBody)
endif()
if(LinearMath)
	dk_build(${bullet3} LinearMath)
endif()

	

