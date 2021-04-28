/////////////////////
function Input_init()
{
	dk.create("DKDebug/Input.html");
	byId("Input_Text").addEventListener("keydown", Input_onevent);
}

////////////////////
function Input_end()()
{
	byId("Input_Text").removeEventListener("keydown", Input_onevent);
	dk.close("DKDebug/Input.html");
}

/////////////////////////////
function Input_OnEvent(event)
{
	DKDEBUG("Input_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id === "Input_Text"){
		if(event.code === "Enter"){ return; }
		Input_Run(byId("Input_Text").value)
	}
}

///////////////////////////
function Input_Run(command)
{
	DK_RunDuktape(command);
}