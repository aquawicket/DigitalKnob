#ifdef USE_DKDuktape 
#include "DKWebSockets.h"
#include "DKWebSocketsJS.h"


///////////////////////////
bool DKWebSocketsJS::Init()
{
	DKDuktape::AttachFunction("DKWebSockets_SendMessage", DKWebSocketsJS::SendMessage);
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
	int port = duk_require_int(ctx, 0);
	if(!DKWebSockets::CreateServer(port)){ return 0; }
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