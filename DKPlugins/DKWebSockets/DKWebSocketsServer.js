//////////////////////////////////
function DKWebSocketsServer_Init()
{
	dk.create("DKWebSockets");
	dk.create("DKWebSockets/DKWebSocketsServer.html", function(){
		window.addEventListener("DKWebSockets_OnMessageFromClient", DKWebSocketsServer_onevent);
		byId("DKWebSocketsServer_CloseServer").addEventListener("click", DKWebSocketsServer_onevent);
		byId("DKWebSocketsServer_CreateServer").addEventListener("click", DKWebSocketsServer_onevent);
		byId("DKWebSocketsServer_MessageToClient").addEventListener("click", DKWebSocketsServer_onevent);
		byId("DKWebSocketsServer_IpAddress").value = DK_GetLocalIP();
		byId("DKWebSocketsServer_Port").value = "80";
	});
}

/////////////////////////////////
function DKWebSocketsServer_End()
{
	window.removeEventListener("DKWebSockets_OnMessageFromClient", DKWebSocketsServer_onevent);
	byId("DKWebSocketsServer_CloseServer").removeEventListener("click", DKWebSocketsServer_onevent);
	byId("DKWebSocketsServer_CreateServer").removeEventListener("click", DKWebSocketsServer_onevent);
	byId("DKWebSocketsServer_MessageToClient").removeEventListener("click", DKWebSocketsServer_onevent);
	dk.close("DKWebSocketsServer/DKWebSocketsServer.html");
}

//////////////////////////////////////////
function DKWebSocketsServer_OnEvent(event)
{
	if(event.currentTarget.id === "DKWebSocketsServer_CreateServer"){
		DKWebSocketsServer_CreateServer();
	}
	if(event.currentTarget.id === "DKWebSocketsServer_CloseServer"){
		DKWebSocketsServer_CloseServer();
	}
	if(event.currentTarget.id === "DKWebSocketsServer_MessageToClient"){
		DKWebSocketsServer_MessageToClient();
	}
	if(event.type === "DKWebSockets_OnMessageFromClient"){
		DKWebSocketsServer_OnMessageFromClient(DK_GetValue(event));
	}
}

//////////////////////////////////////////
function DKWebSocketsServer_CreateServer()
{
	if(!DK_GetValue("DKWebSocketsServer_IpAddress")){
		console.warn("DKWebSocketsServer_CreateServer(): Please enter an ip address\n");
		//return;
	}
	if(!DK_GetValue("DKWebSocketsServer_Port")){
		console.warn("DKWebSocketsServer_CreateServer(): Please enter a port number\n");
		return;
	}
	console.log("DKWebSocketsServer_CreateServer(): port = "+DK_GetValue("DKWebSocketsServer_Port")+"\n");
	DKWebSockets_CreateServer(DK_GetValue("DKWebSocketsServer_IpAddress"), Number(DK_GetValue("DKWebSocketsServer_Port")));
}

/////////////////////////////////////////
function DKWebSocketsServer_CloseServer()
{
	DKWebSockets_CloseServer();
}

/////////////////////////////////////////////
function DKWebSocketsServer_MessageToClient()
{
	var message = DK_GetValue("DKWebSocketsServer_send");
	DKWebSockets_MessageToClient(message);
}

////////////////////////////////////////////////////////
function DKWebSocketsServer_OnMessageFromClient(message)
{
	byId("DKWebSocketsServer_receive").value = message;
}