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
};

#endif //DKMac_H
#endif //MAC