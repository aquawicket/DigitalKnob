#ifdef WIN32
#pragma once
#ifndef DKHook_H
#define DKHook_H
#include "DK.h"

#include <Tlhelp32.h>
#include <vector>

//Functions in wxHookDLL.dll
typedef bool(*InstallHook)(unsigned long);
typedef bool(*UnInstallHook)();

////////////////
struct HWNDname{   
   int alias;
   const char* caption;
};

///////////////////////////////////////
class DKHook : public DKObjectT<DKHook>
{
public:
	void Init();
	void End();

	bool Click();
	bool DoHighlight();
	bool GetClass(DKString& clas);
	bool GetHandles();
	bool GetLeft(int& left);
	bool GetParent(DKString& parent);
	bool GetString(DKString& text);
	bool GetTop(int& top);
	bool GetWindows(DKStringArray& windows);
	bool NextHandle();
	bool PrevHandle();
	bool SendHook(const DKString& window, const DKString& handle, const DKString& data);
	bool SetHandle(unsigned int index);
	bool SetHandle(const DKString& clas, const DKString& value);
	bool SetHandle(const DKString& value);
	bool SetString(const DKString& text);
	bool SetWindowHandle(const DKString& caption);
	bool ToggleHighlight();
	bool WaitForWindow(const DKString& title, int timeout);
	bool WaitForHandle(unsigned int index, int timeout);
	bool WaitForHandle(const DKString& clas, const DKString& value, int timeout);
	bool WaitForHandle(const DKString& value, int timeout);
	bool WindowExists(const DKString& title);
	static BOOL CALLBACK EnumWindowsProc(HWND hwnd, LPARAM lParam);
	static BOOL CALLBACK FindWindowPartial(HWND hwnd, LPARAM lapram);
	static BOOL CALLBACK GetWindows(HWND hwnd, LPARAM lParam);

	HMODULE hModule;  //dll module
	static std::vector<HWND> handle; //handle[0] is the window
	static DKStringArray _windows;
	unsigned int currentHandle;
	bool highlight;
	//HDC screenDC;
};

REGISTER_OBJECT(DKHook, true);
#endif //DKHook_H
#endif //WIN32 || WIN64