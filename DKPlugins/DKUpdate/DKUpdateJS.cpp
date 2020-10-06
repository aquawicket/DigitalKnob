#ifdef USE_DKDuktape
#include "DKUpdate/DKUpdate.h"
#include "DKUpdate/DKUpdateJS.h"

///////////////////////
bool DKUpdateJS::Init()
{
	DKDEBUGFUNC();
	//DKDuktape::AttachFunction("CPP_DKUpdate_TestInt", DKUpdateJS::TestInt);
	//DKDuktape::AttachFunction("CPP_DKUpdate_TestString", DKUpdateJS::TestString);
	//DKDuktape::AttachFunction("CPP_DKUpdate_TestReturnInt", DKUpdateJS::TestReturnInt);
	//DKDuktape::AttachFunction("CPP_DKUpdate_TestReturnString", DKUpdateJS::TestReturnString);

	DKDuktape::AttachFunction("CPP_DKUpdate_CheckForUpdate", DKUpdateJS::CheckForUpdate);
	DKDuktape::AttachFunction("CPP_DKUpdate_CreateUpdate", DKUpdateJS::CreateUpdate);
	DKDuktape::AttachFunction("CPP_DKUpdate_DoUpdate", DKUpdateJS::DoUpdate);
	return true;
}

/*
/////////////////////////////////////////
int DKUpdateJS::TestInt(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int input = duk_require_int(ctx, 0);
	int output = DKUpdate::TestInt(input);
	duk_push_int(ctx, output);
	return 1;
}

////////////////////////////////////////////
int DKUpdateJS::TestString(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString input = duk_require_string(ctx, 0);
	DKString output = DKUpdate::TestString(input);
	duk_push_string(ctx, output.c_str());
	return 1;
}

///////////////////////////////////////////////
int DKUpdateJS::TestReturnInt(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int rval = DKWindow::TestReturnInt();
	duk_push_int(ctx, rval);
	return 1;
}

//////////////////////////////////////////////////
int DKUpdateJS::TestReturnString(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString rval = DKUpdate::TestReturnString();
	duk_push_string(ctx, rval.c_str());
	return 1;
}
*/


////////////////////////////////////////////////
int DKUpdateJS::CheckForUpdate(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	if(!DKUpdate::CheckForUpdate()){ return 0; }
	return 1;
}

//////////////////////////////////////////////
int DKUpdateJS::CreateUpdate(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	if(!DKUpdate::CreateUpdate()){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKUpdateJS::DoUpdate(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	if(!DKUpdate::DoUpdate()){ return 0; }
	return 1;
}

//////////////////////////////////////////////
int DKUpdateJS::UpdatePlugin(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString url = duk_require_string(ctx, 0);
	if(!DKUpdate::UpdatePlugin(url)){ return 0; }
	return 1;
}

#endif //USE_DKDuktape