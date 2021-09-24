const url = CPP_DKAssets_LocalAssets()+"index.html"

console.log("window.screen.width      = "+window.screen.width)
console.log("window.screen.height     = "+window.screen.height)
console.log("window.screen.width  / 2 = "+window.screen.width / 2)
console.log("window.screen.height / 2 = "+window.screen.height / 2)
console.log("window.screen.width  / 3 = "+window.screen.width / 3)
console.log("window.screen.height / 3 = "+window.screen.height / 3)
console.log("window.screen.width  / 4 = "+window.screen.width / 4)
console.log("window.screen.height / 4 = "+window.screen.height / 4)


sw = window.screen.width
sh = window.screen.height
sw2 = window.screen.width/2
sh2 = window.screen.height/2
sw3 = window.screen.width/3
sh3 = window.screen.height/3
sw3 = window.screen.width/4
sh3 = window.screen.height/4

w1x = 0
w1y = 0
w1w = sw3
w1h = sw3

w2x = 0
w2y = 0
w2w = sw3
w2h = sw3

w3x = 0
w3y = 0
w3w = sw3
w3h = sw3



//// Console window
const console_x = 0
const console_y = 0
const console_width = sw3
const console_height = sh
const console_x_offset = -8
const console_y_offest = -1
const console_width_offset = +16
const console_height_offset = +9
CPP_DK_setConsolePosition(console_x+console_x_offset, console_y+console_y_offest, console_width+console_width_offset, console_height+console_height_offset)

//// Create Cef window
const cef_x = sw3
const cef_y = 0
const cef_width = sw3
const cef_height = sh
const cef_x_offset = -8
const cef_y_offset = -1
const cef_width_offset = +16
const cef_height_offset = +9
CPP_DK_Create("DKCef")
CPP_DKCef_NewBrowser("Cef", cef_y+cef_y_offset, cef_x+cef_x_offset, cef_width+cef_width_offset, cef_height+cef_height_offset, url)


//// Create SDLRml window
const sdl_x = sw3+sw3-2
const sdl_y = 0
const sdl_width = sw3
const sdl_height = sh
const sdl_x_offset = 0
const sdl_y_offest = 30
const sdl_width_offset = 1
const sdl_height_offset = -30
CPP_DK_Create("DKWindow")
CPP_DK_Create("DKRml")
window.resizeTo(sdl_width+sdl_width_offset, sdl_height+sdl_height_offset)
window.moveTo(sdl_x+sdl_x_offset, sdl_y+sdl_y_offest)
location.href = url
