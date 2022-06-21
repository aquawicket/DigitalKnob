#include "DK/stdafx.h"
#include "DKOSGModel.h"

#include "DKOSGWindow.h"
#include "DKFile.h"

//#ifdef USE_osgwTools
//#include "DKPhysics.h"
//#include <osgwTools/AbsoluteModelTransform.h>
//#endif

#include <DKString.h>
#include <osgViewer/Viewer>
#include <osgDB/ReadFile>
#include "DKAssets.h"


///////////////////////
bool DKOSGModel::Init()
{
	modelNode = NULL;
	Create(DKOSGWindow::Get("DKOSGWindow0"), DKOSGWindow::Get("DKOSGWindow0")->world, data[1], osg::Vec3(0, 0, 70));
	return true;
}

//////////////////////
bool DKOSGModel::End()
{
	this->theRoot->removeChild(modelNode);
	modelNode = NULL;
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
bool DKOSGModel::Create(DKOSGWindow* window, osg::Group* theRoot, const DKString& file,  osg::Vec3 pos)
{
	//DKLog("Loading Model "+file+"\n");
	this->theRoot = theRoot;

	DKString path = file;
	if(!DKFile::VerifyPath(path)){
		DKLog("Could not find "+file+"\n",DKERROR);
		return false; 
	}

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
			if(!modelNode.valid()){
				DKLog("Cannot load "+path+"\n", DKERROR);
				return false;
			}
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

