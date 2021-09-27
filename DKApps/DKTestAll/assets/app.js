const url = CPP_DKAssets_LocalAssets()+"index.html"
//const url = CPP_DKAssets_LocalAssets()+"DKWebTest/index.html"

//// Create Cef window
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
CPP_DK_SendEvent = function(){} //just consume the message from CEF for now
/*
window.addEventListener("keydown", function window_onkeydown(event){
	if(event.code === "F11")
		CPP_DKWindow_IsFullscreen() ? CPP_DKWindow_Windowed() : CPP_DKWindow_Fullscreen()
	if(event.code === "F12")
*/		
		CPP_DKCef_ShowDevTools(0)
//})


//// Create SDLRml window
const sdl_x = window.screen.width / 2
const sdl_y = 0
const sdl_width = window.screen.width / 2
const sdl_height = window.screen.height / 2
const sdl_x_offset = 0
const sdl_y_offest = 30
const sdl_width_offset = 1
const sdl_height_offset = -30
CPP_DK_Create("DKWindow")
CPP_DK_Create("DKRml")
window.resizeTo(sdl_width+sdl_width_offset, sdl_height+sdl_height_offset)
window.moveTo(sdl_x+sdl_x_offset, sdl_y+sdl_y_offest)
location.href = url
/*
window.addEventListener("keydown", function window_onkeydown(event){
	if(event.code === "F11")
		CPP_DKWindow_IsFullscreen() ? CPP_DKWindow_Windowed() : CPP_DKWindow_Fullscreen()
	if(event.code === "F12")
		CPP_DKRml_ToggleDebugger()
})
*/

//// Console window
const console_x = 0
const console_y = window.screen.height / 2
const console_width = window.screen.width
const console_height = window.screen.height / 2
const console_x_offset = -8
const console_y_offest = -1
const console_width_offset = +16
const console_height_offset = +9
CPP_DK_setConsolePosition(console_x+console_x_offset, console_y+console_y_offest, console_width+console_width_offset, console_height+console_height_offset)
