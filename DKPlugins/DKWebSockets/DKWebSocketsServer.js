//////////////////////////////////
function DKWebSocketsServer_Init()
{
	DKLog("DKWebSocketsServer_Init()\n", DKDEBUG);
	DKCreate("DKWebSockets");
	DKCreate("DKWebSockets/DKWebSocketsServer.html", function(){
		DKAddEvent("DKWebSocketsServer_CloseServer", "click", DKWebSocketsServer_OnEvent);
		DKAddEvent("DKWebSocketsServer_CreateServer", "click", DKWebSocketsServer_OnEvent);
		DKAddEvent("DKWebSocketsServer_MessageToClient", "click", DKWebSocketsServer_OnEvent);
		DKAddEvent("GLOBAL", "DKWebSockets_OnMessageFromClient", DKWebSocketsServer_OnEvent);
	});
}

/////////////////////////////////
function DKWebSocketsServer_End()
{
	DKLog("DKWebSocketsServer_End()\n", DKDEBUG);
	DKRemoveEvents(DKWebSocketsServer_OnEvent);
	DKClose("DKWebSocketsServer/DKWebSocketsServer.html");
}

//////////////////////////////////////////
function DKWebSocketsServer_OnEvent(event)
{
	DKLog("DKWebSocketsServer_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);

	if(DK_Id(event, "DKWebSocketsServer_CreateServer")){
		DKWebSocketsServer_CreateServer();
	}
	if(DK_Id(event, "DKWebSocketsServer_CloseServer")){
		DKWebSocketsServer_CloseServer();
	}
	if(DK_Id(event, "DKWebSocketsServer_MessageToClient")){
		DKWebSocketsServer_MessageToClient();
	}
	if(DK_Type(event, "DKWebSockets_OnMessageFromClient")){
		DKWebSocketsServer_OnMessageFromClient(DK_GetValue(event));
	}
}

//////////////////////////////////////////
function DKWebSocketsServer_CreateServer()
{
	DKLog("DKWebSocketsServer_CreateServer()\n", DKDEBUG);
	
	if(!DKWidget_GetValue("DKWebSocketsServer_IpAddress")){
		DKLog("DKWebSocketsServer_CreateServer(): Please enter an ip address\n", DKWARN);
		//return;
	}
	if(!DKWidget_GetValue("DKWebSocketsServer_Port")){
		DKLog("DKWebSocketsServer_CreateServer(): Please enter a port number\n", DKWARN);
		return;
	}
	DKLog("DKWebSocketsServer_CreateServer(): port = "+DKWidget_GetValue("DKWebSocketsServer_Port")+"\n");
	DKWebSockets_CreateServer(DKWidget_GetValue("DKWebSocketsServer_IpAddress"), Number(DKWidget_GetValue("DKWebSocketsServer_Port")));
}

/////////////////////////////////////////
function DKWebSocketsServer_CloseServer()
{
	DKLog("DKWebSocketsServer_CloseServer()\n", DKDEBUG);
	DKWebSockets_CloseServer();
}

/////////////////////////////////////////////
function DKWebSocketsServer_MessageToClient()
{
	DKLog("DKWebSocketsServer_MessageToClient()\n", DKDEBUG);
	var message = DKWidget_GetValue("DKWebSocketsServer_send");
	DKWebSockets_MessageToClient(message);
}

////////////////////////////////////////////////////////
function DKWebSocketsServer_OnMessageFromClient(message)
{
	DKLog("DKWebSocketsServer_OnMessageFromClient("+message+")\n");
	DKWidget_SetValue("DKWebSocketsServer_receive", message);
}