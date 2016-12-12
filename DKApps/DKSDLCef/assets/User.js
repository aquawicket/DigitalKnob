
if(DK_GetBrowser() == "Rocket"){
	DKCreate("DKWindow");
	DKCreate("DKRocket");
	DKCreate("DKWidget");
}

DKCreate("DKDebug/DKDebug.js", function(){});

var assets = DKAssets_LocalAssets();
var url = "http://www.google.com";
var iframe = DKWidget_CreateElement("body", "iframe", "DKCef_frame");
DKWidget_SetAttribute(iframe, "src", url);
DKWidget_SetProperty(iframe, "position", "absolute");
DKWidget_SetProperty(iframe, "top", "0rem");
DKWidget_SetProperty(iframe, "left", "0rem");
DKWidget_SetProperty(iframe, "width", "100%");
DKWidget_SetProperty(iframe, "bottom", "0rem");
var currentBrowser = DKCef_GetCurrentBrowser(iframe);
DKCef_SetUrl(iframe, url, currentBrowser);
DKCef_SetFocus(iframe);