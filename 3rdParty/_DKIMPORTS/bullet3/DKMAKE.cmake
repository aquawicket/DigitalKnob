#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### bullet3 ######
# https://github.com/bulletphysics/bullet3.git
# https://code.google.com/archive/p/bullet
# https://github.com/bulletphysics/bullet3/archive/refs/tags/2.82.zip
# https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bullet/bullet-2.82-r2704.zip

### IMPORT ###
dk_validate(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
dk_getFileParam(${DKIMPORTS_DIR}/bullet3/bullet3.txt BULLET3_VERSION)
dk_import(https://github.com/bulletphysics/bullet3/archive/${BULLET3_VERSION}.zip)

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

dk_include					(${BULLET3_LIB}/src)

if(Bullet3Collision)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_CONFIG_DIR}/lib/${DEBUG_DIR}/Bullet3Collision_Debug.lib)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/Bullet3Collision.lib)
		else()
			dk_libDebug		(${BULLET3_CONFIG_DIR}/src/Bullet3Collision/${DEBUG_DIR}//libBullet3Collision.a)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/src/Bullet3Collision/${RELEASE_DIR}/libBullet3Collision.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_CONFIG_DIR}/src/Bullet3Collision/libBullet3Collision_Debug.a)
		dk_libRelease		(${BULLET3_CONFIG_DIR}/src/Bullet3Collision/libBullet3Collision.a)
	endif()
endif()
if(Bullet3Common)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_CONFIG_DIR}/lib/${DEBUG_DIR}/Bullet3Common_Debug.lib)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/Bullet3Common.lib)
		else()
			dk_libDebug		(${BULLET3_CONFIG_DIR}/src/Bullet3Common/${DEBUG_DIR}//libBullet3Common.a)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/src/Bullet3Common/${RELEASE_DIR}/libBullet3Common.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_CONFIG_DIR}/src/Bullet3Common/libBullet3Common_Debug.a)
		dk_libRelease		(${BULLET3_CONFIG_DIR}/src/Bullet3Common/libBullet3Common.a)
	endif()
endif()
if(Bullet3Dynamics)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_CONFIG_DIR}/lib/${DEBUG_DIR}/Bullet3Dynamics_Debug.lib)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/Bullet3Dynamics.lib)
		else()
			dk_libDebug		(${BULLET3_CONFIG_DIR}/src/Bullet3Dynamics/${DEBUG_DIR}//libBullet3Dynamics.a)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/src/Bullet3Dynamics/${RELEASE_DIR}/libBullet3Dynamics.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_CONFIG_DIR}/src/Bullet3Dynamics/libBullet3Dynamics_Debug.a)
		dk_libRelease		(${BULLET3_CONFIG_DIR}/src/Bullet3Dynamics/libBullet3Dynamics.a)
	endif()
endif()
if(Bullet3Geometry)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_CONFIG_DIR}/lib/${DEBUG_DIR}/Bullet3Geometry_Debug.lib)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/Bullet3Geometry.lib)
		else()
			dk_libDebug		(${BULLET3_CONFIG_DIR}/src/Bullet3Geometry/${DEBUG_DIR}//libBullet3Geometry.a)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/src/Bullet3Geometry/${RELEASE_DIR}/libBullet3Geometry.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_CONFIG_DIR}/src/Bullet3Geometry/libBullet3Geometry_Debug.a)
		dk_libRelease		(${BULLET3_CONFIG_DIR}/src/Bullet3Geometry/libBullet3Geometry.a)
	endif()	
endif()
if(Bullet3OpenCL)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_CONFIG_DIR}/lib/${DEBUG_DIR}/Bullet3OpenCL_clew_Debug.lib)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/Bullet3OpenCL_clew.lib)
		else()
			dk_libDebug		(${BULLET3_CONFIG_DIR}/src/Bullet3OpenCL/${DEBUG_DIR}//libBullet3OpenCL_clew.a)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/src/Bullet3OpenCL/${RELEASE_DIR}/libBullet3OpenCL_clew.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_CONFIG_DIR}/src/Bullet3OpenCL/libBullet3OpenCL_clew_Debug.a)
		dk_libRelease		(${BULLET3_CONFIG_DIR}/src/Bullet3OpenCL/libBullet3OpenCL_clew.a)
	endif()
endif()
if(Bullet3Serialize)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_CONFIG_DIR}/lib/${DEBUG_DIR}/BulletFileLoader_Debug.lib)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/BulletFileLoader.lib)
		else()
			dk_libDebug		(${BULLET3_CONFIG_DIR}/src/Bullet3Serialize/Bullet2FileLoader/${DEBUG_DIR}/libBullet2FileLoader.a)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/src/Bullet3Serialize/Bullet2FileLoader/${RELEASE_DIR}/libBullet2FileLoader.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_CONFIG_DIR}/src/Bullet3Serialize/Bullet2FileLoader/libBullet2FileLoader_Debug.a)
		dk_libRelease		(${BULLET3_CONFIG_DIR}/src/Bullet3Serialize/Bullet2FileLoader/libBullet2FileLoader.a)
	endif()
