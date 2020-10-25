///////////////////////////
function DKAutomate2_Init()
{
	DK_Create("DKTriggers/DKAutomate2.html,DKTriggers/DKAutomate.html", function(){
		byId("DKTriggers/DKAutomate2.html").addEventListener("SelectTrigger", DKAutomate2_OnEvent);
		byId("DKTriggers/DKAutomate2.html").addEventListener("input", DKAutomate2_OnEvent);
	});
}

//////////////////////////
function DKAutomate2_End()
{
	byId("DKTriggers/DKAutomate2.html").removeEventListener("SelectTrigger", DKAutomate2_OnEvent);
	byId("DKTriggers/DKAutomate2.html").removeEventListener("input", DKAutomate2_OnEvent);
	DK_Close("DKTriggers/DKAutomate2.html");
}

///////////////////////////////////
function DKAutomate2_OnEvent(event)
{
	if(event.currentTarget.id === "NewCause"){
		DKTrigger_NewCause();
		DKAutomate2_SelectTrigger();
	}
	if(DK_IdLike(event,"DeleteCause")){
		var num = byId(event.currentTarget.id).num;
		DKTrigger_DeleteCause(num)
		DKAutomate2_SelectTrigger();
	}
	if(event.currentTarget.id === "NewEffect"){
		DKTrigger_NewEffect();
		DKAutomate2_SelectTrigger();
	}
	if(DK_IdLike(event,"DeleteEffect")){
		var num = byId(event.currentTarget.id).num;
		DKTrigger_DeleteEffect(num);
		DKAutomate2_SelectTrigger();
	}
	if(event.currentTarget.id === "TriggerName"){
		if(!current_trigger){ return; }
		DKTrigger_RenameTrigger(current_trigger, DK_GetValue(event))
		current_trigger = DK_GetValue(event);
		DKSendEvent("DKAutomate.html", "UpdateValues", "");
	}
	if(DK_IdLike(event,"CauseCommand")){
		var num = byId(event.currentTarget.id).num;
		causes[Number(num)].command = DK_GetValue(event);
	}
	if(DK_IdLike(event,"CauseVar1")){
		var num = byId(event.currentTarget.id).num;
		causes[Number(num)].var1 = DK_GetValue(event);
	}
	if(DK_IdLike(event,"CauseVar2")){
		var num = byId(event.currentTarget.id).num;
		causes[Number(num)].var2 = DK_GetValue(event);
	}
	if(DK_IdLike(event,"CauseVar3")){
		var num = byId(event.currentTarget.id).num;
		causes[Number(num)].var3 = DK_GetValue(event);
	}
	if(DK_IdLike(event,"EffectCommand")){
		var num = byId(event.currentTarget.id).num;
		effects[Number(num)].command = DK_GetValue(event);
	}
	if(DK_IdLike(event,"EffectVar1")){
		var num = byId(event.currentTarget.id).num;
		effects[Number(num)].var1 = DK_GetValue(event);
	}
	if(DK_IdLike(event,"EffectVar2")){
		var num = byId(event.currentTarget.id).num;
		effects[Number(num)].var2 = DK_GetValue(event);
	}
	if(DK_IdLike(event,"EffectVar3")){
		var num = byId(event.currentTarget.id).num;
		effects[Number(num)].var3 = DK_GetValue(event);
	}
	
	if(event.type === "SelectTrigger"){
		DKAutomate2_SelectTrigger();
	}
}

