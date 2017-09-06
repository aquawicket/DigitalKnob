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

	HMODULE hModule;  //dll module
	static std::vector<HWND> handle; //handle[0] is the window

	bool GetHandles();
	bool SetWindowHandle(const DKString& caption);
	static BOOL CALLBACK EnumWindowsProc(HWND hwnd, LPARAM lParam);
	static BOOL CALLBACK FindWindowPartial(HWND hwnd, LPARAM lapram);
	static BOOL CALLBACK GetWindows(HWND hwnd, LPARAM lParam);

	static DKStringArray windows;
	unsigned int currentHandle;
	bool NextHandle();
	bool PrevHandle();

	//Highlight window
	bool highlight;
	void ToggleHighlight();
	void DoHighlight();
	void DrawRectangleOnTransparent(HWND hWnd, const RECT& rc);
	HDC screenDC;

	DKStringArray GetWindows();
	bool WindowExists(const DKString& title);
	bool WaitForWindow(const DKString& title, int timeout);
	bool WaitForHandle(unsigned int index, int timeout);
	bool SetHandle(unsigned int index);
	bool SetHandle(const DKString& clas, const DKString& value);
	bool SetHandle(const DKString& value);
	bool GetString(DKString& text);
	bool SetString(const DKString& text);
	bool GetTop(int& top);
	bool GetLeft(int& left);
	bool GetClass(DKString& clas);
	bool Click();

	bool SendHook(const DKString& window, const DKString& handle, const DKString& data);
};

REGISTER_OBJECT(DKHook, true);
#endif //DKHook_H
#endif //WIN32 || WIN64