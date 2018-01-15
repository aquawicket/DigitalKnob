#include "DK/stdafx.h"
#ifdef WIN32
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKHook/DKHook.h"

HHOOK DKHook::hook;

///////////////////
void DKHook::Init()
{
	InstallHook();

	/*
	DKString path = DKFile::local_assets + "DKHook/hookdll.dll";
	hModule = LoadLibrary(path.c_str());
	if(NULL == hModule){
		DKLog("DKHook::DKHook(): cannot find hookdll.dll \n", DKERROR);
	}
	*/
}

//////////////////
void DKHook::End()
{
	//if(hModule){FreeLibrary(hModule);}
}

///////////////////////
int DKHook::Messsages()
{
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

//////////////////////////
void DKHook::InstallHook()
{
	/*
	SetWindowHookEx(
	WM_MOUSE_LL = mouse low level hook type,
	MyMouseCallback = our callback function that will deal with system messages about mouse
	NULL, 0);

	c++ note: we can check the return SetWindowsHookEx like this because:
	If it return NULL, a NULL value is 0 and 0 is false.
	*/
	if(!(hook = SetWindowsHookEx(WH_MOUSE_LL, MyMouseCallback, NULL, 0))){
		printf_s("Error: %x \n", GetLastError());
	}
	if(!(hook = SetWindowsHookEx(WH_KEYBOARD_LL, MyKeyboardCallback, NULL, 0))){
		printf_s("Error: %x \n", GetLastError());
	}
}

////////////////////////////
void DKHook::UninstallHook()
{
	UnhookWindowsHookEx(hook);
}


///////////////////////////////////////////////////////////////////////
LRESULT WINAPI MyMouseCallback(int nCode, WPARAM wParam, LPARAM lParam)
{
	MSLLHOOKSTRUCT* pMouseStruct = (MSLLHOOKSTRUCT *)lParam; // WH_MOUSE_LL struct
															 
	if(nCode == 0){ // we have information in wParam/lParam ? If yes, let's check it:
		if(pMouseStruct != NULL){ // Mouse struct contain information?			
			DKLog("Mouse Coordinates: "+toString(pMouseStruct->pt.x)+","+toString(pMouseStruct->pt.y)+"\n", DKINFO);
			DKEvent::SendEvent("window", "mousemove", toString(pMouseStruct->pt.x)+","+toString(pMouseStruct->pt.y));
		}

		switch(wParam){
			case WM_LBUTTONUP:{
				DKLog("LEFT CLICK UP\n", DKINFO);
				DKEvent::SendEvent("window", "mousedown", toString(1));
			}break;
			case WM_LBUTTONDOWN:{
				DKLog("LEFT CLICK DOWN\n", DKINFO);
				DKEvent::SendEvent("window", "mouseup", toString(1));
			}break;
		}
	}

	return CallNextHookEx(DKHook::hook, nCode, wParam, lParam);
}

//////////////////////////////////////////////////////////////////////////
LRESULT WINAPI MyKeyboardCallback(int nCode, WPARAM wParam, LPARAM lParam)
{
	KBDLLHOOKSTRUCT* pKeyboardStruct = (KBDLLHOOKSTRUCT *)lParam; // WH_KEYBOARD_LL struct

	if(nCode == 0){ // we have information in wParam/lParam ? If yes, let's check it:
		if(pKeyboardStruct != NULL){ // Mouse struct contain information?			
			DKLog("keyboard event\n", DKINFO);
			DKEvent::SendEvent("window", "keypress", "");
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