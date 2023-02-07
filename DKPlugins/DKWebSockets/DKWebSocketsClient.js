var websocket;

function DKWebSocketsClient_init(){
	dk.create("DKWebSockets/DKWebSocketsClient.html", function(){
		window.addEventListener("DKWebSockets_OnMessageFromServer", DKWebSocketsClient_onevent);
		byId("DKWebSocketsClient_CreateClient").addEventListener("click", DKWebSocketsClient_onevent);
		byId("DKWebSocketsClient_CloseClient").addEventListener("click", DKWebSocketsClient_onevent);
		byId("DKWebSocketsClient_MessageToServer").addEventListener("click", DKWebSocketsClient_onevent);
	});
}

function DKWebSocketsClient_end(){
	window.removeEventListener("DKWebSockets_OnMessageFromServer", DKWebSocketsClient_onevent);
	byId("DKWebSocketsClient_CreateClient").removeEventListener("click", DKWebSocketsClient_onevent);
	byId("DKWebSocketsClient_CloseClient").removeEventListener("click", DKWebSocketsClient_onevent);
	byId("DKWebSocketsClient_MessageToServer").removeEventListener("click", DKWebSocketsClient_onevent);
	dk.close("DKWebSockets/DKWebSocketsClient.html");
}

function DKWebSocketsClient_onevent(event){
	if(event.currentTarget.id === "DKWebSocketsClient_CreateClient")
		DKWebSocketsClient_CreateClient();
	if(event.currentTarget.id === "DKWebSocketsClient_CloseClient")
		DKWebSocketsClient_CloseClient();
	if(event.currentTarget.id === "DKWebSocketsClient_MessageToServer")
		DKWebSocketsClient_MessageToServer();
	if(event.currentTarget.id === "DKWebSockets_OnMessageFromServer"){
		console.log("event = "+event);
		DKWebSocketsClient_OnMessageFromServer(event);
	}
}

function DKWebSocketsClient_CreateClient(){
	byId("DKWebSocketsClient_Address").value = "ws://192.168.1.47:80"  //TEMPORARY
	if(!byId("DKWebSocketsClient_Address").value){
		console.warn("DKWebSocketsClient_CreateClient(): please enter an address\n");
		return;
	}
	url = byId("DKWebSocketsClient_Address").value;  //  ws://localhost:3000
	
	if(DUKTAPE){
		console.log("Connecting to WebSocket via C++...\n");
		CPP_DKWebSockets_CreateClient(url);
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
		CPP_DKWebSocketsClient_OnMessageFromServer(e.data.toString());
	}
	websocket.onclose = function(e){
		console.log("websocket.onclose");
	}
	websocket.onerror = function(e){
		console.log("websocket.onerror");
	}
}

function DKWebSocketsClient_CloseClient(){
	if(DUKTAPE){
		CPP_DKWebSockets_CloseClient();
		return;
	}
	
	//else
	websocket.close();
}

function DKWebSocketsClient_MessageToServer(){
	var message = byId("DKWebSocketsClient_send").value;
	console.log("sending ... \n"+message)
	if(DUKTAPE){
		CPP_DKWebSockets_MessageToServer(message);
		return;
	}
	
	//else
	websocket.send(message);
}

function DKWebSocketsClient_OnMessageFromServer(message){
	byId("DKWebSocketsClient_receive").value = message;
}