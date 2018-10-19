#include "DKPlugin1.h"

//////////////////////
void DKPlugin1::Init()
{
	DKLog("DKPlugin1::Init()\n");
	DKClass::RegisterFunc("DKPlugin1::SomeFunction", &DKPlugin1::SomeFunction, this);
};

///////////////////////////////////////////////////////
bool DKPlugin1::SomeFunction(void* input, void* output)
{
	DKLog("DKPlugin1::SomeFunction()\n");
	return true;
};