////////////////////
function DKOS_Init()
{
	DKCreate("DK/DKBrowser.css");
	//DKCreate("DKGui/DKOS.html", function(){
	var OS = DK_GetOS();
	DKLog("OS="+OS+"\n");
	//DKWidget_SetProperty("DKGui/DKOS.html", "left", "0px");
	//DKWidget_SetProperty("DKGui/DKOS.html", "top", "0px");
	//DKWidget_SetProperty("DKGui/DKOS.html", "width", "10px");
	//DKWidget_SetProperty("DKGui/DKOS.html", "height", "10px");
	if(OS != "iOS" && OS != "Android"){
		var screenwidth = DK_GetScreenWidth();
		var screenheight = DK_GetScreenHeight();
		var newwidth = parseInt(screenwidth)-100;
		var newheight = parseInt(screenheight)-150;
		DKWindow_SetWidth(newwidth);
		DKWindow_SetHeight(newheight);
	}

	DKCreate("DKGui/DKFrame.js", function(){
	DKCreate("DKGui/DKMenu.js", function(){
	DKCreate("DKGui/Desktop.js", function(){
	DKCreate("DKGui/Taskbar.js", function(){
		if(OS == "iOS" || OS == "Android"){
			//DKWidget_SetScale(2);   FIXME
		}
	});
	});
	});
	});
	//});
}