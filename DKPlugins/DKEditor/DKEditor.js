////////////////////////
function DKEditor_Init()
{
	DKCreate("DKEditor/DKEditor.html");

	//DKWidget_AddDragHandle("DKEditor.html", "DKEditor.html"); //FIXME - this eats the click event
	DKAddEvent("DKEditor_edit", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_edit", "contextmenu", DKEditor_OnEvent);
	
}

///////////////////////
function DKEditor_End()
{
	DKClose("DKEditor/DKEditor.html");
}

////////////////////////////////
function DKEditor_OnEvent(event)
{
	DKLog("DKEditor_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKINFO);
	
	if(DK_Id(event, "DKEditor_edit")){
		DKCreate("DKEditor/DKEditor_Menu.js", function(){});
	}
}