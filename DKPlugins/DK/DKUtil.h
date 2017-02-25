#pragma once
#ifndef DKUtil_H
#define DKUtil_H

#include "DKString.h"
#ifndef WIN32
	#include <limits.h>
	#include <stdlib.h>
#else
	#include <shellapi.h> //DKFile::Execute()
#endif

////////////
class DKUtil
{
public:
	static bool SetMainThreadNow(); //ONLY SET THIS FROM THE MAIN THREAD ONCE
	static bool GetThreadId(int& id);
	static bool SetClipboard(const DKString& text);
	static bool GetClipboard(DKString& text);
	static bool GetPixelFromScreen(int x, int y, int& r, int& g, int& b);
	static bool GetPixelFromImage(const DKString& image, int x, int y);
	static bool WaitForImage(const DKString& file, int timeout);
	static bool FindImageOnScreen(const DKString& file, int& x, int& y);
	static bool SetMousePos(const int& x, const int& y);
	static bool GetMousePos(int& x, int& y);
	static bool LeftClick();
	static bool DoubleClick();
	static bool RightClick();
	static bool Sleep(int milliseconds);
	static bool GetTicks(double& ticks);
	static bool GetTime(DKString& _time);
	static bool GetDate(DKString& date);
	static bool GetKey(int& key);
	static bool PressKey(int key);
	static bool ReleaseKey(int key);
	static bool StrokeKey(int key);
	static bool round(double& num);
	static bool GetLocalIP(DKString& ip);
	static bool ChangeVolume(double& volume);
	static bool GetVolume(float& volume);
	static bool Bin2C(const DKString& input, const DKString& output);
	static bool C2Bin(const unsigned char* header, const long int size, const DKString& output);
	static bool Run(const DKString& command);
	static bool System(const DKString& command);
	static bool Execute(const DKString& command, DKString& rtn);
	static bool InMainThread();
	static bool Round(double& num);
	static bool Beep();
	static bool GetProcessList(DKString& list);

#ifdef MAC
	static pthread_t mainThreadId;
#else
	static int mainThreadId;
#endif
};


#endif //DKUtil_H
