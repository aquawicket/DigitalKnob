var websocket;

function DKUWebSocketsClient_init(){
	dk.create("DKWebSockets/DKUWebSocketsClient.html", function(){
		window.addEventListener("DKWebSockets_OnMessageFromServer", DKUWebSocketsClient_onevent);
		byId("DKUWebSocketsClient_CreateClient").addEventListener("click", DKUWebSocketsClient_onevent);
		byId("DKUWebSocketsClient_CloseClient").addEventListener("click", DKUWebSocketsClient_onevent);
		byId("DKUWebSocketsClient_MessageToServer").addEventListener("click", DKUWebSocketsClient_onevent);
	});
}

function DKUWebSocketsClient_end(){
	window.removeEventListener("DKWebSockets_OnMessageFromServer", DKUWebSocketsClient_onevent);
	byId("DKUWebSocketsClient_CreateClient").removeEventListener("click", DKUWebSocketsClient_onevent);
	byId("DKUWebSocketsClient_CloseClient").removeEventListener("click", DKUWebSocketsClient_onevent);
	byId("DKUWebSocketsClient_MessageToServer").removeEventListener("click", DKUWebSocketsClient_onevent);
	dk.close("DKWebSockets/DKUWebSocketsClient.html");
}

function DKUWebSocketsClient_onevent(event){
	if(event.currentTarget.id === "DKUWebSocketsClient_CreateClient")
		DKUWebSocketsClient_CreateClient();
	if(event.currentTarget.id === "DKUWebSocketsClient_CloseClient")
		DKUWebSocketsClient_CloseClient();
	if(event.currentTarget.id === "DKUWebSocketsClient_MessageToServer")
		DKUWebSocketsClient_MessageToServer();
	if(event.currentTarget.id === "DKWebSockets_OnMessageFromServer"){
		console.log("event = "+event);
		DKUWebSocketsClient_OnMessageFromServer(event);
	}
}

function DKUWebSocketsClient_CreateClient(){
	byId("DKUWebSocketsClient_Address").value = "ws://192.168.1.47:80"  //TEMPORARY
	if(!byId("DKUWebSocketsClient_Address").value){
		console.warn("DKUWebSocketsClient_CreateClient(): please enter an address\n");
		return;
	}
	url = byId("DKUWebSocketsClient_Address").value;  //  ws://localhost:3000
	
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
		CPP_DKUWebSocketsClient_OnMessageFromServer(e.data.toString());
	}
	websocket.onclose = function(e){
		console.log("websocket.onclose");
	}
	websocket.onerror = function(e){
		console.log("websocket.onerror");
	}
}

function DKUWebSocketsClient_CloseClient(){
	if(DUKTAPE){
		CPP_DKWebSockets_CloseClient();
		return;
	}
	
	//else
	websocket.close();
}

function DKUWebSocketsClient_MessageToServer(){
	var message = byId("DKUWebSocketsClient_send").value;
	console.log("sending ... \n"+message)
	if(DUKTAPE){
		CPP_DKWebSockets_MessageToServer(message);
		return;
	}
	
	//else
	websocket.send(message);
}

function DKUWebSocketsClient_OnMessageFromServer(message){
	byId("DKUWebSocketsClient_receive").value = message;
}