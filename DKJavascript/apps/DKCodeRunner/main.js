//alert("DKCodeRunner")

function main(){
	dk_source(DKJAVASCRIPT_DIR+"/functions/DKHtmlConsole.js", function(){
		dkconsole = new DKHtmlConsole;
		dkconsole.create("","0px","0px","0px","","25%");
		/*
		dk_source(DKJAVASCRIPT_DIR+"/functions/DKCodeRunner.js", function(){
			codeRunner = new DKCodeRunner;
			codeRunner.init(window);
		});
		*/
	});	
}