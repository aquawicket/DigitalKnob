////////////////////////
function Template_Init()
{
	DKLog("Template_Init()\n");
	
	var title = DKWidget_CreateElement("head", "title", "title");
	DKWidget_SetInnerHtml(title, "DKTemplate - A template for creating Digitalknob Apps");
		
	DKWidget_SetProperty("body","background-color","grey");
	
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