//TODO - https://www.codeproject.com/Articles/1698/MS-Spy-style-Window-Finder

#ifdef WIN32
#pragma once
#ifndef DKWinSpy_H
#define DKWinSpy_H

#include "DK/DK.h"

///////////////////////////////////////////
class DKWinSpy : public DKObjectT<DKWinSpy>
{
public:
	bool Init();
	bool End();
	
};

REGISTER_OBJECT(DKWinSpy, true);
#endif //DKWinSpy_H
#endif //WIN32 || WIN64