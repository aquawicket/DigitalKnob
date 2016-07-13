DKCreate("DKRocket/DKBrowser.css");
DKCreate("DKWindow");
DKCreate("DKWindowJS");
DKCreate("DKRocket");
DKCreate("DKWidgetJS");
var OS = DK_GetOS();
DKLog("OS="+OS+"\n");
if(OS != "IOS" && OS != "ANDROID"){
	var screenwidth = DK_GetScreenWidth();
	var screenheight = DK_GetScreenHeight();
	var newwidth = parseInt(screenwidth)-100;
	var newheight = parseInt(screenheight)-150;
	DKWindow_SetWidth(newwidth.toString()+"px");
	DKWindow_SetHeight(newheight.toString()+"px");
}

DKCreate("DKFrame/DKFrame.js")
DKCreate("DKOS/Desktop.js");
DKCreate("DKOS/Taskbar.js");
//DKCreate("DKDom");

if(OS == "IOS" || OS == "ANDROID"){
	DKWidget_SetScale(2);
}
