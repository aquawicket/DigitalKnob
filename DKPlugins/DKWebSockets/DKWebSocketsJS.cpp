#ifdef USE_DKDuktape 
#include "DKWebSockets.h"
#include "DKWebSocketsJS.h"


///////////////////////////
bool DKWebSocketsJS::Init()
{
	DKDuktape::AttachFunction("DKWebSockets_SendMessage", DKWebSocketsJS::SendMessage);
	DKDuktape::AttachFunction("DKWebSockets_CloseServer", DKWebSocketsJS::CloseServer);
	DKDuktape::AttachFunction("DKWebSockets_CreateServer", DKWebSocketsJS::CreateServer);
	return true;
}

/////////////////////////////////////////////////
int DKWebSocketsJS::CloseServer(duk_context* ctx)
{
	if(!DKWebSockets::CloseServer()){ return 0; }
	return 1;
}

//////////////////////////////////////////////////
int DKWebSocketsJS::CreateServer(duk_context* ctx)
{
	DKString address = duk_require_string(ctx, 0);
	int port = duk_require_int(ctx, 1);
	if(!DKWebSockets::CreateServer(address, port)){ return 0; }
	return 1;
}

/////////////////////////////////////////////////
int DKWebSocketsJS::SendMessage(duk_context* ctx)
{
	DKString text = duk_require_string(ctx, 0);
	if(!DKWebSockets::SendMessageA(text)){ return 0; }
	return 1;
}

#endif //USE_DKDuktape