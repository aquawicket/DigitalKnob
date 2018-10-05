var DKMessage_callback;

/////////////////////////
function DKMessage_Init()
{	
	DKLog("DKMessage_Init()\n", DKDEBUG);
	DKCreate("DKMessage/DKMessage.html");//, function(){
		DKAddEvent("DKMessageOk", "click", DKMessage_OnEvent);
		DKAddEvent("DKMessageCancel", "click", DKMessage_OnEvent);
	//});
}

////////////////////////
function DKMessage_End()
{
	DKLog("DKMessage_End()\n", DKDEBUG);
	DKRemoveEvents(DKMessage_OnEvent);
	DKClose("DKMessage/DKMessage.html");
}

/////////////////////////////////
function DKMessage_OnEvent(event)
{	
	DKLog("DKMessage_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	if(DK_Id(event, "DKMessageOk")){
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
	
	if(DK_Id(event, "DKMessageCancel")){
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
	DKLog("DKMessage_Message("+message+")\n", DKDEBUG);
	DKWidget_SetInnerHtml("DKMessageText", message);
	DKWidget_Hide("DKMessageInput");
	DKWidget_Hide("DKMessageCancel");
	DKWidget_Show("DKMessageText");
	DKWidget_Show("DKMessage/DKMessage.html");
}

/////////////////////////////////////////////
function DKMessage_Confirm(message, callback)
{
	DKLog("DKMessage_Confirm("+message+","+callback+")\n", DKDEBUG);
	DKWidget_SetInnerHtml("DKMessageText", message);
	DKWidget_Hide("DKMessageInput");
	DKWidget_Show("DKMessageText");
	DKWidget_Show("DKMessageCancel");
	DKWidget_Show("DKMessage/DKMessage.html");
	
	DKMessage_callback = callback;
}

//////////////////////////////////////////////
function DKMessage_GetValue(message, callback)
{
	DKLog("DKMessage_GetValue("+message+","+callback+")\n", DKDEBUG);
	DKWidget_SetInnerHtml("DKMessageText", message);
	DKWidget_Show("DKMessageText");
	DKWidget_Show("DKMessageInput");
	DKWidget_Show("DKMessageCancel");
	DKWidget_Show("DKMessage/DKMessage.html");
	DKMessage_callback = callback;
}