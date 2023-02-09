function DKWebSocketsServer_init(){
	dk.create("DKWebSockets");
	dk.create("DKWebSocketsJS");
	dk.create("DKWebSockets/DKWebSocketsServer.html", function(){
		window.addEventListener("DKWebSockets_OnMessageFromClient", DKWebSocketsServer_onevent);
		byId("DKWebSocketsServer_CloseServer").addEventListener("click", DKWebSocketsServer_onevent);
		byId("DKWebSocketsServer_CreateServer").addEventListener("click", DKWebSocketsServer_onevent);
		byId("DKWebSocketsServer_MessageToClient").addEventListener("click", DKWebSocketsServer_onevent);
		byId("DKWebSocketsServer_IpAddress").value = CPP_DK_GetLocalIP();
		byId("DKWebSocketsServer_Port").value = "80";
	});
}

function DKWebSocketsServer_end(){
	window.removeEventListener("DKWebSockets_OnMessageFromClient", DKWebSocketsServer_onevent);
	byId("DKWebSocketsServer_CloseServer").removeEventListener("click", DKWebSocketsServer_onevent);
	byId("DKWebSocketsServer_CreateServer").removeEventListener("click", DKWebSocketsServer_onevent);
	byId("DKWebSocketsServer_MessageToClient").removeEventListener("click", DKWebSocketsServer_onevent);
	dk.close("DKWebSocketsServer/DKWebSocketsServer.html");
}

function DKWebSocketsServer_onevent(event){
	if(event.currentTarget.id === "DKWebSocketsServer_CreateServer")
		DKWebSocketsServer_CreateServer();
	if(event.currentTarget.id === "DKWebSocketsServer_CloseServer")
		DKWebSocketsServer_CloseServer();
	if(event.currentTarget.id === "DKWebSocketsServer_MessageToClient")
		DKWebSocketsServer_MessageToClient();
	if(event.type === "DKWebSockets_OnMessageFromClient"){
		console.log("event = "+event)
		console.log("event.type = "+event.type)
		console.log("event.returnValue = "+event.returnValue)
		console.log("event.toString = "+event.toString)
		console.log("event.target = "+event.target)
		console.log("event.target.value = "+event.target.value)
		console.log("event.currentTarget = "+event.currentTarget)
		console.log("event.currentTarget.id = "+event.currentTarget.id)
		//console.log("getParameters = "+event.getParameters())
		//DKWebSocketsServer_OnMessageFromClient(event);
	}
}

function DKWebSocketsServer_CreateServer(){
	byId("DKWebSocketsServer_IpAddress").value = "192.168.1.47" //TEMPORARY
	if(!byId("DKWebSocketsServer_IpAddress").value){
		console.warn("DKWebSocketsServer_CreateServer(): Please enter an ip address\n");
		//return;
	}
	if(!byId("DKWebSocketsServer_Port").value){
		console.warn("DKWebSocketsServer_CreateServer(): Please enter a port number\n");
		return;
	}
	console.log("DKWebSocketsServer_CreateServer(): port = "+byId("DKWebSocketsServer_Port").value+"\n");
	CPP_DKWebSockets_CreateServer(byId("DKWebSocketsServer_IpAddress").value, Number(byId("DKWebSocketsServer_Port").value));
}

function DKWebSocketsServer_CloseServer(){
	CPP_DKWebSockets_CloseServer();
}

function DKWebSocketsServer_MessageToClient(){
	var message = byId("DKWebSocketsServer_send").value;
	CPP_DKWebSockets_MessageToClient(message);
}

function DKWebSocketsServer_OnMessageFromClient(message){
	console.log("DKWebSocketsServer_OnMessageFromClient() = "+message);
	byId("DKWebSocketsServer_receive").value = message;
}