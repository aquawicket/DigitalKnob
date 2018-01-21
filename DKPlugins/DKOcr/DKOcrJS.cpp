#ifdef USE_DKDuktape 
#include "DKOcrJS.h"
#include "DKOcr.h"


////////////////////
void DKOcrJS::Init()
{
	DKLog("DKOcrJS::Init()\n", DKDEBUG);

	DKDuktape::AttachFunction("DKOcr_TestInt", DKOcrJS::TestInt);
	DKDuktape::AttachFunction("DKOcr_TestString", DKOcrJS::TestString);
	DKDuktape::AttachFunction("DKOcr_TestReturnInt", DKOcrJS::TestReturnInt);
	DKDuktape::AttachFunction("DKOcr_TestReturnString", DKOcrJS::TestReturnString);
}


/////////////////////////////////////////
int DKOcrJS::TestInt(duk_context* ctx)
{
	int input = duk_require_int(ctx, 0);
	int output = DKOcr::TestInt(input);
	duk_push_int(ctx, output);
	return 1;
}

////////////////////////////////////////////
int DKOcrJS::TestString(duk_context* ctx)
{
	DKString input = duk_require_string(ctx, 0);
	DKString output = DKOcr::TestString(input);
	duk_push_string(ctx, output.c_str());
	return 1;
}

///////////////////////////////////////////////
int DKOcrJS::TestReturnInt(duk_context* ctx)
{
	int rval = DKOcr::TestReturnInt();
	duk_push_int(ctx, rval);
	return 1;
}

//////////////////////////////////////////////////
int DKOcrJS::TestReturnString(duk_context* ctx)
{
	DKString rval = DKOcr::TestReturnString();
	duk_push_string(ctx, rval.c_str());
	return 1;
}

#endif //USE_DKDuktape