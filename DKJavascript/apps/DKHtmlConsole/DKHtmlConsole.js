//"use strict";
function DKHtmlConsole(){}

DKHtmlConsole.prototype.create = function DKHtmlConsole_create(top, bottom, left, right, width, height){
	//alert("DKHtmlConsole.create");
	if(!window){ alert("windows is invalid"); return; }
	if(!window.document){ alert("document is invalid"); return; }
	var dkhtmlconsole = window.document.createElement("div");
	this.dkhtmlconsole = dkhtmlconsole;
	dkhtmlconsole.setAttribute("id", "DKHtmlConsole");
	dkhtmlconsole.style.position = "absolute";
	dkhtmlconsole.style.top = top;
	dkhtmlconsole.style.bottom = bottom;
    dkhtmlconsole.style.left = left;
	dkhtmlconsole.style.right = right;
    dkhtmlconsole.style.width = width;
    dkhtmlconsole.style.height = height;
	dkhtmlconsole.style.fontFamily = "Consolas, Lucinda, Console, Courier New, monospace";
	dkhtmlconsole.style.fontSize = "13.5px";
	dkhtmlconsole.style.fontWeight = "350px";
	dkhtmlconsole.style.color = "rgb(200,200,200)";
	dkhtmlconsole.style.backgroundColor = "black";
	dkhtmlconsole.style.overflowY = "scroll";
	if(!window.document.body){ alert("body is invalid"); return; }
	window.document.body.appendChild(dkhtmlconsole);
	
	console = this //overwrite the console
}

DKHtmlConsole.prototype.log = function DKHtmlConsole_log(message){
	this.dkhtmlconsole.innerHTML = this.dkhtmlconsole.innerHTML + "<a>" + message + "</a></br>";
	this.dkhtmlconsole.scrollTop = this.dkhtmlconsole.scrollHeight;
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dkconsole = new DKHtmlConsole;
	dkconsole.create("","0px","0px","0px","","25%");
}
