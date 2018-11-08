#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKNavigator.h"

////////////////////////
bool DKNavigator::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKNavigator_onLine", DKNavigator::onLine);
	DKDuktape::AttachFunction("DKNavigator_platform", DKNavigator::platform);
	DKDuktape::AttachFunction("DKNavigator_productSub", DKNavigator::productSub);
	
	DKClass::DKCreate("DKDuktape/DKNavigator.js");
	return true;
}

/////////////////////////////////////////
int DKNavigator::onLine(duk_context* ctx)
{
	//TODO
	return false;
}

///////////////////////////////////////////
int DKNavigator::platform(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////////////
int DKNavigator::productSub(duk_context* ctx)
{
	//TODO
	return false;
}


#endif //USE_DKDuktape