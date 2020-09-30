//////////////////////////
function makeStruct(names)
{
	var names = names.split(' ');
	var count = names.length;
	function constructor(){
		for (var i = 0; i < count; i++) {
			this[names[i]] = arguments[i];
		}
	}
	return constructor;
	
	//Usage:
	//var Item = makeStruct("id speaker country");
	//var row = new Item(1, 'john', 'au');
	//alert(row.speaker); // displays: john
}


var current_trigger;
var triggers;
var Cause;
var causes;
var Effect;
var effects;
var trigger_events;


//////////////////////////
function DKTriggers_Init()
{
	current_trigger;
	triggers = [];
	Cause = makeStruct("trigger command var1 var2 var3");
	causes = [];
	Effect = makeStruct("trigger command var1 var2 var3");
	effects = [];
	trigger_events = true;

	//assets = DKAssets_LocalAssets();
	DKTrigger_LoadTriggers("USER/triggers.txt");
	window.addEventListener("gui", DKTrigger_OnEvent); //C++
	window.addEventListener("midi", DKTrigger_OnEvent); //C++
	window.addEventListener("keydown", DKTrigger_OnEvent);
	window.addEventListener("keyup", DKTrigger_OnEvent);
	window.addEventListener("resize", DKTrigger_OnEvent);
	window.addEventListener("ToggleTriggers", DKTrigger_OnEvent); //JS
}

/////////////////////////
function DKTriggers_End()
{
	window.removeEventListener("gui", DKTrigger_OnEvent); //C++
	window.removeEventListener("midi", DKTrigger_OnEvent); //C++
	window.removeEventListener("keydown", DKTrigger_OnEvent);
	window.removeEventListener("keyup", DKTrigger_OnEvent);
	window.removeEventListener("resize", DKTrigger_OnEvent);
	window.removeEventListener("ToggleTriggers", DKTrigger_OnEvent); //JS
}

/////////////////////////////////
function DKTrigger_OnEvent(event)
{
	if(event.type === "gui"){ //C++
		var arry = DK_GetValue(event).split(",");
		DKTrigger_ProcessGui(arry[0], arry[1]);
	}
	if(event.type === "midi"){ //C++
		var arry = DK_GetValue(event).split(",");
		DKTrigger_ProcessMidi(arry[0], arry[1], arry[2]);
	}
	if(event.type === "keydown"){
		DKTrigger_ProcessKeyDown(DK_GetValue(event));
	}
	if(event.type === "keyup"){
		DKTrigger_ProcessKeyUp(DK_GetValue(event)); //JS keydown
	}
	if(event.type === "resize"){
		DKTrigger_ProcessWindowResize(); 
	}
	if(event.type === "click"){
		DKTrigger_ProcessGui("click", DK_GetId(event));
	}
	if(event.type === "mousedown"){
		DKTrigger_ProcessGui("mousedown", DK_GetId(event));
	}
	if(event.type === "mouseup"){
		DKTrigger_ProcessGui("mouseup", DK_GetId(event));
	}
	if(event.type === "contextmenu"){ //JS
		DKTrigger_ProcessGui("contextmenu", DK_GetId(event));
	}
	if(event.type === "mouseover"){ //JS
		DKTrigger_ProcessGui("mouseover", DK_GetId(event));
	}
	if(event.type === "mouseout"){ //JS
		DKTrigger_ProcessGui("mouseout", DK_GetId(event));
	}
	if(event.type === "ToggleTriggers"){ //JS
		if(DK_Value(event, "ON")){
			DKTrigger_On();
		}
		else{
			DKTrigger_Off();
		}
	}
}

///////////////////////
function DKTrigger_On()
{
	trigger_events = true;
}

////////////////////////
function DKTrigger_Off()
{
	trigger_events = false;
}

///////////////////////////////////
function DKTrigger_AddTrigger(name)
{
	triggers.push(name);
}

//////////////////////////////////////
function DKTrigger_RemoveTrigger(name)
{
	for(var i = 0; i < triggers.length; i++){
		if(name === triggers[i]){
			triggers.splice(i, 1);
		}
	}
	for(var c = 0; c < causes.length; c++){
		if(name === causes[c].trigger){
			causes.splice(c, 1);
		}
	}
	for(var e = 0; e < effects.length; e++){
		if(name === effects[e].trigger){
			effects.splice(e, 1);
		}
	}
}

//////////////////////////////////////
function DKTrigger_SelectTrigger(name)
{
	current_trigger = "";
	for(var i = 0; i < triggers.length; i++){
		if(name === triggers[i]){
			current_trigger = triggers[i];
			console.log("Current Trigger: "+current_trigger+"\n");
		}
	}
}

