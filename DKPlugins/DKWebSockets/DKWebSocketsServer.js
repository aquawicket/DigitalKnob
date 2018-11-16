//////////////////////////////////
function DKWebSocketsServer_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKWebSockets");
	DKCreate("DKWebSockets/DKWebSocketsServer.html", function(){
		DKAddEvent("DKWebSocketsServer_CloseServer", "click", DKWebSocketsServer_OnEvent);
		DKAddEvent("DKWebSocketsServer_CreateServer", "click", DKWebSocketsServer_OnEvent);
		DKAddEvent("DKWebSocketsServer_MessageToClient", "click", DKWebSocketsServer_OnEvent);
		DKAddEvent("window", "DKWebSockets_OnMessageFromClient", DKWebSocketsServer_OnEvent);
		DKWidget_SetAttribute("DKWebSocketsServer_IpAddress", "value", DK_GetLocalIP());
		DKWidget_SetAttribute("DKWebSocketsServer_Port", "value", "80");
	});
}

/////////////////////////////////
function DKWebSocketsServer_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKWebSocketsServer_OnEvent);
	DKClose("DKWebSocketsServer/DKWebSocketsServer.html");
}

//////////////////////////////////////////
function DKWebSocketsServer_OnEvent(event)
{
	DKDEBUGFUNC(event);
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
	DKDEBUGFUNC();	
	if(!DKWidget_GetValue("DKWebSocketsServer_IpAddress")){
		DKWARN("DKWebSocketsServer_CreateServer(): Please enter an ip address\n");
		//return;
	}
	if(!DKWidget_GetValue("DKWebSocketsServer_Port")){
		DKWARN("DKWebSocketsServer_CreateServer(): Please enter a port number\n");
		return;
	}
	DKINFO("DKWebSocketsServer_CreateServer(): port = "+DKWidget_GetValue("DKWebSocketsServer_Port")+"\n");
	DKWebSockets_CreateServer(DKWidget_GetValue("DKWebSocketsServer_IpAddress"), Number(DKWidget_GetValue("DKWebSocketsServer_Port")));
}

/////////////////////////////////////////
function DKWebSocketsServer_CloseServer()
{
	DKDEBUGFUNC();
	DKWebSockets_CloseServer();
}

/////////////////////////////////////////////
function DKWebSocketsServer_MessageToClient()
{
	DKDEBUGFUNC();
	var message = DKWidget_GetValue("DKWebSocketsServer_send");
	DKWebSockets_MessageToClient(message);
}

////////////////////////////////////////////////////////
function DKWebSocketsServer_OnMessageFromClient(message)
{
	DKDEBUGFUNC(message);
	DKWidget_SetAttribute("DKWebSocketsServer_receive","value", message);
	//DKWidget_SetValue("DKWebSocketsServer_receive", message);
}