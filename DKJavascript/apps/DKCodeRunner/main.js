//alert("DKCodeRunner")

function main(){
	dk_source(DKJAVASCRIPT_DIR+"/apps/DKHtmlConsole/DKHtmlConsole.js", function(){
		dkconsole = new DKHtmlConsole;
		dkconsole.create("","0px","0px","0px","","25%");

		dk_source(DKJAVASCRIPT_DIR+"/apps/DKCodeRunner/DKCodeRunner.js", function(){
			codeRunner = new DKCodeRunner;
			codeRunner.create("0px","","0px","0px","","74%");
		});
	});	
}