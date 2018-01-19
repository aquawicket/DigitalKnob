#ifdef MAC
#pragma once
#ifndef DKMac_H
#define DKMac_H

#define DESKTOP

////////////
class DKMac
{
public:
	//static bool SetMainThreadNow(unsigned long int& id);
	//static bool GetThreadId(unsigned long int& id);
	static bool GetMousePos(int& x, int& y);

	static bool VirtualMemory(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsed(unsigned long long& virtualMemory);
	static bool VirtualMemoryUsedByApp(unsigned int& virtualMemory);
	static bool PhysicalMemory(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsed(unsigned long long& physicalMemory);
	static bool PhysicalMemoryUsedByApp(unsigned int& physicalMemory);
	static void CpuInit();
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);

	static bool TurnOffMonitor();
	static bool TurnOnMonitor();
	static bool LowPowerMonitor();
};

#endif //DKMac_H
#endif //MAC
