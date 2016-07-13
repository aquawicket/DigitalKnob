#include "stdafx.h"
#include "DKOSGManipulator.h"
#include "DKOSGWindow.h"

//////////////////////////
void DKOSGManipulator::Init()
{
	tb = new osgGA::TrackballManipulator;
	DKString test = data[1];
	//tb->setHomePosition(osg::Vec3(10., -100., 10.), osg::Vec3(10., 0., 10.), osg::Vec3(0., 0., 0.));
	tb->setHomePosition(osg::Vec3(0., -100., 0.), osg::Vec3(0., 0., 0.), osg::Vec3(0., 0., 0.));
	DKOSGWindow::Instance(data[1])->view->setCameraManipulator(tb);
}

/////////////////////////
void DKOSGManipulator::End()
{
	//dkWindow->view->removeEventHandler(tb);
	//tb = NULL;
}
