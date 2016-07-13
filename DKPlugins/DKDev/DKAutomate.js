//////////////////////////
function DKAutomate_Init()
{
	DKCreate("DKDev/DKAutomate.html");
	DKCreate("DKDev/DKAutomate2.js");
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

	DKCreate("DKTriggers/DKTriggers.js");
	DKAutomate_UpdateValues();
}

/////////////////////////
function DKAutomate_End()
{
	DKClose("DKAutomate.html");
}

//////////////////////////////////
function DKAutomate_OnEvent(event)
{
	DKLog("DKAutomate_OnEvent("+event+") \n", DKDEBUG);
	DKLog("DKAutomate_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+") \n", DKDEBUG);
	if(DK_Type(event, "keydown")){
		DKTrigger_ProcessKeyDown(DKWidget_GetValue(event));
	}
	
	if(DK_Id(event, "DKA-NewButton")){
		DKLog("DKA-NewButton \n", DKDEBUG);
		var value = DKMessageBox(event, "GetInput", "New Trigger");
		if(!value){ return; }
		DKAutomate_NewTrigger(value);
	}
	
	if(DK_Id(event, "DKA-DeleteButton")){
		var value = DKMessageBox(event, "Confirm", "Delete Trigger?");
		if(!value){ return; }
		if(!current_trigger){ return; }
		DKTrigger_RemoveTrigger(current_trigger);
		DKSendEvent("DKAutomate.html", "UpdateValues", "");
		DKAutomate_SelectValue("");
	}
	
	if(DK_IdLike(event, "Trigger")){
		DKAutomate_SelectValue(DKWidget_GetValue(event));
		DKAutomate_UpdateSelection(DKWidget_GetValue(event));
	}
	
	if(DK_Id(event, "CancelButton")){
		DKAutomate_CancelSave();
	}
	
	if(DK_Id(event, "SaveButton")){
		//var value = MessageBox(event, "Confirm", "Save Triggers?");
		//if(!value){ return; }
		DKTrigger_SaveTriggers("triggers.txt");
	}
	
	if(DK_Id(event, "MidiDevices")){
		DKCreate("DKMidiJS");
		DKCreate("DKJavascript,DKMidi/DKMidiDialog.js");
		DKWidget_Show("DKMidiDialog.html");
	}
	
	if(DK_Type(event, "UpdateValues")){
		DKAutomate_UpdateValues();
	}
}

////////////////////////////////////
function DKAutomate_NewTrigger(name)
{
	DKLog("DKAutomate_NewTrigger(value); \n", DKDEBUG)
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