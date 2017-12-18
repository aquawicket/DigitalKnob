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

#define FRAME_VALUES 30

////////////
class DKUtil
{
public:
	static bool SetMainThreadNow(); //ONLY SET THIS FROM THE MAIN THREAD ONCE
	static bool GetThreadId(unsigned long int& id);
	static bool SetClipboard(DKString& text);
	static bool GetClipboard(DKString& text);
	static bool SetClipboardFiles(const DKString& filelist);
	static bool GetPixelFromScreen(int x, int y, int& r, int& g, int& b);
	static bool GetPixelFromImage(const DKString& image, int x, int y);
	static bool WaitForImage(const DKString& file, int timeout);
	static bool FindImageOnScreen(const DKString& file, int& x, int& y);
	static bool SetMousePos(const int& x, const int& y);
	static bool GetMousePos(int& x, int& y);
	static bool LeftClick();
	static bool LeftPress();
	static bool LeftRelease();
	static bool MiddlePress();
	static bool MiddleRelease();
	static bool DoubleClick();
	static bool RightClick();
	static bool RightPress();
	static bool RightRelease();
	static bool WheelUp();
	static bool WheelDown();
	static bool Sleep(int milliseconds);
	static bool GetTicks(UINT32& ticks);
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
	static bool Run(const DKString& command, const DKString& params);
	static bool System(const DKString& command);
	static bool Execute(const DKString& command, DKString& rtn);
	static bool InMainThread();
	static bool Round(double& num);
	static bool Beep();
	static bool GetProcessList(DKString& list);
	static bool KeyIsDown(int& key);
	static int GetFramerate();
	static void SetFramerate(int fps);

	//https://stackoverflow.com/questions/63166/how-to-determine-cpu-and-memory-consumption-from-inside-a-process
	static bool VirtualMemory(float& virtualMemory);
	static bool VirtualMemoryUsed(float& virtualMemory);
	static bool VirtualMemoryUsedByApp(float& virtualMemory);
	static bool PhysicalMemory(float& physicalMemory);
	static bool PhysicalMemoryUsed(float& physicalMemory);
	static bool PhysicalMemoryUsedByApp(float& physicalMemory);
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);

	//Frame limiter
	static UINT32 now;
	static UINT32 lastFrame;
	static int _fps;
	static int ticksPerFrame;
	static UINT32 lastSecond;

	//Fps counter
	static void InitFps();
	static void UpdateFps();
	static void GetFps(unsigned int& fps);


	static unsigned long int mainThreadId;

	static UINT32 frametimes[FRAME_VALUES]; // An array to store frame times:
	static UINT32 frametimelast; // Last calculated SDL_GetTicks
	static UINT32 framecount; // total frames rendered
	static float framespersecond;
};


#endif //DKUtil_H
