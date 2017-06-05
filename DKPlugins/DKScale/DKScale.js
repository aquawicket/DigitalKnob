//////////////////////
function DKScale_Init()
{
	DKAddEvent("GLOBAL", "resize", DKScale_OnEvent);
	DKScale_Resize();
}

/////////////////////
function DKScale_End()
{
	DKRemoveEvent("GLOBAL", "resize", DKScale_OnEvent);
}

//////////////////////////////
function DKScale_OnEvent(event)
{
	//DKLog("DKScale_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "resize")){
		DKScale_Resize();
	}
}

////////////////////////
function DKScale_Resize()
{
    //DKLog("DKWindow_GetPixelRatio() = "+DKWindow_GetPixelRatio()+"\n");
	//Set the scale
	if((parseInt(DKWindow_GetHeight()) > parseInt(DKWindow_GetWidth())) && (parseFloat(DKWindow_GetPixelRatio()) > 1)){
		var pixel_ratio = DKWindow_GetPixelRatio();
		if(pixel_ratio > 1.0){//= Math.min(2, pixel_ratio);
			pixel_ratio = 2.0;
			DKWidget_SetProperty("html", "font-size", pixel_ratio+"px");
			DKLog("DKScale_Resize(): scale set to "+pixel_ratio+"px\n");
		}
	}
	else{
		DKWidget_SetProperty("html", "font-size", "1px");
		DKLog("DKScale_Resize(): scale set to 1px\n");
	}
}