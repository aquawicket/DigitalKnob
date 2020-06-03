var url = DKAssets_LocalAssets()+"index.html";
//var url = DKAssets_LocalAssets()+"DKWebTest/index.html";

//// Create Cef window ////
var USE_CEF = 1;
DKCreate("DKCef,Cef,0,0,800,600,"+url);
DKCef_NewBrowser("Cef",5,5,screen.width/2-10,screen.height-45,url);
//DKCef_ShowDevTools(0);


//// Create SDL Rocket window ////
DKCreate("DKWindow");
DKCreate("DKRml");
location.href = url;
window.moveTo(screen.width/2, 36);
window.resizeTo(screen.width / 2 - 10, screen.height-84);
//DKRml_ToggleDebugger();