const assets = CPP_DKAssets_LocalAssets()


CPP_DKFile_ChDir(assets+"DKPhp/")
const batch = assets+"DKPhp/RunPhpServers.bat"
CPP_DK_System(batch)


const url = assets+"index.html"

//// Create SDLRml window
const sdl_x = window.screen.width / 2
const sdl_y = 0
const sdl_width = window.screen.width / 2
const sdl_height = window.screen.height
const sdl_x_offset = 0
const sdl_y_offest = 30
const sdl_width_offset = 1
const sdl_height_offset = -70//-30
CPP_DK_Create("DKSDLWindow")
CPP_DK_Create("DKRml")
window.resizeTo(sdl_width+sdl_width_offset, sdl_height+sdl_height_offset)
window.moveTo(sdl_x+sdl_x_offset, sdl_y+sdl_y_offest)
location.href = url
window.addEventListener("keydown", function(event){
	CPP_DK_Create("DKWindow/DKWindow.js")
	console.log(event.code)
	if(event.code === "F12")
		CPP_DKRml_DebuggerToggle()
	if(event.code === "F11")
		CPP_DKWindow_IsFullscreen() ? CPP_DKWindow_Windowed() : dk.window.fullscreen()
	
})


//// Console window
const console_x = 0
const console_y = 0
const console_width = window.screen.width / 2
const console_height = window.screen.height
const console_x_offset = -8
const console_y_offest = -1
const console_width_offset = +16
const console_height_offset = 9
CPP_DK_setConsolePosition(console_x+console_x_offset, console_y+console_y_offest, console_width+console_width_offset, console_height+console_height_offset)
