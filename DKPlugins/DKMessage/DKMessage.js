var event_return_type;
var event_return_id;
var event_data;


/////////////////////////
function DKMessage_Init()
{	
	//DKLog("***********DKMessageInit() \n", DKDEBUG);
	DKCreate("DKMessage/DKMessage.html", function(){
		DKFrame_Widget("DKMessage.html");
		DKAddEvent("DKMessage.html", "ShowMessage", DKMessage_OnEvent);
		DKAddEvent("DKMessage.html", "Confirm", DKMessage_OnEvent);
		DKAddEvent("DKMessage.html", "GetInput", DKMessage_OnEvent);
		DKAddEvent("DKMessageOk", "click", DKMessage_OnEvent);
		DKAddEvent("DKMessageCancel", "click", DKMessage_OnEvent);
		//DKAddEvent("DKMessageInput", "keydown", DKMessage_OnEvent);
		//DKAddEvent(/*"DKMessageOk",*/ "keydown", DKMessage_OnEvent);
	});
}

////////////////////////
function DKMessage_End()
{
	DKClose("DKMessage/DKMessage.html");
}

/////////////////////////////////
function DKMessage_OnEvent(event)
{	
	DKLog("DKMessage_OnEvent("+event+") \n", DKDEBUG);
	if(DK_Id(event, "DKMessageOk")){
		//DKLog("DKMessageOk \n", DKDEBUG)
		//DKWidget_Hide("DKMessage.html");
		event_data = "OK";
		if(DKWidget_Visible("DKMessageInput")){
			event_data = DKWidget_GetValue("DKMessageInput");
			DKWidget_Hide("DKMessageInput");
			if(!event_data){ event_data = "CANCEL"; }
		}
		
		//DKLog("event_return_type: "+event_return_type+"\n", DKDEBUG);
		//DKLog("event_return_id: "+event_return_id+"\n", DKDEBUG);
		//DKLog("event_data: "+event_data+"\n", DKDEBUG);
		if(event_return_id){
			DKSendEvent(event_return_id, event_return_type, event_data);
		}
		
		DKMessage_ClearData();
		DKFrame_Close("DKMessage.html");
		return;
	}
	
	if(DK_Id(event, "DKMessageCancel")){
		//DKWidget_Hide("DKMessage.html");
		event_data = "CANCEL";
		
		//DKLog("event_return_type: "+event_return_type+"\n", DKDEBUG);
		//DKLog("event_return_id: "+event_return_id+"\n", DKDEBUG);
		//DKLog("event_data: "+event_data+"\n", DKDEBUG);
		if(event_return_id){
			DKSendEvent(event_return_id, event_return_type, event_data);
		}
		
		DKMessage_ClearData();
		DKFrame_Close("DKMessage.html");
		return;
	}
	
	if(DK_Type(event, "GetInput")){
		var params = DKWidget_GetValue(event).split(",");
		event_return_id = params[0];
		event_return_type = params[1];
		if(params[2]){
			event_data = params[2];
			DKWidget_SetInnerHtml("DKMessageText", event_data);
		}
		
		DKWidget_Show("DKMessageText");
		DKWidget_Show("DKMessageInput");
		DKWidget_Show("DKMessage.html");
		
		DKLog("event_return_type: "+event_return_type+"\n", DKDEBUG);
		DKLog("event_return_id: "+event_return_id+"\n", DKDEBUG);
		DKLog("event_data: "+event_data+"\n", DKDEBUG);
		//GetElementById("DKMessageInput")->Focus();
	}
	
	if(DK_Type(event, "Confirm")){
		var params = DKWidget_GetValue(event).split(",");
		event_return_id = params[0];
		event_return_type = params[1];
		if(params[2]){
			event_data = params[2];
			DKWidget_SetInnerHtml("DKMessageText", event_data);
		}
		
		DKWidget_Hide("DKMessageInput");
		DKWidget_Show("DKMessageText");
		DKWidget_Show("DKMessage.html");
		
		DKLog("event_return_type: "+event_return_type+"\n", DKDEBUG);
		DKLog("event_return_id: "+event_return_id+"\n", DKDEBUG);
		DKLog("event_data: "+event_data+"\n", DKDEBUG);
		//GetElementById("DKMessageOk")->Focus();
	}
	
	if(DK_Type(event, "ShowMessage")){
		//var params = DKWidget_GetValue(event).split(",");
		//event_return_id = params[0];
		//event_return_type = params[1];
		//if(params[2]){
		//	event_data = params[2];
			DKWidget_SetInnerHtml("DKMessageText", DKWidget_GetValue(event));
		//}
		
		DKWidget_Hide("DKMessageInput");
		DKWidget_Show("DKMessageText");
		DKWidget_Show("DKMessage.html");
		
		//DKLog("event_return_type: "+event_return_type+"\n", DKDEBUG);
		//DKLog("event_return_id: "+event_return_id+"\n", DKDEBUG);
		//DKLog("event_data: "+event_data+"\n", DKDEBUG);
		//GetElementById("DKMessageOk")->Focus();
	}
}

//////////////////////////////
function DKMessage_ClearData()
{
	//DKLog("DKMessage_ClearData() \n", DKDEBUG);
	event_return_id = "";
	event_return_type = "";
	event_data = "";
	DKWidget_SetValue("DKMessageText", "");
	DKWidget_SetValue("DKMessageInput", "");
}

//Quick function
//////////////////////////////////////////
function DKMessageBox(event, cmd, message)
{
	//DKLog("MessageBox("+event+", "+cmd+", "+message+") \n", DKDEBUG);
	if(!event){
		DKSendEvent("DKMessage.html", cmd, message);
		return;
	}
	
	if(!DKWidget_GetValue(event)){ DKSendEvent("DKMessage.html", cmd, DK_GetId(event)+","+DK_GetType(event)+","+message); return false; }
	if(DKWidget_GetValue(event) == "CANCEL"){ return false; }
	return DKWidget_GetValue(event);
}