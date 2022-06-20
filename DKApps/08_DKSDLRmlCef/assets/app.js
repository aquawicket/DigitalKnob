var USE_CEF = 1
var url = "chrome://gpu";

////// RmlUi
//if(CPP_DK_GetBrowser() === "RML"){
	CPP_DK_Create("DKDuktapeDom")
	CPP_DK_Create("DKSDLWindow")    //DO NOT Create DKSDLWindow directly
	CPP_DK_Create("DKSDLText")
	CPP_DK_Create("DKRml")
//}

var width = CPP_DKWindow_GetWidth()
var height = CPP_DKWindow_GetHeight()


///// CEF 
var iframe = document.createElement("iframe")
iframe.id = dk.getAvailableId("CefBrowserTab")
iframe.setAttribute("src", url)
iframe.style["position"] = "absolute"
iframe.style["top"] = "0rem"
iframe.style["left"] = "0rem"
iframe.style["width"] = "100%"
iframe.style["height"] = "100%"
iframe.style["background-color"] = "white"
document.body.appendChild(iframe)
CPP_DKRml_PostProcess()


	
//CPP_DK_Create("DKCef") 
//CPP_DKCef_NewBrowser("Cef",0,0,width,height,url)
//CPP_DKCef_ShowDevTools(0)

/*
window.addEventListener("keydown", function mykeydown(event){
	if(event.key === "F12")
		CPP_DKCef_ShowDevTools(0)	
})

window.addEventListener("resize", function onresize(event){
	//console.log("User_OnEvent(): resize\n")
	//CPP_DKCef_SetSize("CefSDL", 100, 100)
	var width = CPP_DKWindow_GetWidth()
	var height = CPP_DKWindow_GetHeight()
	DK_CallFunc("CefSDL::OnResize", "0,0,"+String(width)+","+String(height))
})
*/