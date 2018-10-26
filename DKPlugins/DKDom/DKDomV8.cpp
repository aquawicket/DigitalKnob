#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomV8.h"

/////////////////////
bool DKDomV8::Init()
{
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKDom_Test", DKDomV8::Test);
	return true;
}

////////////////////
bool DKDomV8::End()
{
	DKDEBUGFUNC();
	return true;
}


//////////////////////////////////////////////////
bool DKDomV8::Test(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	//TODO
	return false;
}


#endif //USE_DKCef