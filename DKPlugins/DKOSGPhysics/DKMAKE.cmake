#if(LINUX)
#	return()
#endif()
#if(ANDROID)
#	return()
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

dk_generateCmake(DKOSGPhysics)
