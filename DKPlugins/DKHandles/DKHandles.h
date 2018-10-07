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

	static bool Click(HWND handle);
	static bool DoMouseMove();
	static bool DoMouseUp();
	static bool GetBottom(HWND handle, int& bottom);
	static bool GetClass(HWND handle, DKString& clas);
	static bool GetIndex(HWND handle, int& index);
	static bool GetLeft(HWND handle, int& left);
	static bool GetParent(HWND handle, DKString& parent);
	static bool GetRight(HWND handle, int& right);
	static bool GetString(HWND handle, DKString& text);
	static bool GetTop(HWND handle, int& top);
	static bool GetWindow(HWND handle, HWND& window);
	static bool GetWindowIndex(HWND handle, int& index);
	static bool GetWindows(DKStringArray& windows);
	static bool HighlightFoundWindow(HWND hwnd);
	static bool HighlightWindow(HWND handle);
	static bool NextHandle(HWND hwnd, HWND& next);
	static bool PopulateHandles();
	static bool PrevHandle(HWND hwnd, HWND& prev);
	static bool RefreshWindow(HWND hwnd);
	//bool SendHook(const DKString& window, const DKString& handle, const DKString& data);
	static bool SetHandle(const DKString& clas, const DKString& value, unsigned int timeout);
	static bool SetHandle(const DKString& value, unsigned int timeout);
	static bool SetHandle(unsigned int index, unsigned int timeout);
	static bool SetString(HWND hwnd, const DKString& text);
	static bool SetWindowHandle(const DKString& title, const unsigned int timeout, HWND& hwnd);
	static bool ShowWindow(HWND hwnd, unsigned int flag);
	static bool StartSearch();
	static bool ToggleHighlight();
	static bool WaitForHandle(const DKString& clas, const DKString& value, int timeout);
	static bool WaitForHandle(const DKString& value, int timeout);
	static bool WaitForHandle(unsigned int index, int timeout);
	static bool WaitForWindow(const DKString& title, int timeout);
	static bool WindowExists(const DKString& title);
	
	static BOOL CALLBACK EnumChildProc(HWND hwnd, LPARAM lParam);
	static BOOL CALLBACK EnumChildProcTemp(HWND hwnd, LPARAM lParam);
	//static BOOL CALLBACK EnumWindowsProc(HWND hwnd, LPARAM lParam);
	static BOOL CALLBACK FindWindow(HWND hwnd, LPARAM lapram);
	static BOOL CALLBACK FindWindowPartial(HWND hwnd, LPARAM lapram);
	static BOOL CALLBACK GetWindows(HWND hwnd, LPARAM lParam);
	static LRESULT CALLBACK SearchProc(int code, WPARAM wParam, LPARAM lParam);

	static HWND currentHandle;
	static DKStringArray _windows; //list of windows
	static bool highlight; //highlight toggle
	static bool searching;
	static WNDPROC prevWndProc;
	static HHOOK hMouseHook;
	static HPEN	rectanglePen;
	static HWND hwndFoundWindow;
	static std::map<HWND,HWND> handles;
	static std::vector<HWND> winhandles;
};

REGISTER_OBJECT(DKHandles, true);
#endif //DKHandles_H
#endif //WIN32 || WIN64