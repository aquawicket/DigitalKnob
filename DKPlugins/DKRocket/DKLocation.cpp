#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKRocket/DKLocation.h"


///////////////////////
bool DKLocation::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKLocation_href", DKLocation::href);
	
	DKClass::DKCreate("DKDuktape/DKLocation.js");
	return true;
}

//////////////////////////////////////
int DKLocation::href(duk_context* ctx)
{
	//TODO
	return false;
}

#endif //USE_DKDuktape