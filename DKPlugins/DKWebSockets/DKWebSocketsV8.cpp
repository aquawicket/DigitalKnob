#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKWebSockets/DKWebSockets.h"
#include "DKWebSockets/DKWebSocketsV8.h"

///////////////////////////
bool DKWebSocketsV8::Init()
{
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKWebSockets_CloseClient", DKWebSocketsV8::CloseClient);
	DKV8::AttachFunction("DKWebSockets_CloseServer", DKWebSocketsV8::CloseServer);
	DKV8::AttachFunction("DKWebSockets_CreateClient", DKWebSocketsV8::CreateClient);
	DKV8::AttachFunction("DKWebSockets_CreateServer", DKWebSocketsV8::CreateServer);
	DKV8::AttachFunction("DKWebSockets_MessageToClient", DKWebSocketsV8::MessageToClient);
	DKV8::AttachFunction("DKWebSockets_MessageToServer", DKWebSocketsV8::MessageToServer);
	return true;
}

//////////////////////////
bool DKWebSocketsV8::End()
{
	DKDEBUGFUNC();
	return true;
}

////////////////////////////////////////////////////////////////
bool DKWebSocketsV8::CloseClient(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	if(!DKWebSockets::CloseClient()){ return false; }
	return true;
}

////////////////////////////////////////////////////////////////
bool DKWebSocketsV8::CloseServer(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	if(!DKWebSockets::CloseServer()){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKWebSocketsV8::CreateClient(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString address = args->GetString(0);
	if(!DKWebSockets::CreateClient(address)){ return false; }
	return true;
}

////////////////////////////////////////////////////////////////
bool DKWebSocketsV8::CreateServer(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString address = args->GetString(0);
	int port = args->GetInt(1);
	if(!DKWebSockets::CreateServer(address, port)){ return false; }
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKWebSocketsV8::MessageToClient(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString text = args->GetString(0);
	if(!DKWebSockets::MessageToClient(text)){ return false; }
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKWebSocketsV8::MessageToServer(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString text = args->GetString(0);
	if(!DKWebSockets::MessageToServer(text)){ return false; }
	return true;
}


#endif //USE_DKCef