
/////////////////////////////
function DKEditor_Menu_Init()
{
	DKCreate("DKEditor/DKEditor_Menu.html");
	DKWidget_SetProperty("DKEditor_Menu.html","top",DKWindow_GetMouseY()+"rem");
	DKWidget_SetProperty("DKEditor_Menu.html","left",DKWindow_GetMouseX()+"rem");
	DKAddEvent("DKEditor_Menu_Assets", "click", DKEditor_Menu_OnEvent);
}

////////////////////////////
function DKEditor_Menu_End()
{
	DKRemoveEvent("DKEditor_Menu_Assets", "click", DKEditor_Menu_OnEvent);
	DKClose("DKEditor/DKEditor_Menu.html");
}

/////////////////////////////////////
function DKEditor_Menu_OnEvent(event)
{
	//DKLog("DKEditor_Menu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n", DKINFO);
	
	if(DK_Id(event, "DKEditor_Menu_Assets")){
		//DKLog("Assets", DKINFO);
		DKCreate("DKBuild/DKSolution.js", function(){
			DKFrame_Widget("DKSolution.html");
		});
	}

	DKClose("DKEditor/DKEditor_Menu.js");
}