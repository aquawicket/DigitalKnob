var USE_CEF = 1
//var url = "chrome://gpu";
const url = CPP_DKAssets_LocalAssets()+"DKWebTest/index.html"
//var url = "http://youtube.com";

////// RmlUi
//if(CPP_DK_GetBrowser() === "RML"){
	CPP_DK_Create("DKSDLWindow")    //DO NOT Create DKSDLWindow directly
	CPP_DK_Create("DKSDLText")
	CPP_DK_Create("DKRml")
//}

console.log("screen.width = "+screen.width)
console.log("screen.height = "+screen.height)

window.resizeTo(1000,600)


///// CEF
var iframe = document.createElement("iframe")
iframe.id = "CefBrowserTab0"//dk.getAvailableId("CefBrowserTab")
iframe.setAttribute("src", url)
iframe.style["position"] = "absolute"
iframe.style["top"] = "0rem"
iframe.style["left"] = "0rem"
var width = CPP_DKWindow_GetWidth()
var height = CPP_DKWindow_GetHeight()
iframe.style["width"] = width+"px"
iframe.style["height"] = height+"px"
iframe.style["background-color"] = "white"
document.body.appendChild(iframe)
CPP_DKRml_PostProcess()


window.addEventListener("keydown", function mykeydown(event){
	console.log("event.key = "+event.key)
	if(event.key === "F12")
		CPP_DKCef_ShowDevTools(0)	
})

window.addEventListener("resize", function onresize(event){
	//CPP_DKCef_SetSize("CefSDL", 100, 100)
	var width = CPP_DKWindow_GetWidth()
	var height = CPP_DKWindow_GetHeight()
	var iframe = document.getElementById("CefBrowserTab0")
	iframe.style["width"] = width+"px"
	iframe.style["height"] = height+"px"
})
