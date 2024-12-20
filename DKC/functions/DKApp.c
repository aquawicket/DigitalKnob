/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
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

//#include "DK/stdafx.h"
#include "DKApp.h"
//#include "DK/DKOsInfo.h"
//#include "DK/DKFile.h"

//WARNING_DISABLE
#if HAVE_backward_cpp
	//#include <backward.hpp>
#endif
#if HAVE_boxer
	#include <boxer/boxer.h>
#endif
#if ANDROID && HAVE_sdl
	#include <SDL.h>
#endif
//WARNING_ENABLE

int    DKApp_argc;
char** DKApp_argv;
bool   DKApp_active = false;
bool   DKApp_paused = false;
//std_vector<std_function<void()> > DKApp_loop_funcs;


/*
// Root try/catch block
try{
	//code to try
}
catch (...){
	std_cout << "Exception:\n";
	if(DKClass_HasFunc("DKDebug_ShowStackTrace")){
		DKClass_CallFunc("DKDebug_ShowStackTrace");
		boxer_Selection sel = boxer_show("An exception in the main thread has occured.\n", "EXCEPTION", boxer_Style_Error, boxer_Buttons_YesNo);
		if(sel == boxer_Selection_Yes){
			DKApp_Exit();
			return false;
		}
	}
}
*/


/*
DKApp_DKApp(_argc, _argv)
	(Main entry point)
	_argc: (int) The number of arguments provided
	_argv: (char**) The values of the arguments
*/
DKApp_DKApp(int _argc, char** _argv){
	//DKDEBUGFUNC(_argc, _argv);
	DKApp_argc = _argc;
	DKApp_argv = _argv;
	//DKUtil_SetMainThreadNow();

	//DKPreprocessor_PrintPreprocessor();
/*
	if (argc)
		//DKFile_exe_path = argv[0];
	#if ANDROID
		#if HAVE_sdl
			if (!SDL_AndroidGetExternalStorageState())
				DKERROR("SDL_AndroidGetExternalStorageState(): failed");
			const char* externalStoragePath = SDL_AndroidGetExternalStoragePath();
			DKFile_exe_path = externalStoragePath;
		#endif
	#endif
	#if EMSCRIPTEN
		DKFile_GetCurrentPath(DKFile_exe_path);
	#endif

	DKFile_NormalizePath(DKFile_exe_path);

	DKString appName;
	DKFile_GetAppName(appName);
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

	#if WIN
		DKWindows_CreateConsoleHandler();
		DKWindows_SetTitle(appName + " " + version + " " + osFlag + " " + toString(DKBUILD_TYPE));
	#endif
	DKString osInfo;
	GetOSInfo(osInfo);
	DKINFO(osInfo + "\n");
	DKString date;
	DKUtil_GetDate(date);
	DKString time;
	DKUtil_GetTime(time);
	DKINFO(date + " " + time + "\n");
	if (DKApp_argc > 1){
		for (int i = 1; i < DKApp_argc; ++i){
			DKINFO("argv[" + toString(i) + "] = " + toString(DKApp_argv[i]) + "\n"); //print args
		}
	}
	//Display app path information
	DKFile_GetExePath(DKFile_exe_path);
	DKFile_GetAppPath(DKFile_app_path);
	DKFile_GetExeName(DKFile_exe_name);
	DKFile_GetAppName(DKFile_app_name);
	DKINFO("DKFile_exe_path = " + DKFile_exe_path + "\n");
	DKINFO("DKFile_app_path = " + DKFile_app_path + "\n");
	DKINFO("DKFile_exe_name = " + DKFile_exe_name + "\n");
	DKINFO("DKFile_app_name = " + DKFile_app_name + "\n");
	DKClass_DKCreate("DKAssets"); //Nothing will be logged to log.txt until here.
	//if (DKClass_DKAvailable("App")){
	//	DKObject* app = DKClass_DKCreate("App"); //App.h/App.cpp (user code)
	//}
	DKClass_DKCreate("DKDuktape");
	DKClass_DKCreate("DKDebug");
*/	
	return 0;
}

void DKApp_Init(){
	//DKDEBUGFUNC();
	DKApp_active = true;
}

#if EMSCRIPTEN
EM_BOOL DKApp_EM_DoFrame(double time, void* userData) {
	if (paused) {
		DKUtil_Sleep(100);
		return EM_TRUE; // Return true to keep the loop running.
	}
	DKUtil_LimitFramerate();
	DKApp_CallLoops(); //Call loop functions
	return EM_TRUE; // Return true to keep the loop running.
}
#endif

void DKApp_Loop(){
	//DKDEBUGFUNC();
#if EMSCRIPTEN
	// Receives a function to call and some user data to provide it.
	emscripten_request_animation_frame_loop(DKApp_EM_DoFrame, 0);
#else
	while(DKApp_active)
		DKApp_DoFrame();
#endif
}

void DKApp_DoFrame(){
	if(DKApp_paused){ 
		//DKUtil_Sleep(100);
		return;
	}
	//DKUtil_LimitFramerate();
	DKApp_CallLoops(); //Call loop functions
}

void DKApp_CallLoops(){
	/*
	for(unsigned int i = 0; i < loop_funcs.size(); ++i){
		//if(active)
			loop_funcs[i]();
	}
	*/
}

void DKApp_Exit(){
	//DKDEBUGFUNC();
	DKApp_active = false;
	//DKUtil_CallExit();
	//exit(0);
}















//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN = 1
#include <stdio.h>
int main(int argc, char** argv) {
	return DKApp_DKApp(argc, argv);
}
#endif