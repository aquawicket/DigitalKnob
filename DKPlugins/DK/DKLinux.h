#ifdef LINUX
#pragma once
#ifndef DKLinux_H
#define DKLinux_H

#define DESKTOP //FIXME: Linux could potentially be an embedded device

#include "DKString.h"

class DKLinux{
public:
	static bool getch(int& key);
	static bool CpuInit();
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);
	static bool GetClipboard(DKString& text);
	static bool GetKey(int& key);
	static bool GetMousePos(int& x, int& y);
	static bool SetMousePos(const int& x, const int& y);
	static bool GetScreenWidth(int& w);
	static bool GetScreenHeight(int& h);
	static bool GetVolume(int& percent);
	static bool KeyIsDown(int& key);
	static bool LeftPress();
	static bool LeftRelease();
	static bool RightPress();
	static bool RightRelease();
	static bool MiddlePress();
	static bool MiddleRelease();
	static bool PressKey(int key);
	static bool ReleaseKey(int key);
	static bool LowPowerMonitor();
	static bool PhysicalMemory(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsed(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsedByApp(unsigned int& physicalMemory);
	static bool Run(const DKString& command);
	static bool SetClipboard(const DKString& text);
	static bool SetVolume(double nVolume);
	static bool StrokeKey(const int& key);
	static bool TurnOffMonitor();
	static bool TurnOnMonitor();
	static bool VirtualMemory(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsed(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsedByApp(unsigned int& virtualMemory);
};

#endif //DKLinux_H
#endif //LINUX
