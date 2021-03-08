#ifdef MAC
#pragma once
#ifndef DKMac_H
#define DKMac_H

#define DESKTOP

////////////
class DKMac
{
public:
	static bool GetMousePos(int& x, int& y);
	static bool SetMousePos(const int& x, const int& y);
	static bool GetScreenWidth(int& w);
	static bool GetScreenHeight(int& h);
	static bool LeftPress();
	static bool LeftRelease();
	static bool RightPress();
	static bool RightRelease();
	static bool MiddlePress();
	static bool MiddleRelease();
	static bool PressKey(int key);
	static bool ReleaseKey(int key);

	static bool VirtualMemory(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsed(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsedByApp(unsigned int& virtualMemory);
	static bool PhysicalMemory(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsed(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsedByApp(unsigned int& physicalMemory);
	static bool CpuInit();
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);

	static bool TurnOffMonitor();
	static bool TurnOnMonitor();
	static bool LowPowerMonitor();
};

#endif //DKMac_H
#endif //MAC
