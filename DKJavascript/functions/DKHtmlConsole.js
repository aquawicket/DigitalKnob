//"use strict";

function DKHtmlConsole() {}

DKHtmlConsole.prototype.create = function DKHtmlConsole_create(top, left, width, height) {
	if(!window){ alert("windows is invalid"); return; }
	if(!window.document){ alert("document is invalid"); return; }
	var dkhtmlconsole = window.document.createElement("div");
	this.dkhtmlconsole = dkhtmlconsole;
	dkhtmlconsole.setAttribute("id", "DKHtmlConsole");
	dkhtmlconsole.style.position = "absolute";
	dkhtmlconsole.style.top = top;
    dkhtmlconsole.style.left = left;
    dkhtmlconsole.style.width = width;
    dkhtmlconsole.style.height = height;
	dkhtmlconsole.style.fontFamily = "Consolas, Lucinda, Console, Courier New, monospace";
	dkhtmlconsole.style.fontSize = "13.5px";
	dkhtmlconsole.style.fontWeight = "350px";
	dkhtmlconsole.style.color = "rgb(200,200,200,1)";
	dkhtmlconsole.style.backgroundColor = "black";
	if(!window.document.body){ alert("body is invalid"); return; }
	window.document.body.appendChild(dkhtmlconsole);
}

DKHtmlConsole.prototype.log = function DKHtmlConsole_log(message) {
	this.dkhtmlconsole.innerHTML = this.dkhtmlconsole.innerHTML + "<a>" + message + "</a></br>";
}