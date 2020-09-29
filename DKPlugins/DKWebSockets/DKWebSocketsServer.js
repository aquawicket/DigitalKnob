//////////////////////////////////
function DKWebSocketsServer_Init()
{
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
	DKRemoveEvents(DKWebSocketsServer_OnEvent);
	DKClose("DKWebSocketsServer/DKWebSocketsServer.html");
}

//////////////////////////////////////////
function DKWebSocketsServer_OnEvent(event)
{
	if(event.currentTarget.id == "DKWebSocketsServer_CreateServer"){
		DKWebSocketsServer_CreateServer();
	}
	if(event.currentTarget.id == "DKWebSocketsServer_CloseServer"){
		DKWebSocketsServer_CloseServer();
	}
	if(event.currentTarget.id == "DKWebSocketsServer_MessageToClient"){
		DKWebSocketsServer_MessageToClient();
	}
	if(event.type == "DKWebSockets_OnMessageFromClient"){
		DKWebSocketsServer_OnMessageFromClient(DK_GetValue(event));
	}
}

//////////////////////////////////////////
function DKWebSocketsServer_CreateServer()
{
	if(!DKWidget_GetValue("DKWebSocketsServer_IpAddress")){
		DKWARN("DKWebSocketsServer_CreateServer(): Please enter an ip address\n");
		//return;
	}
	if(!DKWidget_GetValue("DKWebSocketsServer_Port")){
		DKWARN("DKWebSocketsServer_CreateServer(): Please enter a port number\n");
		return;
	}
	console.log("DKWebSocketsServer_CreateServer(): port = "+DKWidget_GetValue("DKWebSocketsServer_Port")+"\n");
	DKWebSockets_CreateServer(DKWidget_GetValue("DKWebSocketsServer_IpAddress"), Number(DKWidget_GetValue("DKWebSocketsServer_Port")));
}

/////////////////////////////////////////
function DKWebSocketsServer_CloseServer()
{
	DKWebSockets_CloseServer();
}

/////////////////////////////////////////////
function DKWebSocketsServer_MessageToClient()
{
	var message = DKWidget_GetValue("DKWebSocketsServer_send");
	DKWebSockets_MessageToClient(message);
}

////////////////////////////////////////////////////////
function DKWebSocketsServer_OnMessageFromClient(message)
{
	DKWidget_SetAttribute("DKWebSocketsServer_receive","value", message);
	//DKWidget_SetValue("DKWebSocketsServer_receive", message);
}