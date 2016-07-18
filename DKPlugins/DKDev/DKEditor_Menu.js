
/////////////////////////////
function DKEditor_Menu_Init()
{
	DKCreate("DKDev/DKEditor_Menu.html");
	DKAddEvent("DKEditor_Menu_NewFrame", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewFrame2", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_OpenFile", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_OpenFile2", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewImage", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewText", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewDiv", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewButton", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewTextbox", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewTextarea", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewDropdown", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewCheckbox", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewRadioButton", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewiFrame", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewVSlider", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_NewHSlider", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_MoveToFront", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_Delete", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_Menu_Cut", "click", DKEditor_OnEvent);	
	DKAddEvent("DKEditor_Menu_Copy", "click", DKEditor_OnEvent);	
	DKAddEvent("DKEditor_Menu_Paste", "click", DKEditor_OnEvent);
}

////////////////////////////
function DKEditor_Menu_End()
{
	DKClose("DKDev/DKEditor_Menu.html");
}

/////////////////////////////////////
function DKEditor_Menu_OnEvent(event)
{
	if(DK_Id(event, "DKEditor_Menu_NewFrame")){
		DKEditor_NewPage(stored_element);
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_OpenFile")){
		DKCreate("DKFile/DKFileDialog.js");
		DKFrame_Widget("DKFileDialog.html");
		DKSendEvent("DKFileDialog.html", "GetFile", "GLOBAL,OpenFile,/,relative"); // To -> DKFileDialog
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_NewDiv")){
		DKEditor_NewDiv(stored_element);
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_NewImage")){
		DKCreate("DKFile/DKFileDialog.js");
		DKFrame_Widget("DKFileDialog.html");
		DKSendEvent("DKFileDialog.html", "GetFile", "GLOBAL,OpenFile,"+local_assets+",relative"); // To -> DKFileDialog
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_NewText")){
		DKEditor_NewText();
		return;
	}	
	if(DK_Id(event, "DKEditor_Menu_NewButton")){
		DKEditor_NewButton();
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_NewTextbox")){
		DKEditor_NewTextbox();
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_NewTextarea")){
		DKEditor_NewTextarea();
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_NewDropdown")){
		DKEditor_NewDropdown();
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_NewCheckbox")){
		DKEditor_NewCheckbox();
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_NewRadioButton")){
		DKEditor_NewRadioButton();
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_NewiFrame")){
		DKEditor_NewiFrame();
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_NewVSlider")){
		DKEditor_NewVSlider();
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_NewHSlider")){
		DKEditor_NewHSlider();
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_Delete")){
		DKWidget_PrependChild("body", "DKC-DKEditorBox");
		DKWidget_RemoveElement(stored_element);
		stored_element = "body";
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_MoveToFront")){
		//DKWidget_MoveToFront(stored_element);
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_Cut")){
		DKEditor_Cut();
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_Copy")){
		DKEditor_Copy();
		return;
	}
	if(DK_Id(event, "DKEditor_Menu_Paste")){
		DKEditor_Paste();
		return;
	}
}