var event_type;
var event_id;

/////////////////////////////
function DKColorPicker_Init()
{
	DKCreate("DKColorPicker/DKColorPicker.html");
	DKAddEvent("DKColorPicker.html", "GetColor", DKColorPicker_OnEvent);
	DKAddEvent("DKColorPickerBar", "mousedown", DKColorPicker_OnEvent);
	DKAddEvent("DKColorHover", "mousedown", DKColorPicker_OnEvent);
	DKAddEvent("DKColorPickerClose", "click", DKColorPicker_OnEvent);
	DKAddEvent("DKColorPickerOK", "click", DKColorPicker_OnEvent);
}

////////////////////////////
function DKColorPicker_End()
{
	DKRemoveEvent("DKColorPicker.html", "GetColor", DKColorPicker_OnEvent);
	DKRemoveEvent("DKColorPickerBar", "mousedown", DKColorPicker_OnEvent);
	DKRemoveEvent("DKColorHover", "mousedown", DKColorPicker_OnEvent);
	DKRemoveEvent("DKColorPickerClose", "click", DKColorPicker_OnEvent);
	DKRemoveEvent("DKColorPickerOK", "click", DKColorPicker_OnEvent);
	DKClose("DKColorPicker.html");
}

/////////////////////////////////////
function DKColorPicker_OnEvent(event)
{
	DKLog("DKColorPicker_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DKWidget_GetValue(event)+")\n", DKDEBUG);
	
	if(DK_Type(event, "GetColor")){
		var params = DKWidget_GetValue(event).split(",");
		event_id = params[0];
		event_type = params[1];
		//DKLog("event_id:"+event_id);
		//DKLog("event_type:"+event_type);
	}
	if(DK_Id(event, "DKColorPickerBar")){
		DKColorPicker_ColorBar(); //hover
	}
	if(DK_Id(event, "DKColorHover")){
		DKColorPicker_ColorBox();
	}
	if(DK_Id(event, "DKColorPickerOK")){
		//DKLog("DKColorPickerOK");
		//DKLog("event_id:"+event_id);
		//DKLog("event_type:"+event_type);
		if(event_id){
			var color = DKWidget_GetProperty("DKColorSelected", "background-color");
			DKSendEvent(event_id, event_type, color);
		}
		DKFrame_Close("DKColorPicker.html");
	}
}


/////////////////////////////////
function DKColorPicker_ColorBar()
{
	var temp = DK_GetPixelUnderMouse();
	var rgb_arry = temp.split(",");

	var rgb = "rgb(";
	rgb += String(rgb_arry[0]) + ",";
	rgb += String(rgb_arry[1]) + ",";
	rgb += String(rgb_arry[2]) + ")";
		
	DKWidget_SetValue("DKColorR", String(rgb_arry[0]));
	DKWidget_SetValue("DKColorG", String(rgb_arry[1]));
	DKWidget_SetValue("DKColorB", String(rgb_arry[2]));
	DKWidget_SetProperty("DKColorHover", "background-color", rgb);
	DKWidget_SetProperty("DKColorSelected", "background-color", rgb);
}

/////////////////////////////////
function DKColorPicker_ColorBox()
{
	var temp = DK_GetPixelUnderMouse();
	var rgb_arry = temp.split(",");

	var rgb = "rgb(";
	rgb += String(rgb_arry[0]) + ",";
	rgb += String(rgb_arry[1]) + ",";
	rgb += String(rgb_arry[2]) + ")";
		
	DKWidget_SetValue("DKColorR", String(rgb_arry[0]));
	DKWidget_SetValue("DKColorG", String(rgb_arry[1]));
	DKWidget_SetValue("DKColorB", String(rgb_arry[2]));
	DKWidget_SetProperty("DKColorSelected", "background-color", rgb);
	//event->Stop();
}

