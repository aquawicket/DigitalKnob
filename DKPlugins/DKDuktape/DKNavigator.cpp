#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKNavigator.h"

////////////////////////
bool DKNavigator::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDuktape_DKNavigator_onLine", DKNavigator::onLine);
	DKDuktape::AttachFunction("CPP_DKDuktape_DKNavigator_platform", DKNavigator::platform);
	DKDuktape::AttachFunction("CPP_DKDuktape_DKNavigator_productSub", DKNavigator::productSub);
	
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
	//TODO - complete this for all OS's
#ifdef WIN64
	duk_push_string(ctx, "Win32");
	return true;
#endif
#ifdef WIN32
	duk_push_string(ctx, "Win64");
	return true;
#endif
#ifdef MAC
	duk_push_string(ctx, "MacIntel");
	return true;
#endif
	DKERROR("DKNavigator::platform(): platform invalid\n");
	return false;
}

/////////////////////////////////////////////
int DKNavigator::productSub(duk_context* ctx)
{
	//TODO
	return false;
}


#endif //USE_DKDuktape