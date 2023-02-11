var server

function DKUWebSocketsServer_init(){
	dk.create("DKUWebSocketsServer");
	//dk.create("DKWebSocketsJS");
	dk.create("DKUWebSocketsServer/DKUWebSocketsServer.html", function(){
		byId("DKUWebSocketsServer_CloseServer").addEventListener("click", DKUWebSocketsServer_onevent);
		byId("DKUWebSocketsServer_CreateServer").addEventListener("click", DKUWebSocketsServer_onevent);
		byId("DKUWebSocketsServer_MessageToClient").addEventListener("click", DKUWebSocketsServer_onevent);
		byId("DKUWebSocketsServer_IpAddress").value = CPP_DK_GetLocalIP();
		byId("DKUWebSocketsServer_Port").value = "80";
	});
}

function DKUWebSocketsServer_end(){
	//window.removeEventListener("DKWebSockets_OnMessageFromClient", DKUWebSocketsServer_onevent);
	byId("DKUWebSocketsServer_CloseServer").removeEventListener("click", DKUWebSocketsServer_onevent);
	byId("DKUWebSocketsServer_CreateServer").removeEventListener("click", DKUWebSocketsServer_onevent);
	byId("DKUWebSocketsServer_MessageToClient").removeEventListener("click", DKUWebSocketsServer_onevent);
	dk.close("DKUWebSocketsServer/DKUWebSocketsServer.html");
}

function DKUWebSocketsServer_onevent(event){
	if(event.currentTarget.id === "DKUWebSocketsServer_CreateServer")
		DKUWebSocketsServer_CreateServer();
	if(event.currentTarget.id === "DKUWebSocketsServer_CloseServer")
		DKUWebSocketsServer_CloseServer();
	if(event.currentTarget.id === "DKUWebSocketsServer_MessageToClient")
		DKUWebSocketsServer_MessageToClient();
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
		//DKUWebSocketsServer_OnMessageFromClient(event);
	}
}

function DKUWebSocketsServer_CreateServer(){
	var local_ip = CPP_DK_GetLocalIP()
	byId("DKUWebSocketsServer_IpAddress").value = local_ip
	
	if(!byId("DKUWebSocketsServer_IpAddress").value){
		console.warn("DKUWebSocketsServer_CreateServer(): Please enter an ip address\n");
		//return;
	}
	if(!byId("DKUWebSocketsServer_Port").value){
		console.warn("DKUWebSocketsServer_CreateServer(): Please enter a port number\n");
		return;
	}
	console.log("DKUWebSocketsServer_CreateServer(): port = "+byId("DKUWebSocketsServer_Port").value+"\n");
	
	//CPP_DKWebSockets_CreateServer(byId("DKUWebSocketsServer_IpAddress").value, Number(byId("DKUWebSocketsServer_Port").value));
	server = new WebSocketServer("ws://"+local_ip+":80");
	
	//server.onclose = function onclose(event){
	server.addEventListener("close", function onclose(event){
		console.log("server.onclose("+event+")");
		console.log("event.value = "+event.value);
	})

	//server.onerror = function onerror(event){
	server.addEventListener("error", function onerror(event){
		console.log("server.onerror("+event+")");
		console.log("event.value = "+event.value);
	})

	//server.oninit = function oninit(event){
	server.addEventListener("init", function oninit(event){
		console.log("server.oninit("+event+")");
		console.log("event.value = "+event.value);
	})

	//server.onmessage = function onmessage(event){
	server.addEventListener("message", function onmessage(event){
		console.log("server.onmessage("+event+")");
		console.log("event.value = "+event.value);
		byId("DKUWebSocketsServer_receive").value = event.value;
	})

	//server.onopen = function onopen(event){
	server.addEventListener("open", function onopen(event){
		console.log("server.onopen("+event+")");
		console.log("event.value = "+event.value);
	})
		
	server.start(local_ip, "80");
}

function DKUWebSocketsServer_CloseServer(){
	server.close()
}

function DKUWebSocketsServer_MessageToClient(){
	var message = byId("DKUWebSocketsServer_send").value;
	server.send(message)
}
