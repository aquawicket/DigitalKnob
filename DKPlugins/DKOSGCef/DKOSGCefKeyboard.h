#pragma once
#ifndef DKOSGCefKeyboard_H
#define DKOSGCefKeyboard_H
#include "DK.h"
#include <osgGA/GUIEventAdapter>

class DKOSGCefKeyboard
{
public:

	DKOSGCefKeyboard(){};
    unsigned int getCefModifiers(int modKeyMask);
};


#endif //DKOSGCefKeyboard_H
