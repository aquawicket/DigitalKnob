//"use strict";
function DKCodeRunner(){}

DKCodeRunner.prototype.create = function DKCodeRunner_create(top, bottom, left, right, width, height){
	//alert("DKCodeRunner.create");
	if(!window){ alert("windows is invalid"); return; }
	if(!window.document){ alert("document is invalid"); return; }
	var dkcoderunner = window.document.createElement("div");
	this.dkcoderunner = dkcoderunner;
	dkcoderunner.setAttribute("id", "DKCodeRunner");
	dkcoderunner.style.position = "absolute";
	dkcoderunner.style.top = top;
	dkcoderunner.style.bottom = bottom;
    dkcoderunner.style.left = left;
	dkcoderunner.style.right = right;
    dkcoderunner.style.width = width;
    dkcoderunner.style.height = height;
	dkcoderunner.style.fontFamily = "Consolas, Lucinda, Console, Courier New, monospace";
	dkcoderunner.style.fontSize = "13.5px";
	dkcoderunner.style.fontWeight = "350px";
	dkcoderunner.style.color = "rgb(200,200,200)";
	dkcoderunner.style.backgroundColor = "grey";
	dkcoderunner.style.overflowY = "scroll";
	if(!window.document.body){ alert("body is invalid"); return; }
	window.document.body.appendChild(dkcoderunner);
	
	console = this //overwrite the console
}

DKCodeRunner = function DKCodeRunner_init(){
	DKCodeRunner.prototype.func("myArg");
}

DKCodeRunner.prototype.func = function DKCodeRunner_func(arg){
	console.log("DKCodeRunner_func('+arg+')");
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dkcoderunner = new DKCodeRunner;
	dkcoderunner.create("0px","50px","0px","0px","","");
}
