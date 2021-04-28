///////////////////////////
function DKAutomate2_init()()
{
	dk.create("DKTriggers/DKAutomate2.html,DKTriggers/DKAutomate.html", function(){
		byId("DKTriggers/DKAutomate2.html").addEventListener("SelectTrigger", DKAutomate2_onevent);
		byId("DKTriggers/DKAutomate2.html").addEventListener("input", DKAutomate2_onevent);
	});
}

//////////////////////////
function DKAutomate2_end()()
{
	byId("DKTriggers/DKAutomate2.html").removeEventListener("SelectTrigger", DKAutomate2_onevent);
	byId("DKTriggers/DKAutomate2.html").removeEventListener("input", DKAutomate2_onevent);
	dk.close("DKTriggers/DKAutomate2.html");
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
		
		var command = DK_CreateElement(cause, "input", "CauseCommand");
		command.type = "text";
		command.style.width = "100px";
		command.style.height = "18px";
		command.style.display = "inline-block";
		command.style.borderWidth = "1px";
		command.num = String(c);
		command.value = causes[c].command;
		command.addEventListener("change", DKAutomate2_onevent);

		var var1 = DK_CreateElement(cause, "input", "CauseVar1");
		var1.type = "text";
		var1.style.width = "100px";
		var1.style.height = "18px";
		var1.style.display = "inline-block";
		var1.style.borderWidth = "1px";
		var1.num = String(c);
		var1.value = causes[c].var1;
		var1.addEventListener("change", DKAutomate2_onevent);

		var var2 = DK_CreateElement(cause, "input", "CauseVar2");
		var2.type = "text";
		var2.style.width = "100px";
		var2.style.height = "18px";
		var2.style.display = "inline-block";
		var2.style.borderWidth = "1px";
		var2.num = String(c);
		var2.value = causes[c].var2;
		var2.addEventListener("change", DKAutomate2_onevent);

		var var3 = DK_CreateElement(cause, "input", "CauseVar3");
		var3.type = "text";
		var3.style.width = "100px";
		var3.style.height = "18px";
		var3.style.display = "inline-block";
		var3.style.borderWidth = "1px";
		var3.num = String(c);
		var3.value = causes[c].var3;
		var3.addEventListener("change", DKAutomate2_onevent);

		var button = DK_CreateElement(cause, "button", "DeleteCause");
		button.style.width = "50px";
		button.style.height = "18px";
		button.style.display = "inline-block";
		button.style.borderWidth = "1px";
		button.num = String(c);
		button.innerHTML = "Delete";
		button.addEventListener("click", DKAutomate2_onevent);
	}

	var button = DK_CreateElement(byId("Causes"), "button", "NewCause");
	button.style.width = "50px";
	button.style.height = "18px";
	button.borderWidth = "1px";
	button.innerHTML = "New";
	button.addEventListener("click", DKAutomate2_onevent);


	byId("Effects").innerHTML = "";
	for(var e = 0; e < effects.length; e++){
		if(effects[e].trigger !== current_trigger){ continue; }
		
		var effect = DK_CreateElement(byId("Effects"), "div", "EffectDiv");

		var command = DK_CreateElement(effect, "input", "EffectCommand");
		command.type = "text";
		command.style.width = "100px";
		command.style.height = "18px";
		command.style.display = "inline-block";
		command.style.borderWidth = "1px";
		command.num = String(e);
		command.value = effects[e].command;
		command.addEventListener("change", DKAutomate2_onevent);

		var var1 = DK_CreateElement(effect, "input", "EffectVar1");
		var1.type = "text";
		var1.style.width = "100px";
		var1.style.height = "18px";
		var1.style.display = "inline-block";
		var1.style.borderWidth = "1px";
		var1.num = String(e);
		var1.value = effects[e].var1;
		var1.addEventListener("change", DKAutomate2_onevent);

		var var2 = DK_CreateElement(effect, "input", "EffectVar2");
		var2.type = "text";
		var2.style.width = "100px";
		var2.style.height = "18px";
		var2.style.display = "inline-block";
		var2.style.borderWidth = "1px";
		var2.num = String(e);
		var2.value = effects[e].var2;
		var2.addEventListener("change", DKAutomate2_onevent);

		var var3 = DK_CreateElement(effect, "input", "EffectVar3");
		var3.type = "text";
		var3.style.width = "100px";
		var3.style.height = "18px";
		var3.style.display = "inline-block";
		var3.style.borderWidth = "1px";
		var3.num = String(e);
		var3.value = effects[e].var3;
		var3.addEventListener("change", DKAutomate2_onevent);

		var button = DK_CreateElement(effect, "button", "DeleteEffect");
		button.style.width = "50px";
		button.style.height = "18px";
		button.style.display = "inline-block";
		button.style.borderWidth = "1px";
		button.num = String(e);
		button.innerHTML = "Delete";
		button.addEventListener("click", DKAutomate2_onevent);
	}

	var button2 = DK_CreateElement(byId("Effects"), "button", "NewEffect");
	button2.style.width = "50px";
	button2.style.height = "18px";
	button2.style.borderWidth = "1px";
	button2.innerHTML = "New";
	button2.addEventListener("click", DKAutomate2_onevent);
}