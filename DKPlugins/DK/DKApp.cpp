#include "DK/stdafx.h"
#include "DK/DKApp.h"
#include "DK/DKOsInfo.h"
#include "DK/DKFile.h"

int    DKApp::argc;
char** DKApp::argv;
bool   DKApp::active = false;
bool   DKApp::paused = false;
std::vector<boost::function<void()> > DKApp::loop_funcs;


/////////// MAIN ////////////////
#ifndef ANDROID
int main(int argc, char **argv)
{
	DKUtil::SetMainThreadNow();
	DKApp::argc = argc;
	DKApp::argv = argv;

#if __cplusplus <= 199711L
	DKLog("C++98 \n", DKINFO);
#else
	DKLog("C++11 \n", DKINFO);
#endif

#ifndef IOS
	DKFile::exe_path = argv[0];

#ifdef WIN32
	DKWindows::CreateConsoleHandler();
	DKWindows::SetTitle();
#endif

	DKString info;
	GetOSInfo(info);
	DKLog(info+"\n", DKINFO);

	DKString date;
	DKUtil::GetDate(date);
	DKString time;
	DKUtil::GetTime(time);
	DKLog(date+" "+time+"\n", DKINFO);
	
	//print args
	if(DKApp::argc > 1){
		for(int i = 1; i < DKApp::argc; ++i){
			DKLog("argv["+toString(i)+"] = "+toString(DKApp::argv[i])+"\n", DKINFO);
	    }
    }
	
	//Display app path information
	DKFile::GetExePath(DKFile::exe_path);
	DKFile::GetExeName(DKFile::exe_name);
	DKFile::GetAppPath(DKFile::app_path);
	DKFile::GetAppName(DKFile::app_name);
	DKLog("DKFile::exe_path = "+DKFile::exe_path+"\n", DKINFO);
	DKLog("DKFile::exe_name = "+DKFile::exe_name+"\n", DKINFO);
	DKLog("DKFile::app_path = "+DKFile::app_path+"\n", DKINFO);
	DKLog("DKFile::app_name = "+DKFile::app_name+"\n", DKINFO);

	DKCreate("DKAssets");
	DKCreate("DKDuktape");
	DKCreate("DKDebug");
	DKApp dkapp;
	DKObject* app = DKCreate("App"); //App.h/App.cpp (user code)
	dkapp.Init();
	dkapp.Loop();
	dkapp.Exit();

#else
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    UIApplicationMain(argc, argv, nil, @"iphoneViewerAppDelegate");
    [pool release];
    return 0;
#endif
}
#endif //!ANDROID
/////////////////////////////////


//////////////
DKApp::DKApp()
{
	DKLog("DKApp::DKApp()\n", DKDEBUG);

#ifdef ANDROID
	DKUtil::mainThreadId = (int)pthread_self();
#endif
}

//////////////////
void DKApp::Init()
{
	DKLog("DKApp::Init()\n", DKDEBUG);
	active = true;
	DKCHECK(true);
	DKCHECK(false);
}

//////////////////
void DKApp::Loop()
{
	DKLog("DKApp::Loop(): \n", DKINFO);
	while(active){
		DoFrame();
	}
}

/////////////////////
void DKApp::DoFrame()
{
	if(paused){ 
		DKUtil::Sleep(100);
		return;
	}

	DKUtil::LimitFramerate();
	DKUtil::SendTick();

	//Call loop functions
	for(unsigned int i = 0; i < loop_funcs.size(); ++i){
		if (active){
			loop_funcs[i](); 
		}
	}
}

//////////////////
void DKApp::Exit()
{
	DKLog("DKApp::Exit(): \n", DKINFO);
	active = false;
	DKUtil::CallExit();
	exit(0);
}