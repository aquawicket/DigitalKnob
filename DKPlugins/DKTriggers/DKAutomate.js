//////////////////////////
function DKAutomate_init()
{
	dk.create("DKAssets");
	dk.create("DKTriggers/DKAutomate.html");
	dk.create("DKTriggers/DKAutomate2.js", function(){
		byId("DKTriggers/DKAutomate.html", "keydown", DKAutomate_onevent);
		//window.addEventListener("midi", DKAutomate_onevent);
		//window.addEventListener("gui", DKAutomate_onevent); //all events
		//byId("DKA-Title").addEventListener("click", DKAutomate_onevent);
		byId("DKA-NewButton").addEventListener("click", DKAutomate_onevent);
		byId("DKA-DeleteButton").addEventListener("click", DKAutomate_onevent);
		byId("CancelButton").addEventListener("click", DKAutomate_onevent);
		byId("SaveButton").addEventListener("click", DKAutomate_onevent);
		byId("MidiDevices").addEventListener("click", DKAutomate_onevent);
		byId("DKTriggers/DKAutomate.html").addEventListener("UpdateValues", DKAutomate_onevent);

		dk.create("DKTriggers/DKTriggers.js", function(){
			DKAutomate_UpdateValues();
		});
	});
}

/////////////////////////
function DKAutomate_end()
{
	byId("DKTriggers/DKAutomate.html", "keydown", DKAutomate_onevent);
	//window.removeEventListener("midi", DKAutomate_onevent);
	//window.removeEventListener("gui", DKAutomate_onevent); //all events
	//byId("DKA-Title").removeEventListener("click", DKAutomate_onevent);
	byId("DKA-NewButton").removeEventListener("click", DKAutomate_onevent);
	byId("DKA-DeleteButton").removeEventListener("click", DKAutomate_onevent);
	byId("CancelButton").removeEventListener("click", DKAutomate_onevent);
	byId("SaveButton").removeEventListener("click", DKAutomate_onevent);
	byId("MidiDevices").removeEventListener("click", DKAutomate_onevent);
	byId("DKTriggers/DKAutomate.html").removeEventListener("UpdateValues", DKAutomate_onevent);

	dk.close("DKTriggers/DKTriggers.js");
	dk.close("DKTriggers/DKAutomate2.js");
	dk.close("DKTriggers/DKAutomate.html");
}

//////////////////////////////////
function DKAutomate_OnEvent(event)
{
	if(event.type === "keydown"){
		DKTrigger_ProcessKeyDown(DK_GetValue(event));
	}
	
	if(event.currentTarget.id === "DKA-NewButton"){
		//console.log("DKA-NewButton\n");
		dk.create("DKGui/DKMessageBox.js", function(){
			dk.file.create("DKGui/DKMessageBox.html");
			DKMessageBox_GetValue("Enter trigger name", function(rval){
				console.log("DKMessageBox_GetValue() rval = "+rval+"\n");
				if(!rval){ return; }
				DKAutomate_NewTrigger(rval);
			});
		});
	}
	
	if(event.currentTarget.id === "DKA-DeleteButton"){
		dk.create("DKGui/DKMessageBox.js", function(){
			dk.file.create("DKGui/DKMessageBox.html");
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
		dk.create("DKMidi/DKMidiDialog.js", function(){
			byId("DKMidi/DKMidiDialog.html").style.display = "block";
			byId("DKMidi/DKMidiDialog.html").style.visibility = "visible";
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
		var option = DK_CreateElement(byId("DKA-TriggerList"), "option", "Trigger");
		option.value = triggers[i];
		option.innerHTML = triggers[i];
		option.addEventListener("click", DKAutomate_onevent);
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
	var temp = DK_GetElements(byId("DKA-TriggerList"));
	var options = temp.split(",");
	for(var i = 0; i < options.length; ++i){
		if(value === DK_GetValue(options[i])){
			byId(options[i]).style.backgroundColor = "rgb(60,60,60)";
			byId(options[i]).style.color = "rgb(200,200,200)";
		}
		else{
			byId(options[i]).style.backgroundColor = "rgb(255,255,255)";
			byId(options[i]).style.color = "rgb(0,0,0)";
		}
	}
}