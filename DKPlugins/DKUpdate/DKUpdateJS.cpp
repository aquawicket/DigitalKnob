#ifdef USE_DKDuktape 
#include "DKUpdateJS.h"
#include "DKWindow.h"


///////////////////////
void DKUpdateJS::Init()
{
	DKLog("DKUpdateJS::Init()\n", DKDEBUG);

	DKDuktape::AttachFunction("DKWindow_TestInt", DKUpdateJS::TestInt, 1);
	DKDuktape::AttachFunction("DKWindow_TestString", DKUpdateJS::TestString, 1);
	DKDuktape::AttachFunction("DKWindow_TestReturnInt", DKUpdateJS::TestReturnInt, 0);
	DKDuktape::AttachFunction("DKWindow_TestReturnString", DKUpdateJS::TestReturnString, 0);
}

/////////////////////////////////////////
int DKUpdateJS::TestInt(duk_context* ctx)
{
	//int input = duk_require_int(ctx, 0);
	//int output = DKWindow::TestInt(input);
	//duk_push_int(ctx, output);
	return 1;
}

////////////////////////////////////////////
int DKUpdateJS::TestString(duk_context* ctx)
{
	//DKString input = duk_require_string(ctx, 0);
	//DKString output = DKWindow::TestString(input);
	//duk_push_string(ctx, output.c_str());
	return 1;
}

///////////////////////////////////////////////
int DKUpdateJS::TestReturnInt(duk_context* ctx)
{
	//int rval = DKWindow::TestReturnInt();
	//duk_push_int(ctx, rval);
	return 1;
}

//////////////////////////////////////////////////
int DKUpdateJS::TestReturnString(duk_context* ctx)
{
	//DKString rval = DKWindow::TestReturnString();
	//duk_push_string(ctx, rval.c_str());
	return 1;
}

#endif //USE_DKDuktape