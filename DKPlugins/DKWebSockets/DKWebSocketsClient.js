var websocket;

//////////////////////////////////
function DKWebSocketsClient_Init()
{
	DKLog("DKWebSocketsClient_Init()\n", DKDEBUG);
	DKCreate("DKWebSockets/DKWebSocketsClient.html", function(){
		DKAddEvent("DKWebSocketsClient_CreateClient", "click", DKWebSocketsClient_OnEvent);
		DKAddEvent("DKWebSocketsClient_CloseClient", "click", DKWebSocketsClient_OnEvent);
		DKAddEvent("DKWebSocketsClient_MessageToServer", "click", DKWebSocketsClient_OnEvent);
		DKAddEvent("GLOBAL", "DKWebSockets_OnMessageFromServer", DKWebSocketsServer_OnEvent);
	});
}

/////////////////////////////////
function DKWebSocketsClient_End()
{
	DKLog("DKWebSocketsClient_End()\n", DKDEBUG);
	DKRemoveEvents(DKWebSocketsClient_OnEvent);
	DKClose("DKWebSockets/DKWebSocketsClient.html");
}

//////////////////////////////////////////
function DKWebSocketsClient_OnEvent(event)
{
	DKLog("DKWebSocketsClient_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event, "DKWebSocketsClient_CreateClient")){
		DKWebSocketsClient_CreateClient();
	}
	if(DK_Id(event, "DKWebSocketsClient_CloseClient")){
		DKWebSocketsClient_CloseClient();
	}
	if(DK_Id(event, "DKWebSocketsClient_MessageToServer")){
		DKWebSocketsClient_MessageToServer();
	}
	if(DK_Type(event, "DKWebSockets_OnMessageFromServer")){
		DKWebSocketsClient_OnMessageFromServer(DK_GetValue(event));
	}
}

//////////////////////////////////////////
function DKWebSocketsClient_CreateClient()
{
	DKLog("DKWebSocketsClient_CreateClient()\n", DKDEBUG);
	if(!DKWidget_GetValue("DKWebSocketsClient_Address")){
		DKLog("DKWebSocketsClient_CreateClient(): please enter an address\n", DKWARN);
		return;
	}
	url = DKWidget_GetValue("DKWebSocketsClient_Address");  //  ws://localhost:3000
	
	if(DK_GetBrowser == "Rocket"){
		DKLog("Connecting to WebSocket via C++...\n");
		DKWebSockets_CreateClient(url);
		return;
	}
	
	//else
	DKLog("Connecting to WebSocket via javascript...\n");
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
	DKLog("DKWebSocketsClient_CloseClient()\n", DKDEBUG);
	websocket.close();
}

/////////////////////////////////////////////
function DKWebSocketsClient_MessageToServer()
{
	DKLog("DKWebSocketsClient_MessageToServer()\n", DKDEBUG);
	
	var message = DKWidget_GetValue("DKWebSocketsClient_send");
	if(DK_GetBrowser == "Rocket"){
		DKWebSockets_MessageToServer(message);
		return;
	}
	
	//else
	websocket.send(message);
}

////////////////////////////////////////////////////////
function DKWebSocketsClient_OnMessageFromServer(message)
{
	DKLog("DKWebSocketsClient_OnMessageFromServer("+message+")\n", DKDEBUG);
	DKWidget_SetValue("DKWebSocketsClient_receive", message);
}