#ifdef USE_DKDuktape 
#include "DKWebSockets.h"
#include "DKWebSocketsJS.h"


///////////////////////////
bool DKWebSocketsJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKCPP_DKWebSockets_CloseClient", DKWebSocketsJS::CloseClient);
	DKDuktape::AttachFunction("DKCPP_DKWebSockets_CloseServer", DKWebSocketsJS::CloseServer);
	DKDuktape::AttachFunction("DKCPP_DKWebSockets_CreateClient", DKWebSocketsJS::CreateClient);
	DKDuktape::AttachFunction("DKCPP_DKWebSockets_CreateServer", DKWebSocketsJS::CreateServer);
	DKDuktape::AttachFunction("DKCPP_DKWebSockets_MessageToClient", DKWebSocketsJS::MessageToClient);
	DKDuktape::AttachFunction("DKCPP_DKWebSockets_MessageToServer", DKWebSocketsJS::MessageToServer);
	return true;
}

/////////////////////////////////////////////////
int DKWebSocketsJS::CloseClient(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	if(!DKWebSockets::CloseClient()){ return 0; }
	return 1;
}

/////////////////////////////////////////////////
int DKWebSocketsJS::CloseServer(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	if(!DKWebSockets::CloseServer()){ return 0; }
	return 1;
}

//////////////////////////////////////////////////
int DKWebSocketsJS::CreateClient(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	if(!DKWebSockets::CreateClient(address)){ return 0; }
	return 1;
}

//////////////////////////////////////////////////
int DKWebSocketsJS::CreateServer(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	int port = duk_require_int(ctx, 1);
	if(!DKWebSockets::CreateServer(address, port)){ return 0; }
	return 1;
}

/////////////////////////////////////////////////////
int DKWebSocketsJS::MessageToClient(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString text = duk_require_string(ctx, 0);
	if(!DKWebSockets::MessageToClient(text)){ return 0; }
	return 1;
}

/////////////////////////////////////////////////////
int DKWebSocketsJS::MessageToServer(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString text = duk_require_string(ctx, 0);
	if(!DKWebSockets::MessageToServer(text)){ return 0; }
	return 1;
}

#endif //USE_DKDuktape