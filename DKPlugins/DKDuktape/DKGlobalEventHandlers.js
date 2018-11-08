///////////////////////////////////////////
var GlobalEventHandlers = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("GlobalEventHandlers("+pointer+")");
	
	this.pointer = pointer;
	
	Object.defineProperty(this, "onabort", {
		get: function(){ return this.abort; },
		set: function(func){ this.addEventListener("abort", func); this.abort = func }
	});
	Object.defineProperty(this, "onanimationcancel", {
		get: function(){ return this.animationcancel; },
		set: function(func){ this.addEventListener("animationcancel", func); this.animationcancel = func }
	});
	Object.defineProperty(this, "onanimationend", {
		get: function(){ return this.animationend; },
		set: function(func){ this.addEventListener("animationend", func); this.animationend = func }
	});
	Object.defineProperty(this, "onanimationiteration", {
		get: function(){ return this.animationiteration; },
		set: function(func){ this.addEventListener("animationiteration", func); this.animationiteration = func }
	});
	Object.defineProperty(this, "onanimationstart", {
		get: function(){ return this.animationstart; },
		set: function(func){ this.addEventListener("animationstart", func); this.animationstart = func }
	});
	Object.defineProperty(this, "onauxclick", {
		get: function(){ return this.auxclick; },
		set: function(func){ this.addEventListener("auxclick", func); this.auxclick = func }
	});
	Object.defineProperty(this, "onblur", {
		get: function(){ return this.blur; },
		set: function(func){ this.addEventListener("blur", func); this.blur = func }
	});
	Object.defineProperty(this, "onerror", {
		get: function(){ return this.error; },
		set: function(func){ this.addEventListener("error", func); this.error = func }
	});
	Object.defineProperty(this, "onfocus", {
		get: function(){ return this.focus; },
		set: function(func){ this.addEventListener("focus", func); this.focus = func }
	});
	Object.defineProperty(this, "oncanplay", {
		get: function(){ return this.canplay; },
		set: function(func){ this.addEventListener("canplay", func); this.canplay = func }
	});
	Object.defineProperty(this, "oncanplaythrough", {
		get: function(){ return this.canplaythrough; },
		set: function(func){ this.addEventListener("canplaythrough", func); this.canplaythrough = func }
	});
	Object.defineProperty(this, "onchange", {
		get: function(){ return this.change; },
		set: function(func){ this.addEventListener("change", func); this.change = func }
	});
	Object.defineProperty(this, "onclick", {
		get: function(){ return this.click; },
		set: function(func){ this.addEventListener("click", func); this.click = func }
	});
	Object.defineProperty(this, "onclose", {
		get: function(){ return this.close; },
		set: function(func){ this.addEventListener("close", func); this.close = func }
	});
	Object.defineProperty(this, "oncontextmenu", {
		get: function(){ return this.contextmenu; },
		set: function(func){ this.addEventListener("contextmenu", func); this.contextmenu = func }
	});
	Object.defineProperty(this, "oncuechange", {
		get: function(){ return this.cuechange; },
		set: function(func){ this.addEventListener("cuechange", func); this.cuechange = func }
	});
	Object.defineProperty(this, "ondblclick", {
		get: function(){ return this.dblclick; },
		set: function(func){ this.addEventListener("dblclick", func); this.dblclick = func }
	});
	Object.defineProperty(this, "ondrag", {
		get: function(){ return this.drag; },
		set: function(func){ this.addEventListener("drag", func); this.drag = func }
	});
	Object.defineProperty(this, "ondragend", {
		get: function(){ return this.dragend; },
		set: function(func){ this.addEventListener("dragend", func); this.dragend = func }
	});
	Object.defineProperty(this, "ondragenter", {
		get: function(){ return this.dragenter; },
		set: function(func){ this.addEventListener("dragenter", func); this.dragenter = func }
	});
	Object.defineProperty(this, "ondragexit", {
		get: function(){ return this.dragexit; },
		set: function(func){ this.addEventListener("dragexit", func); this.dragexit = func }
	});
	Object.defineProperty(this, "ondragleave", {
		get: function(){ return this.dragleave; },
		set: function(func){ this.addEventListener("dragleave", func); this.dragleave = func }
	});
	Object.defineProperty(this, "ondragover", {
		get: function(){ return this.dragover; },
		set: function(func){ this.addEventListener("dragover", func); this.dragover = func }
	});
	Object.defineProperty(this, "ondragstart", {
		get: function(){ return this.dragstart; },
		set: function(func){ this.addEventListener("dragstart", func); this.dragstart = func }
	});
	Object.defineProperty(this, "ondrop", {
		get: function(){ return this.drop; },
		set: function(func){ this.addEventListener("drop", func); this.drop = func }
	});
	Object.defineProperty(this, "ondurationchange", {
		get: function(){ return this.durationchange; },
		set: function(func){ this.addEventListener("durationchange", func); this.durationchange = func }
	});
	Object.defineProperty(this, "onemptied", {
		get: function(){ return this.emptied; },
		set: function(func){ this.addEventListener("emptied", func); this.emptied = func }
	});
	Object.defineProperty(this, "onended", {
		get: function(){ return this.ended; },
		set: function(func){ this.addEventListener("ended", func); this.ended = func }
	});
	Object.defineProperty(this, "ongotpointercapture", {
		get: function(){ return this.gotpointercapture; },
		set: function(func){ this.addEventListener("gotpointercapture", func); this.gotpointercapture = func }
	});
	Object.defineProperty(this, "oninput", {
		get: function(){ return this.input; },
		set: function(func){ this.addEventListener("input", func); this.input = func }
	});
	Object.defineProperty(this, "oninvalid", {
		get: function(){ return this.invalid; },
		set: function(func){ this.addEventListener("invalid", func); this.invalid = func }
	});
	Object.defineProperty(this, "onkeydown", {
		get: function(){ return this.keydown; },
		set: function(func){ this.addEventListener("keydown", func); this.keydown = func }
	});
	Object.defineProperty(this, "onkeypress", {
		get: function(){ return this.keypress; },
		set: function(func){ this.addEventListener("keypress", func); this.keypress = func }
	});
	Object.defineProperty(this, "onkeyup", {
		get: function(){ return this.keyup; },
		set: function(func){ this.addEventListener("keyup", func); this.keyup = func }
	});
	Object.defineProperty(this, "onload", {
		get: function(){ return this.load; },
		set: function(func){ this.addEventListener("load", func); this.load = func }
	});
	Object.defineProperty(this, "onloadeddata", {
		get: function(){ return this.loadeddata; },
		set: function(func){ this.addEventListener("loadeddata", func); this.loadeddata = func }
	});
	Object.defineProperty(this, "onloadedmetadata", {
		get: function(){ return this.loadedmetadata; },
		set: function(func){ this.addEventListener("loadedmetadata", func); this.loadedmetadata = func }
	});
	Object.defineProperty(this, "onloadend", {
		get: function(){ return this.loadend; },
		set: function(func){ this.addEventListener("loadend", func); this.loadend = func }
	});
	Object.defineProperty(this, "onloadstart", {
		get: function(){ return this.loadstart; },
		set: function(func){ this.addEventListener("loadstart", func); this.loadstart = func }
	});
	Object.defineProperty(this, "onlostpointercapture", {
		get: function(){ return this.lostpointercapture; },
		set: function(func){ this.addEventListener("lostpointercapture", func); this.lostpointercapture = func }
	});
	Object.defineProperty(this, "onmousedown", {
		get: function(){ return this.mousedown; },
		set: function(func){ this.addEventListener("mousedown", func); this.mousedown = func }
	});
	Object.defineProperty(this, "onmouseenter", {
		get: function(){ return this.mouseenter; },
		set: function(func){ this.addEventListener("mouseenter", func); this.mouseenter = func }
	});
	Object.defineProperty(this, "onmouseleave", {
		get: function(){ return this.mouseleave; },
		set: function(func){ this.addEventListener("mouseleave", func); this.mouseleave = func }
	});
	Object.defineProperty(this, "onmousemove", {
		get: function(){ return this.mousemove; },
		set: function(func){ this.addEventListener("mousemove", func); this.mousemove = func }
	});
	Object.defineProperty(this, "onmouseout", {
		get: function(){ return this.mouseout; },
		set: function(func){ this.addEventListener("mouseout", func); this.mouseout = func }
	});
	Object.defineProperty(this, "onmouseover", {
		get: function(){ return this.mouseover; },
		set: function(func){ this.addEventListener("mouseover", func); this.mouseover = func }
	});
	Object.defineProperty(this, "onmouseup", {
		get: function(){ return this.mouseup; },
		set: function(func){ this.addEventListener("mouseup", func); this.mouseup = func }
	});
	Object.defineProperty(this, "onmousewheel", {
		get: function(){ return this.mousewheel; },
		set: function(func){ this.addEventListener("mousewheel", func); this.mousewheel = func }
	});
	Object.defineProperty(this, "onwheel", {
		get: function(){ return this.wheel; },
		set: function(func){ this.addEventListener("wheel", func); this.wheel = func }
	});
	Object.defineProperty(this, "onpause", {
		get: function(){ return this.pause; },
		set: function(func){ this.addEventListener("pause", func); this.pause = func }
	});
	Object.defineProperty(this, "onplay", {
		get: function(){ return this.play; },
		set: function(func){ this.addEventListener("play", func); this.play = func }
	});
	Object.defineProperty(this, "onplaying", {
		get: function(){ return this.playing; },
		set: function(func){ this.addEventListener("playing", func); this.playing = func }
	});
	Object.defineProperty(this, "onpointerdown", {
		get: function(){ return this.pointerdown; },
		set: function(func){ this.addEventListener("pointerdown", func); this.pointerdown = func }
	});
	Object.defineProperty(this, "onpointermove", {
		get: function(){ return this.pointermov; },
		set: function(func){ this.addEventListener("pointermov", func); this.pointermov = func }
	});
	Object.defineProperty(this, "onpointerup", {
		get: function(){ return this.pointerup; },
		set: function(func){ this.addEventListener("pointerup", func); this.pointerup = func }
	});
	Object.defineProperty(this, "onpointercancel", {
		get: function(){ return this.pointercancel; },
		set: function(func){ this.addEventListener("pointercancel", func); this.pointercancel = func }
	});
	Object.defineProperty(this, "onpointerover", {
		get: function(){ return this.pointerover; },
		set: function(func){ this.addEventListener("pointerover", func); this.pointerover = func }
	});
	Object.defineProperty(this, "onpointerout", {
		get: function(){ return this.pointerout; },
		set: function(func){ this.addEventListener("pointerout", func); this.pointerout = func }
	});
	Object.defineProperty(this, "onpointerenter", {
		get: function(){ return this.pointerenter; },
		set: function(func){ this.addEventListener("pointerenter", func); this.pointerenter = func }
	});
	Object.defineProperty(this, "onpointerleave", {
		get: function(){ return this.pointerleave; },
		set: function(func){ this.addEventListener("pointerleave", func); this.pointerleave = func }
	});
	Object.defineProperty(this, "onpointerlockchange", {
		get: function(){ return this.pointerlockchange; },
		set: function(func){ this.addEventListener("pointerlockchange", func); this.pointerlockchange = func }
	});
	Object.defineProperty(this, "onpointerlockerror", {
		get: function(){ return this.pointerlockerror; },
		set: function(func){ this.addEventListener("pointerlockerror", func); this.pointerlockerror = func }
	});
	Object.defineProperty(this, "onprogress", {
		get: function(){ return this.progress; },
		set: function(func){ this.addEventListener("progress", func); this.progress = func }
	});
	Object.defineProperty(this, "onratechange", {
		get: function(){ return this.ratechange; },
		set: function(func){ this.addEventListener("ratechange", func); this.ratechange = func }
	});
	Object.defineProperty(this, "onreset", {
		get: function(){ return this.reset; },
		set: function(func){ this.addEventListener("reset", func); this.reset = func }
	});
	Object.defineProperty(this, "onresize", {
		get: function(){ return this.resize; },
		set: function(func){ this.addEventListener("resize", func); this.resize = func }
	});
	Object.defineProperty(this, "onscroll", {
		get: function(){ return this.scroll; },
		set: function(func){ this.addEventListener("scroll", func); this.scroll = func }
	});
	Object.defineProperty(this, "onseeked", {
		get: function(){ return this.seeked; },
		set: function(func){ this.addEventListener("seeked", func); this.seeked = func }
	});
	Object.defineProperty(this, "onseeking", {
		get: function(){ return this.seeking; },
		set: function(func){ this.addEventListener("seeking", func); this.seeking = func }
	});
	Object.defineProperty(this, "onselect", {
		get: function(){ return this.select; },
		set: function(func){ this.addEventListener("select", func); this.select = func }
	});
	Object.defineProperty(this, "onselectstart", {
		get: function(){ return this.selectstart; },
		set: function(func){ this.addEventListener("selectstart", func); this.selectstart = func }
	});
	Object.defineProperty(this, "onselectionchange", {
		get: function(){ return this.selectionchange; },
		set: function(func){ this.addEventListener("selectionchange", func); this.selectionchange = func }
	});
	Object.defineProperty(this, "onshow", {
		get: function(){ return this.show; },
		set: function(func){ this.addEventListener("show", func); this.show = func }
	});
	Object.defineProperty(this, "onsort", {
		get: function(){ return this.sort; },
		set: function(func){ this.addEventListener("sort", func); this.sort = func }
	});
	Object.defineProperty(this, "onstalled", {
		get: function(){ return this.stalled; },
		set: function(func){ this.addEventListener("stalled", func); this.stalled = func }
	});
	Object.defineProperty(this, "onsubmit", {
		get: function(){ return this.submit; },
		set: function(func){ this.addEventListener("submit", func); this.submit = func }
	});
	Object.defineProperty(this, "onsuspend", {
		get: function(){ return this.suspend; },
		set: function(func){ this.addEventListener("suspend", func); this.suspend = func }
	});
	Object.defineProperty(this, "ontimeupdate", {
		get: function(){ return this.timeupdate; },
		set: function(func){ this.addEventListener("timeupdate", func); this.timeupdate = func }
	});
	Object.defineProperty(this, "onvolumechange", {
		get: function(){ return this.volumechange; },
		set: function(func){ this.addEventListener("volumechange", func); this.volumechange = func }
	});
	Object.defineProperty(this, "ontouchcancel", {
		get: function(){ return this.touchcancel; },
		set: function(func){ this.addEventListener("touchcancel", func); this.touchcancel = func }
	});
	Object.defineProperty(this, "ontouchend", {
		get: function(){ return this.touchend; },
		set: function(func){ this.addEventListener("touchend", func); this.touchend = func }
	});
	Object.defineProperty(this, "ontouchmove", {
		get: function(){ return this.touchmove; },
		set: function(func){ this.addEventListener("touchmove", func); this.touchmove = func }
	});
	Object.defineProperty(this, "ontouchstart", {
		get: function(){ return this.touchstart; },
		set: function(func){ this.addEventListener("touchstart", func); this.touchstart = func }
	});
	Object.defineProperty(this, "ontransitioncancel", {
		get: function(){ return this.transitioncancel; },
		set: function(func){ this.addEventListener("transitioncancel", func); this.transitioncancel = func }
	});
	Object.defineProperty(this, "ontransitionend", {
		get: function(){ return this.transitionend; },
		set: function(func){ this.addEventListener("transitionend", func); this.transitionend = func }
	});
	Object.defineProperty(this, "onwaiting", {
		get: function(){ return this.waiting; },
		set: function(func){ this.addEventListener("waiting", func); this.waiting = func }
	});
}
GlobalEventHandlers.prototype = EventTarget.prototype;