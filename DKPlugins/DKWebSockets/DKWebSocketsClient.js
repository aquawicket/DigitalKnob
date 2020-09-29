var websocket;

//////////////////////////////////
function DKWebSocketsClient_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKWebSockets/DKWebSocketsClient.html", function(){
		DKAddEvent("DKWebSocketsClient_CreateClient", "click", DKWebSocketsClient_OnEvent);
		DKAddEvent("DKWebSocketsClient_CloseClient", "click", DKWebSocketsClient_OnEvent);
		DKAddEvent("DKWebSocketsClient_MessageToServer", "click", DKWebSocketsClient_OnEvent);
		DKAddEvent("window", "DKWebSockets_OnMessageFromServer", DKWebSocketsClient_OnEvent);
	});
}

/////////////////////////////////
function DKWebSocketsClient_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKWebSocketsClient_OnEvent);
	DKClose("DKWebSockets/DKWebSocketsClient.html");
}

//////////////////////////////////////////
function DKWebSocketsClient_OnEvent(event)
{
	DKDEBUGFUNC(event);	
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
	DKDEBUGFUNC();
	if(!DKWidget_GetValue("DKWebSocketsClient_Address")){
		DKWARN("DKWebSocketsClient_CreateClient(): please enter an address\n");
		return;
	}
	url = DKWidget_GetValue("DKWebSocketsClient_Address");  //  ws://localhost:3000
	
	if(DK_GetBrowser() == "Rocket"){
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
	DKDEBUGFUNC();
	if(DK_GetBrowser() == "Rocket"){
		DKWebSockets_CloseClient();
		return;
	}
	
	//else
	websocket.close();
}

/////////////////////////////////////////////
function DKWebSocketsClient_MessageToServer()
{
	DKDEBUGFUNC();	
	var message = DKWidget_GetValue("DKWebSocketsClient_send");
	if(DK_GetBrowser() == "Rocket"){
		DKWebSockets_MessageToServer(message);
		return;
	}
	
	//else
	websocket.send(message);
}

////////////////////////////////////////////////////////
function DKWebSocketsClient_OnMessageFromServer(message)
{
	DKDEBUGFUNC(message);
	DKWidget_SetAttribute("DKWebSocketsClient_receive","value", message);
}