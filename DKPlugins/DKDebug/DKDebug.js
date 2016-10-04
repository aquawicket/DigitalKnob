/////////////////////////
function DKDebug_Init()
{
	DKAddEvent("GLOBAL", "keydown", DKDebug_OnEvent);
}

//////////////////////
function DKDebug_End()
{

}

///////////////////////////////
function DKDebug_OnEvent(event)
{
	if(DK_Type(event, "click")){
		//Function();
	}
}
