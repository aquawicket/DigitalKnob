console.log("Loading DKColorPicker.js");

var event_type;
var event_id;

/////////////////////////////
function DKColorPicker_Init()
{
	//DKDEBUGFUNC();
	console.log("DKColorPicker_Init()");
	DKCreate("DKColorPicker/DKColorPicker.css");
	DKCreate("DKColorPicker/DKColorPicker.html");
	DKAddEvent("DKColorPicker/DKColorPicker.html", "GetColor", DKColorPicker_OnEvent);
	DKAddEvent("DKColorPickerBar", "mousedown", DKColorPicker_OnEvent);
	DKAddEvent("DKColorHover", "mousedown", DKColorPicker_OnEvent);
	DKAddEvent("DKColorPickerOK", "click", DKColorPicker_OnEvent);
}

////////////////////////////
function DKColorPicker_End()
{
	DKDEBUGFUNC();	
	
	//FIXME - Crash
	//DKRemoveEvents(DKColorPicker_OnEvent);
	//DKClose("DKColorPicker/DKColorPicker.html");
	//DKClose("DKColorPicker/DKColorPicker.css");
}

/////////////////////////////////////
function DKColorPicker_OnEvent(event)
{
	DKDEBUGFUNC();
	//console.log("DKColorPicker_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	if(event.currentTarget.id == "GetColor"){
		var params = DK_GetValue(event).split(",");
		event_id = params[0];
		event_type = params[1];
		//DKINFO("event_id:"+event_id+"\n");
		//DKINFO("event_type:"+event_type+"\n");
	}
	if(event.currentTarget.id == "DKColorPickerBar"){
		DKColorPicker_ColorBar(); //hover
	}
	if(event.currentTarget.id == "DKColorHover"){
		DKColorPicker_ColorBox();
	}
	if(event.currentTarget.id == "DKColorPickerOK"){
		//DKINFO("DKColorPickerOK\n");
		//DKINFO("event_id:"+event_id+"\n");
		//DKINFO("event_type:"+event_type+"\n");
		if(event_id){
			var color = DKWidget_GetProperty("DKColorSelected", "background-color");
			DKSendEvent(event_id, event_type, color);
		}
		DKFrame_Close("DKColorPicker/DKColorPicker.html");
	}
}


/////////////////////////////////
function DKColorPicker_ColorBar()
{
	DKDEBUGFUNC();	
	var temp = DK_GetPixelUnderMouse();
	var rgb_arry = temp.split(",");

	var rgb = "rgb(";
	rgb += String(rgb_arry[0]) + ",";
	rgb += String(rgb_arry[1]) + ",";
	rgb += String(rgb_arry[2]) + ")";
		
	DKWidget_SetValue("DKColorR", String(rgb_arry[0]));
	DKWidget_SetValue("DKColorG", String(rgb_arry[1]));
	DKWidget_SetValue("DKColorB", String(rgb_arry[2]));
	byId("DKColorHover").style.backgroundColor = rgb;
	byId("DKColorSelected").style.backgroundColor = rgb;
}

/////////////////////////////////
function DKColorPicker_ColorBox()
{
	DKDEBUGFUNC();	
	var temp = DK_GetPixelUnderMouse();
	var rgb_arry = temp.split(",");

	var rgb = "rgb(";
	rgb += String(rgb_arry[0]) + ",";
	rgb += String(rgb_arry[1]) + ",";
	rgb += String(rgb_arry[2]) + ")";
		
	DKWidget_SetValue("DKColorR", String(rgb_arry[0]));
	DKWidget_SetValue("DKColorG", String(rgb_arry[1]));
	DKWidget_SetValue("DKColorB", String(rgb_arry[2]));
	byId("DKColorSelected").style.backgroundColor = rgb;
	//event->Stop();
}