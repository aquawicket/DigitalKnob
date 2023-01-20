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
#pragma once
#ifndef DKOSGPhysics_H
#define DKOSGPhysics_H
#include "DK/DK.h"
#include "DKOSGModel/DKOSGModel.h"

//WARNING_DISABLE
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
//WARNING_ENABLE


class DKOSGPhysics : public DKObjectT<DKOSGPhysics>
{

public:
	bool Init();
	bool End();
	
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
