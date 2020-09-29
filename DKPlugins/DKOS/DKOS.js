////////////////////
function DKOS_Init() {
	console.log("DKOS_Init()");
	DKCreate("DKOS/DKOS.html", function(){
		//document.documentElement.style.backgroundColor = "black"; //FIXME
		document.body.style.margin = "0px";
		document.body.style.overflow = "hidden";
		var OS = DK_GetOS();
		if(OS != "iOS" && OS != "Android"){
			/*
			var screenwidth = screen.width;
			var screenheight = screen.height;
			var newwidth = parseInt(screenwidth)-100;
			var newheight = parseInt(screenheight)-150;
			//DKWindow_SetWidth(newwidth);
			//DKWindow_SetHeight(newheight);
			*/
		}

		//DKCreate("DKGui/DKFrame.js", function(){
		//DKCreate("DKGui/DKMenu.js", function(){
		DKCreate("DKOS/Desktop.js", function(){
		DKCreate("DKOS/Taskbar.js", function(){
			if(OS === "iOS" || OS === "Android"){
				//DKWidget_SetScale(2);   FIXME
			}
		});
		});
		//});
		//});
	});
}