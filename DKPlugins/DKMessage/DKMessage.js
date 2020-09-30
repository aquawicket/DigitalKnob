var DKMessage_callback;

/////////////////////////
function DKMessage_Init()
{	
	DKCreate("DKMessage/DKMessage.html");
	byId("DKMessageOk").addEventListener("click", DKMessage_OnEvent);
	byId("DKMessageCancel").addEventListener("click", DKMessage_OnEvent);
}

////////////////////////
function DKMessage_End()
{
	byId("DKMessageOk").removeEventListener("click", DKMessage_OnEvent);
	byId("DKMessageCancel").removeEventListener("click", DKMessage_OnEvent);
	DKClose("DKMessage/DKMessage.html");
}

/////////////////////////////////
function DKMessage_OnEvent(event)
{	
	if(event.currentTarget.id === "DKMessageOk"){
		if(DKMessage_callback){
			if(DKWidget_Visible("DKMessageInput")){
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
	//byId("DKMessageText").innerHTML = message;
	byId("DKMessageText").innerHTML = message;
	DKWidget_Hide("DKMessageInput");
	DKWidget_Hide("DKMessageCancel");
	DKWidget_Show("DKMessageText");
	DKWidget_Show("DKMessage/DKMessage.html");
}

/////////////////////////////////////////////
function DKMessage_Confirm(message, callback)
{
	//byId("DKMessageText").innerHTML = message;
	byId("DKMessageText").innerHTML = message;
	DKWidget_Hide("DKMessageInput");
	DKWidget_Show("DKMessageText");
	DKWidget_Show("DKMessageCancel");
	DKWidget_Show("DKMessage/DKMessage.html");
	
	DKMessage_callback = callback;
}

//////////////////////////////////////////////
function DKMessage_GetValue(message, callback)
{
	byId("DKMessageText").innerHTML = message;
	DKWidget_Show("DKMessageText");
	DKWidget_Show("DKMessageInput");
	DKWidget_Show("DKMessageCancel");
	DKWidget_Show("DKMessage/DKMessage.html");
	DKMessage_callback = callback;
}