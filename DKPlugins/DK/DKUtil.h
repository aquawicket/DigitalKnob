#pragma once
#ifndef DKUtil_H
#define DKUtil_H

#include "DKString.h"
#ifdef WIN32
	#include <shellapi.h> //DKFile::Execute()
#else
	#include <limits.h>
	#include <stdlib.h>
#endif

#define FRAME_VALUES 30

////////////
class DKUtil
{
public:
	static bool Beep();
	static bool Bin2C(const DKString& input, const DKString& output);
	static bool C2Bin(const DKString hex, std::streamsize size, const char* fileOut);
	static bool CallExit();
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);
	static bool DoubleClick();
	static bool DrawTextOnScreen(const DKString& text);
	static bool Execute(const DKString& command, DKString& rtn);
	static bool FindImageOnScreen(const DKString& file, int& x, int& y);
	static bool GetClipboard(DKString& text);
	static bool GetDate(DKString& date);
	static bool GetFps(unsigned int& fps);
	static bool GetFramerate(int& framerate);
	static bool GetFrames(long& frames);
	static bool GetKey(int& key);
	static bool GetLocalIP(DKString& ip);
	static bool GetMousePos(int& x, int& y);
	static bool GetPixelFromImage(const DKString& image, int x, int y);
	static bool GetPixelFromScreen(int x, int y, int& r, int& g, int& b);
	static bool GetProcessList(DKString& list);
	static bool GetScreenHeight(int& h);
	static bool GetScreenWidth(int& w);
	static bool GetThreadId(unsigned long int& id);
	static bool GetTicks(long& ticks);
	static bool GetTime(DKString& _time);
	static bool GetUsername(DKString& username);
	static bool GetVolume(int& percent);
	static bool InMainThread();
	static bool InitFps();
	static bool InitFramerate();
	static bool KeyIsDown(int& key);
	static bool LeftClick();
	static bool LeftPress();
	static bool LeftRelease();
	static bool LimitFramerate();
	static bool LowPowerMonitor();
	static bool MiddlePress();
	static bool MiddleRelease();
	static bool PhysicalMemory(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsed(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsedByApp(unsigned int& physicalMemory);
	static bool PressKey(const int& key);
	static bool ReleaseKey(const int& key);
	static bool RightClick();
	static bool RightPress();
	static bool RightRelease();
	static bool Round(double& num);
	static bool Run(const DKString& command, const DKString& params);
	static bool SetBrightness(const int& percent);
	static bool SendTick();
	static bool SetClipboard(const DKString& text);
	static bool SetClipboardFiles(const DKString& filelist);
	static bool SetClipboardImage(const DKString& file);
	static bool SetFramerate(const int& fps);
	static bool SetMainThreadNow(); //ONLY SET THIS FROM THE MAIN THREAD ONCE
	static bool SetMousePos(const int& x, const int& y);
	static bool SetVolume(int& percent);
	static bool Sleep(const int& milliseconds);
	static bool StrokeKey(const int& key);
	static bool System(const DKString& command, DKString& ret);
	static bool TurnOffMonitor();
	static bool TurnOnMonitor();
	static bool UpdateFps();
	static bool VirtualMemory(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsed(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsedByApp(unsigned int& virtualMemory);
	static bool WaitForImage(const DKString& file, int timeout);
	static bool WheelDown();
	static bool WheelUp();

	static unsigned long int mainThreadId;

	//Frame limiter
	static long now;
	static long lastFrame;
	static int _fps;
	static int ticksPerFrame;
	static long lastSecond;

	static long frametimes[FRAME_VALUES]; // An array to store frame times:
	static long frametimelast; // Last calculated SDL_GetTicks
	static long framecount; // total frames rendered
	static float framespersecond;
};


#endif //DKUtil_H
