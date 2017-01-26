#ifdef WIN32
#pragma once
#ifndef DKWindows_H
#define DKWindows_H
#define DESKTOP

//#include <boost/asio/io_service.hpp>  //This needs to come before <windows.h>

#define WIN32_LEAN_AND_MEAN
//#include <Winsock2.h> //does this fix needing boost/asio to come before windows.h?
#include <windows.h>
#include "DKString.h"


////////////////
class DKWindows
{
public:
	static bool SetClipboard(const DKString& text);
	static bool GetClipboard(DKString& text);
	static bool GetPixelFromScreen(int x, int y, int& r, int& g, int& b);
	static bool GetPixelFromImage(const DKString& image, int x, int y);
	static bool ChangeVolume(double nVolume);
	static float GetVolume();
	static int GetKey();
	static bool PressKey(int key);
	static bool ReleaseKey(int key);
	static bool WaitForImage(const DKString& file, int timeout);
	static bool FindImageOnScreen(const DKString& file, int& x, int& y);
	static bool SetMousePos(const int& x, const int& y);
	static bool GetMousePos(int& x, int& y);
	static bool LeftClick();
	static bool RightClick();
	static bool Sleep(int milliseconds);
#if !defined(WIN64)
	static void RefreshWindowsEnvironment();
#endif
	static DKString GetLastError();
};


#endif //DKWindows_H
#endif //WIN32