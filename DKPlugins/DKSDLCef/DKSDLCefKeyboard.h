#pragma once
#ifndef DKSDLCefKeyboard_H
#define DKSDLCefKeyboard_H

#include "DK/DK.h"

//////////////////////
class DKSDLCefKeyboard
{
public:
	DKSDLCefKeyboard(){};
    int getCefModifiers(int modKeyMask);
};


#endif //DKSDLCefKeyboard_H
