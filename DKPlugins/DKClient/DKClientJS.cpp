//########## THIS PLUGIN IS OBSOLETE, PLEASE USE DKWebSockets ##########

#ifdef USE_DKDuktape 
#include "DKClient/DKClient.h"
#include "DKClient/DKClientJS.h"


///////////////////////
bool DKClientJS::Init()
{
	DKDuktape::AttachFunction("DKClient_Address", DKClientJS::Address);
	DKDuktape::AttachFunction("DKClient_Connect", DKClientJS::Connect);
	DKDuktape::AttachFunction("DKClient_Send", DKClientJS::Send);
	return true;
}

//////////////////////////////////
int DKClientJS::Address(duk_context* ctx)
{
	DKString path = duk_require_string(ctx, 0);
	DKClient::Instance("DKClient")->_address = path;
	return 1;
}

//////////////////////////////////
int DKClientJS::Connect(duk_context* ctx)
{
	DKString path = duk_require_string(ctx, 0);
	DKClient::Instance("DKClient")->Connect(path);
	return 1;
}

///////////////////////////////
int DKClientJS::Send(duk_context* ctx)
{
	DKString message = duk_require_string(ctx, 0);
	DKClient::Instance("DKClient")->Send(message);
	return 1;
}

#endif //USE_DKDuktape