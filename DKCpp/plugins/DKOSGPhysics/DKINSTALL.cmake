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


dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

############ DKOSGPhysics ############

#if(Linux)
#	dk_return()
#endif()
#if(Android)
#	dk_return()
#endif()

dk_depend(osgbullet)
dk_depend(DKOSGModel)
###osgWorks
dk_depend(osgworks osgwControls)
dk_depend(osgworks osgwMx)
dk_depend(osgworks osgwQuery)
dk_depend(osgworks osgwTools)
dk_depend(osgworks osgdb_osgobjects)
dk_depend(osgworks osgdb_osgwTools)
dk_depend(osgworks osgdb_skeleton)

##bullet
#dk_depend(bullet BulletCollision)
#dk_depend(bullet BulletDynamics)
#dk_depend(bullet BulletSoftBody)
#dk_depend(bullet LinearMath)
dk_depend(bullet3 BulletCollision)
dk_depend(bullet3 BulletDynamics)
dk_depend(bullet3 BulletSoftBody)
dk_depend(bullet3 LinearMath)

#dk_depend(bullet BulletMultiThreaded)  ##  BROKEN
#dk_depend(bullet MiniCL)  ##  BROKEN
##osgBullet
dk_depend(osgbullet osgbCollision)
dk_depend(osgbullet osgbDynamics)	
dk_depend(osgbullet osgbInteraction)
dk_depend(osgbullet osgdb_osgbdynamics)
dk_depend(osgbullet osgdb_sgb)




############ DKOSGPhysics ############
dk_generateCmake()
dk_assets()
dk_configure()
dk_build()
