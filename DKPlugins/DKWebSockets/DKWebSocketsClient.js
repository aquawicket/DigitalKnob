var websocket;

//////////////////////////////////
function DKWebSocketsClient_Init()
{
	DKCreate("DKWebSockets/DKWebSocketsClient.html", function(){
		window.addEventListener("DKWebSockets_OnMessageFromServer", DKWebSocketsClient_OnEvent);
		byId("DKWebSocketsClient_CreateClient").addEventListener("click", DKWebSocketsClient_OnEvent);
		byId("DKWebSocketsClient_CloseClient").addEventListener("click", DKWebSocketsClient_OnEvent);
		byId("DKWebSocketsClient_MessageToServer").addEventListener("click", DKWebSocketsClient_OnEvent);
	});
}

/////////////////////////////////
function DKWebSocketsClient_End()
{
	window.removeEventListener("DKWebSockets_OnMessageFromServer", DKWebSocketsClient_OnEvent);
	byId("DKWebSocketsClient_CreateClient").removeEventListener("click", DKWebSocketsClient_OnEvent);
	byId("DKWebSocketsClient_CloseClient").removeEventListener("click", DKWebSocketsClient_OnEvent);
	byId("DKWebSocketsClient_MessageToServer").removeEventListener("click", DKWebSocketsClient_OnEvent);
	DKClose("DKWebSockets/DKWebSocketsClient.html");
}

//////////////////////////////////////////
function DKWebSocketsClient_OnEvent(event)
{
	if(event.currentTarget.id == "DKWebSocketsClient_CreateClient"){
		DKWebSocketsClient_CreateClient();
	}
	if(event.currentTarget.id == "DKWebSocketsClient_CloseClient"){
		DKWebSocketsClient_CloseClient();
	}
	if(event.currentTarget.id == "DKWebSocketsClient_MessageToServer"){
		DKWebSocketsClient_MessageToServer();
	}
	if(event.currentTarget.id == "DKWebSockets_OnMessageFromServer"){
		DKWebSocketsClient_OnMessageFromServer(DK_GetValue(event));
	}
}

//////////////////////////////////////////
function DKWebSocketsClient_CreateClient()
{
	if(!DKWidget_GetValue("DKWebSocketsClient_Address")){
		console.warn("DKWebSocketsClient_CreateClient(): please enter an address\n");
		return;
	}
	url = DKWidget_GetValue("DKWebSocketsClient_Address");  //  ws://localhost:3000
	
	if(DK_GetBrowser() == "RML"){
		console.log("Connecting to WebSocket via C++...\n");
		DKWebSockets_CreateClient(url);
		return;
	}
	
	//else
	console.log("Connecting to WebSocket via javascript...\n");
	websocket = new WebSocket(url);
	websocket.onopen = function(){
		console.log("websocket.onopen");
	}
	websocket.onmessage = function(e){
		console.log("websocket.onmessage");
		DKWebSocketsClient_OnMessageFromServer(e.data.toString());
	}
	websocket.onclose = function(e){
		console.log("websocket.onclose");
	}
	websocket.onerror = function(e){
		console.log("websocket.onerror");
	}
}

/////////////////////////////////////////
function DKWebSocketsClient_CloseClient()
{
	if(DK_GetBrowser() == "RML"){
		DKWebSockets_CloseClient();
		return;
	}
	
	//else
	websocket.close();
}

/////////////////////////////////////////////
function DKWebSocketsClient_MessageToServer()
{
	var message = DKWidget_GetValue("DKWebSocketsClient_send");
	if(DK_GetBrowser() == "RML"){
		DKWebSockets_MessageToServer(message);
		return;
	}
	
	//else
	websocket.send(message);
}

////////////////////////////////////////////////////////
function DKWebSocketsClient_OnMessageFromServer(message)
{
	byId("DKWebSocketsClient_receive").value = message;
}