////////////////////////
function Template_Init()
{
	DKLog("Template_Init()\n");
	DKCreate("Template.html", function(){});
}

///////////////////////
function Template_End()
{
	DKLog("Template_End()\n");
}

////////////////////////////////
function Template_OnEvent(event)
{
	DKLog("Template_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
}