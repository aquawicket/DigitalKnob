/////////////////////
function DKOcr_Init()
{
	DKLog("DKOcr_Init()\n");
	
	DKCreate("DKNotepad/DKNotepad.html");
}

////////////////////
function DKOcr_End()
{
	DKLog("DKOcr_End()\n");
	
	DKRemoveEvents(DKOcr_OnEvent);
}

/////////////////////////////
function DKOcr_OnEvent(event)
{
	DKLog("DKOcr_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
}