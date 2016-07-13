IF(LINUX)
	RETURN()
ENDIF()
IF(ANDROID)
	RETURN()
ENDIF()

DKDEPEND(osgbullet-master)
DKDEPEND(DKOSGModel)
###osgWorks
DKDEPEND(osgworks-master osgwControls)
DKDEPEND(osgworks-master osgwMx)
DKDEPEND(osgworks-master osgwQuery)
DKDEPEND(osgworks-master osgwTools)
DKDEPEND(osgworks-master osgdb_osgobjects)
DKDEPEND(osgworks-master osgdb_osgwTools)
DKDEPEND(osgworks-master osgdb_skeleton)
##bullet
DKDEPEND(bullet-2.82-r2704 BulletCollision)
DKDEPEND(bullet-2.82-r2704 BulletDynamics)
DKDEPEND(bullet-2.82-r2704 BulletSoftBody)
DKDEPEND(bullet-2.82-r2704 LinearMath)
#DKDEPEND(bullet-2.82-r2704 BulletMultiThreaded)  ##  BROKEN
#DKDEPEND(bullet-2.82-r2704 MiniCL)  ##  BROKEN
##osgBullet
DKDEPEND(osgbullet-master osgbCollision)
DKDEPEND(osgbullet-master osgbDynamics)	
DKDEPEND(osgbullet-master osgbInteraction)
DKDEPEND(osgbullet-master osgdb_osgbdynamics)
DKDEPEND(osgbullet-master osgdb_sgb)

DKPLUGIN(DKOSGPhysics)