////////////////////////////////////
function DKAutomate2_SelectTrigger()
{
	byId("TriggerName").value = current_trigger;
	byId("Causes").innerHTML = "";
	
	for(var c = 0; c < causes.length; c++){
		if(causes[c].trigger !== current_trigger){ continue; }
		
		var cause = DK_CreateElement(byId("Causes"), "div", "CauseDiv");
		
		var command = DK_CreateElement(byId(cause), "input", "CauseCommand");
		byId(command).type = "text";
		byId(command).stylewidth = "100px";
		byId(command).style.height = "18px";
		byId(command).style.display = "inline-block";
		byId(command).style.borderWidth = "1px";
		byId(command).num = String(c);
		byId(command).value = causes[c].command;
		byId(command).addEventListener("change", DKAutomate2_OnEvent);

		var var1 = DK_CreateElement(byId(cause), "input", "CauseVar1");
		byId(var1).type = "text";
		byId(var1).style.width = "100px";
		byId(var1).style.height = "18px";
		byId(var1).style.display = "inline-block";
		byId(var1).style.borderWidth = "1px";
		byId(var1).num = String(c);
		byId(var1).value = causes[c].var1;
		byId(var1).addEventListener("change", DKAutomate2_OnEvent);

		var var2 = DK_CreateElement(byId(cause), "input", "CauseVar2");
		byId(var2).type = "text";
		byId(var2).style.width = "100px;
		byId(var2).style.height = "18px";
		byId(var2).style.display = "inline-block";
		byId(var2).style.borderWidth = "1px";
		byId(var2).num = String(c);
		byId(var2).value = causes[c].var2;
		byId(var2).addEventListener("change", DKAutomate2_OnEvent);

		var var3 = DK_CreateElement(byId(cause), "input", "CauseVar3");
		byId(var3).type = "text";
		byId(var3).style.width = "100px";
		byId(var3).style.height = "18px";
		byId(var3).style.display = "inline-block";
		byId(var3).style.borderWidth = "1px";
		byId(var3).num = String(c);
		byId(var3).value = causes[c].var3;
		byId(var3).addEventListener("change", DKAutomate2_OnEvent);

		var button = DK_CreateElement(byId(cause), "button", "DeleteCause");
		byId(button).style.width = "50px";
		byId(button).style.height = "18px";
		byId(button).style.display = "inline-block";
		byId(button).style.borderWidth = "1px";
		byId(button).num = String(c);
		byId(button).innerHTML = "Delete";
		byId(button).addEventListener("click", DKAutomate2_OnEvent);
	}

	var button = DK_CreateElement(byId("Causes"), "button", "NewCause");
	byId(button, "width", "50px");
	byId(button, "height", "18px");
	byId(button, "border-width", "1px");
	byId(button).innerHTML = "New";
	byId(button).addEventListener("click", DKAutomate2_OnEvent);


	byId("Effects").innerHTML = "";
	for(var e = 0; e < effects.length; e++){
		if(effects[e].trigger !== current_trigger){ continue; }
		
		var effect = DK_CreateElement(byId("Effects"), "div", "EffectDiv");

		var command = DK_CreateElement(byId(effect), "input", "EffectCommand");
		byId(command).type = "text";
		byId(command, "width", "100px");
		byId(command, "height", "18px");
		byId(command, "display", "inline-block");
		byId(command, "border-width", "1px");
		byId(command).num = String(e);
		byId(command).value = effects[e].command;
		byId(command).addEventListener("change", DKAutomate2_OnEvent);

		var var1 = DK_CreateElement(byId(effect), "input", "EffectVar1");
		byId(var1).type = "text";
		byId(var1, "width", "100px");
		byId(var1, "height", "18px");
		byId(var1, "display", "inline-block");
		byId(var1, "border-width", "1px");
		byId(var1).num = String(e);
		byId(var1).value = effects[e].var1;
		byId(var1).addEventListener("change", DKAutomate2_OnEvent);

		var var2 = DK_CreateElement(byId(effect), "input", "EffectVar2");
		byId(var2).type = "text";
		byId(var2).style  "width", "100px");
		byId(var2).style  "height", "18px");
		byId(var2).style  "display", "inline-block");
		byId(var2).style  "border-width", "1px");
		ById(var2).num = String(e);
		byId(var2).value = effects[e].var2;
		byId(var2).addEventListener("change", DKAutomate2_OnEvent);

		var var3 = DK_CreateElement(byId(effect), "input", "EffectVar3");
		byId(var3).type = "text";
		byId(var3, "width", "100px");
		byId(var3, "height", "18px");
		byId(var3, "display", "inline-block");
		byId(var3, "border-width", "1px");
		byId(var3).num = String(e);
		byId(var3).value = effects[e].var3;
		byId(var3).addEventListener("change", DKAutomate2_OnEvent);

		var button = DK_CreateElement(byId(effect), "button", "DeleteEffect");
		byId(button, "width", "50px");
		byId(button, "height", "18px");
		byId(button, "display", "inline-block");
		byId(button, "border-width", "1px");
		byId(button).num = String(e);
		byId(button).innerHTML = "Delete";
		byId(button).addEventListener("click", DKAutomate2_OnEvent);
	}

	var button2 = DK_CreateElement(byId("Effects"), "button", "NewEffect");
	byId(button2, "width", "50px");
	byId(button2, "height", "18px");
	byId(button2, "border-width", "1px");
	byId(button2).innerHTML = "New";
	byId(button2).addEventListener("click", DKAutomate2_OnEvent);
}