////////////////////
function DKOS_Init()
{
	DKCreate("DK/DKBrowser.css");
	DKCreate("DKOS/DKOS.html", function(){
	var OS = DK_GetOS();
	DKLog("OS="+OS+"\n");
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
	DKCreate("DKOS/Desktop.js", function(){
	DKCreate("DKOS/Taskbar.js", function(){
		if(OS == "iOS" || OS == "Android"){
			//DKWidget_SetScale(2);   FIXME
		}
	});
	});
	});
	});
	});
}