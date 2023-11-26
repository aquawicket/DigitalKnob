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
#include "DKOSGWindow/DKOSGWindow.h"


DKOSGWidget::DKOSGWidget(){

}

DKOSGWidget::~DKOSGWidget(){

}

bool DKOSGWidget::SetupWidget(DKOSGWindow* window){
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
