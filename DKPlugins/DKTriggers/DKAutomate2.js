///////////////////////////
function DKAutomate2_Init()
{
	DKCreate("DKTriggers/DKAutomate2.html,DKTriggers/DKAutomate.html", function(){
		byId("DKTriggers/DKAutomate2.html").addEventListener("SelectTrigger", DKAutomate2_OnEvent);
		byId("DKTriggers/DKAutomate2.html").addEventListener("input", DKAutomate2_OnEvent);
	});
}

//////////////////////////
function DKAutomate2_End()
{
	byId("DKTriggers/DKAutomate2.html").removeEventListener("SelectTrigger", DKAutomate2_OnEvent);
	byId("DKTriggers/DKAutomate2.html").removeEventListener("input", DKAutomate2_OnEvent);
	DKClose("DKTriggers/DKAutomate2.html");
}

///////////////////////////////////
function DKAutomate2_OnEvent(event)
{
	if(event.currentTarget.id == "NewCause"){
		DKTrigger_NewCause();
		DKAutomate2_SelectTrigger();
	}
	if(DK_IdLike(event,"DeleteCause")){
		var num = DKWidget_GetAttribute(DK_GetId(event), "num");
		DKTrigger_DeleteCause(num)
		DKAutomate2_SelectTrigger();
	}
	if(event.currentTarget.id == "NewEffect"){
		DKTrigger_NewEffect();
		DKAutomate2_SelectTrigger();
	}
	if(DK_IdLike(event,"DeleteEffect")){
		var num = DKWidget_GetAttribute(DK_GetId(event), "num");
		DKTrigger_DeleteEffect(num);
		DKAutomate2_SelectTrigger();
	}
	if(event.currentTarget.id == "TriggerName"){
		if(!current_trigger){ return; }
		DKTrigger_RenameTrigger(current_trigger, DK_GetValue(event))
		current_trigger = DK_GetValue(event);
		DKSendEvent("DKAutomate.html", "UpdateValues", "");
	}
	if(DK_IdLike(event,"CauseCommand")){
		var num = DKWidget_GetAttribute(DK_GetId(event), "num");
		causes[Number(num)].command = DK_GetValue(event);
	}
	if(DK_IdLike(event,"CauseVar1")){
		var num = DKWidget_GetAttribute(DK_GetId(event), "num");
		causes[Number(num)].var1 = DK_GetValue(event);
	}
	if(DK_IdLike(event,"CauseVar2")){
		var num = DKWidget_GetAttribute(DK_GetId(event), "num");
		causes[Number(num)].var2 = DK_GetValue(event);
	}
	if(DK_IdLike(event,"CauseVar3")){
		var num = DKWidget_GetAttribute(DK_GetId(event), "num");
		causes[Number(num)].var3 = DK_GetValue(event);
	}
	if(DK_IdLike(event,"EffectCommand")){
		var num = DKWidget_GetAttribute(DK_GetId(event), "num");
		effects[Number(num)].command = DK_GetValue(event);
	}
	if(DK_IdLike(event,"EffectVar1")){
		var num = DKWidget_GetAttribute(DK_GetId(event), "num");
		effects[Number(num)].var1 = DK_GetValue(event);
	}
	if(DK_IdLike(event,"EffectVar2")){
		var num = DKWidget_GetAttribute(DK_GetId(event), "num");
		effects[Number(num)].var2 = DK_GetValue(event);
	}
	if(DK_IdLike(event,"EffectVar3")){
		var num = DKWidget_GetAttribute(DK_GetId(event), "num");
		effects[Number(num)].var3 = DK_GetValue(event);
	}
	
	if(event.type == "SelectTrigger"){
		DKAutomate2_SelectTrigger();
	}
}

