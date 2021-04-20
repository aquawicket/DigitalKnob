var url = CPP_DKAssets_LocalAssets()+"/index.html";
//var url = CPP_DKAssets_LocalAssets()+"/DKWebTest/index.html";

/*
//// Create Cef window ////
var USE_CEF = 1;
CPP_DKDuktape_Create("DKCef,Cef,0,0,800,600,"+url);
CPP_DKCef_NewBrowser("Cef",5,5,screen.width/2-10,screen.height-45,url);
//DKCef_ShowDevTools(0);
*/

//// Create SDL Rocket window ////
CPP_DKDuktape_Create("DKWindow");
CPP_DKDuktape_Create("DKRml");
location.href = url;
window.moveTo(screen.width/2, 36);
window.resizeTo(screen.width / 2 - 10, screen.height-84);
//CPP_DKRml_DebuggerOn();