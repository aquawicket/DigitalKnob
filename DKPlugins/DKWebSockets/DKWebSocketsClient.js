var websocket;

//////////////////////////////////
function DKWebSocketsClient_Init()
{
	DKLog("DKWebSocketsClient_Init()\n", DKDEBUG);
	DKCreate("DKWebSockets/DKWebSocketsClient.html", function(){
		DKAddEvent("DKWebSocketsClient_Connect", "click", DKWebSocketsClient_OnEvent);
		DKAddEvent("DKWebSocketsClient_Disconnect", "click", DKWebSocketsClient_OnEvent);
		DKAddEvent("DKWebSocketsClient_SendMessage", "click", DKWebSocketsClient_OnEvent);
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
	
	if(DK_Id(event, "DKWebSocketsClient_Connect")){
		DKWebSocketsClient_Connect();
	}
	if(DK_Id(event, "DKWebSocketsClient_Disconnect")){
		DKWebSocketsClient_Disconnect();
	}
	if(DK_Id(event, "DKWebSocketsClient_SendMessage")){
		DKWebSocketsClient_SendMessage();
	}
}

/////////////////////////////////////
function DKWebSocketsClient_Connect()
{
	DKLog("DKWebSocketsClient_Connect()\n", DKDEBUG);
	url = "ws://localhost:3000";
	websocket = new WebSocket(url);
	
	websocket.onopen = function(){
		console.log("open web socket");
		//websocket.send("thank you for accepting this Web Socket request");
	}
	websocket.onmessage = function(e){
		//console.log("OpenWebSocket(): Message received: "+e.data.toString());
		DKWebSocketsClient_OnWebSocketMessage(e.data.toString());
	}
	websocket.onclose = function(e){
		console.log("closed");
	}
	websocket.onerror = function(e){
		console.log("error");
	}
}

////////////////////////////////////////
function DKWebSocketsClient_Disconnect()
{
	DKLog("DKWebSocketsClient_Disconnect()\n", DKDEBUG);
	websocket.close();
}

/////////////////////////////////////////
function DKWebSocketsClient_SendMessage()
{
	DKLog("DKWebSocketsClient_SendMessage()\n", DKDEBUG);
	var message = DKWidget_GetValue("DKWebSocketsClient_send");
	websocket.send(message);
}

///////////////////////////////////////////////////////
function DKWebSocketsClient_OnWebSocketMessage(message)
{
	DKLog("DKWebSocketsClient_OnWebSocketMessage("+message+")\n", DKDEBUG);
	DKWidget_SetValue("DKWebSocketsClient_receive", message);
}