endif()
if(BulletCollision)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_CONFIG_DIR}/lib/${DEBUG_DIR}/BulletCollision_Debug.lib)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/BulletCollision.lib)
		else()
			dk_libDebug		(${BULLET3_CONFIG_DIR}/src/BulletCollision/${DEBUG_DIR}//libBulletCollision.a)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/src/BulletCollision/${RELEASE_DIR}/libBulletCollision.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_CONFIG_DIR}/src/BulletCollision/libBulletCollision_Debug_Debug.a)
		dk_libRelease		(${BULLET3_CONFIG_DIR}/src/BulletCollision/libBulletCollision.a)
	endif()
endif()
if(BulletDynamics)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_CONFIG_DIR}/lib/${DEBUG_DIR}/BulletDynamics_Debug.lib)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/BulletDynamics.lib)
		else()
			dk_libDebug		(${BULLET3_CONFIG_DIR}/src/BulletDynamics/${DEBUG_DIR}/libBulletDynamics.a)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/src/BulletDynamics/${RELEASE_DIR}/libBulletDynamics.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_CONFIG_DIR}/src/BulletDynamics/libBulletDynamics_Debug.a)
		dk_libRelease		(${BULLET3_CONFIG_DIR}/src/BulletDynamics/libBulletDynamics.a)
	endif()
endif()
if(BulletInverseDynamics)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_CONFIG_DIR}/lib/${DEBUG_DIR}/BulletInverseDynamics_Debug.lib)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/BulletInverseDynamics.lib)
		else()
			dk_libDebug		(${BULLET3_CONFIG_DIR}/src/BulletInverseDynamics/${DEBUG_DIR}/libBulletInverseDynamics_Debug.a)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/src/BulletInverseDynamics/${RELEASE_DIR}/libBulletInverseDynamics.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_CONFIG_DIR}/src/BulletInverseDynamics/libBulletInverseDynamics.a)
		dk_libRelease		(${BULLET3_CONFIG_DIR}/src/BulletInverseDynamics/libBulletInverseDynamics.a)
	endif()
endif()
if(BulletSoftBody)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_CONFIG_DIR}/lib/${DEBUG_DIR}/BulletSoftBody_Debug.lib)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/BulletSoftBody.lib)
		else()
			dk_libDebug		(${BULLET3_CONFIG_DIR}/src/BulletSoftBody/${DEBUG_DIR}/libBulletSoftBody.a)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/src/BulletSoftBody/${RELEASE_DIR}/libBulletSoftBody.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_CONFIG_DIR}/src/BulletSoftBody/libBulletSoftBody_Debug.a)
		dk_libRelease		(${BULLET3_CONFIG_DIR}/src/BulletSoftBody/libBulletSoftBody.a)
	endif()
