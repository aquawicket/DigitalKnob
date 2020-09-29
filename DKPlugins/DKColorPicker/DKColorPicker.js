console.log("Loading DKColorPicker.js");

var event_type;
var event_id;

/////////////////////////////
function DKColorPicker_Init()
{
	console.log("DKColorPicker_Init()");
	DKCreate("DKColorPicker/DKColorPicker.css");
	DKCreate("DKColorPicker/DKColorPicker.html");
	byId("DKColorPicker/DKColorPicker.html").addEventListener("GetColor", DKColorPicker_OnEvent);
	byId("DKColorPickerBar").addEventListener("mousedown", DKColorPicker_OnEvent);
	byId("DKColorHover").addEventListener("mousedown", DKColorPicker_OnEvent);
	byId("DKColorPickerOK").addEventListener("click", DKColorPicker_OnEvent);
}

////////////////////////////
function DKColorPicker_End()
{
	byId("DKColorPicker/DKColorPicker.html").removeEventListener("GetColor", DKColorPicker_OnEvent);
	byId("DKColorPickerBar").removeEventListener("mousedown", DKColorPicker_OnEvent);
	byId("DKColorHover").removeEventListener("mousedown", DKColorPicker_OnEvent);
	byId("DKColorPickerOK").removeEventListener("click", DKColorPicker_OnEvent);
	
	//FIXME - Crash
	//DKClose("DKColorPicker/DKColorPicker.html");
	//DKClose("DKColorPicker/DKColorPicker.css");
}

/////////////////////////////////////
function DKColorPicker_OnEvent(event)
{
	//console.log("DKColorPicker_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	if(event.currentTarget.id == "GetColor"){
		var params = DK_GetValue(event).split(",");
		event_id = params[0];
		event_type = params[1];
		//console.lof("event_id:"+event_id+"\n");
		//console.lof("event_type:"+event_type+"\n");
	}
	if(event.currentTarget.id == "DKColorPickerBar"){
		DKColorPicker_ColorBar(); //hover
	}
	if(event.currentTarget.id == "DKColorHover"){
		DKColorPicker_ColorBox();
	}
	if(event.currentTarget.id == "DKColorPickerOK"){
		//console.lof("DKColorPickerOK\n");
		//console.lof("event_id:"+event_id+"\n");
		//console.lof("event_type:"+event_type+"\n");
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