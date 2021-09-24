const url = CPP_DKAssets_LocalAssets()+"index.html"

/*
const x = 0
const y = 0
const width = (window.screen.width/2)
const height = window.screen.height
*/


//// Console window
const console_x = 100
const console_y = 100
const console_width = 500
const console_height = 500
const console_x_offset = 0
const console_y_offest = 0
const console_width_offset = 0
const console_height_offset = 0
CPP_DK_setConsolePosition(console_x+console_x_offset, console_y+console_y_offest, console_width+console_width_offset, console_height+console_height_offset)


//// Create Cef window
const cef_x = 100
const cef_y = 100
const cef_width = 500
const cef_height = 500
const cef_x_offset = -7
const cef_y_offset = 0
const cef_width_offset = +16
const cef_height_offset = +9
CPP_DK_Create("DKCef")
CPP_DKCef_NewBrowser("Cef", cef_y+cef_y_offset, cef_x+cef_x_offset, cef_width+cef_width_offset, cef_height+cef_height_offset, url)


//// Create SDLRml window
const sdl_x = 100
const sdl_y = 100
const sdl_width = 500
const sdl_height = 500
const sdl_x_offset = 1
const sdl_y_offest = 31
const sdl_width_offset = 0
const sdl_height_offset = -30
CPP_DK_Create("DKWindow")
CPP_DK_Create("DKRml")
window.resizeTo(sdl_width+sdl_width_offset, sdl_height+sdl_height_offset)
window.moveTo(sdl_x+sdl_x_offset, sdl_y+sdl_y_offest)
location.href = url
