DKCodeRunner = function DKCodeRunner_init(){
	DKCodeRunner.prototype.func("myArg");
}

DKCodeRunner.prototype.func = function DKCodeRunner_func(arg){
	console.log("DKCodeRunner_func('+arg+')");
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_source(DKJAVASCRIPT_DIR+"/functions/DKHtmlConsole.js", function(){
		dkconsole = new DKHtmlConsole;
		dkconsole.create("","0px","0px","0px","","25%");
		dk_source(DKJAVASCRIPT_DIR+"/functions/DKCodeRunner.js", function(){
			codeRunner = new DKCodeRunner;
			//codeRunner.init(document.body);
		});
	});	
}
