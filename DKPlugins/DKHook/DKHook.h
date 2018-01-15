#ifdef WIN32
#pragma once
#ifndef DKHook_H
#define DKHook_H

#include "DK/DK.h"

//Functions in DKHookDLL.dll
//typedef bool(*InstallHook)(unsigned long);
//typedef bool(*UnInstallHook)();

///////////////////////////////////////
class DKHook : public DKObjectT<DKHook>
{
public:
	void Init();
	void End();

	static HHOOK hook; // handle to the hook	
	void InstallHook(); // function to install our hook
	void UninstallHook(); // function to uninstall our hook
	int Messsages(); // function to "deal" with our messages 

	MSG msg; // struct with information about all messages in our queue
	//HMODULE hModule;  //dll module
};

LRESULT WINAPI MyMouseCallback(int nCode, WPARAM wParam, LPARAM lParam); //callback declaration

REGISTER_OBJECT(DKHook, true);
#endif //DKHook_H
#endif //WIN32 || WIN64