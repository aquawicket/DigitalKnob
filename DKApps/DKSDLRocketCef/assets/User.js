
if(DK_GetBrowser() == "Rocket"){
	DKCreate("DKWindow");
	DKCreate("DKRocket");
	DKCreate("DKWidget");
}

DKCreate("DKDebug/DKDebug.js", function(){});
DKWidget_SetProperty("body","background-color","blue");


var assets = DKAssets_LocalAssets();
var url = "http://www.google.com";
var iframe = DKWidget_CreateElement("body", "iframe", "DKCef_frame");
DKWidget_SetAttribute(iframe, "src", url);
DKWidget_SetProperty(iframe, "position", "absolute");
DKWidget_SetProperty(iframe, "top", "20rem");
DKWidget_SetProperty(iframe, "left", "20rem");
DKWidget_SetProperty(iframe, "right", "20rem");
DKWidget_SetProperty(iframe, "bottom", "20rem");
var currentBrowser = DKCef_GetCurrentBrowser(iframe);
DKCef_SetUrl(iframe, url, currentBrowser);
DKCef_SetFocus(iframe);