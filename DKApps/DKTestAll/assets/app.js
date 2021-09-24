const url = CPP_DKAssets_LocalAssets()+"index.html";

/*
const x = 0;
const y = 0;
const width = (window.screen.width/2);
const height = window.screen.height;
*/

const sdl_x = 10;
const sdl_y = 10;
const sdl_width = 500;
const sdl_height = 500;

const cef_x = 10;
const cef_y = 10;
const cef_width = 500;
const cef_height = 500;

const sdl_x_offset = 1;
const sdl_y_offest = 31;
const sdl_width_offset = 0;
const sdl_height_offset = -30;

const cef_x_offset = 0;
const cef_y_offest = -7;
const cef_width_offset = +16;
const cef_height_offset = +9;


//// Create Cef window
CPP_DK_Create("DKCef");
CPP_DKCef_NewBrowser("Cef", cef_x+cef_x_offset, cef_y+cef_y_offest, cef_width+cef_width_offset, cef_height+cef_height_offset, url);

//// Create SDLRml window
CPP_DK_Create("DKWindow")
CPP_DK_Create("DKRml")
window.resizeTo(sdl_width+sdl_width_offset, sdl_height+sdl_height_offset);
window.moveTo(sdl_x+sdl_x_offset, sdl_y+sdl_y_offest);
location.href = url;

