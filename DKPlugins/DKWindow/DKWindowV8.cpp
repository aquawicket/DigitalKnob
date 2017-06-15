#ifdef USE_DKCef
#include "DKWindowV8.h"
#include "DKWindow.h"
#include "DKApp.h"

/////////////////////
void DKWindowV8::Init()
{
	DKLog("DKWindowV8::Init()\n", DKDEBUG);
	DKV8::AttachFunction("Test", DKWindowV8::Test);
}

//////////////////////
void DKWindowV8::End()
{
	DKLog("DKWindowV8::End()\n", DKDEBUG);
}

/////////////////////////////////////////////////////
bool DKWindowV8::Test(CefArgs args, CefReturn retval)
{
	DKLog("DKWindowV8::Test(CefArgs,CefReturn)\n", DKINFO);
	
	DKString data = args->GetString(0);
	DKString result = data;
	retval->SetString(0, result);
	return true;
}


#endif //USE_DKCef