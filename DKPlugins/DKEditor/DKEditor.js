////////////////////////
function DKEditor_Init()
{
	DKCreate("DKEditor/DKEditor.html");
	DKAddEvent("DKEditor_edit", "click", DKEditor_OnEvent);
	//DKWidget_AddDragHandle("DKEditor_edit", "DKEditor_edit");
}

///////////////////////
function DKEditor_End()
{
	DKClose("DKEditor/DKEditor.html");
}

////////////////////////////////
function DKEditor_OnEvent(event)
{
	//DKLog("DKEditor_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKINFO);
	
	if(DK_Id(event, "DKEditor_edit")){
		DKCreate("DKEditor/DKEditor_Menu.js", function(){});
	}
}