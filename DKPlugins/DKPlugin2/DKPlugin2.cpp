#include "DKPlugin2.h"

//////////////////////
void DKPlugin2::Init()
{
	DKDEBUGFUNC();
	DKClass::RegisterFunc("DKPlugin2::SomeFunction", &DKPlugin2::SomeFunction, this);
};

/////////////////////////////////////////
void* DKPlugin2::SomeFunction(void* data)
{
	DKDEBUGFUNC(data);
	return NULL;
};

