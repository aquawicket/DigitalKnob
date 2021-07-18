#ifdef WIN32
#pragma once
#ifndef DKWindows_H
#define DKWindows_H

#define DESKTOP
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include "DKString.h"

#include "pdh.h"
const int MB = 1048576; // A megabyte is 1,048,576 bytes
static PDH_HQUERY cpuQuery;
static PDH_HCOUNTER cpuTotal;
static ULARGE_INTEGER lastCPU, lastSysCPU, lastUserCPU;
static int numProcessors;
static HANDLE self;
static bool cpuInit = false;

class DKWindows{
public:
	static bool WINAPI ConsoleHandler(DWORD type);
	static bool CpuInit();
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);
	static bool CreateConsoleHandler();
	static bool DrawTextOnScreen(const DKString& text);
	static bool FindImageOnScreen(const DKString& file, int& x, int& y);
	static bool GetClipboard(DKString& text);
	static bool GetKey(int& key);
	static bool GetLastError(DKString& error);
	static bool GetMousePos(int& x, int& y);
	static bool GetPixelFromImage(const DKString& image, int x, int y);
	static bool GetPixelFromScreen(int x, int y, int& r, int& g, int& b);
	static bool GetProcessList(DKString& list);
	static bool GetScreenWidth(int& w);
	static bool GetScreenHeight(int& h);
	static bool GetUsername(DKString& username);
	static bool GetVolume(int& percent);
	static bool KeyIsDown(const int& key);
	static bool LeftClick();
	static bool LeftPress();
	static bool LeftRelease();
	static bool LowPowerMonitor();
	static bool MiddlePress();
	static bool MiddleRelease();
	static bool PhysicalMemory(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsed(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsedByApp(unsigned int& physicalMemory);
	static bool PressKey(int key);
	static bool RefreshWindowsEnvironment();
	static bool ReleaseKey(int key);
	static bool RightClick();
	static bool RightPress();
	static bool RightRelease();
	static bool Run(const DKString& command);
	static bool SetBrightness(const int& percent);
	static bool SetClipboard(const DKString& text);
	static bool SetClipboardFiles(const DKString& filelist);
	static bool SetClipboardImage(const DKString& file);
	static bool SetMousePos(const int& x, const int& y);
	static void SetTitle();
	static bool SetVolume(int& percent);
	static bool Sleep(int milliseconds);
	static bool TurnOffMonitor();
	static bool TurnOnMonitor();
	static bool VirtualMemory(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsed(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsedByApp(unsigned int& virtualMemory);
	static bool WaitForImage(const DKString& file, int timeout);
	static bool WheelDown();
	static bool WheelUp();
	
	static HINSTANCE hInstance;
	static HWND consoleWindow;
};

#endif //DKWindows_H
#endif //WIN32