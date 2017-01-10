DKCreate("DKWindow");
DKCreate("DKDebug/DKDebug.js", function(){});
var assets = DKAssets_LocalAssets();
var url = "http://www.google.com";
DKCreate("DKCef,CefSDL,0,0,400,400,"+url);
var currentBrowser = DKCef_GetCurrentBrowser("CefSDL");
DKCef_SetUrl("CefSDL", url, currentBrowser);
DKCef_SetFocus("CefSDL");