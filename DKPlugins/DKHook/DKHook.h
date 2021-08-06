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
	bool Init();
	bool End();

#ifdef LINUX
	void LinuxHook();
	int fd, bytes;
	unsigned char _data[3];
	int left, middle, right;
	signed char x, y;
#endif //LINUX

#ifdef WIN32
	void InstallHook(); // function to install our hook
	void UninstallHook(); // function to uninstall our hook
	int Messsages(); // function to "deal" with our messages 

	static HHOOK hook; // handle to the hook
	MSG msg; // struct with information about all messages in our queue
	//HMODULE hModule;  //dll module
#endif //WIN32
};

#ifdef WIN32
LRESULT WINAPI MyMouseCallback(int nCode, WPARAM wParam, LPARAM lParam);
LRESULT WINAPI MyKeyboardCallback(int nCode, WPARAM wParam, LPARAM lParam);
#endif //WIN32

REGISTER_OBJECT(DKHook, true);
#endif //DKHook_H