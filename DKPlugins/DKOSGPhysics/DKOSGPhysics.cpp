/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#include "DK/stdafx.h"
#include "DKOSGPhysics/DKOSGPhysics.h"
#include "DKOSGWindow/DKOSGWindow.h"


bool DKOSGPhysics::Init(){
//#ifdef USE_osgbDynamics 
	InitPhysics(DKOSGWindow::Instance("DKOSGWindow")->view);
	AddLaunchBall(DKOSGWindow::Instance("DKOSGWindow")->view,DKOSGWindow::Instance("DKOSGWindow")->world);
	//AddDragHandler(DKOSGWindow::Instance("DKOSGWindow")->view);
	Ground(DKOSGWindow::Instance("DKOSGWindow")->world);
	Start();
	return true;
//#endif //USE_osgbDynamics
}

bool DKOSGPhysics::End(){
//#ifdef USE_osgbDynamics
	Kill();
	return true;
//#endif
}

void DKOSGPhysics::Process(){
//#ifdef USE_osgbDynamics 
	TripleBufferMotionStateUpdate( msl, &tBuf );
//#endif
}

//FIXME - models already created in DKModel.  Change to -> AddPhysics(DKModel*) ???
bool DKOSGPhysics::AddModel(const DKOSGModel* model){
	//TODO
	return false;
}

bool DKOSGPhysics::makeModel(osg::Group* world, const std::string& fileName, osg::Vec3 pos){
//#ifdef USE_osgbDynamics 
	osg::ref_ptr<osg::Node> modelNode(NULL);

    osg::Matrix m(osg::Matrix::translate(pos));
    osg::ref_ptr< osgwTools::AbsoluteModelTransform > amt = new osgwTools::AbsoluteModelTransform;
    amt->setDataVariance(osg::Object::DYNAMIC);

    if(!modelNode.valid()){
        modelNode = osgDB::readNodeFile( fileName );
		if(!modelNode.valid())
			return DKERROR("Cannot load "+fileName);
	}
    amt->addChild( modelNode.get() );

    osg::ref_ptr< osgbDynamics::CreationRecord > cr = new osgbDynamics::CreationRecord;
    cr->_sceneGraph = amt.get();
    cr->_shapeType = BOX_SHAPE_PROXYTYPE;
    cr->_mass = .2f;
    cr->_restitution = 0.3f;
    cr->_parentTransform = m;
    btRigidBody* rb = osgbDynamics::createRigidBody(cr.get());

    rb->setActivationState(DISABLE_DEACTIVATION);

    // Set up for multithreading and triple buffering.
    osgbDynamics::MotionState* motion = static_cast< osgbDynamics::MotionState* >( rb->getMotionState() );
    motion->registerTripleBuffer( &tBuf );
    msl.insert( motion );

    std::ostringstream ostr;
    ostr << fileName << index;
    srh->add( ostr.str(), rb );

    amt->setUserData( new osgbCollision::RefRigidBody(rb));
    bw->addRigidBody( rb );
	
	DKOSGWindow::Instance("DKOSGWindow")->world->addChild(amt.release());
	index++;

	//amt is a osg::Transform*..   I think we can position it this way
//#endif
    return true;
}

//#ifdef USE_osgbDynamics 

void DKOSGPhysics::Start(){
	pt->setProcessorAffinity(0);
    pt->start();
}

void DKOSGPhysics::Kill(){
	DKOSGWindow::Instance("DKOSGWindow")->view->removeEventHandler(lh);
	pt->stopPhysics();
	pt->join();
}

bool DKOSGPhysics::Ground(osg::Group* world){
	DKOSGWindow::Instance("DKOSGWindow")->world->addChild(osgbDynamics::generateGroundPlane(osg::Vec4(0.f, 0.f, 1000.f, 0.f), bw));
	return true;
}

bool DKOSGPhysics::InitPhysics(osgViewer::Viewer* view){
	tBuf.resize(65536); // Increase triple buffer size to hold lots of transform data

	btDefaultCollisionConfiguration * collisionConfiguration = new btDefaultCollisionConfiguration();
    btCollisionDispatcher * dispatcher = new btCollisionDispatcher(collisionConfiguration);
    btConstraintSolver * solver = new btSequentialImpulseConstraintSolver;

    btVector3 worldAabbMin(-10000, -10000, -10000);
    btVector3 worldAabbMax(10000, 10000, 10000);
    btBroadphaseInterface * inter = new btAxisSweep3(worldAabbMin, worldAabbMax, 1000);

    bw = new btDiscreteDynamicsWorld(dispatcher, inter, solver, collisionConfiguration);
    bw->setGravity(btVector3(0, 0, -50));
	pt = new osgbDynamics::PhysicsThread(bw, &tBuf);
	srh = new osgbInteraction::SaveRestoreHandler;
	srh->capture();
    view->addEventHandler(srh.get());
	srh->setThreadedPhysicsSupport(pt);
	index = 0;
	return true;
}

bool DKOSGPhysics::AddLaunchBall(osgViewer::Viewer* view, osg::Group* world){
	// Ball Launch handler
	osg::Group* launchHandlerAttachPoint = new osg::Group; 
	world->addChild(launchHandlerAttachPoint);
    /*osgbInteraction::LaunchHandler* */lh = new osgbInteraction::LaunchHandler(bw, launchHandlerAttachPoint, view->getCamera());

    osg::Geode* geode = new osg::Geode;
    const double radius(1);
    geode->addDrawable(osgwTools::makeGeodesicSphere(radius));
    lh->setLaunchModel(geode, new btSphereShape(radius));
    lh->setInitialVelocity(600.);
    DKOSGWindow::Instance("DKOSGWindow")->view->addEventHandler(lh);
	srh->setLaunchHandler(lh);

	lh->setThreadedPhysicsSupport(pt, &tBuf, &msl);
	return true;
}

bool DKOSGPhysics::AddDragHandler(osgViewer::Viewer* view){
	// Drag Handler
	osgbInteraction::DragHandler* dh = new osgbInteraction::DragHandler(bw, view->getCamera());
    view->addEventHandler(dh);
    dh->setThreadedPhysicsSupport(pt);
	return true;
}

//#endif //USE_osgbDynamics
