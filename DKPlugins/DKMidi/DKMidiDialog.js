////////////////////////////
function DKMidiDialog_Init()
{
	//DKLog("DKMidiDialog_Init()\n");
	
	DKCreate("DKMidi/DKMidiDialog.css");
	DKCreate("DKMidi/DKMidiDialog.html");
	//DKMidiDialog_UpdatePorts();
}

///////////////////////////
function DKMidiDialog_End()
{
	//DKLog("DKMidiDialog_End()\n");
	
	DKRemoveEvents(DKMidiDialog_OnEvent);
	DKClose("DKMidi/DKMidiDialog.html");
	DKClose("DKMidi/DKMidiDialog.css");
}

////////////////////////////////////
function DKMidiDialog_OnEvent(event)
{
	//DKLog("DKMidiDialog_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");

	if(DK_IdLike(event, "DKMidiDialogInput")){
		DKMidiDialog_ToggleInput(DK_GetValue(event));
		return;
	}

	if(DK_IdLike(event, "DKMidiDialogOutput")){
		DKMidiDialog_ToggleOutput(DK_GetValue(event));
		return;
	}
}

///////////////////////////////////
function DKMidiDialog_UpdatePorts()
{
	//DKLog("DKMidiDialog_UpdatePorts()\n");
	
	var inputs = DKMidi_GetMidiInputs();
	var list = inputs.split(",");
	DKWidget_SetInnerHtml("DKMidiDialogInputs","");
	for(var i=0; i<list.length; i++){
		var element = DKWidget_CreateElement("DKMidiDialogInputs", "option", "DKMidiDialogInput");
		DKWidget_SetAttribute(element, "value", list[i]);
		DKAddEvent(element, "click", DKMidiDialog_OnEvent);
		DKWidget_SetInnerHtml(element, list[i]);
	}

	var outputs = DKMidi_GetMidiOutputs();
	var outlist = outputs.split(",");
	DKWidget_SetInnerHtml("DKMidiDialogOutputs","");
	for(var i=0; i<outlist.length; i++){
		var element = DKWidget_CreateElement("DKMidiDialogOutputs", "option", "DKMidiDialogOutput");
		DKWidget_SetAttribute(element, "value", outlist[i]);
		DKAddEvent(element, "click", DKMidiDialog_OnEvent);
		DKWidget_SetInnerHtml(element, outlist[i]);
	}
	return true;
}

///////////////////////////////////////
function DKMidiDialog_ToggleInput(name)
{
	//DKLog("DKMidiDialog_ToggleInput("+name+")\n");
	
	if(!DKMidi_ToggleMidiInput(name)){ return false; }
	return true;
}

////////////////////////////////////////
function DKMidiDialog_ToggleOutput(name)
{
	//DKLog("DKMidiDialog_ToggleOutput("+name+")\n");
	
	if(!DKMidi_ToggleMidiOutput(name)){ return false; }
	return true;
}
