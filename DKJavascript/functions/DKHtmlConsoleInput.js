//"use strict";
function DKHtmlConsoleInput() {}

DKHtmlConsoleInput.prototype.create = function DKHtmlConsoleInput_create(top, bottom, left, right, width, height) {
	var dkhtmlconsoleinput = window.document.createElement("div");
	this.dkhtmlconsoleinput = dkhtmlconsoleinput;
	dkhtmlconsoleinput.setAttribute("id", "DKHtmlConsoleInput");
	dkhtmlconsoleinput.style.position = "absolute";
	dkhtmlconsoleinput.style.top = top;
	dkhtmlconsoleinput.style.bottom = bottom;
    dkhtmlconsoleinput.style.left = left;
	dkhtmlconsoleinput.style.right = right;
    dkhtmlconsoleinput.style.width = width;
    dkhtmlconsoleinput.style.height = height;
	dkhtmlconsoleinput.style.fontFamily = "Consolas, Lucinda, Console, Courier New, monospace";
	dkhtmlconsoleinput.style.fontSize = "13.5px";
	dkhtmlconsoleinput.style.fontWeight = "350px";
	dkhtmlconsoleinput.style.color = "rgb(200,200,200)";
	dkhtmlconsoleinput.style.backgroundColor = "black";
	if(!window.document.body){ alert("body is invalid"); return; }
	window.document.body.appendChild(dkhtmlconsole);
	
	console = this //overwrite the console
}

DKHtmlConsoleInput.prototype.log = function DKHtmlConsoleInput_log(message) {
	this.dkhtmlconsole.innerHTML = this.dkhtmlconsole.innerHTML + "<a>" + message + "</a></br>";
	this.dkhtmlconsole.scrollTop = this.dkhtmlconsole.scrollHeight;
}

