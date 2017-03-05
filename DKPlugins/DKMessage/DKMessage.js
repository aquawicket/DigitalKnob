var DKMessage_callback;

/////////////////////////
function DKMessage_Init()
{	
	DKCreate("DKMessage/DKMessage.html", function(){
		DKAddEvent("DKMessageOk", "click", DKMessage_OnEvent);
		DKAddEvent("DKMessageCancel", "click", DKMessage_OnEvent);
	});
}

////////////////////////
function DKMessage_End()
{
	DKRemoveEvent("DKMessageOk", "click", DKMessage_OnEvent);
	DKRemoveEvent("DKMessageCancel", "click", DKMessage_OnEvent);
	DKClose("DKMessage.html");
}

/////////////////////////////////
function DKMessage_OnEvent(event)
{	
	DKLog("DKMessage_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Id(event, "DKMessageOk")){
		if(DKMessage_callback){
			if(DKWidget_Visible("DKMessageInput")){
				DKMessage_callback(DKWidget_GetValue("DKMessageInput"));
			}
			else{
				DKMessage_callback(true);
			}
		}
		DKFrame_Close("DKMessage.html");
		return;
	}
	
	if(DK_Id(event, "DKMessageCancel")){
		if(DKMessage_callback){
			DKMessage_callback(false);
		}
		DKFrame_Close("DKMessage.html");
		return;
	}
}

////////////////////////////////////
function DKMessageBox_Message(message)
{
	DKWidget_SetInnerHtml("DKMessageText", message);
	DKWidget_Hide("DKMessageInput");
	DKWidget_Hide("DKMessageCancel");
	DKWidget_Show("DKMessageText");
	DKWidget_Show("DKMessage.html");
}

////////////////////////////////////
function DKMessageBox_Confirm(message, callback)
{
	DKWidget_SetInnerHtml("DKMessageText", message);
	DKWidget_Hide("DKMessageInput");
	DKWidget_Show("DKMessageText");
	DKWidget_Show("DKMessageCancel");
	DKWidget_Show("DKMessage.html");
	
	DKMessage_callback = callback;
}

////////////////////////////////////
function DKMessageBox_GetValue(message, callback)
{
	DKWidget_SetInnerHtml("DKMessageText", message);
	DKWidget_Show("DKMessageText");
	DKWidget_Show("DKMessageInput");
	DKWidget_Show("DKMessageCancel");
	DKWidget_Show("DKMessage.html");
	
	DKMessage_callback = callback;
}