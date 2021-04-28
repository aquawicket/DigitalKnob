console.log("Loading DKColorPicker.js");

var event_type;
var event_id;

/////////////////////////////
function DKColorPicker_init()()()
{
	console.log("DKColorPicker_init()()()");
	dk.create("DKColorPicker/DKColorPicker.css");
	dk.create("DKColorPicker/DKColorPicker.html");
	byId("DKColorPicker/DKColorPicker.html").addEventListener("GetColor", DKColorPicker_onevent);
	byId("DKColorPickerBar").addEventListener("mousedown", DKColorPicker_onevent);
	byId("DKColorHover").addEventListener("mousedown", DKColorPicker_onevent);
	byId("DKColorPickerOK").addEventListener("click", DKColorPicker_onevent);
}

////////////////////////////
function DKColorPicker_end()()
{
	byId("DKColorPicker/DKColorPicker.html").removeEventListener("GetColor", DKColorPicker_onevent);
	byId("DKColorPickerBar").removeEventListener("mousedown", DKColorPicker_onevent);
	byId("DKColorHover").removeEventListener("mousedown", DKColorPicker_onevent);
	byId("DKColorPickerOK").removeEventListener("click", DKColorPicker_onevent);
	
	//FIXME - Crash
	//dk.close("DKColorPicker/DKColorPicker.html");
	//dk.close("DKColorPicker/DKColorPicker.css");
}

/////////////////////////////////////
function DKColorPicker_OnEvent(event)
{
	//console.log("DKColorPicker_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	
	if(event.currentTarget.id === "GetColor"){
		var params = DK_GetValue(event).split(",");
		event_id = params[0];
		event_type = params[1];
		//console.log("event_id:"+event_id+"\n");
		//console.log("event_type:"+event_type+"\n");
	}
	if(event.currentTarget.id === "DKColorPickerBar"){
		DKColorPicker_ColorBar(); //hover
	}
	if(event.currentTarget.id === "DKColorHover"){
		DKColorPicker_ColorBox();
	}
	if(event.currentTarget.id === "DKColorPickerOK"){
		//console.log("DKColorPickerOK\n");
		//console.log("event_id:"+event_id+"\n");
		//console.log("event_type:"+event_type+"\n");
		if(event_id){
			var color = byId("DKColorSelected").style.backgroundColor;
			DKSendEvent(event_id, event_type, color);
		}
		DKFrame_Close("DKColorPicker/DKColorPicker.html");
	}
}


/////////////////////////////////
function DKColorPicker_ColorBar()
{
	var temp = CPP_DK_GetPixelUnderMouse();
	var rgb_arry = temp.split(",");

	var rgb = "rgb(";
	rgb += String(rgb_arry[0]) + ",";
	rgb += String(rgb_arry[1]) + ",";
	rgb += String(rgb_arry[2]) + ")";
		
	byId("DKColorR").value = String(rgb_arry[0]);
	byId("DKColorG").value = String(rgb_arry[1]);
	byId("DKColorB").value = String(rgb_arry[2]);
	byId("DKColorHover").style.backgroundColor = rgb;
	byId("DKColorSelected").style.backgroundColor = rgb;
}

/////////////////////////////////
function DKColorPicker_ColorBox()
{
	var temp = CPP_DK_GetPixelUnderMouse();
	var rgb_arry = temp.split(",");

	var rgb = "rgb(";
	rgb += String(rgb_arry[0]) + ",";
	rgb += String(rgb_arry[1]) + ",";
	rgb += String(rgb_arry[2]) + ")";
		
	byId("DKColorR").value = String(rgb_arry[0]);
	byId("DKColorG").value = String(rgb_arry[1]);
	byId("DKColorB").value = String(rgb_arry[2]);
	byId("DKColorSelected").style.backgroundColor = rgb;
	//event->Stop();
}