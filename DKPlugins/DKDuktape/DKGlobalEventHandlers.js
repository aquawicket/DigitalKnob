//https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers

var GlobalEventHandlers = function GlobalEventHandlers(pointer) {
    this.pointer = pointer;

    this.abort = null;
    Object.defineProperty(this, "onabort", {
        configurable: true,
        get: function onabort() {
            return this.abort;
        },
        set: function onabort(func) {
            this.addEventListener("abort", func);
            this.abort = func
        }
    });
    this.animationcancel = null;
    Object.defineProperty(this, "onanimationcancel", {
        configurable: true,
        get: function onanimationcancel() {
            return this.animationcancel;
        },
        set: function onanimationcancel(func) {
            this.addEventListener("animationcancel", func);
            this.animationcancel = func
        }
    });
    this.animationend = null;
    Object.defineProperty(this, "onanimationend", {
        configurable: true,
        get: function onanimationend() {
            return this.animationend;
        },
        set: function onanimationend(func) {
            this.addEventListener("animationend", func);
            this.animationend = func
        }
    });
    this.animationiteration = null;
    Object.defineProperty(this, "onanimationiteration", {
        configurable: true,
        get: function onanimationiteration() {
            return this.animationiteration;
        },
        set: function onanimationiteration(func) {
            this.addEventListener("animationiteration", func);
            this.animationiteration = func
        }
    });
    this.animationstart = null;
    Object.defineProperty(this, "onanimationstart", {
        configurable: true,
        get: function onanimationstart() {
            return this.animationstart;
        },
        set: function onanimationstart(func) {
            this.addEventListener("animationstart", func);
            this.animationstart = func
        }
    });
    this.auxclick = null;
    Object.defineProperty(this, "onauxclick", {
        configurable: true,
        get: function onauxclick() {
            return this.auxclick;
        },
        set: function onauxclick(func) {
            this.addEventListener("auxclick", func);
            this.auxclick = func
        }
    });
	/*
    this.blur = null;
    Object.defineProperty(this, "onblur", {
        configurable: true,
        get: function onblur() {
            return this.blur;
        },
        set: function onblur(func) {
            this.addEventListener("blur", func);
            this.blur = func
        }
    });
	*/
    this.error = null;
    Object.defineProperty(this, "onerror", {
        configurable: true,
        get: function onerror() {
            return this.error;
        },
        set: function onerror(func) {
            this.addEventListener("error", func);
            this.error = func
        }
    });
	/*
    this.focus = null;
    Object.defineProperty(this, "onfocus", {
        configurable: true,
        get: function onfocus() {
            return this.focus;
        },
        set: function onfocus(func) {
            this.addEventListener("focus", func);
            this.focus = func
        }
    });
	*/
    this.canplay = null;
    Object.defineProperty(this, "oncanplay", {
        configurable: true,
        get: function oncanplay() {
            return this.canplay;
        },
        set: function oncanplay(func) {
            this.addEventListener("canplay", func);
            this.canplay = func
        }
    });
    this.canplaythrough = null;
    Object.defineProperty(this, "oncanplaythrough", {
        configurable: true,
        get: function oncanplaythrough() {
            return this.canplaythrough;
        },
        set: function oncanplaythrough(func) {
            this.addEventListener("canplaythrough", func);
            this.canplaythrough = func
        }
    });
    this.change = null;
    Object.defineProperty(this, "onchange", {
        configurable: true,
        get: function onchange() {
            return this.change;
        },
        set: function onchange(func) {
            this.addEventListener("change", func);
            this.change = func
        }
    });
    this.click = null;
    Object.defineProperty(this, "onclick", {
        configurable: true,
        get: function onclick() {
            return this.click;
        },
        set: function onclick(func) {
            this.addEventListener("click", func);
            this.click = func;
        }
    });
	/*
    this.close = null;
    Object.defineProperty(this, "onclose", {
        configurable: true,
        get: function onclose() {
            return this.close;
        },
        set: function onclose(func) {
            this.addEventListener("close", func);
            this.close = func
        }
    });
	*/
    this.contextmenu = null;
    Object.defineProperty(this, "oncontextmenu", {
        configurable: true,
        get: function oncontextmenu() {
            return this.contextmenu;
        },
        set: function oncontextmenu(func) {
            this.addEventListener("contextmenu", func);
            this.contextmenu = func
        }
    });
    this.cuechange = null;
    Object.defineProperty(this, "oncuechange", {
        configurable: true,
        get: function oncuechange() {
            return this.cuechange;
        },
        set: function oncuechange(func) {
            this.addEventListener("cuechange", func);
            this.cuechange = func
        }
    });
    this.dblclick = null;
    Object.defineProperty(this, "ondblclick", {
        configurable: true,
        get: function ondblclick() {
            return this.dblclick;
        },
        set: function ondblclick(func) {
            this.addEventListener("dblclick", func);
            this.dblclick = func
        }
    });
    this.drag = null;
    Object.defineProperty(this, "ondrag", {
        configurable: true,
        get: function ondrag() {
            return this.drag;
        },
        set: function ondrag(func) {
            this.addEventListener("drag", func);
            this.drag = func
        }
    });
    this.dragend = null;
    Object.defineProperty(this, "ondragend", {
        configurable: true,
        get: function ondragend() {
            return this.dragend;
        },
        set: function ondragend(func) {
            this.addEventListener("dragend", func);
            this.dragend = func
        }
    });
    this.dragenter = null;
    Object.defineProperty(this, "ondragenter", {
        configurable: true,
        get: function ondragenter() {
            return this.dragenter;
        },
        set: function ondragenter(func) {
            this.addEventListener("dragenter", func);
            this.dragenter = func
        }
    });
    this.dragexit = null;
    Object.defineProperty(this, "ondragexit", {
        configurable: true,
        get: function ondragexit() {
            return this.dragexit;
        },
        set: function ondragexit(func) {
            this.addEventListener("dragexit", func);
            this.dragexit = func
        }
    });
    this.dragleave = null;
    Object.defineProperty(this, "ondragleave", {
        configurable: true,
        get: function ondragleave() {
            return this.dragleave;
        },
        set: function ondragleave(func) {
            this.addEventListener("dragleave", func);
            this.dragleave = func
        }
    });
    this.dragover = null;
    Object.defineProperty(this, "ondragover", {
        configurable: true,
        get: function ondragover() {
            return this.dragover;
        },
        set: function ondragover(func) {
            this.addEventListener("dragover", func);
            this.dragover = func
        }
    });
    this.dragstart = null;
    Object.defineProperty(this, "ondragstart", {
        configurable: true,
        get: function ondragstart() {
            return this.dragstart;
        },
        set: function ondragstart(func) {
            this.addEventListener("dragstart", func);
            this.dragstart = func
        }
    });
    this.drop = null;
    Object.defineProperty(this, "ondrop", {
        configurable: true,
        get: function ondrop() {
            return this.drop;
        },
        set: function ondrop(func) {
            this.addEventListener("drop", func);
            this.drop = func
        }
    });
    this.durationchange = null;
    Object.defineProperty(this, "ondurationchange", {
        configurable: true,
        get: function ondurationchange() {
            return this.durationchange;
        },
        set: function ondurationchange(func) {
            this.addEventListener("durationchange", func);
            this.durationchange = func
        }
    });
    this.emptied = null;
    Object.defineProperty(this, "onemptied", {
        configurable: true,
        get: function onemptied() {
            return this.emptied;
        },
        set: function onemptied(func) {
            this.addEventListener("emptied", func);
            this.emptied = func
        }
    });
    this.ended = null;
    Object.defineProperty(this, "onended", {
        configurable: true,
        get: function onended() {
            return this.ended;
        },
        set: function onended(func) {
            this.addEventListener("ended", func);
            this.ended = func
        }
    });
    this.gotpointercapture = null;
    Object.defineProperty(this, "ongotpointercapture", {
        configurable: true,
        get: function ongotpointercapture() {
            return this.gotpointercapture;
        },
        set: function ongotpointercapture(func) {
            this.addEventListener("gotpointercapture", func);
            this.gotpointercapture = func
        }
    });
    this.input = null;
    Object.defineProperty(this, "oninput", {
        configurable: true,
        get: function oninput() {
            return this.input;
        },
        set: function oninput(func) {
            this.addEventListener("input", func);
            this.input = func
        }
    });
    this.invalid = null;
    Object.defineProperty(this, "oninvalid", {
        configurable: true,
        get: function oninvalid() {
            return this.invalid;
        },
        set: function oninvalid(func) {
            this.addEventListener("invalid", func);
            this.invalid = func
        }
    });
    this.keydown = null;
    Object.defineProperty(this, "onkeydown", {
        configurable: true,
        get: function onkeydown() {
            return this.keydown;
        },
        set: function onkeydown(func) {
            this.addEventListener("keydown", func);
            this.keydown = func
        }
    });
    this.keypress = null;
    Object.defineProperty(this, "onkeypress", {
        configurable: true,
        get: function onkeypress() {
            return this.keypress;
        },
        set: function onkeypress(func) {
            this.addEventListener("keypress", func);
            this.keypress = func
        }
    });
    this.keyup = null;
    Object.defineProperty(this, "onkeyup", {
        configurable: true,
        get: function onkeyup() {
            return this.keyup;
        },
        set: function onkeyup(func) {
            this.addEventListener("keyup", func);
            this.keyup = func
        }
    });
    this.load = null;
    Object.defineProperty(this, "onload", {
        configurable: true,
        get: function onload() {
            return this.load;
        },
        set: function onload(func) {
            this.addEventListener("load", func);
            this.load = func
        }
    });
    this.loadeddata = null;
    Object.defineProperty(this, "onloadeddata", {
        configurable: true,
        get: function onloadeddata() {
            return this.loadeddata;
        },
        set: function onloadeddata(func) {
            this.addEventListener("loadeddata", func);
            this.loadeddata = func
        }
    });
    this.loadedmetadata = null;
    Object.defineProperty(this, "onloadedmetadata", {
        configurable: true,
        get: function onloadedmetadata() {
            return this.loadedmetadata;
        },
        set: function onloadedmetadata(func) {
            this.addEventListener("loadedmetadata", func);
            this.loadedmetadata = func
        }
    });
    this.loadend = null;
    Object.defineProperty(this, "onloadend", {
        configurable: true,
        get: function onloadend() {
            return this.loadend;
        },
        set: function onloadend(func) {
            this.addEventListener("loadend", func);
            this.loadend = func
        }
    });
    this.loadstart = null;
    Object.defineProperty(this, "onloadstart", {
        configurable: true,
        get: function onloadstart() {
            return this.loadstart;
        },
        set: function onloadstart(func) {
            this.addEventListener("loadstart", func);
            this.loadstart = func
        }
    });
    this.lostpointercapture = null;
    Object.defineProperty(this, "onlostpointercapture", {
        configurable: true,
        get: function onlostpointercapture() {
            return this.lostpointercapture;
        },
        set: function onlostpointercapture(func) {
            this.addEventListener("lostpointercapture", func);
            this.lostpointercapture = func
        }
    });
    this.mousedown = null;
    Object.defineProperty(this, "onmousedown", {
        configurable: true,
        get: function onmousedown() {
            return this.mousedown;
        },
        set: function onmousedown(func) {
            this.addEventListener("mousedown", func);
            this.mousedown = func
        }
    });
    this.mouseenter = null;
    Object.defineProperty(this, "onmouseenter", {
        configurable: true,
        get: function onmouseenter() {
            return this.mouseenter;
        },
        set: function onmouseenter(func) {
            this.addEventListener("mouseenter", func);
            this.mouseenter = func
        }
    });
    this.mouseleave = null;
    Object.defineProperty(this, "onmouseleave", {
        configurable: true,
        get: function onmouseleave() {
            return this.mouseleave;
        },
        set: function onmouseleave(func) {
            this.addEventListener("mouseleave", func);
            this.mouseleave = func
        }
    });
    this.mousemove = null;
    Object.defineProperty(this, "onmousemove", {
        configurable: true,
        get: function onmousemove() {
            return this.mousemove;
        },
        set: function onmousemove(func) {
            this.addEventListener("mousemove", func);
            this.mousemove = func
        }
    });
    this.mouseout = null;
    Object.defineProperty(this, "onmouseout", {
        configurable: true,
        get: function onmouseout() {
            return this.mouseout;
        },
        set: function onmouseout(func) {
            this.addEventListener("mouseout", func);
            this.mouseout = func
        }
    });
    this.mouseover = null;
    Object.defineProperty(this, "onmouseover", {
        configurable: true,
        get: function onmouseover() {
            return this.mouseover;
        },
        set: function onmouseover(func) {
            this.addEventListener("mouseover", func);
            this.mouseover = func
        }
    });
    this.mouseup = null;
    Object.defineProperty(this, "onmouseup", {
        configurable: true,
        get: function onmouseup() {
            return this.mouseup;
        },
        set: function onmouseup(func) {
            this.addEventListener("mouseup", func);
            this.mouseup = func
        }
    });
    this.mousewheel = null;
    Object.defineProperty(this, "onmousewheel", {
        configurable: true,
        get: function onmousewheel() {
            return this.mousewheel;
        },
        set: function onmousewheel(func) {
            this.addEventListener("mousewheel", func);
            this.mousewheel = func
        }
    });
    this.wheel = null;
    Object.defineProperty(this, "onwheel", {
        configurable: true,
        get: function onwheel() {
            return this.wheel;
        },
        set: function onwheel(func) {
            this.addEventListener("wheel", func);
            this.wheel = func
        }
    });
    this.pause = null;
    Object.defineProperty(this, "onpause", {
        configurable: true,
        get: function onpause() {
            return this.pause;
        },
        set: function onpause(func) {
            this.addEventListener("pause", func);
            this.pause = func
        }
    });
    this.play = null;
    Object.defineProperty(this, "onplay", {
        configurable: true,
        get: function onplay() {
            return this.play;
        },
        set: function onplay(func) {
            this.addEventListener("play", func);
            this.play = func
        }
    });
    this.playing = null;
    Object.defineProperty(this, "onplaying", {
        configurable: true,
        get: function onplaying() {
            return this.playing;
        },
        set: function onplaying(func) {
            this.addEventListener("playing", func);
            this.playing = func
        }
    });
    this.pointerdown = null;
    Object.defineProperty(this, "onpointerdown", {
        configurable: true,
        get: function onpointerdown() {
            return this.pointerdown;
        },
        set: function onpointerdown(func) {
            this.addEventListener("pointerdown", func);
            this.pointerdown = func
        }
    });
    this.pointermov = null;
    Object.defineProperty(this, "onpointermove", {
        configurable: true,
        get: function onpointermove() {
            return this.pointermov;
        },
        set: function onpointermove(func) {
            this.addEventListener("pointermov", func);
            this.pointermov = func
        }
    });
    this.pointerup = null;
    Object.defineProperty(this, "onpointerup", {
        configurable: true,
        get: function onpointerup() {
            return this.pointerup;
        },
        set: function onpointerup(func) {
            this.addEventListener("pointerup", func);
            this.pointerup = func
        }
    });
    this.pointercancel = null;
    Object.defineProperty(this, "onpointercancel", {
        configurable: true,
        get: function onpointercancel() {
            return this.pointercancel;
        },
        set: function onpointercancel(func) {
            this.addEventListener("pointercancel", func);
            this.pointercancel = func
        }
    });
    this.pointerover = null;
    Object.defineProperty(this, "onpointerover", {
        configurable: true,
        get: function onpointerover() {
            return this.pointerover;
        },
        set: function onpointerover(func) {
            this.addEventListener("pointerover", func);
            this.pointerover = func
        }
    });
    this.pointerout = null;
    Object.defineProperty(this, "onpointerout", {
        configurable: true,
        get: function onpointerout() {
            return this.pointerout;
        },
        set: function onpointerout(func) {
            this.addEventListener("pointerout", func);
            this.pointerout = func
        }
    });
    this.pointerenter = null;
    Object.defineProperty(this, "onpointerenter", {
        configurable: true,
        get: function onpointerenter() {
            return this.pointerenter;
        },
        set: function onpointerenter(func) {
            this.addEventListener("pointerenter", func);
            this.pointerenter = func
        }
    });
    this.pointerleave = null;
    Object.defineProperty(this, "onpointerleave", {
        configurable: true,
        get: function onpointerleave() {
            return this.pointerleave;
        },
        set: function onpointerleave(func) {
            this.addEventListener("pointerleave", func);
            this.pointerleave = func
        }
    });
    this.pointerlockchange = null;
    Object.defineProperty(this, "onpointerlockchange", {
        configurable: true,
        get: function onpointerlockchange() {
            return this.pointerlockchange;
        },
        set: function onpointerlockchange(func) {
            this.addEventListener("pointerlockchange", func);
            this.pointerlockchange = func
        }
    });
    this.pointerlockerror = null;
    Object.defineProperty(this, "onpointerlockerror", {
        configurable: true,
        get: function onpointerlockerror() {
            return this.pointerlockerror;
        },
        set: function onpointerlockerror(func) {
            this.addEventListener("pointerlockerror", func);
            this.pointerlockerror = func
        }
    });
    this.progress = null;
    Object.defineProperty(this, "onprogress", {
        configurable: true,
        get: function onprogress() {
            return this.progress;
        },
        set: function onprogress(func) {
            this.addEventListener("progress", func);
            this.progress = func
        }
    });
    this.ratechange = null;
    Object.defineProperty(this, "onratechange", {
        configurable: true,
        get: function onratechange() {
            return this.ratechange;
        },
        set: function onratechange(func) {
            this.addEventListener("ratechange", func);
            this.ratechange = func
        }
    });
    this.reset = null;
    Object.defineProperty(this, "onreset", {
        configurable: true,
        get: function onreset() {
            return this.reset;
        },
        set: function onreset(func) {
            this.addEventListener("reset", func);
            this.reset = func
        }
    });
    this.resize = null;
    Object.defineProperty(this, "onresize", {
        configurable: true,
        get: function onresize() {
            return this.resize;
        },
        set: function onresize(func) {
            this.addEventListener("resize", func);
            this.resize = func
        }
    });
    this.scroll = null;
    Object.defineProperty(this, "onscroll", {
        configurable: true,
        get: function onscroll() {
            return this.scroll;
        },
        set: function onscroll(func) {
            this.addEventListener("scroll", func);
            this.scroll = func
        }
    });
    this.seeked = null;
    Object.defineProperty(this, "onseeked", {
        configurable: true,
        get: function onseeked() {
            return this.seeked;
        },
        set: function onseeked(func) {
            this.addEventListener("seeked", func);
            this.seeked = func
        }
    });
    this.seeking = null;
    Object.defineProperty(this, "onseeking", {
        configurable: true,
        get: function onseeking() {
            return this.seeking;
        },
        set: function onseeking(func) {
            this.addEventListener("seeking", func);
            this.seeking = func
        }
    });
    this.select = null;
    Object.defineProperty(this, "onselect", {
        configurable: true,
        get: function onselect() {
            return this.select;
        },
        set: function onselect(func) {
            this.addEventListener("select", func);
            this.select = func
        }
    });
    this.selectstart = null;
    Object.defineProperty(this, "onselectstart", {
        configurable: true,
        get: function onselectstart() {
            return this.selectstart;
        },
        set: function onselectstart(func) {
            this.addEventListener("selectstart", func);
            this.selectstart = func
        }
    });
    this.selectionchange = null;
    Object.defineProperty(this, "onselectionchange", {
        configurable: true,
        get: function onselectionchange() {
            return this.selectionchange;
        },
        set: function onselectionchange(func) {
            this.addEventListener("selectionchange", func);
            this.selectionchange = func
        }
    });
    this.show = null;
    Object.defineProperty(this, "onshow", {
        configurable: true,
        get: function onshow() {
            return this.show;
        },
        set: function onshow(func) {
            this.addEventListener("show", func);
            this.show = func
        }
    });
    this.sort = null;
    Object.defineProperty(this, "onsort", {
        configurable: true,
        get: function onsort() {
            return this.sort;
        },
        set: function onsort(func) {
            this.addEventListener("sort", func);
            this.sort = func
        }
    });
    this.stalled = null;
    Object.defineProperty(this, "onstalled", {
        configurable: true,
        get: function onstalled() {
            return this.stalled;
        },
        set: function onstalled(func) {
            this.addEventListener("stalled", func);
            this.stalled = func
        }
    });
    this.submit = null;
    Object.defineProperty(this, "onsubmit", {
        configurable: true,
        get: function onsubmit() {
            return this.submit;
        },
        set: function onsubmit(func) {
            this.addEventListener("submit", func);
            this.submit = func
        }
    });
    this.suspend = null;
    Object.defineProperty(this, "onsuspend", {
        configurable: true,
        get: function onsuspend() {
            return this.suspend;
        },
        set: function onsuspend(func) {
            this.addEventListener("suspend", func);
            this.suspend = func
        }
    });
    this.timeupdate = null;
    Object.defineProperty(this, "ontimeupdate", {
        configurable: true,
        get: function ontimeupdate() {
            return this.timeupdate;
        },
        set: function ontimeupdate(func) {
            this.addEventListener("timeupdate", func);
            this.timeupdate = func
        }
    });
    this.volumechange = null;
    Object.defineProperty(this, "onvolumechange", {
        configurable: true,
        get: function onvolumechange() {
            return this.volumechange;
        },
        set: function onvolumechange(func) {
            this.addEventListener("volumechange", func);
            this.volumechange = func
        }
    });
    this.touchcancel = null;
    Object.defineProperty(this, "ontouchcancel", {
        configurable: true,
        get: function ontouchcancel() {
            return this.touchcancel;
        },
        set: function ontouchcancel(func) {
            this.addEventListener("touchcancel", func);
            this.touchcancel = func
        }
    });
    this.touchend = null;
    Object.defineProperty(this, "ontouchend", {
        configurable: true,
        get: function ontouchend() {
            return this.touchend;
        },
        set: function ontouchend(func) {
            this.addEventListener("touchend", func);
            this.touchend = func
        }
    });
    this.touchmove = null;
    Object.defineProperty(this, "ontouchmove", {
        configurable: true,
        get: function ontouchmove() {
            return this.touchmove;
        },
        set: function ontouchmove(func) {
            this.addEventListener("touchmove", func);
            this.touchmove = func
        }
    });
    this.ontouchstart = null;
    Object.defineProperty(this, "ontouchstart", {
        configurable: true,
        get: function ontouchstart() {
            return this.touchstart;
        },
        set: function ontouchstart(func) {
            this.addEventListener("touchstart", func);
            this.touchstart = func
        }
    });
    this.transitioncancel = null;
    Object.defineProperty(this, "ontransitioncancel", {
        configurable: true,
        get: function ontransitioncancel() {
            return this.transitioncancel;
        },
        set: function ontransitioncancel(func) {
            this.addEventListener("transitioncancel", func);
            this.transitioncancel = func
        }
    });
    this.transitionend = null;
    Object.defineProperty(this, "ontransitionend", {
        configurable: true,
        get: function ontransitionend() {
            return this.transitionend;
        },
        set: function ontransitionend(func) {
            this.addEventListener("transitionend", func);
            this.transitionend = func
        }
    });
    this.waiting = null;
    Object.defineProperty(this, "onwaiting", {
        configurable: true,
        get: function onwaiting() {
            return this.waiting;
        },
        set: function onwaiting(func) {
            this.addEventListener("waiting", func);
            this.waiting = func
        }
    });
	
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object GlobalEventHandlers]"
		}
	}
}
GlobalEventHandlers.prototype = EventTarget.prototype;
