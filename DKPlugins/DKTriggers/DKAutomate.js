//////////////////////////
function DKAutomate_Init()
{
	DKCreate("DKAssets");
	DKCreate("DKTriggers/DKAutomate.html");
	DKCreate("DKTriggers/DKAutomate2.js", function(){
		byId("DKTriggers/DKAutomate.html", "keydown", DKAutomate_OnEvent);
		//window.addEventListener("midi", DKAutomate_OnEvent);
		//window.addEventListener("gui", DKAutomate_OnEvent); //all events
		//byId("DKA-Title").addEventListener("click", DKAutomate_OnEvent);
		byId("DKA-NewButton").addEventListener("click", DKAutomate_OnEvent);
		byId("DKA-DeleteButton").addEventListener("click", DKAutomate_OnEvent);
		byId("CancelButton").addEventListener("click", DKAutomate_OnEvent);
		byId("SaveButton").addEventListener("click", DKAutomate_OnEvent);
		byId("MidiDevices").addEventListener("click", DKAutomate_OnEvent);
		byId("DKTriggers/DKAutomate.html").addEventListener("UpdateValues", DKAutomate_OnEvent);

		DKCreate("DKTriggers/DKTriggers.js", function(){
			DKAutomate_UpdateValues();
		});
	});
}

/////////////////////////
function DKAutomate_End()
{
	byId("DKTriggers/DKAutomate.html", "keydown", DKAutomate_OnEvent);
	//window.removeEventListener("midi", DKAutomate_OnEvent);
	//window.removeEventListener("gui", DKAutomate_OnEvent); //all events
	//byId("DKA-Title").removeEventListener("click", DKAutomate_OnEvent);
	byId("DKA-NewButton").removeEventListener("click", DKAutomate_OnEvent);
	byId("DKA-DeleteButton").removeEventListener("click", DKAutomate_OnEvent);
	byId("CancelButton").removeEventListener("click", DKAutomate_OnEvent);
	byId("SaveButton").removeEventListener("click", DKAutomate_OnEvent);
	byId("MidiDevices").removeEventListener("click", DKAutomate_OnEvent);
	byId("DKTriggers/DKAutomate.html").removeEventListener("UpdateValues", DKAutomate_OnEvent);

	DKClose("DKTriggers/DKTriggers.js");
	DKClose("DKTriggers/DKAutomate2.js");
	DKClose("DKTriggers/DKAutomate.html");
}

//////////////////////////////////
function DKAutomate_OnEvent(event)
{
	if(event.type === "keydown"){
		DKTrigger_ProcessKeyDown(DK_GetValue(event));
	}
	
	if(event.currentTarget.id === "DKA-NewButton"){
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
	
	if(event.currentTarget.id === "DKA-DeleteButton"){
		DKCreate("DKMessage/DKMessage.js", function(){
			DKFrame_Widget("DKMessage/DKMessage.html");
			DKMessageBox_Confirm("Delete Trigger?", function(rval){
				console.log("DKMessageBox_GetValue() rval = "+rval+"\n");
				if(rval === true){
					if(!current_trigger){ return; }
					DKTrigger_RemoveTrigger(current_trigger);
					DKSendEvent("DKTriggers/DKAutomate.html", "UpdateValues", "");
					DKAutomate_SelectValue("");
				}
			});
		});		
	}
	
	if(event.currentTarget.id === "Trigger"){
		DKAutomate_SelectValue(DK_GetValue(event));
		DKAutomate_UpdateSelection(DK_GetValue(event));
	}
	
	if(event.currentTarget.id === "CancelButton"){
		DKAutomate_CancelSave();
	}
	
	if(event.currentTarget.id === "SaveButton"){
		//var value = MessageBox(event, "Confirm", "Save Triggers?");
		//if(!value){ return; }
		//var assets = DKAssets_LocalAssets();
		DKTrigger_SaveTriggers("USER/triggers.txt");
	}
	
	if(event.currentTarget.id === "MidiDevices"){
		DKCreate("DKMidi/DKMidiDialog.js", function(){
			DKWidget_Show("DKMidi/DKMidiDialog.html");
		});
	}
	
	if(event.type === "UpdateValues"){
		DKAutomate_UpdateValues();
	}
}

////////////////////////////////////
function DKAutomate_NewTrigger(name)
{
	DKTrigger_AddTrigger(name);
	DKAutomate_UpdateValues();
	DKAutomate_SelectValue(name);
}

//////////////////////////////////
function DKAutomate_UpdateValues()
{
	byId("DKA-TriggerList").innerHTML = "";

	if(!triggers){return;}
	for(var i = 0; i < triggers.length; i++){
		var option = DKWidget_CreateElement(byId("DKA-TriggerList"), "option", "Trigger");
		byId(option).value = triggers[i];
		byId(option).innerHTML = triggers[i];
		byId(option, "click", DKAutomate_OnEvent);
	}
}

//////////////////////////////////////
function DKAutomate_SelectValue(value)
{
	DKTrigger_SelectTrigger(value);
	DKSendEvent("DKTriggers/DKAutomate2.html", "SelectTrigger", value);
	DKAutomate_UpdateSelection(value);
}

////////////////////////////////
function DKAutomate_CancelSave()
{
	//DKTrigger_LoadTriggers();
	DKSendEvent("DKTriggers/DKAutomate.html", "UpdateValues", "");
	DKAutomate_SelectValue(current_trigger);
}

//////////////////////////////////////////
function DKAutomate_UpdateSelection(value)
{
	if(!value){ return; }
	var temp = DKWidget_GetElements("DKA-TriggerList");
	var options = temp.split(",");
	for(var i = 0; i < options.length; ++i){
		if(value === DKWidget_GetValue(options[i])){
			byId(options[i]).style.backgroundColor = "rgb(60,60,60)";
			byId(options[i]).style.color = "rgb(200,200,200)";
		}
		else{
			byId(options[i]).style.backgroundColor = "rgb(255,255,255)";
			byId(options[i]).style.color = "rgb(0,0,0)";
		}
	}
}