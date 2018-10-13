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
int DKWebSocketsJS::SendMessage(duk_context* ctx)
{
	DKString text = duk_require_string(ctx, 0);
	if(!DKWebSockets::SendMessageA(text)){ return 0; }
	return 1;
}

#endif //USE_DKDuktape