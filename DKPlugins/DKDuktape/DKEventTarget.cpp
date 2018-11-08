#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKEventTarget.h"


//////////////////////////
bool DKEventTarget::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKEventTarget_addEventListner", DKEventTarget::addEventListner);
	DKDuktape::AttachFunction("DKEventTarget_removeEventListner", DKEventTarget::removeEventListner);
	
	DKClass::DKCreate("DKDuktape/DKEventTarget.js");
	return true;
}

////////////////////////////////////////////////////
int DKEventTarget::addEventListner(duk_context* ctx)
{
	//TODO
	return false;
}

///////////////////////////////////////////////////////
int DKEventTarget::removeEventListner(duk_context* ctx)
{
	//TODO
	return false;
}


#endif //USE_DKDuktape