endif()
if(LinearMath)
	if(MULTI_CONFIG)
		if(MSVC)
			dk_libDebug		(${BULLET3_CONFIG_DIR}/lib/${DEBUG_DIR}/LinearMath_Debug.lib)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/LinearMath.lib)
		else()
			dk_libDebug		(${BULLET3_CONFIG_DIR}/src/LinearMath/${DEBUG_DIR}/libLinearMath.a)
			dk_libRelease	(${BULLET3_CONFIG_DIR}/src/LinearMath/${RELEASE_DIR}/libLinearMath.a)
		endif()
	else()
		dk_libDebug			(${BULLET3_CONFIG_DIR}/src/LinearMath/libLinearMath_Debug.a)
		dk_libRelease		(${BULLET3_CONFIG_DIR}/src/LinearMath/libLinearMath.a)
	endif()	
endif(LinearMath)


### 3RDPARTY LINK ###
ANDROID_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletDynamics/${RELEASE_DIR}/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3_CONFIG_DIR}/src/Bullet3Collision/${RELEASE_DIR}/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3_CONFIG_DIR}/src/LinearMath/${RELEASE_DIR}/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletSoftBody/${RELEASE_DIR}/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3_DIR}/include)
APPLE_dk_set(BULLET3_CMAKE
	-DBULLET_COMMON_LIBRARY=${BULLET3_CONFIG_DIR}/src/Bullet3Common/${RELEASE_DIR}/libBullet3Common.a
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletDynamics/${RELEASE_DIR}/libBulletDynamics.a
	-DBULLET_INVERSE_DYNAMICS_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletInverseDynamics/${RELEASE_DIR}/libBulletInverseDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletCollision/${RELEASE_DIR}/libBulletCollision.a 
	-DBULLET_MATH_LIBRARY=${BULLET3_CONFIG_DIR}/src/LinearMath/${RELEASE_DIR}/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletSoftBody/${RELEASE_DIR}/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3_DIR}/include)
EMSCRIPTEN_DEBUG_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletDynamics/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletCollision/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3_CONFIG_DIR}/src/LinearMath/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletSoftBody/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3_DIR}/include)
EMSCRIPTEN_RELEASE_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletDynamics/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletCollision/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3_CONFIG_DIR}/src/LinearMath/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletSoftBody/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3_DIR}/include)
LINUX_DEBUG_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletDynamics/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletCollision/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3_CONFIG_DIR}/src/LinearMath/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletSoftBody/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3_DIR}/include)
LINUX_RELEASE_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletDynamics/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletCollision/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3_CONFIG_DIR}/src/LinearMath/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletSoftBody/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3_DIR}/include)
RASPBERRY_DEBUG_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletDynamics/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletCollision/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3_CONFIG_DIR}/src/LinearMath/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletSoftBody/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3_DIR}/include)
RASPBERRY_RELEASE_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletDynamics/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletCollision/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3_CONFIG_DIR}/src/LinearMath/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3_CONFIG_DIR}/src/BulletSoftBody/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3_DIR}/include)
WIN_dk_set(BULLET3_CMAKE
	-DBULLET3_COLLISION_LIBRARY=${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/Bullet3Collision_Debug.lib
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/BulletDynamics.lib 
	-DBULLET_COLLISION_LIBRARY=${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/BulletCollision.lib 
	-DBULLET_MATH_LIBRARY=${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/LinearMath.lib 
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3_CONFIG_DIR}/lib/${RELEASE_DIR}/BulletSoftBody.lib 
	-DBULLET_INCLUDE_DIR=${BULLET3_DIR}/include)	


### GENERATE ###
#dk_configure(${BULLET3_DIR} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF)
#UNIX_dk_configure(${BULLET3_DIR} -DBUILD_PYBULLET=ON -DBUILD_PYBULLET_NUMPY=ON -DUSE_DOUBLE_PRECISION=ON -DBT_USE_EGL=ON)
dk_configure(${BULLET3_DIR})


### COMPILE ###
#dk_build(${BULLET3})
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

	

