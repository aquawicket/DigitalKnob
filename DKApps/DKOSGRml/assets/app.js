CPP_DK_Create("DKDuktapeDom")

//const url = CPP_DKAssets_LocalAssets()+"index.html"
//const url = CPP_DKAssets_LocalAssets()+"DKRmlElement/index.html"
const url = CPP_DKAssets_LocalAssets()+"DKWebTest/index.html"
CPP_DK_Create("DKOSGWindow")
CPP_DK_Create("DKRml")
location.href = url

//// Resize SDLRml window
const osg_x = window.screen.width / 2
const osg_y = 0
const osg_width = window.screen.width / 2
const osg_height = window.screen.height
const osg_x_offset = 0
const osg_y_offest = 30
const osg_width_offset = 1
const osg_height_offset = -30

/*
window.resizeTo(osg_width+osg_width_offset, osg_height+osg_height_offset)
window.moveTo(osg_x+osg_x_offset, osg_y+osg_y_offest)
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
const console_height_offset = +9
CPP_DK_setConsolePosition(console_x+console_x_offset, console_y+console_y_offest, console_width+console_width_offset, console_height+console_height_offset)
*/