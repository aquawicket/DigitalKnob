#include "DK/stdafx.h"
#include "DKOSGWindow.h"
#include "DKFile.h"
#include "DKAssets.h"

const unsigned int MASK_2D = 0xF0000000;
std::map<int,int> DKOSGWindow::osgKeyCode;
std::map<int,int> DKOSGWindow::osgCharCode;
std::map<int,int> DKOSGWindow::osgShiftCharCode;
std::map<int,int> DKOSGWindow::osgMouse;

////////////////////////
bool DKOSGWindow::Init()
{
#ifdef ANDROID
	DKCreate("DKOSGWindowAndroid");
#endif	
	//link objects
	dkOsgViewer = DKOSGViewer::Instance("DKOSGViewer0");
	if(!dkOsgViewer){ DKLog("DKOSGRocket::Init(): dkOsgViewer invalid \n", DKERROR); return false; }

	lastMouseX = 0;
	lastMouseY = 0;
	DKString title;
	DKFile::GetExeName(title);
	DKFile::RemoveExtention(title);
	CreateWin(title, 0, 0, 0, 0);

	DKClass::RegisterFunc("DKOSGWindow::GetX", &DKOSGWindow::GetX, this);
	DKClass::RegisterFunc("DKOSGWindow::GetY", &DKOSGWindow::GetY, this);
	DKClass::RegisterFunc("DKOSGWindow::SetX", &DKOSGWindow::SetX, this);
	DKClass::RegisterFunc("DKOSGWindow::SetY", &DKOSGWindow::SetY, this);
	DKClass::RegisterFunc("DKOSGWindow::GetWidth", &DKOSGWindow::GetWidth, this);
	DKClass::RegisterFunc("DKOSGWindow::GetHeight", &DKOSGWindow::GetHeight, this);
	DKClass::RegisterFunc("DKOSGWindow::SetWidth", &DKOSGWindow::SetWidth, this);
	DKClass::RegisterFunc("DKOSGWindow::SetHeight", &DKOSGWindow::SetHeight, this);
	DKClass::RegisterFunc("DKOSGWindow::GetScreenWidth", &DKOSGWindow::GetScreenWidth, this);
	DKClass::RegisterFunc("DKOSGWindow::GetScreenHeight", &DKOSGWindow::GetScreenHeight, this);
	DKClass::RegisterFunc("DKOSGWindow::GetMouseX", &DKOSGWindow::GetMouseX, this);
	DKClass::RegisterFunc("DKOSGWindow::GetMouseY", &DKOSGWindow::GetMouseY, this);
	DKClass::RegisterFunc("DKOSGWindow::GetHwnd", &DKOSGWindow::GetHwnd, this);
	MapInputs();
	return true;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKOSGWindow::CreateWin(const DKString& title, const int& x, const int& y, const int& w, const int& h)
{
	mTitle = title;
	winX = x;
	winY = y;
	width = w;
	height = h;

	DKString textX;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[WINX]", textX);
	DKString textY;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[WINY]", textY);
	DKString textWidth;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[WIDTH]", textWidth);
	DKString textHeight;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[HEIGHT]", textHeight);
	if(!textX.empty()){ winX = toInt(textX); }
	if(!textY.empty()){ winY = toInt(textY); }
	if(!textWidth.empty()){ width = toInt(textWidth); }
	if(!textHeight.empty()){ height = toInt(textHeight); }

#ifdef WIN32 //account window frame
	winY = (winY + 30); 
	winX = (winX + 10);
#endif
	if(winX < 1){winX = 20;}
	if(winY < 1){winY = 40;}
	if(width < 1){ width = 800; }
	if(height < 1){height = 600;}

	CreateView();
	resizeTime = 0;

	return true;
}

//////////////////////////////
bool DKOSGWindow::CreateView()
{
	DKLog("DKOSGWindow::CreateView()\n", DKDEBUG);
	
	unsigned int screen = 0;
	view = new osgViewer::Viewer;
	//view->setRunFrameScheme(osgViewer::ViewerBase::ON_DEMAND); 
	//view->setRunFrameScheme(osgViewer::ViewerBase::CONTINUOUS); 
	//view->setRunMaxFrameRate(120);

#ifdef DESKTOP
		//dkOsgViewer->viewer->setThreadingModel(osgViewer::ViewerBase::SingleThreaded); 
		dkOsgViewer->viewer->setDataVariance(osg::Object::DYNAMIC);

		wsi = osg::GraphicsContext::getWindowingSystemInterface();
		if (!wsi){
			DKLog("Error, no WindowSystemInterface available, cannot create windows\n",DKERROR);
		    return false;
		}

		traits = new osg::GraphicsContext::Traits;
		traits->x = winX;
		traits->y = winY;
		traits->width = width;
		traits->height = height;
		traits->windowDecoration = true;
		traits->doubleBuffer = true;
		traits->vsync = true;
		traits->sharedContext = 0;
		traits->screenNum = screen;

		gc = osg::GraphicsContext::createGraphicsContext(traits.get());
		if(!gc.valid()){
			DKLog("Error: GraphicsContext invalid\n",DKERROR);
		    return false;
		}

        view->getCamera()->setViewport(new osg::Viewport(0, 0, traits->width, traits->height));
        view->getCamera()->setGraphicsContext(gc.get());
#endif
	
#ifdef ANDROID
	width = DKAndroid::android_width;
	height = DKAndroid::android_height;
	view->setThreadingModel(osgViewer::ViewerBase::SingleThreaded);
	view->setUpViewerAsEmbeddedInWindow(0, 0, width, height);

	gc = view->getCamera()->getGraphicsContext();
	if(!gc.valid()){
			DKLog("Error: GraphicsContext invalid\n",DKERROR);
		    return false;
	}

	view->getEventQueue()->setMouseInputRange(0, 0, width, height); //LOOK AT THIS
#endif

#ifdef IOS
    view->setThreadingModel(osgViewer::Viewer::SingleThreaded);
    osg::GraphicsContext::WindowingSystemInterface* wsi = osg::GraphicsContext::getWindowingSystemInterface();
    if(wsi){ wsi->getScreenResolution(osg::GraphicsContext::ScreenIdentifier(0),width, height); }
	//DKLog("iOS Screensize: width="+toString(width)+" height="+toString(height)+"\n", DKDEBUG);
    
    osg::ref_ptr<osg::GraphicsContext::Traits> traits = new osg::GraphicsContext::Traits;
    //osg::ref_ptr<osg::Referenced> windata = new osgViewer::GraphicsWindowIOS::WindowData(wsi->);
    // Setup the traits parameters
    traits->x = 0;
    traits->y = 0;
    traits->width = width;
    traits->height = height;
    traits->depth = 16; //keep memory down, default is currently 24
    traits->windowDecoration = false;
    traits->doubleBuffer = true;
    traits->sharedContext = 0;
    traits->setInheritedWindowPixelFormat = true;
    traits->samples = 4;
    traits->sampleBuffers = 1;
    //traits->inheritedWindowData = windata;
    
    // Create the Graphics Context
    gc = osg::GraphicsContext::createGraphicsContext(traits.get());
    if(!gc){
        DKLog("DKOSGWindow::CreateView(): ERROR: grapics context invalid. \n", DKERROR);
        return false;
    }
    
	// if the context was created then attach to our viewer
    view->getCamera()->setGraphicsContext(gc);
    view->getCamera()->setViewport(new osg::Viewport(traits->x, traits->y, traits->width, traits->height));

    //view->getEventQueue()->setMouseInputRange(0, 0, width, height); //LOOK AT THIS
#endif

	root = new osg::Group();
    view->setSceneData(root.get());

	//we use a world group for 3d to keep everything seperate
	world = new osg::Group();
	world->setName("world");
	root->addChild(world);

	dkOsgViewer->viewer->addView(view);
	dkOsgViewer->Realize();
	
#ifdef WIN32
	SetHwnd();//get a windows handle
#endif

	view->addEventHandler(this);

	//Set the window title
	DKString title = mTitle;

#if defined(WIN32) && !defined(WIN64)
		title += " - WIN32";
#endif
#ifdef WIN64
		title += " - WIN64";
#endif
#ifdef MAC
		title += " - MAC";
#endif
#ifdef LINUX
		title += " - LINUX";
#endif
#ifdef DEBUG
		title += " DEBUG ";
#else
		title += " RELEASE ";
#endif
	DKString mTime;
	DKString file;
	DKFile::GetFullExeName(file);
	DKFile::GetModifiedTime(file, mTime);
	title += mTime;

	SetIcon(DKFile::local_assets+"icon.ico");
	SetTitle(title);

	osg::Vec4 color(0.7,0.7,0.7,1.0); //light grey
	view->getCamera()->setClearColor(color); 

	DKLog("DKOSGWindow::CreateView()  created window width:"+toString(width)+" height:"+toString(height)+"\n", DKDEBUG);
	return true;
}




/*
////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKOSGWindow::CreatePIP(const int& x, const int& y, const int& w, const int& h, DKOSGWindow* parent)
{
	winX = x;
	winY = y;
	width = w;
	height = h;

	wsi = osg::GraphicsContext::getWindowingSystemInterface();
	if (!wsi){
		DKLog("Error, no WindowSystemInterface available, cannot create windows\n",DKERROR);
	    return false;
	}

	int screen = 0;
	//DKString computername; //Bandaid: YOU CAN DELETE THIS :P
    //getComputerName(computername); //Bandaid: YOU CAN DELETE THIS :P
	//if(same(computername, "aquastudio-PC") && getNumScreens() > 1){ screen = 1; } //Bandaid: YOU CAN DELETE THIS :P

	traits = new osg::GraphicsContext::Traits;
	traits->x = winX;
	traits->y = winY;
	traits->width = width;
	traits->height = height;
	traits->windowDecoration = true;
	traits->doubleBuffer = true;
	traits->vsync = true;
	traits->sharedContext = 0;
	traits->screenNum = screen;

	gc = osg::GraphicsContext::createGraphicsContext(traits.get());
	if(!gc.valid()){
		DKLog("Error: GraphicsContext invalid\n",DKERROR);
	    return false;
	}

	//FIXME - work to be done here and DKOSGWindow::CreatePIP()
	DKLog("Creating Window. \n");
	winX = x;
	winY = y;
	width = w;
	height = h;
	windowtype = 3;
	view = new osgViewer::Viewer;

	gc = parent->gc;
	view->getCamera()->setClearColor(osg::Vec4(0.1f, 0.1f, 0.1f, 1.0f));  //145,44,44 
	view->getCamera()->setRenderOrder(osg::Camera::POST_RENDER, 1);

	root = new osg::Group();
	view->setSceneData(root.get());

	//we use a world group for 3d to keep everything seperate
	world = new osg::Group();
	root->addChild(world);

	//view->getCamera()->setProjectionMatrixAsPerspective(45.0, 1.0, 0.5, 10); 
    view->getCamera()->setViewport(new osg::Viewport(winX,winY,width,height));
    view->getCamera()->setGraphicsContext(gc.get());

	view->addEventHandler(this);
	return true;
}
*/



/////////////////////////////////////////////////
bool DKOSGWindow::SetTitle(const DKString& title)
{
#ifdef DESKTOP
	//Set Window Title
	typedef osgViewer::Viewer::Windows Windows;
	Windows windows;
	view->getWindows(windows);
	for (Windows::iterator window = windows.begin();window != windows.end(); ++window){
		(*window)->setWindowName(title.c_str());
	}
	return true;
#endif
	DKLog("DKOSGWindow::SetTitle is not implemented on this OS. \n", DKERROR);
	return false;
}

///////////////////////////////////////////////
bool DKOSGWindow::SetIcon(const DKString& file)
{
#ifdef WIN32
	HICON hIcon = (HICON)LoadImage(NULL, file.c_str(), IMAGE_ICON, 32, 32, LR_LOADFROMFILE);
	SendMessage( hwnd, WM_SETICON, ICON_SMALL, (LPARAM)hIcon );
	return true;
#endif
	DKLog("DKOSGWindow::SetIcon is not implemented on this OS. \n", DKERROR);
	return false;
}


#ifdef WIN32
///////////////////////////
bool DKOSGWindow::SetHwnd()
{
	/*
	typedef osgViewer::Viewer::Windows Windows;
	Windows windows;
	view->getWindows(windows);
	for (Windows::iterator window = windows.begin();window != windows.end(); ++window){
		DKLog("!window!\n", DKDEBUG);
		hwnd = dynamic_cast<osgViewer::GraphicsHandleWin32*>(*window);
	}
	return true;
	*/

	osgViewer::GraphicsHandleWin32* gw = 
    dynamic_cast<osgViewer::GraphicsHandleWin32*> (        
    view->getCamera()->getGraphicsContext());

	hwnd = gw->getHWND();
	DKApp::hInstance = GetModuleHandle(0);
	return true;
}
#endif

////////////////////////////////
int DKOSGWindow::getNumScreens()
{
    osg::GraphicsContext::WindowingSystemInterface* wsi = osg::GraphicsContext::getWindowingSystemInterface();
    osg::GraphicsContext::ScreenIdentifier si;
    si.readDISPLAY();
    return wsi->getNumScreens(si);
}

///////////////////////////////////////////////////////////////////////////////////
bool DKOSGWindow::handle(const osgGA::GUIEventAdapter& ea,osgGA::GUIActionAdapter&)
{
	return handle(ea);
}

//////////////////////////////////////////////////////////
bool DKOSGWindow::handle(const osgGA::GUIEventAdapter& ea)
{
	if(ea.getEventType() == osgGA::GUIEventAdapter::KEYDOWN){ 
		//DKLog("DKOSGWindow::KEYDOWN("+toString(ea.getUnmodifiedKey())+")\n", DKDEBUG);
		if(ea.getUnmodifiedKey() > 96 && ea.getUnmodifiedKey() < 123){ //letter
			if(ea.getModKeyMask() & osgGA::GUIEventAdapter::MODKEY_SHIFT && ea.getModKeyMask() & osgGA::GUIEventAdapter::MODKEY_CAPS_LOCK){ //both = lowercase
				DKEvent::SendEvent("GLOBAL", "keypress", toString(osgCharCode[ea.getUnmodifiedKey()]));
			}
			else if(ea.getModKeyMask() & osgGA::GUIEventAdapter::MODKEY_SHIFT || ea.getModKeyMask() & osgGA::GUIEventAdapter::MODKEY_CAPS_LOCK){ //1 = uppercase
				DKEvent::SendEvent("GLOBAL", "keypress", toString(osgShiftCharCode[ea.getUnmodifiedKey()]));
			}
			else{
				DKEvent::SendEvent("GLOBAL", "keypress", toString(osgCharCode[ea.getUnmodifiedKey()])); //lowercase
			}
		}
		else if(ea.getModKeyMask() & osgGA::GUIEventAdapter::MODKEY_SHIFT){ //other character keys
			DKEvent::SendEvent("GLOBAL", "keypress", toString(osgShiftCharCode[ea.getUnmodifiedKey()])); //shifted symbol
		}
		else{
			DKEvent::SendEvent("GLOBAL", "keypress", toString(osgCharCode[ea.getUnmodifiedKey()])); //symbol
		}
		DKEvent::SendEvent("GLOBAL", "keydown", toString(osgKeyCode[ea.getUnmodifiedKey()])); //keycode
	}

	if(ea.getEventType() == osgGA::GUIEventAdapter::KEYUP){ 
		int key = ea.getUnmodifiedKey();
		DKEvent::SendEvent("GLOBAL", "keyup", toString(osgKeyCode[key]));
	}
	if(ea.getEventType() == osgGA::GUIEventAdapter::PUSH){
		int button = ea.getButton();
		DKEvent::SendEvent("GLOBAL", "mousedown", toString(osgMouse[button]));
	}
	if(ea.getEventType() == osgGA::GUIEventAdapter::RELEASE){
		int button = ea.getButton();
		DKEvent::SendEvent("GLOBAL", "mouseup", toString(osgMouse[button]));
		if(osgMouse[button] == 3){
			DKEvent::SendEvent("GLOBAL", "contextmenu", toString(osgMouse[button]));
		}
		else{
			DKEvent::SendEvent("GLOBAL", "click", toString(osgMouse[button]));
		}
	}
	if(ea.getEventType() == osgGA::GUIEventAdapter::DOUBLECLICK){
		int button = ea.getButton();
		DKEvent::SendEvent("GLOBAL", "dblclick", toString(osgMouse[button]));
	}
	if(ea.getEventType() == osgGA::GUIEventAdapter::MOVE){
		if(lastMouseX != ea.getX() || lastMouseY != (ea.getYmax() - ea.getY())){
			lastMouseX = ea.getX();
			lastMouseY = ea.getYmax() - ea.getY();
			int screenX = ea.getX() + ea.getWindowX();
			int screenY = ea.getYmax() - ea.getY() + ea.getWindowY();
			DKEvent::SendEvent("GLOBAL", "mousemove", toString(lastMouseX)+","+toString(lastMouseX)+","+toString(screenX)+","+toString(screenY));
		}
	}
	if(ea.getEventType() == osgGA::GUIEventAdapter::SCROLL){
		int wheel_step = 1;
#ifdef MAC
		DKEvent::SendEvent("GLOBAL", "wheel", toString(ea.getScrollingDeltaY()));
#else
		if(ea.getScrollingMotion() == osgGA::GUIEventAdapter::SCROLL_DOWN){
			DKEvent::SendEvent("GLOBAL", "wheel", toString(-wheel_step));
		}
		if(ea.getScrollingMotion() == osgGA::GUIEventAdapter::SCROLL_UP){
			DKEvent::SendEvent("GLOBAL", "wheel", toString(wheel_step));
		}
#endif
	}
	/*
	if(ea.getEventType() == osgGA::GUIEventAdapter::RESIZE){

		//osgGA::EventQueue* eventQueue = new osgGA::EventQueue(osgGA::GUIEventAdapter::Y_INCREASING_UPWARDS);
		//osgGA::EventQueue::Events events;
		//eventQueue->takeEvents(events);
		//DKLog(toString(events.size())+"\n", DKWARN);

		if(width != ea.getWindowWidth() || height != ea.getWindowHeight()){
			width = ea.getWindowWidth();
			height = ea.getWindowHeight();
			DKEvent::SendEvent("GLOBAL", "resize", toString(width)+","+toString(height));
		}
	}
	*/
	if(ea.getEventType() == osgGA::GUIEventAdapter::FRAME){
		if(!gc){ return true; }
		if(width != gc->getTraits()->width || height != gc->getTraits()->height){
			width = gc->getTraits()->width;
			height = gc->getTraits()->height;
			DKEvent::SendEvent("GLOBAL", "resize", toString(width)+","+toString(height));
			return true;
		}
	}
	if(ea.getEventType() == osgGA::GUIEventAdapter::CLOSE_WINDOW){
		DKEvent::SendEvent("GLOBAL", "close_window", "true");
		return true;
	}


	//////  KEYBOARD EVENTS  //////////////////
	if(ea.getEventType()==osgGA::GUIEventAdapter::KEYDOWN){

		const unsigned int mod = ea.getModKeyMask();
		const bool ctrl = ( (mod&osgGA::GUIEventAdapter::MODKEY_LEFT_CTRL) ||
			(mod&osgGA::GUIEventAdapter::MODKEY_RIGHT_CTRL) );
		const bool shift = ( (mod&osgGA::GUIEventAdapter::MODKEY_LEFT_SHIFT) ||
			(mod&osgGA::GUIEventAdapter::MODKEY_RIGHT_SHIFT) );

#ifdef WIN32
		// (~)Key - Show WIN32 Console
		if(ctrl && ea.getUnmodifiedKey()=='`'){
			if(IsWindowVisible(GetConsoleWindow())){
				ShowWindow(GetConsoleWindow(),SW_HIDE);
			}
			else{
				ShowWindow(GetConsoleWindow(),SW_SHOW);
			}
			return true;
		}

		//clear console
		if (ctrl && ea.getUnmodifiedKey() == '-'){
			//DKLog("clear console \n", DKDEBUG);
			DKUtil::System("cls");
			return true;
		}
#endif
	}

    return false; //alow event to continue
}

//////////////////////////////
void* DKOSGWindow::GetX(void*)
{
	return static_cast<void*>(&traits->x);
}

//////////////////////////////
void* DKOSGWindow::GetY(void*)
{
	return static_cast<void*>(&traits->y);
}

////////////////////////////////
void* DKOSGWindow::SetX(void* x)
{
	osgViewer::GraphicsWindow* gw = dynamic_cast<osgViewer::GraphicsWindow*>(view->getCamera()->getGraphicsContext());
	gw->setWindowRectangle(*static_cast<int*>(x), traits->y, traits->width, traits->height);
	return NULL;
}

////////////////////////////////
void* DKOSGWindow::SetY(void* y)
{
	osgViewer::GraphicsWindow* gw = dynamic_cast<osgViewer::GraphicsWindow*>(view->getCamera()->getGraphicsContext());
	gw->setWindowRectangle(traits->x, *static_cast<int*>(y), traits->width, traits->height);
	return NULL;
}

//////////////////////////////////
void* DKOSGWindow::GetWidth(void*)
{
	return static_cast<int*>(new int(traits->width));
}

///////////////////////////////////
void* DKOSGWindow::GetHeight(void*)
{
	return static_cast<int*>(new int(traits->height));
}

////////////////////////////////////////
void* DKOSGWindow::SetWidth(void* width)
{
	osgViewer::GraphicsWindow* gw = dynamic_cast<osgViewer::GraphicsWindow*>(view->getCamera()->getGraphicsContext());
	gw->setWindowRectangle(traits->x, traits->y, *static_cast<int*>(width), traits->height);
	return NULL;
}

//////////////////////////////////////////
void* DKOSGWindow::SetHeight(void* height)
{
	osgViewer::GraphicsWindow* gw = dynamic_cast<osgViewer::GraphicsWindow*>(view->getCamera()->getGraphicsContext());
	gw->setWindowRectangle(traits->x, traits->y, traits->width, *static_cast<int*>(height));
	return NULL;
}

////////////////////////////////////////
void* DKOSGWindow::GetScreenWidth(void*)
{
	osg::GraphicsContext::WindowingSystemInterface* wsi = osg::GraphicsContext::getWindowingSystemInterface();
	osg::GraphicsContext::ScreenIdentifier si;
	unsigned int w, h;
	wsi->getScreenResolution(si, w, h);
	DKLog("DKOSGWindow::GetScreenWidth() width="+toString(w)+" \n", DKDEBUG);
	return static_cast<int*>(new int(w));
}

/////////////////////////////////////////
void* DKOSGWindow::GetScreenHeight(void*)
{
	osg::GraphicsContext::WindowingSystemInterface* wsi = osg::GraphicsContext::getWindowingSystemInterface();
	osg::GraphicsContext::ScreenIdentifier si;
	unsigned int w, h;
	wsi->getScreenResolution(si, w, h);
	DKLog("DKOSGWindow::GetScreenWidth() width="+toString(h)+" \n", DKDEBUG);
	return static_cast<int*>(new int(h));
}

///////////////////////////////////
void* DKOSGWindow::GetMouseX(void*)
{
	return &lastMouseX;
}

///////////////////////////////////
void* DKOSGWindow::GetMouseY(void*)
{
	return &lastMouseY;
}

/////////////////////////////////
void* DKOSGWindow::GetHwnd(void*)
{
#ifdef WIN32
	return &hwnd;//static_cast<void*>(&hwnd);
#else
	DKLog("DKOSGWindow::GetHwnd(): This OS does not have and HWND handle", DKERROR);
	return NULL;
#endif
}

/////////////////////////////
void DKOSGWindow::MapInputs()
{
	osgKeyCode[65307] = 27; //esc
	osgKeyCode[65470] = 112; //f1
	osgKeyCode[65471] = 113; //f2
	osgKeyCode[65472] = 114; //f3
	osgKeyCode[65473] = 115; //f4
	osgKeyCode[65474] = 116; //f5
	osgKeyCode[65475] = 117; //f6
	osgKeyCode[65476] = 118; //f7
	osgKeyCode[65477] = 119; //f8
	osgKeyCode[65478] = 120; //f9
	osgKeyCode[65479] = 121; //f10
	osgKeyCode[65480] = 122; //f11
	osgKeyCode[65481] = 123; //f12
	osgKeyCode[65377] = 44; //printscreen
	osgKeyCode[65300] = 145; //scrolllock
	osgKeyCode[65299] = 19; //pause
	osgKeyCode[96] = 192; //tilde
	osgKeyCode[48] = 48; //0
	osgKeyCode[49] = 49; //1
	osgKeyCode[50] = 50; //2
	osgKeyCode[51] = 51; //3
	osgKeyCode[52] = 52; //4
	osgKeyCode[53] = 53; //5
	osgKeyCode[54] = 54; //6
	osgKeyCode[55] = 55; //7
	osgKeyCode[56] = 56; //8
	osgKeyCode[57] = 57; //9
	osgKeyCode[45] = 189; //minus
	osgKeyCode[61] = 187; //equal
	osgKeyCode[92] = 220; //backslash
	osgKeyCode[65288] = 8; //backspace
	osgKeyCode[65367] = 35; //end
	osgKeyCode[65360] = 36; //home
	osgKeyCode[65407] = 144; //numlock
	osgKeyCode[65455] = 111; //kp_slash
	osgKeyCode[65450] = 106; //kp_multiply
	osgKeyCode[65453] = 109; //kp_minus
	osgKeyCode[65289] = 9; //tab
	osgKeyCode[113] = 81; //q
	osgKeyCode[119] = 87; //w
	osgKeyCode[101] = 69; //e
	osgKeyCode[114] = 82; //r
	osgKeyCode[116] = 84; //t
	osgKeyCode[121] = 89; //y
	osgKeyCode[117] = 85; //u
	osgKeyCode[105] = 73; //i
	osgKeyCode[111] = 79; //o
	osgKeyCode[112] = 80; //p
	osgKeyCode[91] = 219; //leftbracket
	osgKeyCode[93] = 221; //rightbracket
	osgKeyCode[65293] = 13; //enter
	osgKeyCode[65535] = 46; //delete
	osgKeyCode[65379] = 45; //insert
	osgKeyCode[65365] = 33; //pageup
	osgKeyCode[65366] = 34; //pagedown
	osgKeyCode[65438] = 96; //kp_0
	osgKeyCode[65436] = 97; //kp_1
	osgKeyCode[65433] = 98; //kp_2
	osgKeyCode[65435] = 99; //kp_3
	osgKeyCode[65430] = 100; //kp_4
	osgKeyCode[65437] = 101; //kp_5
	osgKeyCode[65432] = 102; //kp_6
	osgKeyCode[65429] = 103; //kp_7
	osgKeyCode[65431] = 104; //kp_8
	osgKeyCode[65434] = 105; //kp_9
	osgKeyCode[65439] = 110; //kp_period
	osgKeyCode[65451] = 107; //kp_plus
	osgKeyCode[65421] = 13; //kp_enter
	osgKeyCode[65509] = 20; //capslock
	osgKeyCode[97] = 65; //a
	osgKeyCode[115] = 83; //s
	osgKeyCode[100] = 68; //d
	osgKeyCode[102] = 70; //f
	osgKeyCode[103] = 71; //g
	osgKeyCode[104] = 72; //h
	osgKeyCode[106] = 74; //j
	osgKeyCode[107] = 75; //k
	osgKeyCode[108] = 76; //l
	osgKeyCode[59] = 186; //semicolon
	osgKeyCode[39] = 222; //quote
	osgKeyCode[65505] = 16; //leftshift
	osgKeyCode[122] = 90; //z
	osgKeyCode[120] = 88; //x
	osgKeyCode[99] = 67; //c
	osgKeyCode[118] = 86; //v
	osgKeyCode[98] = 66; //b
	osgKeyCode[110] = 78; //n
	osgKeyCode[109] = 77; //m
	osgKeyCode[44] = 188; //comma
	osgKeyCode[46] = 190; //period
	osgKeyCode[47] = 191; //slash
	osgKeyCode[65506] = 16; //rightshift
	osgKeyCode[65507] = 17; //leftctrl
	osgKeyCode[65515] = 91; //leftwinkey
	osgKeyCode[65513] = 18; //leftalt
	osgKeyCode[32] = 32; //space
	osgKeyCode[65514] = 18; //rightalt
	osgKeyCode[65515] = 91; //rightwinkey
	osgKeyCode[65383] = 93; //menu
	osgKeyCode[65508] = 17; //rightctrl
	osgKeyCode[65362] = 38; //up
	osgKeyCode[65364] = 40; //down
	osgKeyCode[65361] = 37; //left
	osgKeyCode[65363] = 39; //right
	osgKeyCode[65291] = 12; //kp_5

	//osgCharCode translates (ea.getUnmodifiedKey()) to charcode
	osgCharCode[65307] = 0; //esc
	osgCharCode[65470] = 0; //f1
	osgCharCode[65471] = 0; //f2
	osgCharCode[65472] = 0; //f3
	osgCharCode[65473] = 0; //f4
	osgCharCode[65474] = 0; //f5
	osgCharCode[65475] = 0; //f6
	osgCharCode[65476] = 0; //f7
	osgCharCode[65477] = 0; //f8
	osgCharCode[65478] = 0; //f9
	osgCharCode[65479] = 0; //f10
	osgCharCode[65480] = 0; //f11
	osgCharCode[65481] = 0; //f12
	osgCharCode[65377] = 0; //printscreen
	osgCharCode[65300] = 0; //scrolllock
	osgCharCode[65299] = 0; //pause
	osgCharCode[96] = 96; //tilde
	osgCharCode[48] = 48; //0
	osgCharCode[49] = 49; //1
	osgCharCode[50] = 50; //2
	osgCharCode[51] = 51; //3
	osgCharCode[52] = 52; //4
	osgCharCode[53] = 53; //5
	osgCharCode[54] = 54; //6
	osgCharCode[55] = 55; //7
	osgCharCode[56] = 56; //8
	osgCharCode[57] = 57; //9
	osgCharCode[45] = 45; //minus
	osgCharCode[61] = 61; //equal
	osgCharCode[92] = 92; //backslash
	osgCharCode[65288] = 0; //backspace
	osgCharCode[65367] = 0; //end
	osgCharCode[65360] = 0; //home
	osgCharCode[65407] = 0; //numlock
	osgCharCode[65455] = 47; //kp_slash
	osgCharCode[65450] = 42; //kp_multiply
	osgCharCode[65453] = 45; //kp_minus
	osgCharCode[65289] = 0; //tab
	osgCharCode[113] = 113; //q
	osgCharCode[119] = 119; //w
	osgCharCode[101] = 101; //e
	osgCharCode[114] = 114; //r
	osgCharCode[116] = 116; //t
	osgCharCode[121] = 121; //y
	osgCharCode[117] = 117; //u
	osgCharCode[105] = 105; //i
	osgCharCode[111] = 111; //o
	osgCharCode[112] = 112; //p
	osgCharCode[91] = 91; //leftbracket
	osgCharCode[93] = 93; //rightbracket
	osgCharCode[65293] = 13; //enter
	osgCharCode[65535] = 0; //delete
	osgCharCode[65379] = 0; //insert
	osgCharCode[65365] = 0; //pageup
	osgCharCode[65366] = 0; //pagedown
	osgCharCode[65438] = 48; //kp_0
	osgCharCode[65436] = 49; //kp_1
	osgCharCode[65433] = 50; //kp_2
	osgCharCode[65435] = 51; //kp_3
	osgCharCode[65430] = 52; //kp_4
	osgCharCode[65437] = 53; //kp_5
	osgCharCode[65432] = 54; //kp_6
	osgCharCode[65429] = 55; //kp_7
	osgCharCode[65431] = 56; //kp_8
	osgCharCode[65434] = 57; //kp_9
	osgCharCode[65439] = 46; //kp_period
	osgCharCode[65451] = 43; //kp_plus
	osgCharCode[65421] = 13; //kp_enter
	osgCharCode[65509] = 0; //capslock
	osgCharCode[97] = 97; //a
	osgCharCode[115] = 115; //s
	osgCharCode[100] = 100; //d
	osgCharCode[102] = 102; //f
	osgCharCode[103] = 103; //g
	osgCharCode[104] = 104; //h
	osgCharCode[106] = 106; //j
	osgCharCode[107] = 107; //k
	osgCharCode[108] = 108; //l
	osgCharCode[59] = 59; //semicolon
	osgCharCode[39] = 39; //quote
	osgCharCode[65505] = 0; //leftshift
	osgCharCode[122] = 122; //z
	osgCharCode[120] = 120; //x
	osgCharCode[99] = 99; //c
	osgCharCode[118] = 118; //v
	osgCharCode[98] = 98; //b
	osgCharCode[110] = 110; //n
	osgCharCode[109] = 109; //m
	osgCharCode[44] = 44; //comma
	osgCharCode[46] = 46; //period
	osgCharCode[47] = 47; //slash
	osgCharCode[65506] = 0; //rightshift
	osgCharCode[65507] = 0; //leftctrl
	osgCharCode[65515] = 0; //leftwinkey
	osgCharCode[65513] = 0; //leftalt
	osgCharCode[32] = 32; //space
	osgCharCode[65514] = 0; //rightalt
	osgCharCode[65515] = 0; //rightwinkey
	osgCharCode[65383] = 0; //menu
	osgCharCode[65508] = 0; //rightctrl
	osgCharCode[65362] = 0; //up
	osgCharCode[65364] = 0; //down
	osgCharCode[65361] = 0; //left
	osgCharCode[65363] = 0; //right
	osgCharCode[65291] = 0; //kp_5

	//osgShiftCharCode translates (ea.getUnmodifiedKey()) to shifted charcode
	osgShiftCharCode[65307] = 0; //esc
	osgShiftCharCode[65470] = 0; //f1
	osgShiftCharCode[65471] = 0; //f2
	osgShiftCharCode[65472] = 0; //f3
	osgShiftCharCode[65473] = 0; //f4
	osgShiftCharCode[65474] = 0; //f5
	osgShiftCharCode[65475] = 0; //f6
	osgShiftCharCode[65476] = 0; //f7
	osgShiftCharCode[65477] = 0; //f8
	osgShiftCharCode[65478] = 0; //f9
	osgShiftCharCode[65479] = 0; //f10
	osgShiftCharCode[65480] = 0; //f11
	osgShiftCharCode[65481] = 0; //f12
	osgShiftCharCode[65377] = 0; //printscreen
	osgShiftCharCode[65300] = 0; //scrolllock
	osgShiftCharCode[65299] = 0; //pause
	osgShiftCharCode[96] = 126; //tilde
	osgShiftCharCode[48] = 41; //0
	osgShiftCharCode[49] = 33; //1
	osgShiftCharCode[50] = 64; //2
	osgShiftCharCode[51] = 35; //3
	osgShiftCharCode[52] = 36; //4
	osgShiftCharCode[53] = 37; //5
	osgShiftCharCode[54] = 94; //6
	osgShiftCharCode[55] = 38; //7
	osgShiftCharCode[56] = 42; //8
	osgShiftCharCode[57] = 40; //9
	osgShiftCharCode[45] = 95; //minus
	osgShiftCharCode[61] = 43; //equal
	osgShiftCharCode[92] = 124; //backslash
	osgShiftCharCode[65288] = 0; //backspace
	osgShiftCharCode[65367] = 0; //end
	osgShiftCharCode[65360] = 0; //home
	osgShiftCharCode[65407] = 0; //numlock
	osgShiftCharCode[65455] = 47; //kp_slash
	osgShiftCharCode[65450] = 42; //kp_multiply
	osgShiftCharCode[65453] = 45; //kp_minus
	osgShiftCharCode[65289] = 0; //tab
	osgShiftCharCode[113] = 81; //q
	osgShiftCharCode[119] = 87; //w
	osgShiftCharCode[101] = 69; //e
	osgShiftCharCode[114] = 82; //r
	osgShiftCharCode[116] = 84; //t
	osgShiftCharCode[121] = 89; //y
	osgShiftCharCode[117] = 85; //u
	osgShiftCharCode[105] = 73; //i
	osgShiftCharCode[111] = 79; //o
	osgShiftCharCode[112] = 80; //p
	osgShiftCharCode[91] = 123; //leftbracket
	osgShiftCharCode[93] = 125; //rightbracket
	osgShiftCharCode[65293] = 13; //enter
	osgShiftCharCode[65535] = 0; //delete
	osgShiftCharCode[65379] = 0; //insert
	osgShiftCharCode[65365] = 0; //pageup
	osgShiftCharCode[65366] = 0; //pagedown
	osgShiftCharCode[65438] = 0; //kp_0
	osgShiftCharCode[65436] = 0; //kp_1
	osgShiftCharCode[65433] = 0; //kp_2
	osgShiftCharCode[65435] = 0; //kp_3
	osgShiftCharCode[65430] = 0; //kp_4
	osgShiftCharCode[65437] = 0; //kp_5
	osgShiftCharCode[65432] = 0; //kp_6
	osgShiftCharCode[65429] = 0; //kp_7
	osgShiftCharCode[65431] = 0; //kp_8
	osgShiftCharCode[65434] = 0; //kp_9
	osgShiftCharCode[65439] = 0; //kp_period
	osgShiftCharCode[65451] = 43; //kp_plus
	osgShiftCharCode[65421] = 13; //kp_enter
	osgShiftCharCode[65509] = 0; //capslock
	osgShiftCharCode[97] = 65; //a
	osgShiftCharCode[115] = 83; //s
	osgShiftCharCode[100] = 68; //d
	osgShiftCharCode[102] = 70; //f
	osgShiftCharCode[103] = 71; //g
	osgShiftCharCode[104] = 72; //h
	osgShiftCharCode[106] = 74; //j
	osgShiftCharCode[107] = 75; //k
	osgShiftCharCode[108] = 76; //l
	osgShiftCharCode[59] = 58; //semicolon
	osgShiftCharCode[39] = 34; //quote
	osgShiftCharCode[65505] = 0; //leftshift
	osgShiftCharCode[122] = 90; //z
	osgShiftCharCode[120] = 88; //x
	osgShiftCharCode[99] = 67; //c
	osgShiftCharCode[118] = 86; //v
	osgShiftCharCode[98] = 66; //b
	osgShiftCharCode[110] = 78; //n
	osgShiftCharCode[109] = 77; //m
	osgShiftCharCode[44] = 60; //comma
	osgShiftCharCode[46] = 62; //period
	osgShiftCharCode[47] = 63; //slash
	osgShiftCharCode[65506] = 0; //rightshift
	osgShiftCharCode[65507] = 0; //leftctrl
	osgShiftCharCode[65515] = 0; //leftwinkey
	osgShiftCharCode[65513] = 0; //leftalt
	osgShiftCharCode[32] = 32; //space
	osgShiftCharCode[65514] = 0; //rightalt
	osgShiftCharCode[65515] = 0; //rightwinkey
	osgShiftCharCode[65383] = 0; //menu
	osgShiftCharCode[65508] = 0; //rightctrl
	osgShiftCharCode[65362] = 0; //up
	osgShiftCharCode[65364] = 0; //down
	osgShiftCharCode[65361] = 0; //left
	osgShiftCharCode[65363] = 0; //right
	osgShiftCharCode[65291] = 0; //kp_5

	osgMouse[1] = 1; //left
	osgMouse[2] = 2; //middle
	osgMouse[4] = 3; //right
	osgMouse[3] = 4; //??
}