////////////////////////////
function DKMidiDialog_Init()
{
	DKDEBUGFUNC();	
	DKCreate("DKMidi/DKMidiDialog.css");
	DKCreate("DKMidi/DKMidiDialog.html");
	//DKMidiDialog_UpdatePorts();
}

///////////////////////////
function DKMidiDialog_End()
{
	DKDEBUGFUNC();	
	DKRemoveEvents(DKMidiDialog_OnEvent);
	DKClose("DKMidi/DKMidiDialog.html");
	DKClose("DKMidi/DKMidiDialog.css");
}

////////////////////////////////////
function DKMidiDialog_OnEvent(event)
{
	DKDEBUGFUNC(event);
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
	DKDEBUGFUNC();	
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
	DKDEBUGFUNC(name);	
	if(!DKMidi_ToggleMidiInput(name)){ return false; }
	return true;
}

////////////////////////////////////////
function DKMidiDialog_ToggleOutput(name)
{
	DKDEBUGFUNC(name);	
	if(!DKMidi_ToggleMidiOutput(name)){ return false; }
	return true;
}