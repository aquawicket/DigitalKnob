if(typeof window == "object"){
	var url_string = window.location.href;
	var url = new URL(url_string);
	var frame = url.searchParams.get("frame");
	var plugin = url.searchParams.get("plugin");
	
	if(plugin){
		DKCreate("DK/DK.css");	
		DKCreate("DKFile/DKFile.js", function(){
		DKCreate("DKWidget/DKWidget.js", function(){
		DKCreate("DKGui/DKFrame.js", function(){
		DKCreate(plugin+".js", function(){
			if(frame){
				DKFrame_Widget(plugin+".html");
			}
		});
		});
		});
		});
		//return;
	}
}
	
DKCreate("DK/DK.css");	
DKCreate("DKFile/DKFile.js", function(){
DKCreate("DKWindow/DKWindow.js", function(){
DKCreate("DKWidget/DKWidget.js", function(){
DKCreate("DKDom/DKDom.js", function(){
DKCreate("DKScale/DKScale.js", function(){
DKCreate("DKGui/DKFrame.js", function(){
DKCreate("DKGui/DKMenu.js", function(){
DKCreate("DKDebug/DKDebug.js", function(){
DKCreate("DKGui/Desktop.js", function(){
DKCreate("DKGui/Taskbar.js", function(){

});
});
});
});
});
});
});
});
});
});