////////////////////////
function DKEditor_Init()
{
	DKCreate("DKEditor/DKEditor.html");
	DKAddEvent("DKEditor_edit", "click", DKEditor_OnEvent);
	DKAddEvent("DKEditor_edit", "contextmenu", DKEditor_OnEvent);
	DKWidget_AddDragHandle("DKEditor.html", "DKEditor.html");
}

///////////////////////
function DKEditor_End()
{
	DKClose("DKEditor/DKEditor.html");
}

////////////////////////////////
function DKEditor_OnEvent(event)
{
	//DKLog("DKEditor_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Id(event, "DKEditor_edit")){
		DKCreate("DKEditor/DKEditor_Menu.js", function(){
			
			//make sure menu is within window
			var win_width = DKWidget_GetClientWidth("body");
			var win_height = DKWidget_GetClientHeight("body");
			var top = DKWidget_GetOffsetTop("DKEditor_Menu.html");
			var left = DKWidget_GetOffsetLeft("DKEditor_Menu.html");
			var width = DKWidget_GetClientWidth("DKEditor_Menu.html");
			var height = DKWidget_GetClientHeight("DKEditor_Menu.html");
			if(top + height > win_height){
				top = win_height - height;
				DKWidget_SetProperty("DKEditor_Menu.html", "top", top+"px");
			}
			if(left + width > win_width){
				left = win_width - width;
				DKWidget_SetProperty("DKEditor_Menu.html", "left", left+"px");
			}
		});
	}
}