#include "DK/stdafx.h"
#include "DKOSGRml/DKOSGRml.h"
#include <osg/State>

DKOSGRmlRender* DKOSGRml::guirender = NULL;
DKOSGRmlSystem* DKOSGRml::guisystem = NULL;


bool DKOSGRml::Init(){
	//link objects
	dkOsgViewer = DKOSGViewer::Get("DKOSGViewer0");
	dkOsgWindow = DKOSGWindow::Get("DKOSGWindow0");
	dkRml = DKRml::Instance("DKRml0");
	if(!dkOsgViewer)
		return DKERROR("dkOsgViewer invalid \n");
	if(!dkOsgWindow)
		return DKERROR("dkOsgWindow invalid \n");
	if(!dkRml)
		return DKERROR("dkRml invalid \n");

	SetupRml();

	//ANDROID FIX
	//Unless we initiate some geometry, librocket will not display text or images
#ifdef ANDROID
	osg::ref_ptr<osg::Geode> androidFix = new osg::Geode;
	osg::ref_ptr<osgText::Text> _androidFix = new osgText::Text();
	androidFix->addDrawable(_androidFix);
	dkOsgWindow->world->addChild(androidFix);
#endif

	dkRml->context = guinode->getContext();
	//AddEvent("GLOBAL", "resize", &DKOSGRml::OnResize, this);
	return true;
}

bool DKOSGRml::End(){
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
	return true;
}

bool DKOSGRml::SetupRml(){
	if(!guirender){
		guirender = new DKOSGRmlRender();
		Rml::SetRenderInterface(guirender);
	}
	if(!guisystem){
		guisystem = new DKOSGRmlSystem();
		Rml::SetSystemInterface(guisystem);
	}
	if(!Rml::Initialise())
		return DKERROR("Rocket::Core::Initialise() failed! \n");
	guinode = new DKRmlGuiNode(dkOsgWindow->mTitle, true); //true = rocket debugger
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
		guinode = new DKOSGRml::GuiNode(title.c_str(), true); //true = rocket debugger
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

void DKOSGRml::OnResize(DKEvents* event){
	DKStringArray arry;
	toStringArray(arry, event->data[0], ",");
	DKINFO("DKOSGRml::OnResize("+arry[0]+","+arry[1]+")\n");
	guinode->setScreenSize(toInt(arry[0]), toInt(arry[1]));
}
