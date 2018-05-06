//TODO - https://www.codeproject.com/Articles/1698/MS-Spy-style-Window-Finder

#ifdef WIN32
#pragma once
#ifndef DKHandles_H
#define DKHandles_H

#include <vector>
#include "DK/DK.h"


////////////////
struct HWNDname{   
   int alias;
   const char* caption;
};

/////////////////////////////////////////////
class DKHandles : public DKObjectT<DKHandles>
{
public:
	bool Init();
	bool End();

	bool Click();
	static bool DisplayInfoOnFoundWindow(HWND hwndFoundWindow);
	bool DoHighlight();
	static bool DoMouseMove();
	static bool DoMouseUp();
	bool GetClass(DKString& clas);
	bool GetLeft(int& left);
	bool GetParent(DKString& parent);
	bool GetString(DKString& text);
	bool GetTop(int& top);
	bool GetWindows(DKStringArray& windows);
	static bool HighlightFoundWindow(HWND hwndFoundWindow);
	bool NextHandle();
	static bool PopulateHandles();
	bool PrevHandle();
	static bool RefreshWindow(HWND hwndWindowToBeRefreshed);
	bool SendHook(const DKString& window, const DKString& handle, const DKString& data);
	bool SetHandle(const DKString& clas, const DKString& value, unsigned int timeout);
	bool SetHandle(const DKString& value, unsigned int timeout);
	bool SetHandle(unsigned int index, unsigned int timeout);
	bool SetString(const DKString& text);
	bool SetWindowHandle(const DKString& title, unsigned int timeout);
	bool ShowWindow(unsigned int flag);
	bool StartSearch();
	bool ToggleHighlight();
	bool WaitForHandle(const DKString& clas, const DKString& value, int timeout);
	bool WaitForHandle(const DKString& value, int timeout);
	bool WaitForHandle(unsigned int index, int timeout);
	bool WaitForWindow(const DKString& title, int timeout);
	bool WindowExists(const DKString& title);
	
	static BOOL CALLBACK EnumChildProc(HWND hwnd, LPARAM lParam);
	static BOOL CALLBACK EnumWindowsProc(HWND hwnd, LPARAM lParam);
	static BOOL CALLBACK FindWindow(HWND hwnd, LPARAM lapram);
	static BOOL CALLBACK FindWindowPartial(HWND hwnd, LPARAM lapram);
	static BOOL CALLBACK GetWindows(HWND hwnd, LPARAM lParam);
	static LRESULT CALLBACK SearchProc(int code, WPARAM wParam, LPARAM lParam);

	static HWND currentHandle;
	static DKStringArray _windows; //list of windows
	bool highlight; //highlight toggle
	static bool searching;
	static WNDPROC prevWndProc;
	static HHOOK hMouseHook;
	static HPEN	rectanglePen;
	static HWND hwndFoundWindow;
	static std::map<HWND,HWND> handles;
};

REGISTER_OBJECT(DKHandles, true);
#endif //DKHandles_H
#endif //WIN32 || WIN64