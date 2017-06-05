//////////////////////////
function DKAutomate_Init()
{
	DKCreate("DKAssets");
	DKCreate("DKTriggers/DKAutomate.html");
	DKCreate("DKTriggers/DKAutomate2.js", function(){
		DKAddEvent("DKAutomate.html", "keydown", DKAutomate_OnEvent);
		//DKAddEvent("GLOBAL", "midi", DKAutomate_OnEvent);
		//DKAddEvent("GLOBAL", "gui", DKAutomate_OnEvent); //all events
		//DKAddEvent("DKA-Title", "click", DKAutomate_OnEvent);
		DKAddEvent("DKA-NewButton", "click", DKAutomate_OnEvent);
		DKAddEvent("DKA-DeleteButton", "click", DKAutomate_OnEvent);
		DKAddEvent("CancelButton", "click", DKAutomate_OnEvent);
		DKAddEvent("SaveButton", "click", DKAutomate_OnEvent);
		DKAddEvent("MidiDevices", "click", DKAutomate_OnEvent);
		DKAddEvent("DKAutomate.html", "UpdateValues", DKAutomate_OnEvent);

		DKCreate("DKTriggers/DKTriggers.js", function(){
			DKAutomate_UpdateValues();
		});
	});
}

/////////////////////////
function DKAutomate_End()
{
	DKRemoveEvent("DKAutomate.html", "keydown", DKAutomate_OnEvent);
	//DKRemoveEvent("GLOBAL", "midi", DKAutomate_OnEvent);
	//DKRemoveEvent("GLOBAL", "gui", DKAutomate_OnEvent); //all events
	//DKRemoveEvent("DKA-Title", "click", DKAutomate_OnEvent);
	DKRemoveEvent("DKA-NewButton", "click", DKAutomate_OnEvent);
	DKRemoveEvent("DKA-DeleteButton", "click", DKAutomate_OnEvent);
	DKRemoveEvent("CancelButton", "click", DKAutomate_OnEvent);
	DKRemoveEvent("SaveButton", "click", DKAutomate_OnEvent);
	DKRemoveEvent("MidiDevices", "click", DKAutomate_OnEvent);
	DKRemoveEvent("DKAutomate.html", "UpdateValues", DKAutomate_OnEvent);
	DKClose("DKAutomate.html");
}

//////////////////////////////////
function DKAutomate_OnEvent(event)
{
	DKLog("DKAutomate_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Type(event, "keydown")){
		DKTrigger_ProcessKeyDown(DK_GetValue(event));
	}
	
	if(DK_Id(event, "DKA-NewButton")){
		//DKLog("DKA-NewButton \n", DKDEBUG);
		DKCreate("DKMessage/DKMessage.js", function(){
			DKFrame_Widget("DKMessage.html");
			DKMessageBox_GetValue("Enter trigger name", function(rval){
				DKLog("DKMessageBox_GetValue() rval = "+rval+"\n");
				if(!rval){ return; }
				DKAutomate_NewTrigger(rval);
			});
		});
	}
	
	if(DK_Id(event, "DKA-DeleteButton")){
		DKCreate("DKMessage/DKMessage.js", function(){
			DKFrame_Widget("DKMessage.html");
			DKMessageBox_Confirm("Delete Trigger?", function(rval){
				DKLog("DKMessageBox_GetValue() rval = "+rval+"\n");
				if(rval == true){
					if(!current_trigger){ return; }
					DKTrigger_RemoveTrigger(current_trigger);
					DKSendEvent("DKAutomate.html", "UpdateValues", "");
					DKAutomate_SelectValue("");
				}
			});
		});		
	}
	
	if(DK_IdLike(event, "Trigger")){
		DKAutomate_SelectValue(DK_GetValue(event));
		DKAutomate_UpdateSelection(DK_GetValue(event));
	}
	
	if(DK_Id(event, "CancelButton")){
		DKAutomate_CancelSave();
	}
	
	if(DK_Id(event, "SaveButton")){
		//var value = MessageBox(event, "Confirm", "Save Triggers?");
		//if(!value){ return; }
		//var assets = DKAssets_LocalAssets();
		DKTrigger_SaveTriggers("USER/triggers.txt");
	}
	
	if(DK_Id(event, "MidiDevices")){
		DKCreate("DKMidi/DKMidiDialog.js", function(){
			DKWidget_Show("DKMidiDialog.html");
		});
	}
	
	if(DK_Type(event, "UpdateValues")){
		DKAutomate_UpdateValues();
	}
}

////////////////////////////////////
function DKAutomate_NewTrigger(name)
{
	DKLog("DKAutomate_NewTrigger("+name+") \n", DKDEBUG)
	DKTrigger_AddTrigger(name);
	DKAutomate_UpdateValues();
	DKAutomate_SelectValue(name);
}

//////////////////////////////////
function DKAutomate_UpdateValues()
{
	DKLog("DKAutomate_UpdateValues() \n", DKDEBUG);
	DKWidget_SetInnerHtml("DKA-TriggerList", "");

	if(!triggers){return;}
	for(var i = 0; i < triggers.length; i++){
		var option = DKWidget_CreateElement("DKA-TriggerList", "option", "Trigger");
		DKWidget_SetAttribute(option, "value", triggers[i]);
		DKWidget_SetInnerHtml(option, triggers[i]);
		DKAddEvent(option, "click", DKAutomate_OnEvent);
	}
}

//////////////////////////////////////
function DKAutomate_SelectValue(value)
{
	//DKLog("("+value+") \n");
	
	DKTrigger_SelectTrigger(value);
	DKSendEvent("DKAutomate2.html", "SelectTrigger", value);
	DKAutomate_UpdateSelection(value);
}

////////////////////////////////
function DKAutomate_CancelSave()
{
	//DKTrigger_LoadTriggers();
	DKSendEvent("DKAutomate.html", "UpdateValues", "");
	DKAutomate_SelectValue(current_trigger);
}

//////////////////////////////////////////
function DKAutomate_UpdateSelection(value)
{
	if(!value){ return; }
	var temp = DKWidget_GetElements("DKA-TriggerList");
	var options = temp.split(",");
	for(var i = 0; i < options.length; ++i){
		if(value == DKWidget_GetValue(options[i])){
			DKWidget_SetProperty(options[i], "background-color", "rgb(60,60,60)");
			DKWidget_SetProperty(options[i], "color", "rgb(200,200,200)");
		}
		else{
			DKWidget_SetProperty(options[i], "background-color", "rgb(255,255,255)");
			DKWidget_SetProperty(options[i], "color", "rgb(0,0,0)");
		}
	}
}