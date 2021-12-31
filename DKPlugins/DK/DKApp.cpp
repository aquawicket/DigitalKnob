#include "DK/stdafx.h"
#include "DK/DKApp.h"
#include "DK/DKOsInfo.h"
#include "DK/DKFile.h"
#ifdef HAVE_boxer
	#include <boxer/boxer.h>
#endif

#ifdef IOS
#ifdef __has_include
#if __has_include(<SDL_main.h>)
    #include "SDL_main.h"
#endif
#endif
#endif

int    DKApp::argc;
char** DKApp::argv;
bool   DKApp::active = false;
bool   DKApp::paused = false;
std::vector<std::function<void()> > DKApp::loop_funcs;

//// MAIN ////
//#ifndef ANDROID
int main(int argc, char **argv){
	DKDEBUGFUNC(argc, argv);
	//try{
		DKApp dkapp(argc, argv);
		DKApp::Init();
		DKApp::Loop();
	//}
	//catch (...){
	//	std::cout << "Exception:\n";
	//	if(DKClass::HasFunc("DKDebug::ShowStackTrace")){
	//		DKClass::CallFunc("DKDebug::ShowStackTrace");
	//		boxer::Selection sel = boxer::show("An exception in the main thread has occured.\n", "EXCEPTION", boxer::Style::Error, boxer::Buttons::YesNo);
	//		if(sel == boxer::Selection::Yes){
	//			DKApp::Exit();
	//			return false;
	//		}
	//	}
	//}
}
//#endif //!ANDROID

DKApp::DKApp(int _argc, char** _argv){
	DKDEBUGFUNC(_argc, _argv);
	DKApp::argc = _argc;
	DKApp::argv = _argv;
	DKUtil::SetMainThreadNow();
	if (argc)
		DKFile::exe_path = argv[0];
	DKFile::NormalizePath(DKFile::exe_path);

	DKString appName;
	DKFile::GetAppName(appName);
	DKString version;
	GetVersion(version);
	DKString osFlag;
	GetOSFlag(osFlag);
	DKString buildType;

	DKINFO(appName + " " + version + " " + osFlag + " " + toString(DKBUILD_TYPE) + "\n");
	DKINFO("OS:          " + toString(DKOS) + "\n");
	DKINFO("OS Version:  " + toString(DKOS_VERSION) + "\n");
	DKINFO("Processor:   " + toString(DKARCH) + "\n");
	DKINFO("Bits:        " + toString(DKBITS) + "\n");
	DKINFO("Compiler:    " + toString(DKCOMPILER) + " " + toString(DKCOMPILER_VERSION)+ "\n");
	DKINFO("C Version:   " + toString(DKC_LANGUAGE_VERSION) + "\n");
	DKINFO("C++ Version: " + toString(DKCPP_LANGUAGE_VERSION) + "\n");
	DKINFO("Build type:  " + toString(DKBUILD_TYPE) + "\n");

#ifdef WIN32
	DKWindows::CreateConsoleHandler();
	DKWindows::SetTitle(appName + " " + version + " " + osFlag + " " + toString(DKBUILD_TYPE));
#endif
	DKString osInfo;
	GetOSInfo(osInfo);
	DKINFO(osInfo + "\n");
	DKString date;
	DKUtil::GetDate(date);
	DKString time;
	DKUtil::GetTime(time);
	DKINFO(date + " " + time + "\n");
	if (DKApp::argc > 1) {
		for (int i = 1; i < DKApp::argc; ++i){
			DKINFO("argv[" + toString(i) + "] = " + toString(DKApp::argv[i]) + "\n"); //print args
		}
	}
	//Display app path information
	DKFile::GetExePath(DKFile::exe_path);
	DKFile::GetAppPath(DKFile::app_path);
	DKFile::GetExeName(DKFile::exe_name);
	DKFile::GetAppName(DKFile::app_name);
	DKINFO("DKFile::exe_path = " + DKFile::exe_path + "\n");
	DKINFO("DKFile::app_path = " + DKFile::app_path + "\n");
	DKINFO("DKFile::exe_name = " + DKFile::exe_name + "\n");
	DKINFO("DKFile::app_name = " + DKFile::app_name + "\n");
	DKClass::DKCreate("DKAssets"); //Nothing will be logged to log.txt until here.
	if (DKClass::DKAvailable("App")) {
		DKObject* app = DKClass::DKCreate("App"); //App.h/App.cpp (user code)
	}
	DKClass::DKCreate("DKDuktape");
	DKClass::DKCreate("DKDebug");
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