///////////////////////////////////////////////
function DKTrigger_RenameTrigger(name, newname)
{
	for(var c=0; c < causes.length; c++){
		if(name === causes[c].trigger){
			causes[c].trigger = newname;
		}
	}
	
	for(var e=0; e < effects.length; e++){
		if(name === effects[e].trigger){
			effects[e].trigger = newname;
		}
	}
	
	for(var t=0; t < triggers.length; t++){
		if(name === triggers[t]){
			triggers[t] = newname;
			current_trigger = triggers[t];
			return;
		}
	}
}

/////////////////////////////
function DKTrigger_NewCause()
{
	var cause = new Cause(current_trigger, "", "", "", "");
	causes.push(cause);
}

//////////////////////////////
function DKTrigger_NewEffect()
{
	var effect = new Effect(current_trigger, "", "", "", "");
	effects.push(effect);
}

///////////////////////////////////
function DKTrigger_DeleteCause(num)
{
	causes.splice(Number(num), 1);
}

////////////////////////////////////
function DKTrigger_DeleteEffect(num)
{
	effects.splice(Number(num), 1);
}

///////////////////////////////////////
function DKTrigger_ProcessGui(type, id)
{
	for(var c=0; c < causes.length; c++){
		if(causes[c].command === "gui" &&
			causes[c].var1 === id &&
			causes[c].var2 === type
		){
			DKTrigger_FireTrigger(causes[c].trigger);
		}
	}
}

//////////////////////////////////////
function DKTrigger_ProcessKeyDown(num)
{
	for(var c=0; c < causes.length; c++){
		if(causes[c].command === "keydown" &&
			causes[c].var1 === num
		){
			DKTrigger_FireTrigger(causes[c].trigger);
		}
	}
}

////////////////////////////////////
function DKTrigger_ProcessKeyUp(num)
{
	for(var c=0; c < causes.length; c++){
		if(causes[c].command === "keyup" &&
			causes[c].var1 === num
		){
			DKTrigger_FireTrigger(causes[c].trigger);
		}
	}
}

////////////////////////////////////////
function DKTrigger_ProcessWindowResize()
{
	for(var c=0; c < causes.length; c++){
		if(causes[c].command === "window_resize"){
			DKTrigger_FireTrigger(causes[c].trigger);
		}
	}
}

////////////////////////////////////////////////////
function DKTrigger_ProcessMidi(channel, note, value)
{
	for(var c=0; c < causes.length; c++){
		if(causes[c].command === "midi" &&
			causes[c].var1 === channel &&
			causes[c].var2 === note &&
			causes[c].var3 === value){
			DKTrigger_FireTrigger(causes[c].trigger);
		}
	}
}

///////////////////////////////////////
function DKTrigger_FireTrigger(trigger)
{
	if(trigger_events != true){ return; }
	console.log("Fire Trigger: "+trigger+"\n");
	
	for(var i=0; i < effects.length; ++i){
		if(effects[i].trigger != trigger){ continue; }
		
		var command = effects[i].command;
		var var1 = effects[i].var1;
		var var2 = effects[i].var2;
		var var3 = effects[i].var3;
		console.log("     Command: "+command+"\n");
		console.log("        Var1: "+var1+"\n");
		console.log("        Var2: "+var2+"\n");
		console.log("        Var3: "+var3+"\n");

		////  Commands  ////
		if(command === "DoubleClick"){
			DK_DoubleClick();
			continue;
		}
		if(command === "Hook"){
			//TODO
			//SendHook(window,handle#,(command,value);
			DKHook_SendHook(var1, var2, var3);
			var out = "SEND HOOK: ";
			out += var1;
			out += " ";
			out += var2;
			out += " ";
			out += var3;
			out += "\n";
			console.log(out+"\n");
			continue;
		}
		if(command === "LeftClick"){
			DK_LeftClick();
			continue;
		}
		if(command === "Message"){
			DKCreate("DKMessage/DKMessage.js", function(){
				DKMessageBox_Message(var1);
			});
			continue;
		}
		if(command === "Midi"){
			DKMidi_SendMidi(Number(var1), Number(var2), Number(var3));
			var out = "MIDI OUT: ";
			out += var1;
			out += " ";
			out += var2;
			out += " ";
			out += var3;
			out += "\n";
			console.log(out+"\n");
			continue;
		}
		if(command === "MouseTo"){
			console.log("DK_SetCursorPos("+Number(var1)+","+Number(var2)+")\n");
			DK_SetCursorPos(Number(var1), Number(var2));
			continue;
		}
		if(command === "MouseToImage"){
			//console.log("MouseToImage\n");
			DK_MouseToImage(var1);
			continue;
		}
		if(command === "Open"){
			DK_Run(var1);
			continue;
		}
		if(command === "RightClick"){
			DK_RightClick();
			continue;
		}
		if(command === "Sleep"){
			DK_Sleep(Number(var1));
			continue;
		}
	}
}

