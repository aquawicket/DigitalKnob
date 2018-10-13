//////////////////////////////////
function DKWebSocketsClient_Init()
{
	DKLog("DKWebSocketsClient_Init()\n", DKDEBUG);
	DKCreate("DKWebSocketsClient/DKWebSocketsClient.html");
}

/////////////////////////////////
function DKWebSocketsClient_End()
{
	DKRemoveEvents(DKWebSocketsClient_OnEvent);
	DKClose("DKWebSocketsClient/DKWebSocketsClient.html");
}

//////////////////////////////////////////
function DKWebSocketsClient_OnEvent(event)
{
	DKLog("DKWebSocketsClient_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);

}