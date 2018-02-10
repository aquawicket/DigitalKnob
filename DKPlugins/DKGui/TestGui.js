///////////////////////
function TestGui_Init()
{
	DKLog("TestGui_Init()\n");
	DKCreate("DKGui/TestGui.html");
}

//////////////////////
function TestGui_End()
{
	DKLog("TestGui_End()\n");
}

///////////////////////////////
function TestGui_OnEvent(event)
{
	DKLog("TestGui_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
}