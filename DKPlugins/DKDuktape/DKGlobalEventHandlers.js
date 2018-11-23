///////////////////////////////////////////
var GlobalEventHandlers = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("GlobalEventHandlers("+pointer+")");
	
	this.pointer = pointer;
	
	this.abort = null;
	Object.defineProperty(this, "onabort", {
		get: function(){ return this.abort; },
		set: function(func){ this.addEventListener("abort", func); this.abort = func }
	});
	this.animationcancel = null;
	Object.defineProperty(this, "onanimationcancel", {
		get: function(){ return this.animationcancel; },
		set: function(func){ this.addEventListener("animationcancel", func); this.animationcancel = func }
	});
	this.animationend = null;
	Object.defineProperty(this, "onanimationend", {
		get: function(){ return this.animationend; },
		set: function(func){ this.addEventListener("animationend", func); this.animationend = func }
	});
	this.animationiteration = null;
	Object.defineProperty(this, "onanimationiteration", {
		get: function(){ return this.animationiteration; },
		set: function(func){ this.addEventListener("animationiteration", func); this.animationiteration = func }
	});
	this.animationstart = null;
	Object.defineProperty(this, "onanimationstart", {
		get: function(){ return this.animationstart; },
		set: function(func){ this.addEventListener("animationstart", func); this.animationstart = func }
	});
	this.auxclick = null;
	Object.defineProperty(this, "onauxclick", {
		get: function(){ return this.auxclick; },
		set: function(func){ this.addEventListener("auxclick", func); this.auxclick = func }
	});
	this.blur = null;
	Object.defineProperty(this, "onblur", {
		get: function(){ return this.blur; },
		set: function(func){ this.addEventListener("blur", func); this.blur = func }
	});
	this.error = null;
	Object.defineProperty(this, "onerror", {
		get: function(){ return this.error; },
		set: function(func){ this.addEventListener("error", func); this.error = func }
	});
	this.focus = null;
	Object.defineProperty(this, "onfocus", {
		get: function(){ return this.focus; },
		set: function(func){ this.addEventListener("focus", func); this.focus = func }
	});
	this.canplay = null;
	Object.defineProperty(this, "oncanplay", {
		get: function(){ return this.canplay; },
		set: function(func){ this.addEventListener("canplay", func); this.canplay = func }
	});
	this.canplaythrough = null;
	Object.defineProperty(this, "oncanplaythrough", {
		get: function(){ return this.canplaythrough; },
		set: function(func){ this.addEventListener("canplaythrough", func); this.canplaythrough = func }
	});
	this.change = null;
	Object.defineProperty(this, "onchange", {
		get: function(){ return this.change; },
		set: function(func){ this.addEventListener("change", func); this.change = func }
	});
	this.click = null;
	Object.defineProperty(this, "onclick", {
		get: function(){ return this.click; },
		set: function(func){ console.warn("set:onclick"); this.addEventListener("click", func); this.click = func; }
	});
	this.close = null;
	Object.defineProperty(this, "onclose", {
		get: function(){ return this.close; },
		set: function(func){ this.addEventListener("close", func); this.close = func }
	});
	this.contextmenu = null;
	Object.defineProperty(this, "oncontextmenu", {
		get: function(){ return this.contextmenu; },
		set: function(func){ this.addEventListener("contextmenu", func); this.contextmenu = func }
	});
	this.cuechange = null;
	Object.defineProperty(this, "oncuechange", {
		get: function(){ return this.cuechange; },
		set: function(func){ this.addEventListener("cuechange", func); this.cuechange = func }
	});
	this.dblclick = null;
	Object.defineProperty(this, "ondblclick", {
		get: function(){ return this.dblclick; },
		set: function(func){ this.addEventListener("dblclick", func); this.dblclick = func }
	});
	this.drag = null;
	Object.defineProperty(this, "ondrag", {
		get: function(){ return this.drag; },
		set: function(func){ this.addEventListener("drag", func); this.drag = func }
	});
	this.dragend = null;
	Object.defineProperty(this, "ondragend", {
		get: function(){ return this.dragend; },
		set: function(func){ this.addEventListener("dragend", func); this.dragend = func }
	});
	this.dragenter = null;
	Object.defineProperty(this, "ondragenter", {
		get: function(){ return this.dragenter; },
		set: function(func){ this.addEventListener("dragenter", func); this.dragenter = func }
	});
	this.dragexit = null;
	Object.defineProperty(this, "ondragexit", {
		get: function(){ return this.dragexit; },
		set: function(func){ this.addEventListener("dragexit", func); this.dragexit = func }
	});
	this.dragleave = null;
	Object.defineProperty(this, "ondragleave", {
		get: function(){ return this.dragleave; },
		set: function(func){ this.addEventListener("dragleave", func); this.dragleave = func }
	});
	this.dragover = null;
	Object.defineProperty(this, "ondragover", {
		get: function(){ return this.dragover; },
		set: function(func){ this.addEventListener("dragover", func); this.dragover = func }
	});
	this.dragstart = null;
	Object.defineProperty(this, "ondragstart", {
		get: function(){ return this.dragstart; },
		set: function(func){ this.addEventListener("dragstart", func); this.dragstart = func }
	});
	this.drop = null;
	Object.defineProperty(this, "ondrop", {
		get: function(){ return this.drop; },
		set: function(func){ this.addEventListener("drop", func); this.drop = func }
	});
	this.durationchange = null;
	Object.defineProperty(this, "ondurationchange", {
		get: function(){ return this.durationchange; },
		set: function(func){ this.addEventListener("durationchange", func); this.durationchange = func }
	});
	this.emptied = null;
	Object.defineProperty(this, "onemptied", {
		get: function(){ return this.emptied; },
		set: function(func){ this.addEventListener("emptied", func); this.emptied = func }
	});
	this.ended = null;
	Object.defineProperty(this, "onended", {
		get: function(){ return this.ended; },
		set: function(func){ this.addEventListener("ended", func); this.ended = func }
	});
	this.gotpointercapture = null;
	Object.defineProperty(this, "ongotpointercapture", {
		get: function(){ return this.gotpointercapture; },
		set: function(func){ this.addEventListener("gotpointercapture", func); this.gotpointercapture = func }
	});
	this.input = null;
	Object.defineProperty(this, "oninput", {
		get: function(){ return this.input; },
		set: function(func){ this.addEventListener("input", func); this.input = func }
	});
	this.invalid = null;
	Object.defineProperty(this, "oninvalid", {
		get: function(){ return this.invalid; },
		set: function(func){ this.addEventListener("invalid", func); this.invalid = func }
	});
	this.keydown = null;
	Object.defineProperty(this, "onkeydown", {
		get: function(){ return this.keydown; },
		set: function(func){ this.addEventListener("keydown", func); this.keydown = func }
	});
	this.keypress = null;
	Object.defineProperty(this, "onkeypress", {
		get: function(){ return this.keypress; },
		set: function(func){ this.addEventListener("keypress", func); this.keypress = func }
	});
	this.keyup = null;
	Object.defineProperty(this, "onkeyup", {
		get: function(){ return this.keyup; },
		set: function(func){ this.addEventListener("keyup", func); this.keyup = func }
	});
	this.load = null;
	Object.defineProperty(this, "onload", {
		get: function(){ return this.load; },
		set: function(func){ this.addEventListener("load", func); this.load = func }
	});
	this.loadeddata = null;
	Object.defineProperty(this, "onloadeddata", {
		get: function(){ return this.loadeddata; },
		set: function(func){ this.addEventListener("loadeddata", func); this.loadeddata = func }
	});
	this.loadedmetadata = null;
	Object.defineProperty(this, "onloadedmetadata", {
		get: function(){ return this.loadedmetadata; },
		set: function(func){ this.addEventListener("loadedmetadata", func); this.loadedmetadata = func }
	});
	this.loadend = null;
	Object.defineProperty(this, "onloadend", {
		get: function(){ return this.loadend; },
		set: function(func){ this.addEventListener("loadend", func); this.loadend = func }
	});
	this.loadstart = null;
	Object.defineProperty(this, "onloadstart", {
		get: function(){ return this.loadstart; },
		set: function(func){ this.addEventListener("loadstart", func); this.loadstart = func }
	});
	this.lostpointercapture = null;
	Object.defineProperty(this, "onlostpointercapture", {
		get: function(){ return this.lostpointercapture; },
		set: function(func){ this.addEventListener("lostpointercapture", func); this.lostpointercapture = func }
	});
	this.mousedown = null;
	Object.defineProperty(this, "onmousedown", {
		get: function(){ return this.mousedown; },
		set: function(func){ this.addEventListener("mousedown", func); this.mousedown = func }
	});
	this.mouseenter = null;
	Object.defineProperty(this, "onmouseenter", {
		get: function(){ return this.mouseenter; },
		set: function(func){ this.addEventListener("mouseenter", func); this.mouseenter = func }
	});
	this.mouseleave = null;
	Object.defineProperty(this, "onmouseleave", {
		get: function(){ return this.mouseleave; },
		set: function(func){ this.addEventListener("mouseleave", func); this.mouseleave = func }
	});
	this.mousemove = null;
	Object.defineProperty(this, "onmousemove", {
		get: function(){ return this.mousemove; },
		set: function(func){ this.addEventListener("mousemove", func); this.mousemove = func }
	});
	this.mouseout = null;
	Object.defineProperty(this, "onmouseout", {
		get: function(){ return this.mouseout; },
		set: function(func){ this.addEventListener("mouseout", func); this.mouseout = func }
	});
	this.mouseover = null;
	Object.defineProperty(this, "onmouseover", {
		get: function(){ return this.mouseover; },
		set: function(func){ this.addEventListener("mouseover", func); this.mouseover = func }
	});
	this.mouseup = null;
	Object.defineProperty(this, "onmouseup", {
		get: function(){ return this.mouseup; },
		set: function(func){ this.addEventListener("mouseup", func); this.mouseup = func }
	});
	this.mousewheel = null;
	Object.defineProperty(this, "onmousewheel", {
		get: function(){ return this.mousewheel; },
		set: function(func){ this.addEventListener("mousewheel", func); this.mousewheel = func }
	});
	this.wheel = null;
	Object.defineProperty(this, "onwheel", {
		get: function(){ return this.wheel; },
		set: function(func){ this.addEventListener("wheel", func); this.wheel = func }
	});
	this.pause = null;
	Object.defineProperty(this, "onpause", {
		get: function(){ return this.pause; },
		set: function(func){ this.addEventListener("pause", func); this.pause = func }
	});
	this.play = null;
	Object.defineProperty(this, "onplay", {
		get: function(){ return this.play; },
		set: function(func){ this.addEventListener("play", func); this.play = func }
	});
	this.playing = null;
	Object.defineProperty(this, "onplaying", {
		get: function(){ return this.playing; },
		set: function(func){ this.addEventListener("playing", func); this.playing = func }
	});
	this.pointerdown = null;
	Object.defineProperty(this, "onpointerdown", {
		get: function(){ return this.pointerdown; },
		set: function(func){ this.addEventListener("pointerdown", func); this.pointerdown = func }
	});
	this.pointermov = null;
	Object.defineProperty(this, "onpointermove", {
		get: function(){ return this.pointermov; },
		set: function(func){ this.addEventListener("pointermov", func); this.pointermov = func }
	});
	this.pointerup = null;
	Object.defineProperty(this, "onpointerup", {
		get: function(){ return this.pointerup; },
		set: function(func){ this.addEventListener("pointerup", func); this.pointerup = func }
	});
	this.pointercancel = null;
	Object.defineProperty(this, "onpointercancel", {
		get: function(){ return this.pointercancel; },
		set: function(func){ this.addEventListener("pointercancel", func); this.pointercancel = func }
	});
	this.pointerover = null;
	Object.defineProperty(this, "onpointerover", {
		get: function(){ return this.pointerover; },
		set: function(func){ this.addEventListener("pointerover", func); this.pointerover = func }
	});
	this.pointerout = null;
	Object.defineProperty(this, "onpointerout", {
		get: function(){ return this.pointerout; },
		set: function(func){ this.addEventListener("pointerout", func); this.pointerout = func }
	});
	this.pointerenter = null;
	Object.defineProperty(this, "onpointerenter", {
		get: function(){ return this.pointerenter; },
		set: function(func){ this.addEventListener("pointerenter", func); this.pointerenter = func }
	});
	this.pointerleave = null;
	Object.defineProperty(this, "onpointerleave", {
		get: function(){ return this.pointerleave; },
		set: function(func){ this.addEventListener("pointerleave", func); this.pointerleave = func }
	});
	this.pointerlockchange = null;
	Object.defineProperty(this, "onpointerlockchange", {
		get: function(){ return this.pointerlockchange; },
		set: function(func){ this.addEventListener("pointerlockchange", func); this.pointerlockchange = func }
	});
	this.pointerlockerror = null;
	Object.defineProperty(this, "onpointerlockerror", {
		get: function(){ return this.pointerlockerror; },
		set: function(func){ this.addEventListener("pointerlockerror", func); this.pointerlockerror = func }
	});
	this.progress = null;
	Object.defineProperty(this, "onprogress", {
		get: function(){ return this.progress; },
		set: function(func){ this.addEventListener("progress", func); this.progress = func }
	});
	this.ratechange = null;
	Object.defineProperty(this, "onratechange", {
		get: function(){ return this.ratechange; },
		set: function(func){ this.addEventListener("ratechange", func); this.ratechange = func }
	});
	this.reset = null;
	Object.defineProperty(this, "onreset", {
		get: function(){ return this.reset; },
		set: function(func){ this.addEventListener("reset", func); this.reset = func }
	});
	this.resize = null;
	Object.defineProperty(this, "onresize", {
		get: function(){ return this.resize; },
		set: function(func){ this.addEventListener("resize", func); this.resize = func }
	});
	this.scroll = null;
	Object.defineProperty(this, "onscroll", {
		get: function(){ return this.scroll; },
		set: function(func){ this.addEventListener("scroll", func); this.scroll = func }
	});
	this.seeked = null;
	Object.defineProperty(this, "onseeked", {
		get: function(){ return this.seeked; },
		set: function(func){ this.addEventListener("seeked", func); this.seeked = func }
	});
	this.seeking = null;
	Object.defineProperty(this, "onseeking", {
		get: function(){ return this.seeking; },
		set: function(func){ this.addEventListener("seeking", func); this.seeking = func }
	});
	this.select = null;
	Object.defineProperty(this, "onselect", {
		get: function(){ return this.select; },
		set: function(func){ this.addEventListener("select", func); this.select = func }
	});
	this.selectstart = null;
	Object.defineProperty(this, "onselectstart", {
		get: function(){ return this.selectstart; },
		set: function(func){ this.addEventListener("selectstart", func); this.selectstart = func }
	});
	this.selectionchange = null;
	Object.defineProperty(this, "onselectionchange", {
		get: function(){ return this.selectionchange; },
		set: function(func){ this.addEventListener("selectionchange", func); this.selectionchange = func }
	});
	this.show = null;
	Object.defineProperty(this, "onshow", {
		get: function(){ return this.show; },
		set: function(func){ this.addEventListener("show", func); this.show = func }
	});
	this.sort = null;
	Object.defineProperty(this, "onsort", {
		get: function(){ return this.sort; },
		set: function(func){ this.addEventListener("sort", func); this.sort = func }
	});
	this.stalled = null;
	Object.defineProperty(this, "onstalled", {
		get: function(){ return this.stalled; },
		set: function(func){ this.addEventListener("stalled", func); this.stalled = func }
	});
	this.submit = null;
	Object.defineProperty(this, "onsubmit", {
		get: function(){ return this.submit; },
		set: function(func){ this.addEventListener("submit", func); this.submit = func }
	});
	this.suspend = null;
	Object.defineProperty(this, "onsuspend", {
		get: function(){ return this.suspend; },
		set: function(func){ this.addEventListener("suspend", func); this.suspend = func }
	});
	this.timeupdate = null;
	Object.defineProperty(this, "ontimeupdate", {
		get: function(){ return this.timeupdate; },
		set: function(func){ this.addEventListener("timeupdate", func); this.timeupdate = func }
	});
	this.volumechange = null;
	Object.defineProperty(this, "onvolumechange", {
		get: function(){ return this.volumechange; },
		set: function(func){ this.addEventListener("volumechange", func); this.volumechange = func }
	});
	this.touchcancel = null;
	Object.defineProperty(this, "ontouchcancel", {
		get: function(){ return this.touchcancel; },
		set: function(func){ this.addEventListener("touchcancel", func); this.touchcancel = func }
	});
	this.touchend = null;
	Object.defineProperty(this, "ontouchend", {
		get: function(){ return this.touchend; },
		set: function(func){ this.addEventListener("touchend", func); this.touchend = func }
	});
	this.touchmove = null;
	Object.defineProperty(this, "ontouchmove", {
		get: function(){ return this.touchmove; },
		set: function(func){ this.addEventListener("touchmove", func); this.touchmove = func }
	});
	this.ontouchstart = null;
	Object.defineProperty(this, "ontouchstart", {
		get: function(){ return this.touchstart; },
		set: function(func){ this.addEventListener("touchstart", func); this.touchstart = func }
	});
	this.transitioncancel = null;
	Object.defineProperty(this, "ontransitioncancel", {
		get: function(){ return this.transitioncancel; },
		set: function(func){ this.addEventListener("transitioncancel", func); this.transitioncancel = func }
	});
	this.transitionend = null;
	Object.defineProperty(this, "ontransitionend", {
		get: function(){ return this.transitionend; },
		set: function(func){ this.addEventListener("transitionend", func); this.transitionend = func }
	});
	this.waiting = null;
	Object.defineProperty(this, "onwaiting", {
		get: function(){ return this.waiting; },
		set: function(func){ this.addEventListener("waiting", func); this.waiting = func }
	});
}
GlobalEventHandlers.prototype = EventTarget.prototype;