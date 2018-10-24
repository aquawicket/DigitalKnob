#ifdef USE_DKDuktape 
#include "DKDom.h"
#include "DKDomJS.h"


/////////////////////
bool DKDomJS::Init()
{
	DKDuktape::AttachFunction("DKDom_Test", DKDomJS::Test);
	return true;
}

///////////////////////////////////
int DKDomJS::Test(duk_context* ctx)
{
	//TODO
	return 0;
}

#endif //USE_DKDuktape