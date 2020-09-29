//////////////////////////
function DKAutomate_Init()
{
	DKDEBUGFUNC();	
	DKCreate("DKAssets");
	DKCreate("DKTriggers/DKAutomate.html");
	DKCreate("DKTriggers/DKAutomate2.js", function(){
		DKAddEvent("DKTriggers/DKAutomate.html", "keydown", DKAutomate_OnEvent);
		//DKAddEvent("window", "midi", DKAutomate_OnEvent);
		//DKAddEvent("window", "gui", DKAutomate_OnEvent); //all events
		//DKAddEvent("DKA-Title", "click", DKAutomate_OnEvent);
		DKAddEvent("DKA-NewButton", "click", DKAutomate_OnEvent);
		DKAddEvent("DKA-DeleteButton", "click", DKAutomate_OnEvent);
		DKAddEvent("CancelButton", "click", DKAutomate_OnEvent);
		DKAddEvent("SaveButton", "click", DKAutomate_OnEvent);
		DKAddEvent("MidiDevices", "click", DKAutomate_OnEvent);
		DKAddEvent("DKTriggers/DKAutomate.html", "UpdateValues", DKAutomate_OnEvent);

		DKCreate("DKTriggers/DKTriggers.js", function(){
			DKAutomate_UpdateValues();
		});
	});
}

/////////////////////////
function DKAutomate_End()
{
	DKDEBUGFUNC();	
	DKRemoveEvents(DKAutomate_OnEvent);
	DKClose("DKTriggers/DKTriggers.js");
	DKClose("DKTriggers/DKAutomate2.js");
	DKClose("DKTriggers/DKAutomate.html");
}

//////////////////////////////////
function DKAutomate_OnEvent(event)
{
	DKDEBUGFUNC(event);	
	if(event.type == "keydown"){
		DKTrigger_ProcessKeyDown(DK_GetValue(event));
	}
	
	if(event.currentTarget.id == "DKA-NewButton"){
		//console.log("DKA-NewButton\n");
		DKCreate("DKMessage/DKMessage.js", function(){
			DKFrame_Widget("DKMessage/DKMessage.html");
			DKMessageBox_GetValue("Enter trigger name", function(rval){
				console.log("DKMessageBox_GetValue() rval = "+rval+"\n");
				if(!rval){ return; }
				DKAutomate_NewTrigger(rval);
			});
		});
	}
	
	if(event.currentTarget.id == "DKA-DeleteButton"){
		DKCreate("DKMessage/DKMessage.js", function(){
			DKFrame_Widget("DKMessage/DKMessage.html");
			DKMessageBox_Confirm("Delete Trigger?", function(rval){
				console.log("DKMessageBox_GetValue() rval = "+rval+"\n");
				if(rval == true){
					if(!current_trigger){ return; }
					DKTrigger_RemoveTrigger(current_trigger);
					DKSendEvent("DKTriggers/DKAutomate.html", "UpdateValues", "");
					DKAutomate_SelectValue("");
				}
			});
		});		
	}
	
	if(event.currentTarget.id == "Trigger"){
		DKAutomate_SelectValue(DK_GetValue(event));
		DKAutomate_UpdateSelection(DK_GetValue(event));
	}
	
	if(event.currentTarget.id == "CancelButton"){
		DKAutomate_CancelSave();
	}
	
	if(event.currentTarget.id == "SaveButton"){
		//var value = MessageBox(event, "Confirm", "Save Triggers?");
		//if(!value){ return; }
		//var assets = DKAssets_LocalAssets();
		DKTrigger_SaveTriggers("USER/triggers.txt");
	}
	
	if(event.currentTarget.id == "MidiDevices"){
		DKCreate("DKMidi/DKMidiDialog.js", function(){
			DKWidget_Show("DKMidi/DKMidiDialog.html");
		});
	}
	
	if(event.type == "UpdateValues"){
		DKAutomate_UpdateValues();
	}
}

////////////////////////////////////
function DKAutomate_NewTrigger(name)
{
	DKDEBUGFUNC(name);	
	DKTrigger_AddTrigger(name);
	DKAutomate_UpdateValues();
	DKAutomate_SelectValue(name);
}

//////////////////////////////////
function DKAutomate_UpdateValues()
{
	DKDEBUGFUNC();	
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
	DKDEBUGFUNC(value);	
	DKTrigger_SelectTrigger(value);
	DKSendEvent("DKTriggers/DKAutomate2.html", "SelectTrigger", value);
	DKAutomate_UpdateSelection(value);
}

////////////////////////////////
function DKAutomate_CancelSave()
{
	DKDEBUGFUNC();	
	//DKTrigger_LoadTriggers();
	DKSendEvent("DKTriggers/DKAutomate.html", "UpdateValues", "");
	DKAutomate_SelectValue(current_trigger);
}

//////////////////////////////////////////
function DKAutomate_UpdateSelection(value)
{
	DKDEBUGFUNC(value);	
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