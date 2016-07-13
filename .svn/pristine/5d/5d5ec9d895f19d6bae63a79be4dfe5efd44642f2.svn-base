#pragma once
#ifndef DKOSGWidget_H
#define DKOSGWidget_H

#include "DKOSGWindow.h"
#include <osgWidget/Window>
#include <osgWidget/WindowManager>
#include <osgWidget/ViewerEventHandlers>

//////////////////////////////////////////
class DKOSGWidget : public osg::Referenced
{
public: 
	DKOSGWidget(); 
	~DKOSGWidget();
	bool SetupWidget(DKOSGWindow* window);

	osg::ref_ptr<osgWidget::WindowManager> wm;
	osg::ref_ptr<osg::Camera> wmcamera;
	osg::ref_ptr<osgWidget::Window> wmcanvas;
};


#endif //DKOSGWidget_H