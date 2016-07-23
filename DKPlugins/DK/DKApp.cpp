#include "stdafx.h"
#include "DKApp.h"
#include "DKOsInfo.h"
#include "DKFile.h"

int DKApp::argc;
char** DKApp::argv;
bool DKApp::active = false;
bool DKApp::loaded = false;
bool DKApp::paused = false;
std::vector<boost::function<void()> > DKApp::loop_funcs;
double DKApp::now;
double DKApp::lastFrame = DKUtil::GetTicks();
double DKApp::lastSecond = DKUtil::GetTicks();
double DKApp::_fps;


#ifdef WIN32
HINSTANCE DKApp::hInstance = 0L;
int main(int argc, char **argv);
//////////// WIN32 MAIN //////////////////////////////////////////////////////////////////////////
int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPTSTR lpCmdLine, int nCmdShow) 
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);
    DKApp::hInstance = hInstance;
    return main(__argc, __argv);
}
#endif

/////////// MAIN ////////////////
#ifndef ANDROID
int main(int argc, char **argv)
{
	DKApp::argc = argc;
    DKApp::argv = argv;
#ifdef WIN32
	DKUtil::mainThreadId = GetCurrentThreadId();
#endif
#if defined(MAC)
	DKUtil::mainThreadId = pthread_self();
#endif
#if defined(LINUX) || defined (IOS)
	DKUtil::mainThreadId = (int)pthread_self();
#endif
#ifndef IOS
	DKFile::appfilename = argv[0];

#ifdef WIN32
	if (!SetConsoleCtrlHandler((PHANDLER_ROUTINE)DKApp::ConsoleHandler, true)){
		DKLog("Could not set Console Handler. \n", DKERROR);
	}
	HWND consoleWindow = GetConsoleWindow();
	SetWindowPos(consoleWindow, 0, 0, 0, 640, 1024, SWP_NOSIZE | SWP_NOZORDER);

	/////  Set the window title
	DKString title; 
	DKFile::GetExeName(title);
	title += " - WIN32";
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
	SetConsoleTitle(title.c_str());
#endif

	DKCreate("DKAssets");
	DKLog(GetOSInfo()+"\n", DKINFO);
	DKLog(DKUtil::GetDate()+" "+DKUtil::GetTime()+"\n", DKINFO);
	DKCreate("DKDuktape");
	DKCreate("DKDebug");
	DKApp dkapp;
	DKObject* app = DKCreate("App"); //App.h/App.cpp (user code)
	dkapp.Init();
	dkapp.Loop();
	log_gui_console = false;

#else
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    UIApplicationMain(argc, argv, nil, @"iphoneViewerAppDelegate");
    [pool release];
    return 0;
#endif
}
#endif //!ANDROID
//////////////////////////////////


//////////////
DKApp::DKApp()
{
	DKLog("DKApp::DKApp() \n", DKDEBUG);
#ifdef ANDROID
	DKUtil::mainThreadId = (int)pthread_self();
#endif
}

//////////////////
void DKApp::Init()
{
	DKLog("DKApp::Init() \n", DKDEBUG);
	active = true;
	now = DKUtil::GetTicks();
	lastFrame = DKUtil::GetTicks();
	_fps = 17; //TODO - make this number actually reflect the true FPS
}

//////////////////
void DKApp::Loop()
{
	DKLog("DKApp::Loop() \n", DKDEBUG);
	while(active){
		DoFrame();
	}
}

/////////////////////
void DKApp::DoFrame()
{
	//Framerate / cpu limiter
	now = DKUtil::GetTicks();
	double delta = now - lastFrame;
	lastFrame = now;
	if (delta < _fps){  //FIXME -fps does not reflet with this math. 
		DKUtil::Sleep(DKUtil::Round(_fps - delta));
	}

	if(paused){ return; }
	for(unsigned int i = 0; i < loop_funcs.size(); ++i){
		if (active){
			loop_funcs[i](); //Call loop functions
		}
	}

	if (((now - lastSecond) / 1000) > 1.0){ // 1 second
		SendEvent("GLOBAL", "second", ""); //This might be to heavy
		lastSecond = now;
	}
}

//////////////////
void DKApp::Exit()
{
	DKLog("DKApp::Exit() \n", DKDEBUG);
	active = false;
#ifdef ANDROID
	CallJavaFunction("Exit","");
#endif
	DKClass::CloseAll();
	exit(0);
}

/////////////////////////
int DKApp::GetFramerate()
{
	return (int)_fps;
}

/////////////////////////////////
void DKApp::SetFramerate(int fps)
{
	DKLog("DKApp::SetFramerate("+DKString(toString(fps))+") \n", DKDEBUG);
	_fps = fps;
}

#ifdef WIN32
/////////////////////////////////////////////
bool WINAPI DKApp::ConsoleHandler(DWORD type)
{
	//DKLog("Console Message \n");
	switch (type){
		case CTRL_CLOSE_EVENT:
			DKApp::Exit();
			return(true);
	}
	return false;
}
#endif
