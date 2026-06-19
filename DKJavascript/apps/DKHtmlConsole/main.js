
function main(){
	console.debug("main()");
	dk_source(DKJAVASCRIPT_DIR+"/apps/DKHtmlConsole/DKHtmlConsole.js", function(){
		console.debug(DKJAVASCRIPT_DIR+"/apps/DKHtmlConsole/DKHtmlConsole.js");
		dkconsole = new DKHtmlConsole;
		dkconsole.create("","0px","0px","0px","","25%");
		
	});	
	
	dk_source(DKJAVASCRIPT_DIR+"/functions/dk_test.js", function(){
		dk_test("abc", "123");
	});
	
	//dk_source(DKJAVASCRIPT_DIR+"/functions/dk_color.js", function(){
	//	DKTEST();
	//});
	
}