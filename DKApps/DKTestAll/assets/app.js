//CPP_DK_Create("DKDuktapeDom")
//CPP_DK_Create("DKDebug")
CPP_DK_Create("DKSDLWindow")
CPP_DK_Create("DKRml")

const url = CPP_DKAssets_LocalAssets()+"DKWebTest/index.html"
location.href = url

//// Resize SDLRml window
/*
const sdl_x = window.screen.width / 2
const sdl_y = 0
const sdl_width = window.screen.width / 2
const sdl_height = window.screen.height
const sdl_x_offset = 0
const sdl_y_offest = 30
const sdl_width_offset = 1
const sdl_height_offset = -30
window.resizeTo(sdl_width+sdl_width_offset, sdl_height+sdl_height_offset)
window.moveTo(sdl_x+sdl_x_offset, sdl_y+sdl_y_offest)
*/

//// Add Debugger and Fullscreen keyboard events
window.addEventListener("keydown", function window_onkeydown(event){
	if(event.code === "F11")
		CPP_DKWindow_IsFullscreen() ? CPP_DKWindow_Windowed() : CPP_DKWindow_Fullscreen()
	if(event.code === "F12")
		CPP_DKRml_ToggleDebugger()
})


//// Run local php server
/*
console.log("app.js: CPP_DK_GetOS() = "+CPP_DK_GetOS()+"\n")
if(CPP_DK_GetOS() == "Windows"){
	CPP_DKFile_ChDir(CPP_DKAssets_LocalAssets()+"DKPhp/")
	const batch = CPP_DKAssets_LocalAssets()+"DKPhp/RunPhpServers.bat"
	CPP_DK_System(batch)
}
*/
	
//// Create Cef window
/*
const cef_x = 0
const cef_y = 0
const cef_width = window.screen.width / 2
const cef_height = window.screen.height / 2
const cef_x_offset = -8
const cef_y_offset = -1
const cef_width_offset = +16
const cef_height_offset = +9
CPP_DK_Create("DKCef")
CPP_DKCef_NewBrowser("Cef", cef_y+cef_y_offset, cef_x+cef_x_offset, cef_width+cef_width_offset, cef_height+cef_height_offset, url)
*/
//CPP_DK_SendEvent = function(){} //just consume the message from CEF for now

/*
window.addEventListener("keydown", function window_onkeydown(event){
	if(event.code === "F11")
		CPP_DKWindow_IsFullscreen() ? CPP_DKWindow_Windowed() : CPP_DKWindow_Fullscreen()
	if(event.code === "F12")
*/		
		//CPP_DKCef_ShowDevTools(0)
//})



//// Position Console window
/*
const console_x = 0
const console_y = window.screen.height / 2
const console_width = window.screen.width
const console_height = window.screen.height / 2
const console_x_offset = -8
const console_y_offest = -1
const console_width_offset = +16
const console_height_offset = +9
CPP_DK_setConsolePosition(console_x+console_x_offset, console_y+console_y_offest, console_width+console_width_offset, console_height+console_height_offset)
*/
//console.resizeTo(console_width+console_width_offset, console_height+console_height_offset)
//console.moveTo(console_x+console_x_offset, console_y+console_y_offest)
