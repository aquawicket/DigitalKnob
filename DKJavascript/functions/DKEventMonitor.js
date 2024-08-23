// supressed entries will not be logged.
var supress = ["mousemove", "mouseover", "mouseout", "mouseleave"];

function DKEventMonitor() {
	document.addEventListener("DOMContentLoaded", function(event){ DKEventMonitor.prototype.debugEvent(event, document); });
}

DKEventMonitor.prototype.monitorEvents = function DKEventMonitor_monitorEvents(obj){
	// https://html.spec.whatwg.org/multipage/indices.html#events-2
	
	// GlobalEventHandlers
	obj.addEventListener("abort", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("auxclick", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("beforeinput", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("beforematch", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("beforetoggle", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("blur", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("cancel", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("canplay", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("canplaythrough", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("change", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("click", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("close", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("contextlost", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("contextmenu", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("contextrestored", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("copy", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("cuechange", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("cut", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("dblclick", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("drag", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("dragend", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("dragenter", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("dragleave", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("dragover", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("dragstart", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("drop", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("durationchange", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("emptied", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("ended", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("error", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("focus", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("formdata", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("input", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("invalid", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("keydown", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("keypress", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("keyup", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("load", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("loadeddata", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("loadedmetadata", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("loadstart", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("mousedown", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("mouseenter", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("mouseleave", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("mousemove", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("mouseout", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("mouseover", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("mouseup", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("paste", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("pause", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("play", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("playing", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("progress", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("ratechange", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("reset", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("resize", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("scroll", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("scrollend", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("securitypolicyviolation", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("seeked", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("seeking", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("select", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("slotchange", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("stalled", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("submit", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("suspend", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("timeupdate", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("toggle", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("volumechange", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("waiting", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("webkitanimationend", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("webkitanimationiteration", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("webkitanimationstart", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("webkittransitionend", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("wheel", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	
	// WindowEventHandlers
	obj.addEventListener("afterprint", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("beforeprint", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("beforeunload", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("hashchange", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("languagechange", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("message", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("messageerror", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("offline", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("online", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("pageswap", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("pagehide", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("pagereveal", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("pageshow", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("popstate", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("rejectionhandled", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("storage", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("unhandledrejection", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
	obj.addEventListener("unload", function(event){ DKEventMonitor.prototype.debugEvent(event, obj) });
}

DKEventMonitor.prototype.supressed = function DKEventMonitor_supressed(str){
	if(supress.indexOf(str) > -1) return true;
}

DKEventMonitor.prototype.debugEvent = function DKEventMonitor_debugEvent(event, obj){
	if(DKEventMonitor.prototype.supressed(event.type)) return;
	
	if(obj){ str = obj + " --> on" + event.type; }
	else{ str = "??? --> on" + event.type; }
	dkconsole.log(str);
	document.title = str;
}
