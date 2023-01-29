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
#include "DKOSGModel/DKOSGModel.h"
#include "DKOSGWindow/DKOSGWindow.h"
#include "DK/DKFile.h"
#include "DK/DKString.h"
#include "DKAssets/DKAssets.h"

WARNING_DISABLE
//#ifdef USE_osgwTools
//#include "DKPhysics/DKPhysics.h"
//#include <osgwTools/AbsoluteModelTransform.h>
//#endif
#include <osgViewer/Viewer>
#include <osgDB/ReadFile>
WARNING_ENABLE


bool DKOSGModel::Init(){
	DKDEBUGFUNC();
	modelNode = NULL;
	Create(DKOSGWindow::Get("DKOSGWindow0"), DKOSGWindow::Get("DKOSGWindow0")->world, data[1], osg::Vec3(0, 0, 70));
	return true;
}

bool DKOSGModel::End(){
	DKDEBUGFUNC();
	this->theRoot->removeChild(modelNode);
	modelNode = NULL;
	return true;
}

bool DKOSGModel::Create(DKOSGWindow* window, osg::Group* theRoot, const DKString& file,  osg::Vec3 pos){
	DKDEBUGFUNC(window, theRoot, file, pos);
	//DKLog("Loading Model "+file+"\n");
	this->theRoot = theRoot;

	DKString path = file;
	if(!DKFile::VerifyPath(path))
		return DKERROR("Could not find "+file+"\n");

//#ifdef USE_osgwTools
//	if(DKPhysics::Valid("DKPhysics")){	
//		DKPhysics::Instance("DKPhysics")->makeModel(theRoot, path, pos);
//	}
//	else
//#endif
	{
		//osg::ref_ptr<osg::Node> modelNode(NULL);

		osg::Matrix m(osg::Matrix::translate(pos));
//#ifdef USE_osgwTools
//		osg::ref_ptr< osgwTools::AbsoluteModelTransform > amt = new osgwTools::AbsoluteModelTransform;
//		amt->setDataVariance(osg::Object::DYNAMIC);
//#endif

		if(!modelNode.valid()){
		 modelNode = osgDB::readNodeFile( path );
			if(!modelNode.valid())
				return DKERROR("Cannot load "+path+"\n");
		}
//#ifdef USE_osgwTools
//		amt->addChild( modelNode.get() );
//		theRoot->addChild(amt);
//#else
		theRoot->addChild(modelNode);
//#endif
	}
	return true;
}
