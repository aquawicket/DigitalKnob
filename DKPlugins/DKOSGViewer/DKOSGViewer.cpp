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
#include "DKOSGViewer/DKOSGViewer.h"
//#include "DK/DKApp.h"
#include "DK/DKUtil.h"
#include "DK/DKFile.h"

//WARNING_DISABLE
#include <osgDB/FileUtils>
#include <osgDB/FileNameUtils>
//WARING_ENABLE


bool DKOSGViewer::Init(){
	DKClass::DKCreate("DKOSGNotify");
	DKClass::DKCreate("DKGLInfo");
	viewer = new osgViewer::CompositeViewer;
	DKApp::AppendLoopFunc(&DKOSGViewer::DoFrame, this);
	//viewer->setRunMaxFrameRate(60.00);
	//viewer->setRunFrameScheme(osgViewer::ViewerBase::ON_DEMAND);
	viewer->setRunFrameScheme(osgViewer::ViewerBase::CONTINUOUS);
	AppendDataPath(DKFile::local_assets);
	return true;
}

bool DKOSGViewer::End(){
	return true;
}

void DKOSGViewer::DoFrame(){
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
	if (viewer->done())
		DKApp::active = false;
}

bool DKOSGViewer::Realize(){
	if(!viewer->isRealized())
		viewer->realize();
	if(!viewer->isRealized())
		return DKERROR("DKOSGViewer::Realize(): multiviewer->realize() failed! \n");
	viewer->setKeyEventSetsDone(0); //Don't close OSG with ESC key
	DKINFO("multiviewer->realize() success\n");
	return true;
}

bool DKOSGViewer::AppendDataPath(const DKString& datapath){
	osgDB::FilePathList fl = osgDB::getDataFilePathList();
	if(std::find(fl.begin(), fl.end(), datapath) == fl.end()){
		fl.push_back(datapath);
		osgDB::setDataFilePathList(fl);
	}
	return true;
}
