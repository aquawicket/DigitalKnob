#ifdef USE_DKDuktape 
#include "DKVncClientJS.h"
#include "DKVncClient.h"


//////////////////////////
bool DKVncClientJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKVncClient_TestInt", DKVncClientJS::TestInt);
	DKDuktape::AttachFunction("CPP_DKVncClient_TestString", DKVncClientJS::TestString);
	DKDuktape::AttachFunction("CPP_DKVncClient_TestReturnInt", DKVncClientJS::TestReturnInt);
	DKDuktape::AttachFunction("CPP_DKVncClient_TestReturnString", DKVncClientJS::TestReturnString);
	return true;
}

////////////////////////////////////////////
int DKVncClientJS::TestInt(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int input = duk_require_int(ctx, 0);
	int output;
	if(!DKVncClient::TestInt(input, output)){ return 0; }
	duk_push_int(ctx, output);
	return 1;
}

///////////////////////////////////////////////
int DKVncClientJS::TestString(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString input = duk_require_string(ctx, 0);
	DKString output;
	if(!DKVncClient::TestString(input, output)){ return 0; }
	duk_push_string(ctx, output.c_str());
	return 1;
}

//////////////////////////////////////////////////
int DKVncClientJS::TestReturnInt(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int rval;
	if(!DKVncClient::TestReturnInt(rval)){ return 0; }
	duk_push_int(ctx, rval);
	return 1;
}

/////////////////////////////////////////////////////
int DKVncClientJS::TestReturnString(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString rval;
	if(!DKVncClient::TestReturnString(rval)){ return 0; }
	duk_push_string(ctx, rval.c_str());
	return 1;
}

#endif //USE_DKDuktape