/////////////////////////////////////
function DKTrigger_LoadTriggers(file)
{
	var assets = DKAssets_LocalAssets();
	if(!DKFile_Exists(assets+file)){
		console.log("DKTrigger_LoadTriggers("+assets+file+"): Cannot find file\n");
		return;
	}
	
	triggers = [];
	causes = [];
	effects = [];
	var num_triggers = DKFile_GetSetting(assets+file, "[TRIGGERS]");
	var num_causes = DKFile_GetSetting(assets+file, "[CAUSES]");
	var num_effects = DKFile_GetSetting(assets+file, "[EFFECTS]");
	
	for(var t = 0; t < Number(num_triggers); t++){
		var trigger = DKFile_GetSetting(assets+file, "[TRIGGER_"+String(t)+"]");
		DKTrigger_AddTrigger(trigger);
	}
	
	for(var c = 0; c < Number(num_causes); c++){
		var trigger = DKFile_GetSetting(assets+file, "[CAUSE_"+String(c)+"_TRIGGER]");
		var command = DKFile_GetSetting(assets+file, "[CAUSE_"+String(c)+"_COMMAND]");
		var var1 = DKFile_GetSetting(assets+file, "[CAUSE_"+String(c)+"_VAR1]");
		var var2 = DKFile_GetSetting(assets+file, "[CAUSE_"+String(c)+"_VAR2]");
		var var3 = DKFile_GetSetting(assets+file, "[CAUSE_"+String(c)+"_VAR3]");
	
		var cause = new Cause(trigger, command, var1, var2, var3);
		causes.push(cause);
	}
	
	for(var e = 0; e < Number(num_effects); e++){
		var trigger = DKFile_GetSetting(assets+file, "[EFFECT_"+String(e)+"_TRIGGER]");
		var command = DKFile_GetSetting(assets+file, "[EFFECT_"+String(e)+"_COMMAND]");
		var var1 = DKFile_GetSetting(assets+file, "[EFFECT_"+String(e)+"_VAR1]");
		var var2 = DKFile_GetSetting(assets+file, "[EFFECT_"+String(e)+"_VAR2]");
		var var3 = DKFile_GetSetting(assets+file, "[EFFECT_"+String(e)+"_VAR3]");
		
		var effect = new Effect(trigger, command, var1, var2, var3);
		effects.push(effect);
	}
	
	DKTrigger_AddEvents();
}

/////////////////////////////////////
function DKTrigger_SaveTriggers(file)
{
	var assets = DKAssets_LocalAssets();
	DKFile_StringToFile(" ", assets+file); //clear file
	
	DKFile_SetSetting(assets+file, "[TRIGGERS]", String(triggers.length));
	DKFile_SetSetting(assets+file, "[CAUSES]", String(causes.length));
	DKFile_SetSetting(assets+file, "[EFFECTS]", String(effects.length));
	
	for(var t = 0; t < triggers.length; t++){
		DKFile_SetSetting(assets+file, "[TRIGGER_"+String(t)+"]", triggers[t]);
	}
	
	for(var c = 0; c < causes.length; c++){
		DKFile_SetSetting(assets+file, "[CAUSE_"+String(c)+"_TRIGGER]", causes[c].trigger);
		DKFile_SetSetting(assets+file, "[CAUSE_"+String(c)+"_COMMAND]", causes[c].command);
		DKFile_SetSetting(assets+file, "[CAUSE_"+String(c)+"_VAR1]", causes[c].var1);
		DKFile_SetSetting(assets+file, "[CAUSE_"+String(c)+"_VAR2]", causes[c].var2);
		DKFile_SetSetting(assets+file, "[CAUSE_"+String(c)+"_VAR3]", causes[c].var3);
	}
	
	for(var e = 0; e < effects.length; e++){
		DKFile_SetSetting(assets+file, "[EFFECT_"+String(e)+"_TRIGGER]", effects[e].trigger);
		DKFile_SetSetting(assets+file, "[EFFECT_"+String(e)+"_COMMAND]", effects[e].command);
		DKFile_SetSetting(assets+file, "[EFFECT_"+String(e)+"_VAR1]", effects[e].var1);
		DKFile_SetSetting(assets+file, "[EFFECT_"+String(e)+"_VAR2]", effects[e].var2);
		DKFile_SetSetting(assets+file, "[EFFECT_"+String(e)+"_VAR3]", effects[e].var3);
	}

	console.log("Saved Triggers.\n");
	
	DKTrigger_AddEvents();
}

//////////////////////////////
function DKTrigger_AddEvents()
{
	console.log("Adding events to gui causes . . .\n");
	for(var c = 0; c < causes.length; c++){
		if(causes[c].command === "gui"){
			byId(causes[c].var1).addEventListener(causes[c].var2, DKTrigger_OnEvent);
		}
	}
}