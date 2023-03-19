var USE_CEF = 1
//var url = "chrome://gpu";
var url = "https://google.com";

CPP_DK_Create("DKSDLWindow")
CPP_DK_Create("DKSDLText")
CPP_DK_Create("DKCef")
var width = CPP_DKWindow_GetWidth()
var height = CPP_DKWindow_GetHeight()
CPP_DKCef_NewBrowser("CefSDL", 0, 0, width, height, url)


function OnResize(event){
	console.log("onresize\n")
	//CPP_DKCef_SetSize("CefSDL", 100, 100)
	var width = CPP_DKWindow_GetWidth()
	var height = CPP_DKWindow_GetHeight()
	DK_CallFunc("CefSDL::OnResize", "0,0,"+String(width)+","+String(height))
}
window.addEventListener("resize", OnResize)