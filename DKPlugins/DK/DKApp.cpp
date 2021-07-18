#include "DK/stdafx.h"
#include "DK/DKApp.h"
#include "DK/DKOsInfo.h"
#include "DK/DKFile.h"

int    DKApp::argc;
char** DKApp::argv;
bool   DKApp::active = false;
bool   DKApp::paused = false;
//std::vector<boost::function<void()> > DKApp::loop_funcs;
std::vector<std::function<void()> > DKApp::loop_funcs;


/////////// MAIN ////////////////
#ifndef ANDROID
int main(int argc, char **argv){
	DKDEBUGFUNC(argc, argv);
	DKApp dkapp(argc, argv);
	DKApp::Init();
	DKApp::Loop();
	DKApp::Exit();
}
#endif //!ANDROID

DKApp::DKApp(int argc, char** argv){
	DKDEBUGFUNC(argc, argv);
	DKApp::argc = argc;
	DKApp::argv = argv;
	DKUtil::SetMainThreadNow();
	if (__cplusplus == 201703L) { DKINFO("C++17 \n"); }
	else if (__cplusplus == 201402L) { DKINFO("C++14 \n"); }
	else if (__cplusplus == 201103L) { DKINFO("C++11 \n"); }
	else if (__cplusplus == 199711L) { DKINFO("C++98 \n"); }
	else DKINFO("pre-standard C++ \n");
	DKFile::exe_path = argv[0];
	DKFile::NormalizePath(DKFile::exe_path);
#ifdef WIN32
	DKWindows::CreateConsoleHandler();
	DKWindows::SetTitle();
#endif
	DKString info;
	GetOSInfo(info);
	DKINFO(info + "\n");
	DKString date;
	DKUtil::GetDate(date);
	DKString time;
	DKUtil::GetTime(time);
	DKINFO(date + " " + time + "\n");
	//print args
	if (DKApp::argc > 1) {
		for (int i = 1; i < DKApp::argc; ++i)
			DKINFO("argv[" + toString(i) + "] = " + toString(DKApp::argv[i]) + "\n");
	}
	//Display app path information
	DKFile::GetExePath(DKFile::exe_path);
	DKFile::GetExeName(DKFile::exe_name);
	DKFile::GetAppPath(DKFile::app_path);
	DKFile::GetAppName(DKFile::app_name);
	DKINFO("DKFile::exe_path = " + DKFile::exe_path + "\n");
	DKINFO("DKFile::exe_name = " + DKFile::exe_name + "\n");
	DKINFO("DKFile::app_path = " + DKFile::app_path + "\n");
	DKINFO("DKFile::app_name = " + DKFile::app_name + "\n");
//#ifdef USE_DKAssets
	DKClass::DKCreate("DKAssets"); //Nothing will be logged to log.txt until here.
//#endif
//#ifdef USE_DKDuktape
	DKClass::DKCreate("DKDuktape");
//#endif
//#ifdef USE_DKDebug
	DKClass::DKCreate("DKDebug");
//#endif
	DKObject* app = DKClass::DKCreate("App"); //App.h/App.cpp (user code)
}

void DKApp::Init(){
	DKDEBUGFUNC();
	active = true;
}

void DKApp::Loop(){
	DKDEBUGFUNC();
	DKINFO("DKApp::Loop()\n");
	while(active)
		DoFrame();
}

void DKApp::DoFrame(){
	//DKDEBUGFUNC(); //DON'T DO THIS
	if(paused){ 
		DKUtil::Sleep(100);
		return;
	}
	DKUtil::LimitFramerate();
	//DKUtil::SendTick();
	CallLoops(); //Call loop functions
}

void DKApp::CallLoops(){
	for(unsigned int i = 0; i < loop_funcs.size(); ++i){
		if(active)
			loop_funcs[i]();
	}
}

void DKApp::Exit(){
	DKDEBUGFUNC();
	DKINFO("DKApp::Exit():\n");
	active = false;
	DKUtil::CallExit();
	exit(0);
}


// For iphone
#ifdef IOS
NSAutoreleasePool* pool = [NSAutoreleasePool new];
int retval = UIApplicationMain(argc, argv, nil, @"iphoneViewerAppDelegate");
[pool release] ;
return 0;
#endif
