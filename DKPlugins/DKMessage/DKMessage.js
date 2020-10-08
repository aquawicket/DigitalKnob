var DKMessage_callback;

/////////////////////////
function DKMessage_Init()
{	
	DK_Create("DKMessage/DKMessage.html");
	byId("DKMessageOk").addEventListener("click", DKMessage_OnEvent);
	byId("DKMessageCancel").addEventListener("click", DKMessage_OnEvent);
}

////////////////////////
function DKMessage_End()
{
	byId("DKMessageOk").removeEventListener("click", DKMessage_OnEvent);
	byId("DKMessageCancel").removeEventListener("click", DKMessage_OnEvent);
	DK_Close("DKMessage/DKMessage.html");
}

/////////////////////////////////
function DKMessage_OnEvent(event)
{	
	if(event.currentTarget.id === "DKMessageOk"){
		if(DKMessage_callback){
			if(byId("DKMessageInput").style.visibilty){ //TODO: review this 
				DKMessage_callback(DKWidget_GetValue("DKMessageInput"));
			}
			else{
				DKMessage_callback(true);
			}
		}
		DKFrame_Close("DKMessage/DKMessage.html");
		return;
	}
	
	if(event.currentTarget.id === "DKMessageCancel"){
		if(DKMessage_callback){
			DKMessage_callback(false);
		}
		DKFrame_Close("DKMessage/DKMessage.html");
		return;
	}
}

///////////////////////////////////
function DKMessage_Message(message)
{
	byId("DKMessageText").innerHTML = message;
	byId("DKMessageInput").style.display = "none";
	byId("DKMessageCancel").style.display = "none";
	byId("DKMessageText").style.display = "block";
	byId("DKMessageText").style.visibility = "visible";
	byId("DKMessage/DKMessage.html").style.display = "block";
	byId("DKMessage/DKMessage.html").style.visibility = "visible";
}

/////////////////////////////////////////////
function DKMessage_Confirm(message, callback)
{
	byId("DKMessageText").innerHTML = message;
	byId("DKMessageInput").style.display = "none";
	byId("DKMessageText").style.display = "block";
	byId("DKMessageText").style.visibility = "visible";
	byId("DKMessageCancel").style.display = "block";
	byId("DKMessageCancel").style.visibility = "visible";
	byId("DKMessage/DKMessage.html").style.display = "block";
	byId("DKMessage/DKMessage.html").style.visibility = "visible";
	DKMessage_callback = callback;
}

//////////////////////////////////////////////
function DKMessage_GetValue(message, callback)
{
	byId("DKMessageText").innerHTML = message;
	byId("DKMessageText").style.display = "block";
	byId("DKMessageText").style.visibility = "visible";
	byId("DKMessageInput").style.display = "block";
	byId("DKMessageInput").style.visibility = "visible";
	byId("DKMessageCancel").style.display = "block";
	byId("DKMessageCancel").style.visibility = "visible";
	byId("DKMessage/DKMessage.html").style.display = "block";
	byId("DKMessage/DKMessage.html").style.visibility = "visible";
	DKMessage_callback = callback;
}