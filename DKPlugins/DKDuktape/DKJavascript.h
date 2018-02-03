#pragma once
#ifndef DKJavascript_H
#define DKJavascript_H

#include "DK/DK.h"


///////////////////////////////////////////////////
class DKJavascript : public DKObjectT<DKJavascript>
{
public:
	bool Init();
	bool End();
};


REGISTER_OBJECT(DKJavascript, false);

#endif //DKJavascript_H
