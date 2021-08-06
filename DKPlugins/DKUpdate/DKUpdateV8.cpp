#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKUpdate/DKUpdate.h"
#include "DKUpdate/DKUpdateV8.h"

///////////////////////
bool DKUpdateV8::Init()
{
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKUpdate_CheckForUpdate", DKUpdateV8::CheckForUpdate);
	DKV8::AttachFunction("DKUpdate_CreateUpdate", DKUpdateV8::CreateUpdate);
	DKV8::AttachFunction("DKUpdate_DoUpdate", DKUpdateV8::DoUpdate);
	DKV8::AttachFunction("DKUpdate_UpdatePlugin", DKUpdateV8::UpdatePlugin);
	return true;
}

//////////////////////
bool DKUpdateV8::End()
{
	DKDEBUGFUNC();
	return true;
}

///////////////////////////////////////////////////////////////
bool DKUpdateV8::CheckForUpdate(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	if(!DKUpdate::CheckForUpdate()){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////
bool DKUpdateV8::CreateUpdate(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	if(!DKUpdate::CreateUpdate()){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKUpdateV8::DoUpdate(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	if(!DKUpdate::DoUpdate()){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////
bool DKUpdateV8::UpdatePlugin(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	if(!DKUpdate::UpdatePlugin(url)){ return false; }
	return true;
}

#endif //USE_DKCef