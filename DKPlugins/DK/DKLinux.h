#ifdef LINUX
#pragma once
#ifndef DKLinux_H
#define DKLinux_H

#define DESKTOP

#include "DKString.h"

/////////////
class DKLinux
{
public:
	static bool SetVolume(double nVolume);
	static bool CpuInit();
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);
	static bool GetClipboard(DKString& text);
	static bool GetMousePos(int& x, int& y);
	static bool GetScreenWidth(int& w);
	static bool GetScreenHeight(int& h);
	static bool GetVolume(float& volume);
	static bool KeyIsDown(int& key);
	static bool LowPowerMonitor();
	static bool PhysicalMemory(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsed(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsedByApp(unsigned int& physicalMemory);
	static bool Run(const DKString& command);
	static bool SetClipboard(const DKString& text);
	static bool TurnOffMonitor();
	static bool TurnOnMonitor();
	static bool VirtualMemory(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsed(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsedByApp(unsigned int& virtualMemory);
};

#endif //DKLinux_H
#endif //LINUX