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
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKHook/DKHook.h"

#if WIN32
HHOOK DKHook::hook;
#endif

//WARNING_DISABLE
#if LINUX
	#include <fcntl.h>
#endif
//WARNING_ENABLE

bool DKHook::Init() {
	DKDEBUGFUNC();
#if WIN32
	InstallHook();
#endif
	/*
	DKString path = DKFile::local_assets + "DKHook/hookdll.dll";
	hModule = LoadLibrary(path.c_str());
	if(NULL == hModule){
		DKERROR("DKHook::DKHook(): cannot find hookdll.dll\n");
	}
	*/
#if LINUX
	const char *pDevice = "/dev/input/mice";
	// Open Mouse
	fd = open(pDevice, O_RDWR);
	if(fd == -1){
		printf("ERROR Opening %s\n", pDevice);
		return false;
	}
	DKApp::AppendLoopFunc(&DKHook::LinuxHook, this);
#endif
	return true;
}

bool DKHook::End() {
	DKDEBUGFUNC();
	//if(hModule){FreeLibrary(hModule);}
	return true;
}

#if LINUX
void DKHook::LinuxHook() {
	DKDEBUGFUNC();
	// Read Mouse     
	bytes = read(fd, _data, sizeof(_data));
	if(bytes > 0){
		left = _data[0] & 0x1;
		right = _data[0] & 0x2;
		middle = _data[0] & 0x4;
		x = _data[1];
		y = _data[2];
		printf("x=%d, y=%d, left=%d, middle=%d, right=%d\n", x, y, left, middle, right);
	} 
}
#endif

#if WIN32
int DKHook::Messsages() {
	DKDEBUGFUNC();
	while(msg.message != WM_QUIT){ //while we do not close our application
		if (PeekMessage(&msg, NULL, 0, 0, PM_REMOVE)){
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
		Sleep(1);
	}
	UninstallHook(); //if we close, let's uninstall our hook
	return (int)msg.wParam; //return the messages
}

void DKHook::InstallHook() {
	DKDEBUGFUNC();
	/*
	SetWindowHookEx(
	WM_MOUSE_LL = mouse low level hook type,
	MyMouseCallback = our callback function that will deal with system messages about mouse
	NULL, 0);

	c++ note: we can check the return SetWindowsHookEx like this because:
	If it return NULL, a NULL value is 0 and 0 is false.
	*/
	hook = SetWindowsHookEx(WH_MOUSE_LL, MyMouseCallback, NULL, 0);
	if(!hook){
	//if(!(hook = SetWindowsHookEx(WH_MOUSE_LL, MyMouseCallback, NULL, 0))){
		printf_s("Error: %x \n", GetLastError());
	}
	hook = SetWindowsHookEx(WH_KEYBOARD_LL, MyKeyboardCallback, NULL, 0);
	if(!hook){
	//if(!(hook = SetWindowsHookEx(WH_KEYBOARD_LL, MyKeyboardCallback, NULL, 0))){
		printf_s("Error: %x \n", GetLastError());
	}
}

void DKHook::UninstallHook() {
	DKDEBUGFUNC();
	UnhookWindowsHookEx(hook);
}


LRESULT WINAPI MyMouseCallback(int nCode, WPARAM wParam, LPARAM lParam) {
	DKDEBUGFUNC(nCode, wParam, lParam);
	MSLLHOOKSTRUCT* pMouseStruct = (MSLLHOOKSTRUCT *)lParam; // WH_MOUSE_LL struct										 
	if(nCode == 0){ // we have information in wParam/lParam ? If yes, let's check it:
		if(pMouseStruct != NULL){ // Mouse struct contain information?			
			//DKINFO("Mouse Coordinates: "+toString(pMouseStruct->pt.x)+","+toString(pMouseStruct->pt.y)+"\n");
			DKEvents::SendEvent("window", "GLOBAL_mousemove", toString(pMouseStruct->pt.x)+","+toString(pMouseStruct->pt.y));
		}
		switch(wParam){
			case WM_LBUTTONUP:{
				//DKINFO("LEFT CLICK UP\n");
				DKEvents::SendEvent("window", "GLOBAL_mousedown", toString(1));
			}break;
			case WM_LBUTTONDOWN:{
				//DKINFO("LEFT CLICK DOWN\n");
				DKEvents::SendEvent("window", "GLOBAL_mouseup", toString(1));
			}break;
		}
	}
	return CallNextHookEx(DKHook::hook, nCode, wParam, lParam);
}

LRESULT WINAPI MyKeyboardCallback(int nCode, WPARAM wParam, LPARAM lParam) {
	DKDEBUGFUNC(nCode, wParam, lParam);
	KBDLLHOOKSTRUCT* pKeyboardStruct = (KBDLLHOOKSTRUCT *)lParam; // WH_KEYBOARD_LL struct
	if(nCode == 0){ // we have information in wParam/lParam ? If yes, let's check it:
		if(pKeyboardStruct != NULL){ // Mouse struct contain information?			
			//DKINFO("keyboard event\n");
			DKEvents::SendEvent("window", "GLOBAL_keypress", "");
		}
	}
	/*
	Every time that the nCode is less than 0 we need to CallNextHookEx:
	-> Pass to the next hook
	MSDN: Calling CallNextHookEx is optional, but it is highly recommended; 
	otherwise, other applications that have installed hooks will not receive hook notifications and may behave incorrectly as a result.
	*/
	return CallNextHookEx(DKHook::hook, nCode, wParam, lParam);
}

#endif //WIN32