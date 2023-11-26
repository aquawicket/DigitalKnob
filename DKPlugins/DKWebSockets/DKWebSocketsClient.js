var websocket;

//////////////////////////////////
function DKWebSocketsClient_init()
{
	dk.create("DKWebSockets/DKWebSocketsClient.html", function(){
		window.addEventListener("DKWebSockets_OnMessageFromServer", DKWebSocketsClient_onevent);
		byId("DKWebSocketsClient_CreateClient").addEventListener("click", DKWebSocketsClient_onevent);
		byId("DKWebSocketsClient_CloseClient").addEventListener("click", DKWebSocketsClient_onevent);
		byId("DKWebSocketsClient_MessageToServer").addEventListener("click", DKWebSocketsClient_onevent);
	});
}

/////////////////////////////////
function DKWebSocketsClient_end()
{
	window.removeEventListener("DKWebSockets_OnMessageFromServer", DKWebSocketsClient_onevent);
	byId("DKWebSocketsClient_CreateClient").removeEventListener("click", DKWebSocketsClient_onevent);
	byId("DKWebSocketsClient_CloseClient").removeEventListener("click", DKWebSocketsClient_onevent);
	byId("DKWebSocketsClient_MessageToServer").removeEventListener("click", DKWebSocketsClient_onevent);
	dk.close("DKWebSockets/DKWebSocketsClient.html");
}

//////////////////////////////////////////
function DKWebSocketsClient_OnEvent(event)
{
	if(event.currentTarget.id === "DKWebSocketsClient_CreateClient"){
		DKWebSocketsClient_CreateClient();
	}
	if(event.currentTarget.id === "DKWebSocketsClient_CloseClient"){
		DKWebSocketsClient_CloseClient();
	}
	if(event.currentTarget.id === "DKWebSocketsClient_MessageToServer"){
		DKWebSocketsClient_MessageToServer();
	}
	if(event.currentTarget.id === "DKWebSockets_OnMessageFromServer"){
		DKWebSocketsClient_OnMessageFromServer(DK_GetValue(event));
	}
}

//////////////////////////////////////////
function DKWebSocketsClient_CreateClient()
{
	if(!DK_GetValue("DKWebSocketsClient_Address")){
		console.warn("DKWebSocketsClient_CreateClient(): please enter an address\n");
		return;
	}
	url = DK_GetValue("DKWebSocketsClient_Address");  //  ws://localhost:3000
	
	if(DK_GetBrowser() === "Rml"){
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
	if(DK_GetBrowser() === "Rml"){
		DKWebSockets_CloseClient();
		return;
	}
	
	//else
	websocket.close();
}

/////////////////////////////////////////////
function DKWebSocketsClient_MessageToServer()
{
	var message = DK_GetValue("DKWebSocketsClient_send");
	if(DK_GetBrowser() === "Rml"){
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