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
	static void CpuInit();
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);
	static bool GetClipboard(DKString& text);
	static bool GetMousePos(int& x, int& y);
	static bool GetVolume(float& volume);
	static bool KeyIsDown(int& key);
	static bool LowPowerMonitor();
	static bool PhysicalMemory(float& physicalMemory);
	static bool PhysicalMemoryUsed(float& physicalMemory);
	static bool PhysicalMemoryUsedByApp(float& physicalMemory);
	static bool Run(const DKString& command);
	static bool SetClipboard(DKString& text);
	static bool TurnOffMonitor();
	static bool TurnOnMonitor();
	static bool VirtualMemory(float& virtualMemory);
	static bool VirtualMemoryUsed(float& virtualMemory);
	static bool VirtualMemoryUsedByApp(float& virtualMemory);
};

#endif //DKLinux_H
#endif //LINUX