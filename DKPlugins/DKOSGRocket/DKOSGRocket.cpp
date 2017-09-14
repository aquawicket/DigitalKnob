#include "DK/stdafx.h"
#include "DKOSGRocket.h"
#include <osg/State>

DKOSGRocketRender* DKOSGRocket::guirender = NULL;
DKOSGRocketSystem* DKOSGRocket::guisystem = NULL;


////////////////////////
void DKOSGRocket::Init()
{
	//link objects
	dkOsgViewer = DKOSGViewer::Get("DKOSGViewer0");
	dkOsgWindow = DKOSGWindow::Get("DKOSGWindow0");
	dkRocket = DKRocket::Instance("DKRocket0");
	if(!dkOsgViewer){ DKLog("DKOSGRocket::Init(): dkOsgViewer invalid \n", DKERROR); return; }
	if(!dkOsgWindow){ DKLog("DKOSGRocket::Init(): dkOsgWindow invalid \n", DKERROR); return; }
	if(!dkRocket){ DKLog("DKOSGRocket::Init(): dkRocket invalid \n", DKERROR); return; }

	SetupRocket();

	//ANDROID FIX
	//Unless we initiate some geometry, librocket will not display text or images
#ifdef ANDROID
	osg::ref_ptr<osg::Geode> androidFix = new osg::Geode;
	osg::ref_ptr<osgText::Text> _androidFix = new osgText::Text();
	androidFix->addDrawable(_androidFix);
	dkOsgWindow->world->addChild(androidFix);
#endif

	dkRocket->context = guinode->getContext();
	AddEvent("GLOBAL", "resize", &DKOSGRocket::OnResize, this); 
}

///////////////////////
void DKOSGRocket::End()
{
	if(guicam){
		//dkOsgWindow->root->removeChild(guicam);
		//guicam->removeChild(guinode); 
		//guinode->_context->~Context();
		//guinode = NULL;
		//guicam = NULL;
		//guifile = NULL;
		//guisystem->Release();
		//guisystem = NULL;
		//guirender->Release();
		//guirender = NULL;
		//Rocket::Core::Shutdown();
	}
}

///////////////////////////////
bool DKOSGRocket::SetupRocket()
{
	if(!guirender){
		guirender = new DKOSGRocketRender();
		Rocket::Core::SetRenderInterface(guirender);
	}
	if(!guisystem){
		guisystem = new DKOSGRocketSystem();
		Rocket::Core::SetSystemInterface(guisystem);
	}
	
	if(!Rocket::Core::Initialise()){
		DKLog("Rocket::Core::Initialise() failed! \n", DKERROR);
		return false;
	}
	Rocket::Controls::Initialise();

	guinode = new DKRocketGuiNode(dkOsgWindow->mTitle, true); //true = rocket debugger
	guicam = new osg::Camera();
	guicam->setClearMask(GL_DEPTH_BUFFER_BIT);
	guicam->setRenderOrder(osg::Camera::POST_RENDER, 100);
	guicam->setAllowEventFocus(false);
	guicam->setReferenceFrame(osg::Transform::ABSOLUTE_RF); // set the view matrix
	guicam->setGraphicsContext(dkOsgWindow->gc); // same graphics context as main camera
	guinode->setCamera(guicam); // passing the camera to the gui node makes it render to that cam and adapt the camera settings in accord to the window size

	/*
	{ //PIP window
		//FIXME - work to be done here and DKOSGWindow::CreatePIP()
		guinode = new DKOSGRocket::GuiNode(title.c_str(), true); //true = rocket debugger
		guicam = new osg::Camera();
		guicam->setClearMask(GL_DEPTH_BUFFER_BIT);
		guicam->setRenderOrder(osg::Camera::POST_RENDER, 100);
		guicam->setAllowEventFocus(false);
		guicam->setReferenceFrame(osg::Transform::ABSOLUTE_RF); // set the view matrix
		guicam->setGraphicsContext(window->gc); // same graphics context as main camera
		
		//guicam->setProjectionMatrix(osg::Matrix::ortho2D(window->winX,window->width,window->winY,window->height));
	    //guicam->setViewMatrix(osg::Matrix::identity());
		
		guinode->setCamera(guicam); // passing the camera to the gui node makes it render to that cam and adapt the camera settings in accord to the window size
		guicam->setViewport(new osg::Viewport(window->winX, window->winY, window->width, window->height));	
	}
	*/

	guicam->addChild(guinode); // add gui as child to cam

	dkOsgWindow->root->addChild(guicam); // gui cam is slave cam of viewer cam	
    dkOsgWindow->view->addEventHandler(guinode->GetGUIEventHandler());
	return true;
}

//////////////////////////////////////////
void DKOSGRocket::OnResize(DKEvent* event)
{
	DKStringArray arry;
	toStringArray(arry, event->data[0], ",");
	DKLog("DKOSGRocket::OnResize("+arry[0]+","+arry[1]+")\n", DKINFO);
	guinode->setScreenSize(toInt(arry[0]), toInt(arry[1]));
}