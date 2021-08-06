#include "DKPlugin1.h"

//////////////////////
void DKPlugin1::Init()
{
	DKDEBUGFUNC();
	DKClass::RegisterFunc("DKPlugin1::SomeFunction", &DKPlugin1::SomeFunction, this);
};

///////////////////////////////////////////////////////
bool DKPlugin1::SomeFunction(void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	return true;
};