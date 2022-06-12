/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#include "DK/stdafx.h"
#include "DK/DKApp.h"
#include "DK/DKOsInfo.h"
#include "DK/DKFile.h"
#if HAVE_boxer
	#include <boxer/boxer.h>
#endif
#if ANDROID
	#include <SDL.h>
#endif 

int    DKApp::argc;
char** DKApp::argv;
bool   DKApp::active = false;
bool   DKApp::paused = false;
std::vector<std::function<void()> > DKApp::loop_funcs;


/*
// Root try/catch block
try{
	//code to try
}
catch (...){
	std::cout << "Exception:\n";
	if(DKClass::HasFunc("DKDebug::ShowStackTrace")){
		DKClass::CallFunc("DKDebug::ShowStackTrace");
		boxer::Selection sel = boxer::show("An exception in the main thread has occured.\n", "EXCEPTION", boxer::Style::Error, boxer::Buttons::YesNo);
		if(sel == boxer::Selection::Yes){
			DKApp::Exit();
			return false;
		}
	}
}
*/


/*
DKApp::DKApp(_argc, _argv)
	(Main entry point)
	_argc: (int) The number of arguments provided
	_argv: (char**) The values of the arguments
*/
DKApp::DKApp(int _argc, char** _argv){
	DKDEBUGFUNC(_argc, _argv);
	DKApp::argc = _argc;
	DKApp::argv = _argv;
	DKUtil::SetMainThreadNow();

	if (argc)
		DKFile::exe_path = argv[0];
#if ANDROID
	if (!SDL_AndroidGetExternalStorageState())
		DKERROR("SDL_AndroidGetExternalStorageState(): failed");
	const char* externalStoragePath = SDL_AndroidGetExternalStoragePath();
	DKFile::exe_path = externalStoragePath;
#endif
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

#if WIN32
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
	//if (DKClass::DKAvailable("App")) {
	//	DKObject* app = DKClass::DKCreate("App"); //App.h/App.cpp (user code)
	//}
	DKClass::DKCreate("DKDuktape");
	DKClass::DKCreate("DKDebug");
}

void DKApp::Init(){
	DKDEBUGFUNC();
	active = true;
}

void DKApp::Loop(){
	DKDEBUGFUNC();
	while(active)
		DoFrame();
}

void DKApp::DoFrame(){
	if(paused){ 
		DKUtil::Sleep(100);
		return;
	}
	DKUtil::LimitFramerate();
	CallLoops(); //Call loop functions
}

void DKApp::CallLoops(){
	for(unsigned int i = 0; i < loop_funcs.size(); ++i){
		//if(active)
			loop_funcs[i]();
	}
}

void DKApp::Exit(){
	DKDEBUGFUNC();
	active = false;
	DKUtil::CallExit();
	//exit(0);
}
