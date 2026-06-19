//"use strict";
function DKHtmlConsole(){}

DKHtmlConsole.prototype.create = function DKHtmlConsole_create(top, bottom, left, right, width, height){
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
	
	var css = ".dk_debug { color: #0000ff; }";
	css += ".dk_log { color: #ffffff; }";
	css += ".dk_info { color: #ffffff; }";
	css += ".dk_warn { color: #ffff00; }";
	css += ".dk_error { color: #ff0000; }";
	var styleElement = document.createElement("style");
	styleElement.type = "text/css";
	if (styleElement.styleSheet) {
		styleElement.styleSheet.cssText = css;
	} else {
		styleElement.appendChild(document.createTextNode(css));
	}
	document.getElementsByTagName("head")[0].appendChild(styleElement);

	//console2 = console;		//backup the console
	console = this; 		//overwrite the console
	
	DKHtmlConsole.DKTEST();
}

DKHtmlConsole.prototype.print = function DKHtmlConsole_print(message){
	this.dkhtmlconsole.innerHTML += "<a>"+message+"</a></br>";
	this.dkhtmlconsole.scrollTop = this.dkhtmlconsole.scrollHeight;
}

DKHtmlConsole.prototype.clear = function DKHtmlConsole_clear(message){
	this.dkhtmlconsole.innerHTML = "";
}

DKHtmlConsole.prototype.debug = function DKHtmlConsole_debug(message){
	this.print('<span class="dk_debug">'+message+'</span>');
	//console2.debug(message);
}

DKHtmlConsole.prototype.log = function DKHtmlConsole_log(message){
	this.print('<span class="dk_log">'+message+'</span>');
	//console2.log(message);
}

DKHtmlConsole.prototype.info = function DKHtmlConsole_info(message){
	this.print('<span class="dk_info">'+message+'</span>');
	//console2.info(message);
}

DKHtmlConsole.prototype.warn = function DKHtmlConsole_warn(message){
	this.print('<span class="dk_warn">'+message+'</span>');
	//console2.warn(message);
}

DKHtmlConsole.prototype.error = function DKHtmlConsole_error(message){
	this.print('<span class="dk_error">'+message+'</span>');
	//console2.error(message);
}







//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = DKHtmlConsole.DKTEST = function DKHtmlConsole_TEST(){
	//dk_debugFunc(0);
	
	//dkconsole = new DKHtmlConsole;
	//dkconsole.create("","0px","0px","0px","","25%");
	
	//console.assert("console.assert");
	//console.clear();
	//console.count();
	//console.countReset();
	console.debug("console.debug");
	//console.dir();
	//dirxml();
	console.error("console.error");
	//group();
	//groupCollapsed();
	//groupEnd();
	console.info("console.info");
	console.log("console.log");
	//profile();
	//profileEnd();
	//table();
	//time();
	//timeEnd();
	//timeLog();
	//timeStamp();
	//trace();
	console.warn("console.warn");	
}

