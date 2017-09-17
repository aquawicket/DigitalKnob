var pixel_ratio = 1.0;

///////////////////////
function DKScale_Init()
{
	DKAddEvent("GLOBAL", "resize", DKScale_OnEvent);
	DKScale_Resize();
}

//////////////////////
function DKScale_End()
{
	DKRemoveEvents(DKScale_OnEvent);
}

///////////////////////////////
function DKScale_OnEvent(event)
{
	//DKLog("DKScale_OnEvent("+DK_GetId(event)+","+DK_GetType(event)+","+DK_GetValue(event)+")\n");
	
	if(DK_Type(event, "resize")){
		DKScale_Resize();
	}
}

/////////////////////////
function DKScale_Resize()
{
	//DKLog("DKScale_Resize()\n");
    //DKLog("DKWindow_GetPixelRatio() = "+DKWindow_GetPixelRatio()+"\n");
	//DKLog("DKWindow_GetWidth() = "+DKWindow_GetWidth()+"\n");
	//DKLog("DKWindow_GetHeight() = "+DKWindow_GetHeight()+"\n");
	
	if(pixel_ratio == DKWindow_GetPixelRatio()){ return true; } //nothing to be done
	pixel_ratio = DKWindow_GetPixelRatio();

	//Set the scale
	/*
	if((parseInt(DKWindow_GetHeight()) > parseInt(DKWindow_GetWidth()))){
		if(pixel_ratio > 1.0){//= Math.min(2, pixel_ratio);
			var ratio = 2.0;
			DKWidget_SetProperty("html", "font-size", ratio+"px");
			DKLog("DKScale_Resize(): scale set to "+ratio+"px\n");
		}
	}
	else{
		DKWidget_SetProperty("html", "font-size", "1px");
		DKLog("DKScale_Resize(): scale set to 1px\n");
	}
	*/
}