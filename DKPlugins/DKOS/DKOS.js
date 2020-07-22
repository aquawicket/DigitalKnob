////////////////////
function DKOS_Init()
{
	DKCreate("DKOS/DKOS.html", function(){
		document.body.style.margin = "0px";
		//document.getElementById("DKOS/DKOS.html").style.left = "0px";
		DKWidget_SetProperty("DKOS/DKOS.html", "left", "0px");
		DKWidget_SetProperty("DKOS/DKOS.html", "top", "0px");
		DKWidget_SetProperty("DKOS/DKOS.html", "width", "100%");
		DKWidget_SetProperty("DKOS/DKOS.html", "height", "100%");
		DKWidget_SetProperty("DKOS/DKOS.html", "overflow", "hidden");
		var OS = DK_GetOS();
		if(OS != "iOS" && OS != "Android"){
			var screenwidth = DK_GetScreenWidth();
			var screenheight = DK_GetScreenHeight();
			var newwidth = parseInt(screenwidth)-100;
			var newheight = parseInt(screenheight)-150;
			//DKWindow_SetWidth(newwidth);
			//DKWindow_SetHeight(newheight);
		}

		//DKCreate("DKGui/DKFrame.js", function(){
		//DKCreate("DKGui/DKMenu.js", function(){
		DKCreate("DKOS/Desktop.js", function(){
		DKCreate("DKOS/Taskbar.js", function(){
			if(OS == "iOS" || OS == "Android"){
				//DKWidget_SetScale(2);   FIXME
			}
		});
		});
		//});
		//});
	});
}