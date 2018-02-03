#include "DK/stdafx.h"
#include "DKOSGViewer.h"
#include "DKApp.h"
#include "DKUtil.h"
#include <osgDB/FileUtils>
#include <osgDB/FileNameUtils>
#include "DKFile.h"

////////////////////////
bool DKOSGViewer::Init()
{
	DKCreate("DKOSGNotify");
	DKCreate("DKGLInfo");
	viewer = new osgViewer::CompositeViewer;
	DKApp::AppendLoopFunc(&DKOSGViewer::DoFrame, this);
	//viewer->setRunMaxFrameRate(60.00);
	//viewer->setRunFrameScheme(osgViewer::ViewerBase::ON_DEMAND);
	viewer->setRunFrameScheme(osgViewer::ViewerBase::CONTINUOUS);
	AppendDataPath(DKFile::local_assets);
	return true;
}

///////////////////////
bool DKOSGViewer::End()
{
	return true;
}

///////////////////////////
void DKOSGViewer::DoFrame()
{
	if(viewer->isRealized()){

		//TODO: this should be moved into DKAssets
		/*
		if(DKApp::loaded == false){
			if (viewer->getFrameStamp()->getFrameNumber() > 30){ //wait at least 30 frames
				DKApp::Load();
			}
		}
		*/

		viewer->frame();
	}

	if (viewer->done()){
		DKApp::active = false;
	}
}

////////////////////////
bool DKOSGViewer::Realize()
{
	if(!viewer->isRealized()){
		viewer->realize();
	}
	if(!viewer->isRealized()){
		DKLog("DKOSGViewer::Realize(): multiviewer->realize() failed! \n", DKERROR);
		return false;
	}

	viewer->setKeyEventSetsDone(0); //Don't close OSG with ESC key
	DKLog("multiviewer->realize() success\n", DKINFO);
	return true;
}

///////////////////////////////////////////////////////
bool DKOSGViewer::AppendDataPath(const DKString& datapath)
{
	osgDB::FilePathList fl = osgDB::getDataFilePathList();
	if(std::find(fl.begin(), fl.end(), datapath) == fl.end()){
		fl.push_back(datapath);
		osgDB::setDataFilePathList(fl);
	}
	return true;
}
