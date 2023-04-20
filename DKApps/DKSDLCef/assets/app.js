var USE_CEF = 1
//var url = "chrome://gpu";
var url = "https://google.com";

CPP_DK_Create("DKSdlWindow")
CPP_DK_Create("DKSdlText")
CPP_DK_Create("DKCef")
var width = CPP_DKWindow_GetWidth()
var height = CPP_DKWindow_GetHeight()
CPP_DKCef_NewBrowser("SdlCef", 0, 0, width, height, url)


function OnResize(event){
	console.log("onresize\n")
	//CPP_DKCef_SetSize("SdlCef", 100, 100)
	var width = CPP_DKWindow_GetWidth()
	var height = CPP_DKWindow_GetHeight()
	DK_CallFunc("SdlCef::OnResize", "0,0,"+String(width)+","+String(height))
}
window.addEventListener("resize", OnResize)