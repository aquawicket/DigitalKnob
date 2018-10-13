//////////////////////////////////
function DKWebSocketsServer_Init()
{
	DKLog("DKWebSocketsServer_Init()\n", DKDEBUG);
	DKCreate("DKWebSocketsServer/DKWebSocketsServer.html");
}

/////////////////////////////////
function DKWebSocketsServer_End()
{
	DKRemoveEvents(DKWebSocketsServer_OnEvent);
	DKClose("DKWebSocketsServer/DKWebSocketsServer.html");
}

//////////////////////////////////////////
function DKWebSocketsServer_OnEvent(event)
{
	DKLog("DKWebSocketsServer_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);

}