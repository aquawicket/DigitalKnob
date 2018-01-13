#include "DK/stdafx.h"
#ifdef MAC
#include "DKMac.h"

/*
///////////////////////////////////////////////////
bool DKMac::SetMainThreadNow(unsigned long int& id)
{
	id = (unsigned long int)pthread_self();
	return true;
}

//////////////////////////////////////////////
bool DKMac::GetThreadId(unsigned long int& id)
{
	id = (unsigned long int)pthread_self();
	return true;
}
*/

///////////////////////////////////////
bool DKMac::GetMousePos(int& x, int& y)
{
	//NSPoint mouseLoc;
	//mouseLoc = [NSEvent mouseLocation]; //get current mouse position
	//NSLog(@"Mouse location: %f %f", mouseLoc.x, mouseLoc.y);
	x = 0;//mouseLoc.x;
	y = 0;//mouseLoc.y;
	return true;
}


///////////////////////////////////////////////////
bool DKMac::VirtualMemory(float& virtualMemory)
{
	struct statfs stats;
	if (0 == statfs("/", &stats))
	{
		myFreeSwap = (uint64_t)stats.f_bsize * stats.f_bfree;
	}
	virtualMemory = myFreeSwap;
	return false;
}

///////////////////////////////////////////////////////
bool DKMac::VirtualMemoryUsed(float& virtualMemory)
{
	//TODO
	return false;
}

////////////////////////////////////////////////////////////
bool DKMac::VirtualMemoryUsedByApp(float& virtualMemory)
{
	//TODO
	return false;
}

/////////////////////////////////////////////////////
bool DKMac::PhysicalMemory(float& physicalMemory)
{
	//TODO
	return false;
}

/////////////////////////////////////////////////////////
bool DKMac::PhysicalMemoryUsed(float& physicalMemory)
{
	//TODO
	return false;
}

//////////////////////////////////////////////////////////////
bool DKMac::PhysicalMemoryUsedByApp(float& physicalMemory)
{
	//TODO
	return false;
}

/////////////////////////
void DKMac::CpuInit()
{
	//TODO
	return false;
}

/////////////////////////////////
bool DKMac::CpuUsed(int& cpu)
{
	//TODO
	return false;
}

//////////////////////////////////////
bool DKMac::CpuUsedByApp(int& cpu)
{
	//TODO
	return false;
}

#endif //MAC