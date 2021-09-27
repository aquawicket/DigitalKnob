#pragma once
#ifndef DKJerryscript_H
#define DKJerryscript_H
#include "DK/DK.h"
#include "jerryscript.h"
//#include "DK/DKEvents.h"

class DKJerryscript : public DKObjectT<DKJerryscript>{
public:
	bool Init();
	bool End();
	
	//static bool AttachFunction(const DKString& name, const DKString& vars);

};


REGISTER_OBJECT(DKJerryscript, true);

#endif //DKJerryscript_H
