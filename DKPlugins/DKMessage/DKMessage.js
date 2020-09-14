var DKMessage_callback;

/////////////////////////
function DKMessage_Init()
{	
	DKDEBUGFUNC();
	DKCreate("DKMessage/DKMessage.html");//, function(){
		DKAddEvent("DKMessageOk", "click", DKMessage_OnEvent);
		DKAddEvent("DKMessageCancel", "click", DKMessage_OnEvent);
	//});
}

////////////////////////
function DKMessage_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKMessage_OnEvent);
	DKClose("DKMessage/DKMessage.html");
}

/////////////////////////////////
function DKMessage_OnEvent(event)
{	
	DKDEBUGFUNC(event);
	if(event.currentTarget.id == "DKMessageOk"){
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
	
	if(event.currentTarget.id == "DKMessageCancel"){
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
	DKDEBUGFUNC(message);
	DKWidget_SetInnerHtml("DKMessageText", message);
	DKWidget_Hide("DKMessageInput");
	DKWidget_Hide("DKMessageCancel");
	DKWidget_Show("DKMessageText");
	DKWidget_Show("DKMessage/DKMessage.html");
}

/////////////////////////////////////////////
function DKMessage_Confirm(message, callback)
{
	DKDEBUGFUNC(message, callback);
	//DKWidget_SetInnerHtml("DKMessageText", message);
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
	DKDEBUGFUNC(message, callback);
	DKWidget_SetInnerHtml("DKMessageText", message);
	DKWidget_Show("DKMessageText");
	DKWidget_Show("DKMessageInput");
	DKWidget_Show("DKMessageCancel");
	DKWidget_Show("DKMessage/DKMessage.html");
	DKMessage_callback = callback;
}