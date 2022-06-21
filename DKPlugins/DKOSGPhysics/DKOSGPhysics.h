#pragma once
#ifndef DKOSGPhysics_H
#define DKOSGPhysics_H
#include "DK.h"
#include "DKOSGModel.h"

#include <osgDB/ReadFile>
#include <osgViewer/Viewer>

//#ifdef USE_osgwTools
#include <osgwTools/Shapes.h>
#include <osgwTools/AbsoluteModelTransform.h>
//#endif

//#ifdef USE_osgbDynamics 
#include <osgbDynamics/GroundPlane.h>
#include <osgbDynamics/MotionState.h>
#include <osgbDynamics/RigidBody.h>
#include <osgbDynamics/TripleBuffer.h>
#include <osgbDynamics/PhysicsThread.h>
//#endif

//#ifdef USE_osgbCollision
#include <osgbCollision/RefBulletObject.h>
#include <osgbCollision/Utils.h>
//#endif

//#ifdef USE_osgbInteraction
#include <osgbInteraction/LaunchHandler.h>
#include <osgbInteraction/SaveRestoreHandler.h>
#include <osgbInteraction/DragHandler.h>
//#endif

#include <btBulletDynamicsCommon.h>

class DKOSGPhysics : public DKObjectT<DKOSGPhysics>
{

public:
	void Init();
	void End();
	
	void Process();
	bool AddModel(const DKOSGModel* model); //add existing model to physics
	bool makeModel(osg::Group* theRoot, const std::string& fileName, osg::Vec3 pos);

//#ifdef USE_osgbDynamics 
	void Start();
	void Kill();
	bool Ground(osg::Group* world);
	
private:
	bool InitPhysics(osgViewer::Viewer* view);
	bool AddLaunchBall(osgViewer::Viewer* view, osg::Group* world);
	bool AddDragHandler(osgViewer::Viewer* view);
	btDynamicsWorld* bw;
	osgbDynamics::PhysicsThread* pt;
	osgbDynamics::TripleBuffer tBuf;
	osgbDynamics::MotionStateList msl;
	osg::ref_ptr<osgbInteraction::SaveRestoreHandler> srh;
	int index;
	osgbInteraction::LaunchHandler* lh;
//#endif //USE_osgbDynamics 

};

REGISTER_OBJECT(DKOSGPhysics, true);
#endif //DKOSGPhysics
