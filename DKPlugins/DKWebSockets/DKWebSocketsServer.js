//////////////////////////////////
function DKWebSocketsServer_Init()
{
	DKCreate("DKWebSockets");
	DKCreate("DKWebSockets/DKWebSocketsServer.html", function(){
		window.addEventListener("DKWebSockets_OnMessageFromClient", DKWebSocketsServer_OnEvent);
		byId("DKWebSocketsServer_CloseServer").addEventListener("click", DKWebSocketsServer_OnEvent);
		byId("DKWebSocketsServer_CreateServer").addEventListener("click", DKWebSocketsServer_OnEvent);
		byId("DKWebSocketsServer_MessageToClient").addEventListener("click", DKWebSocketsServer_OnEvent);
		byId("DKWebSocketsServer_IpAddress").value = DK_GetLocalIP();
		byId("DKWebSocketsServer_Port").value = "80";
	});
}

/////////////////////////////////
function DKWebSocketsServer_End()
{
	window.removeEventListener("DKWebSockets_OnMessageFromClient", DKWebSocketsServer_OnEvent);
	byId("DKWebSocketsServer_CloseServer").removeEventListener("click", DKWebSocketsServer_OnEvent);
	byId("DKWebSocketsServer_CreateServer").removeEventListener("click", DKWebSocketsServer_OnEvent);
	byId("DKWebSocketsServer_MessageToClient").removeEventListener("click", DKWebSocketsServer_OnEvent);
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
		console.warn("DKWebSocketsServer_CreateServer(): Please enter an ip address\n");
		//return;
	}
	if(!DKWidget_GetValue("DKWebSocketsServer_Port")){
		console.warn("DKWebSocketsServer_CreateServer(): Please enter a port number\n");
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
	byId("DKWebSocketsServer_receive").value = message;
	//DKWidget_SetValue("DKWebSocketsServer_receive", message);
}