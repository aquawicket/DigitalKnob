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

	static bool VirtualMemory(float& virtualMemory);
	static bool VirtualMemoryUsed(float& virtualMemory);
	static bool VirtualMemoryUsedByApp(float& virtualMemory);
	static bool PhysicalMemory(float& physicalMemory);
	static bool PhysicalMemoryUsed(float& physicalMemory);
	static bool PhysicalMemoryUsedByApp(float& physicalMemory);
	static void CpuInit();
	static bool CpuUsed(int& cpu);
	static bool CpuUsedByApp(int& cpu);
};

#endif //DKMac_H
#endif //MAC