#include "DK/stdafx.h"
#include "DKOSGWidget.h"

//////////////////////////
DKOSGWidget::DKOSGWidget()
{

}

///////////////////////////
DKOSGWidget::~DKOSGWidget()
{

}

///////////////////////////////////////////////
bool DKOSGWidget::SetupWidget(DKOSGWindow* window)
{
	/*
    wm = new osgWidget::WindowManager(
                                      window->view,
                                      window->width,
                                      window->height,
                                      MASK_2D//,
                                      //osgWidget::WindowManager::WM_PICK_DEBUG
    );
    wmcamera = wm->createParentOrthoCamera();
	window->root->addChild(wmcamera);
    window->view->addEventHandler(new osgWidget::MouseHandler(wm));
    window->view->addEventHandler(new osgWidget::KeyboardHandler(wm));
    //window->view->addEventHandler(new osgWidget::ResizeHandler(wm, camera));
    //
	window->view->addEventHandler(new osgWidget::CameraSwitchHandler(wm, camera));

	wmcanvas = new osgWidget::Canvas();
	wmcanvas->setOrigin(0,0);
	wmcanvas->getBackground()->setSize(width,height);
	wmcanvas->getBackground()->setColor(0.0f, 0.0f, 0.0f, 0.0f);
    wmcanvas->setEventMask(osgWidget::EVENT_MOUSE_RELEASE | osgWidget::EVENT_MOUSE_PUSH);
	wm->addChild(wmcanvas);
	*/
	return false;
}

