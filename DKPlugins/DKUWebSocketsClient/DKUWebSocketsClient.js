var client;

function DKUWebSocketsClient_init(){
	dk.create("DKUWebSocketsClient/DKUWebSocketsClient.html", function(){
		byId("DKUWebSocketsClient_CreateClient").addEventListener("click", DKUWebSocketsClient_onevent);
		byId("DKUWebSocketsClient_CloseClient").addEventListener("click", DKUWebSocketsClient_onevent);
		byId("DKUWebSocketsClient_MessageToServer").addEventListener("click", DKUWebSocketsClient_onevent);
	});
}

function DKUWebSocketsClient_end(){
	byId("DKUWebSocketsClient_CreateClient").removeEventListener("click", DKUWebSocketsClient_onevent);
	byId("DKUWebSocketsClient_CloseClient").removeEventListener("click", DKUWebSocketsClient_onevent);
	byId("DKUWebSocketsClient_MessageToServer").removeEventListener("click", DKUWebSocketsClient_onevent);
	dk.close("DKUWebSocketsClient/DKUWebSocketsClient.html");
}

function DKUWebSocketsClient_onevent(event){
	if(event.currentTarget.id === "DKUWebSocketsClient_CreateClient")
		DKUWebSocketsClient_CreateClient();
	if(event.currentTarget.id === "DKUWebSocketsClient_CloseClient")
		DKUWebSocketsClient_CloseClient();
	if(event.currentTarget.id === "DKUWebSocketsClient_MessageToServer")
		DKUWebSocketsClient_MessageToServer();
}

function DKUWebSocketsClient_CreateClient(){
	byId("DKUWebSocketsClient_Address").value = "ws://192.168.1.47:80"  //TEMPORARY
	if(!byId("DKUWebSocketsClient_Address").value){
		console.warn("DKUWebSocketsClient_CreateClient(): please enter an address\n");
		return;
	}
	url = byId("DKUWebSocketsClient_Address").value;

	client = new WebSocket(url);
	
	//client.onclose = function onclose(event){
	client.addEventListener("close", function onclose(event){
		console.log("client.onclose("+event+")");
		console.log("event.value = "+event.value);
	})
	
	//client.onerror = function onerror(event){
	client.addEventListener("error", function onerror(event){
		console.log("client.onerror("+event+")");
		console.log("event.value = "+event.value);
	})
	
	//client.oninit = function oninit(event){
	client.addEventListener("init", function oninit(event){
		console.log("client.oninit("+event+")");
		console.log("event.value = "+event.value);
	})
	
	//client.onmessage = function onmessage(event){
	client.addEventListener("message", function onmessage(event){
		console.log("client.onmessage("+event+")");
		console.log("event.value = "+event.value);
		byId("DKUWebSocketsClient_receive").value = event.value;
	})
	
	//client.onopen = function onopen(event){
	client.addEventListener("open", function onopen(event){
		console.log("client.onopen("+event+")");
		console.log("event.value = "+event.value);
	})
}

function DKUWebSocketsClient_CloseClient(){
	client.close(); // TODO
}

function DKUWebSocketsClient_MessageToServer(){
	var message = byId("DKUWebSocketsClient_send").value;
	console.log("sending ... \n"+message)
	client.send(message);
}