////////////////////////////////////
function DKAutomate2_SelectTrigger()
{
	DKWidget_SetValue("TriggerName", current_trigger);
	DKWidget_SetInnerHtml("Causes", "");
	
	for(var c = 0; c < causes.length; c++){
		if(causes[c].trigger != current_trigger){ continue; }
		
		var cause = DKWidget_CreateElement("Causes", "div", "CauseDiv");
		
		var command = DKWidget_CreateElement(cause, "input", "CauseCommand");
		DKWidget_SetAttribute(command, "type", "text");
		DKWidget_SetProperty(command, "width", "100px");
		DKWidget_SetProperty(command, "height", "18px");
		DKWidget_SetProperty(command, "display", "inline-block");
		DKWidget_SetProperty(command, "border-width", "1px");
		DKWidget_SetAttribute(command, "num", String(c));
		DKWidget_SetValue(command, causes[c].command);
		byId(command).addEventListener("change", DKAutomate2_OnEvent);

		var var1 = DKWidget_CreateElement(cause, "input", "CauseVar1");
		DKWidget_SetAttribute(var1, "type", "text");
		DKWidget_SetProperty(var1, "width", "100px");
		DKWidget_SetProperty(var1, "height", "18px");
		DKWidget_SetProperty(var1, "display", "inline-block");
		DKWidget_SetProperty(var1, "border-width", "1px");
		DKWidget_SetAttribute(var1, "num", String(c));
		DKWidget_SetValue(var1, causes[c].var1);
		byId(var1).addEventListener("change", DKAutomate2_OnEvent);

		var var2 = DKWidget_CreateElement(cause, "input", "CauseVar2");
		DKWidget_SetAttribute(var2, "type", "text");
		DKWidget_SetProperty(var2, "width", "100px");
		DKWidget_SetProperty(var2, "height", "18px");
		DKWidget_SetProperty(var2, "display", "inline-block");
		DKWidget_SetProperty(var2, "border-width", "1px");
		DKWidget_SetAttribute(var2, "num", String(c));
		DKWidget_SetValue(var2, causes[c].var2);
		byId(var2).addEventListener("change", DKAutomate2_OnEvent);

		var var3 = DKWidget_CreateElement(cause, "input", "CauseVar3");
		DKWidget_SetAttribute(var3, "type", "text");
		DKWidget_SetProperty(var3, "width", "100px");
		DKWidget_SetProperty(var3, "height", "18px");
		DKWidget_SetProperty(var3, "display", "inline-block");
		DKWidget_SetProperty(var3, "border-width", "1px");
		DKWidget_SetAttribute(var3, "num", String(c));
		DKWidget_SetValue(var3, causes[c].var3);
		byId(var3).addEventListener("change", DKAutomate2_OnEvent);

		var button = DKWidget_CreateElement(cause, "button", "DeleteCause");
		DKWidget_SetProperty(button, "width", "50px");
		DKWidget_SetProperty(button, "height", "18px");
		DKWidget_SetProperty(button, "display", "inline-block");
		DKWidget_SetProperty(button, "border-width", "1px");
		DKWidget_SetAttribute(button, "num", String(c));
		DKWidget_SetInnerHtml(button, "Delete");
		byId(button).addEventListener("click", DKAutomate2_OnEvent);
	}

	var button = DKWidget_CreateElement(byId("Causes"), "button", "NewCause");
	DKWidget_SetProperty(button, "width", "50px");
	DKWidget_SetProperty(button, "height", "18px");
	DKWidget_SetProperty(button, "border-width", "1px");
	DKWidget_SetInnerHtml(button, "New");
	byId(button).addEventListener("click", DKAutomate2_OnEvent);


	DKWidget_SetInnerHtml("Effects", "");
	for(var e = 0; e < effects.length; e++){
		if(effects[e].trigger != current_trigger){ continue; }
		
		var effect = DKWidget_CreateElement("Effects", "div", "EffectDiv");

		var command = DKWidget_CreateElement(effect, "input", "EffectCommand");
		DKWidget_SetAttribute(command, "type", "text");
		DKWidget_SetProperty(command, "width", "100px");
		DKWidget_SetProperty(command, "height", "18px");
		DKWidget_SetProperty(command, "display", "inline-block");
		DKWidget_SetProperty(command, "border-width", "1px");
		DKWidget_SetAttribute(command, "num", String(e));
		DKWidget_SetValue(command, effects[e].command);
		byId(command).addEventListener("change", DKAutomate2_OnEvent);

		var var1 = DKWidget_CreateElement(effect, "input", "EffectVar1");
		DKWidget_SetAttribute(var1, "type", "text");
		DKWidget_SetProperty(var1, "width", "100px");
		DKWidget_SetProperty(var1, "height", "18px");
		DKWidget_SetProperty(var1, "display", "inline-block");
		DKWidget_SetProperty(var1, "border-width", "1px");
		DKWidget_SetAttribute(var1, "num", String(e));
		DKWidget_SetValue(var1, effects[e].var1);
		byId(var1).addEventListener("change", DKAutomate2_OnEvent);

		var var2 = DKWidget_CreateElement(effect, "input", "EffectVar2");
		DKWidget_SetAttribute(var2, "type", "text");
		DKWidget_SetProperty(var2, "width", "100px");
		DKWidget_SetProperty(var2, "height", "18px");
		DKWidget_SetProperty(var2, "display", "inline-block");
		DKWidget_SetProperty(var2, "border-width", "1px");
		DKWidget_SetAttribute(var2, "num", String(e));
		DKWidget_SetValue(var2, effects[e].var2);
		byId(var2).addEventListener("change", DKAutomate2_OnEvent);

		var var3 = DKWidget_CreateElement(effect, "input", "EffectVar3");
		DKWidget_SetAttribute(var3, "type", "text");
		DKWidget_SetProperty(var3, "width", "100px");
		DKWidget_SetProperty(var3, "height", "18px");
		DKWidget_SetProperty(var3, "display", "inline-block");
		DKWidget_SetProperty(var3, "border-width", "1px");
		DKWidget_SetAttribute(var3, "num", String(e));
		DKWidget_SetValue(var3, effects[e].var3);
		byId(var3).addEventListener("change", DKAutomate2_OnEvent);

		var button = DKWidget_CreateElement(effect, "button", "DeleteEffect");
		DKWidget_SetProperty(button, "width", "50px");
		DKWidget_SetProperty(button, "height", "18px");
		DKWidget_SetProperty(button, "display", "inline-block");
		DKWidget_SetProperty(button, "border-width", "1px");
		DKWidget_SetAttribute(button, "num", String(e));
		DKWidget_SetInnerHtml(button, "Delete");
		byId(button).addEventListener("click", DKAutomate2_OnEvent);
	}

	var button2 = DKWidget_CreateElement("Effects", "button", "NewEffect");
	DKWidget_SetProperty(button2, "width", "50px");
	DKWidget_SetProperty(button2, "height", "18px");
	DKWidget_SetProperty(button2, "border-width", "1px");
	DKWidget_SetInnerHtml(button2, "New");
	byId(button2).addEventListener("click", DKAutomate2_OnEvent);
}