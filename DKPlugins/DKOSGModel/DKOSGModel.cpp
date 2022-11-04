#include "DK/stdafx.h"
#include "DKOSGModel/DKOSGModel.h"
#include "DKOSGWindow/DKOSGWindow.h"
#include "DK/DKFile.h"
#include "DK/DKString.h"
#include "DKAssets/DKAssets.h"


//#ifdef USE_osgwTools
//#include "DKPhysics/DKPhysics.h"
//#include <osgwTools/AbsoluteModelTransform.h>
//#endif
#include <osgViewer/Viewer>
#include <osgDB/ReadFile>


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
