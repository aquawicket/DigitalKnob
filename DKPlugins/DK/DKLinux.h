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
	static bool GetMousePos(int& x, int& y);
	static bool Run(const DKString& command);

};

#endif //DKLinux_H
#endif //LINUX