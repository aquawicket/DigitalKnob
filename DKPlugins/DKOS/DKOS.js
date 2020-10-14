////////////////////
function DKOS_Init() {
	//console.debug("DKOS_Init()");
	DK_Create("DKOS/DKOS.html", function(){
		document.documentElement.style.backgroundColor = "black";
		document.body.style.margin = "0px";
		document.body.style.overflow = "hidden";
		var OS = DK_GetOS();
		if(OS !== "iOS" && OS !== "Android"){
			/*
			var screenwidth = screen.width;
			var screenheight = screen.height;
			var newwidth = parseInt(screenwidth)-100;
			var newheight = parseInt(screenheight)-150;
			//DKWindow_SetWidth(newwidth);
			//DKWindow_SetHeight(newheight);
			*/
		}

		//DK_Create("DKGui/DKFrame.js", function(){
		//DK_Create("DKGui/DKMenu.js", function(){
		DK_Create("DKOS/Desktop.js", function(){
		DK_Create("DKOS/Taskbar.js", function(){
			if(OS === "iOS" || OS === "Android"){
				//DKWidget_SetScale(2);   FIXME
			}
		});
		});
		//});
		//});
	});
}