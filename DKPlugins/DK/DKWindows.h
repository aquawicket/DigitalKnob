#ifdef WIN32
#pragma once
#ifndef DKWindows_H
#define DKWindows_H

#define DESKTOP
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include "DKString.h"

#include "pdh.h"
static PDH_HQUERY cpuQuery;
static PDH_HCOUNTER cpuTotal;
static ULARGE_INTEGER lastCPU, lastSysCPU, lastUserCPU;
static int numProcessors;
static HANDLE self;

////////////////
class DKWindows
{
public:
	static bool SetMainThreadNow(unsigned long int& id);
	static bool GetThreadId(unsigned long int& id);
	static bool SetClipboard(const DKString& text);
	static bool GetClipboard(DKString& text);
	static bool SetClipboardFiles(const DKString& filelist);
	static bool GetPixelFromScreen(int x, int y, int& r, int& g, int& b);
	static bool GetPixelFromImage(const DKString& image, int x, int y);
	static bool ChangeVolume(double nVolume);
	static bool GetVolume(float& volume);
	static bool GetKey(int& key);
	static bool PressKey(int key);
	static bool ReleaseKey(int key);
	static bool WaitForImage(const DKString& file, int timeout);
	static bool FindImageOnScreen(const DKString& file, int& x, int& y);
	static bool SetMousePos(const int& x, const int& y);
	static bool GetMousePos(int& x, int& y);
	static bool LeftClick();
	static bool LeftPress();
	static bool LeftRelease();
	static bool MiddlePress();
	static bool MiddleRelease();
	static bool RightClick();
	static bool RightPress();
	static bool RightRelease();
	static bool WheelUp();
	static bool WheelDown();
	static bool Run(const DKString& command);
	static bool Sleep(int milliseconds);
#if !defined(WIN64)
	static bool RefreshWindowsEnvironment();
#endif
	static bool GetLastError(DKString& error);
	static bool GetProcessList(DKString& list);
	static bool KeyIsDown(int& key);

	//https://stackoverflow.com/questions/63166/how-to-determine-cpu-and-memory-consumption-from-inside-a-process
	static bool VirtualMemory(int& virtualMemory);
	static bool VirtualMemoryUsed(int& virtualMemory);
	static bool VirtualMemoryUsedByApp(int& virtualMemory);
	static bool PhysicalMemory(int& physicalMemory);
	static bool PhysicalMemoryUsed(int& physicalMemory);
	static bool PhysicalMemoryUsedByApp(int& physicalMemory);
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);
};


#endif //DKWindows_H
#endif //WIN32