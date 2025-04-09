//alert("DKConsole")

function main(){
	dk_source(DKJAVASCRIPT_DIR+"/functions/DKHtmlConsole.js", function(){
		dkconsole = new DKHtmlConsole;
		dkconsole.create("","0px","0px","0px","","25%");
		console.log("DKConsole");
		dk_source(DKJAVASCRIPT_DIR+"/functions/dk_test.js", function(){
			dk_test("abc", "123");
		});
	});	
}