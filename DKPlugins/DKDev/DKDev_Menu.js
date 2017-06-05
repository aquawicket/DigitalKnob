
//////////////////////////
function DKDev_Menu_Init()
{
	DKCreate("DKDev/DKDev_Menu.html", function(){});
	DKWidget_SetProperty("DKDev_Menu.html","top",DKWindow_GetMouseY()+"rem");
	DKWidget_SetProperty("DKDev_Menu.html","left",DKWindow_GetMouseX()+"rem");
	DKAddEvent("GLOBAL", "mousedown", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewFrame", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewFrame2", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_OpenFile", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_OpenFile2", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewImage", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewText", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewDiv", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewButton", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewTextbox", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewTextarea", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewDropdown", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewCheckbox", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewRadioButton", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewiFrame", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewVSlider", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_NewHSlider", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_MoveToFront", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_Delete", "click", DKDev_Menu_OnEvent);
	DKAddEvent("DKDev_Menu_Cut", "click", DKDev_Menu_OnEvent);	
	DKAddEvent("DKDev_Menu_Copy", "click", DKDev_Menu_OnEvent);	
	DKAddEvent("DKDev_Menu_Paste", "click", DKDev_Menu_OnEvent);
}

/////////////////////////
function DKDev_Menu_End()
{
	DKRemoveEvent("GLOBAL", "mousedown", DKDev_Menu_OnEvent);
	DKRemoveEvents(DKDev_Menu_OnEvent);
	DKClose("DKDev/DKDev_Menu.html");
}

//////////////////////////////////
function DKDev_Menu_OnEvent(event)
{
	DKLog("DKDev_Menu_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "DKDev_Menu_NewFrame")){
		DKDev_NewPage(stored_element);
	}
	if(DK_Id(event, "DKDev_Menu_OpenFile")){
		DKCreate("DKFile/DKFileDialog.js", function(){
			DKFrame_Widget("DKFileDialog.html");
			var assets = DKAssets_LocalAssets();
			DKSendEvent("DKFileDialog.html", "GetFile", "GLOBAL,OpenFile,"+assets+",relative"); // To -> DKFileDialog
		});
	}
	if(DK_Id(event, "DKDev_Menu_NewDiv")){
		DKDev_NewDiv(stored_element);
	}
	if(DK_Id(event, "DKDev_Menu_NewImage")){
		DKCreate("DKFile/DKFileDialog.js", function(){
			DKFrame_Widget("DKFileDialog.html");
			var assets = DKAssets_LocalAssets();
			DKSendEvent("DKFileDialog.html", "GetFile", "GLOBAL,OpenFile,"+assets+",relative"); // To -> DKFileDialog
		});
	}
	if(DK_Id(event, "DKDev_Menu_NewText")){
		DKDev_NewText();
	}	
	if(DK_Id(event, "DKDev_Menu_NewButton")){
		DKDev_NewButton();
	}
	if(DK_Id(event, "DKDev_Menu_NewTextbox")){
		DKDev_NewTextbox();
	}
	if(DK_Id(event, "DKDev_Menu_NewTextarea")){
		DKDev_NewTextarea();
	}
	if(DK_Id(event, "DKDev_Menu_NewDropdown")){
		DKDev_NewDropdown();
	}
	if(DK_Id(event, "DKDev_Menu_NewCheckbox")){
		DKDev_NewCheckbox();
	}
	if(DK_Id(event, "DKDev_Menu_NewRadioButton")){
		DKDev_NewRadioButton();
	}
	if(DK_Id(event, "DKDev_Menu_NewiFrame")){
		DKDev_NewiFrame();
	}
	if(DK_Id(event, "DKDev_Menu_NewVSlider")){
		DKDev_NewVSlider();
	}
	if(DK_Id(event, "DKDev_Menu_NewHSlider")){
		DKDev_NewHSlider();
	}
	if(DK_Id(event, "DKDev_Menu_Delete")){
		DKWidget_PrependChild("body", "DKDev_Box");
		DKWidget_RemoveElement(stored_element);
		stored_element = "body";
	}
	if(DK_Id(event, "DKDev_Menu_MoveToFront")){
		//DKWidget_MoveToFront(stored_element);
	}
	if(DK_Id(event, "DKDev_Menu_Cut")){
		DKDev_Cut();
	}
	if(DK_Id(event, "DKDev_Menu_Copy")){
		DKDev_Copy();
	}
	if(DK_Id(event, "DKDev_Menu_Paste")){
		DKDev_Paste();
	}
	
	if(DK_Id(event, "GLOBAL")){
		if(DKWidget_IsChildOf(DKWidget_GetHoverElement(), "DKDev_Menu.html")){
			return;
		}
	}
	DKClose("DKDev/DKDev_Menu.js");
}