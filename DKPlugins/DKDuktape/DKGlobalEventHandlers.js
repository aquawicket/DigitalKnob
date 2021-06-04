//https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers

var GlobalEventHandlers = function(pointer) {
    this.pointer = pointer;

    this.abort = null;
    Object.defineProperty(this, "onabort", {
        configurable: true,
        get: function() {
            return this.abort;
        },
        set: function(func) {
            this.addEventListener("abort", func);
            this.abort = func
        }
    });
    this.animationcancel = null;
    Object.defineProperty(this, "onanimationcancel", {
        configurable: true,
        get: function() {
            return this.animationcancel;
        },
        set: function(func) {
            this.addEventListener("animationcancel", func);
            this.animationcancel = func
        }
    });
    this.animationend = null;
    Object.defineProperty(this, "onanimationend", {
        configurable: true,
        get: function() {
            return this.animationend;
        },
        set: function(func) {
            this.addEventListener("animationend", func);
            this.animationend = func
        }
    });
    this.animationiteration = null;
    Object.defineProperty(this, "onanimationiteration", {
        configurable: true,
        get: function() {
            return this.animationiteration;
        },
        set: function(func) {
            this.addEventListener("animationiteration", func);
            this.animationiteration = func
        }
    });
    this.animationstart = null;
    Object.defineProperty(this, "onanimationstart", {
        configurable: true,
        get: function() {
            return this.animationstart;
        },
        set: function(func) {
            this.addEventListener("animationstart", func);
            this.animationstart = func
        }
    });
    this.auxclick = null;
    Object.defineProperty(this, "onauxclick", {
        configurable: true,
        get: function() {
            return this.auxclick;
        },
        set: function(func) {
            this.addEventListener("auxclick", func);
            this.auxclick = func
        }
    });
    this.blur = null;
    Object.defineProperty(this, "onblur", {
        configurable: true,
        get: function() {
            return this.blur;
        },
        set: function(func) {
            this.addEventListener("blur", func);
            this.blur = func
        }
    });
    this.error = null;
    Object.defineProperty(this, "onerror", {
        configurable: true,
        get: function() {
            return this.error;
        },
        set: function(func) {
            this.addEventListener("error", func);
            this.error = func
        }
    });
    this.focus = null;
    Object.defineProperty(this, "onfocus", {
        configurable: true,
        get: function() {
            return this.focus;
        },
        set: function(func) {
            this.addEventListener("focus", func);
            this.focus = func
        }
    });
    this.canplay = null;
    Object.defineProperty(this, "oncanplay", {
        configurable: true,
        get: function() {
            return this.canplay;
        },
        set: function(func) {
            this.addEventListener("canplay", func);
            this.canplay = func
        }
    });
    this.canplaythrough = null;
    Object.defineProperty(this, "oncanplaythrough", {
        configurable: true,
        get: function() {
            return this.canplaythrough;
        },
        set: function(func) {
            this.addEventListener("canplaythrough", func);
            this.canplaythrough = func
        }
    });
    this.change = null;
    Object.defineProperty(this, "onchange", {
        configurable: true,
        get: function() {
            return this.change;
        },
        set: function(func) {
            this.addEventListener("change", func);
            this.change = func
        }
    });
    this.click = null;
    Object.defineProperty(this, "onclick", {
        configurable: true,
        get: function() {
            return this.click;
        },
        set: function(func) {
            this.addEventListener("click", func);
            this.click = func;
        }
    });
    this.close = null;
    Object.defineProperty(this, "onclose", {
        configurable: true,
        get: function() {
            return this.close;
        },
        set: function(func) {
            this.addEventListener("close", func);
            this.close = func
        }
    });
    this.contextmenu = null;
    Object.defineProperty(this, "oncontextmenu", {
        configurable: true,
        get: function() {
            return this.contextmenu;
        },
        set: function(func) {
            this.addEventListener("contextmenu", func);
            this.contextmenu = func
        }
    });
    this.cuechange = null;
    Object.defineProperty(this, "oncuechange", {
        configurable: true,
        get: function() {
            return this.cuechange;
        },
        set: function(func) {
            this.addEventListener("cuechange", func);
            this.cuechange = func
        }
    });
    this.dblclick = null;
    Object.defineProperty(this, "ondblclick", {
        configurable: true,
        get: function() {
            return this.dblclick;
        },
        set: function(func) {
            this.addEventListener("dblclick", func);
            this.dblclick = func
        }
    });
    this.drag = null;
    Object.defineProperty(this, "ondrag", {
        configurable: true,
        get: function() {
            return this.drag;
        },
        set: function(func) {
            this.addEventListener("drag", func);
            this.drag = func
        }
    });
    this.dragend = null;
    Object.defineProperty(this, "ondragend", {
        configurable: true,
        get: function() {
            return this.dragend;
        },
        set: function(func) {
            this.addEventListener("dragend", func);
            this.dragend = func
        }
    });
    this.dragenter = null;
    Object.defineProperty(this, "ondragenter", {
        configurable: true,
        get: function() {
            return this.dragenter;
        },
        set: function(func) {
            this.addEventListener("dragenter", func);
            this.dragenter = func
        }
    });
    this.dragexit = null;
    Object.defineProperty(this, "ondragexit", {
        configurable: true,
        get: function() {
            return this.dragexit;
        },
        set: function(func) {
            this.addEventListener("dragexit", func);
            this.dragexit = func
        }
    });
    this.dragleave = null;
    Object.defineProperty(this, "ondragleave", {
        configurable: true,
        get: function() {
            return this.dragleave;
        },
        set: function(func) {
            this.addEventListener("dragleave", func);
            this.dragleave = func
        }
    });
    this.dragover = null;
    Object.defineProperty(this, "ondragover", {
        configurable: true,
        get: function() {
            return this.dragover;
        },
        set: function(func) {
            this.addEventListener("dragover", func);
            this.dragover = func
        }
    });
    this.dragstart = null;
    Object.defineProperty(this, "ondragstart", {
        configurable: true,
        get: function() {
            return this.dragstart;
        },
        set: function(func) {
            this.addEventListener("dragstart", func);
            this.dragstart = func
        }
    });
    this.drop = null;
    Object.defineProperty(this, "ondrop", {
        configurable: true,
        get: function() {
            return this.drop;
        },
        set: function(func) {
            this.addEventListener("drop", func);
            this.drop = func
        }
    });
    this.durationchange = null;
    Object.defineProperty(this, "ondurationchange", {
        configurable: true,
        get: function() {
            return this.durationchange;
        },
        set: function(func) {
            this.addEventListener("durationchange", func);
            this.durationchange = func
        }
    });
    this.emptied = null;
    Object.defineProperty(this, "onemptied", {
        configurable: true,
        get: function() {
            return this.emptied;
        },
        set: function(func) {
            this.addEventListener("emptied", func);
            this.emptied = func
        }
    });
    this.ended = null;
    Object.defineProperty(this, "onended", {
        configurable: true,
        get: function() {
            return this.ended;
        },
        set: function(func) {
            this.addEventListener("ended", func);
            this.ended = func
        }
    });
    this.gotpointercapture = null;
    Object.defineProperty(this, "ongotpointercapture", {
        configurable: true,
        get: function() {
            return this.gotpointercapture;
        },
        set: function(func) {
            this.addEventListener("gotpointercapture", func);
            this.gotpointercapture = func
        }
    });
    this.input = null;
    Object.defineProperty(this, "oninput", {
        configurable: true,
        get: function() {
            return this.input;
        },
        set: function(func) {
            this.addEventListener("input", func);
            this.input = func
        }
    });
    this.invalid = null;
    Object.defineProperty(this, "oninvalid", {
        configurable: true,
        get: function() {
            return this.invalid;
        },
        set: function(func) {
            this.addEventListener("invalid", func);
            this.invalid = func
        }
    });
    this.keydown = null;
    Object.defineProperty(this, "onkeydown", {
        configurable: true,
        get: function() {
            return this.keydown;
        },
        set: function(func) {
            this.addEventListener("keydown", func);
            this.keydown = func
        }
    });
    this.keypress = null;
    Object.defineProperty(this, "onkeypress", {
        configurable: true,
        get: function() {
            return this.keypress;
        },
        set: function(func) {
            this.addEventListener("keypress", func);
            this.keypress = func
        }
    });
    this.keyup = null;
    Object.defineProperty(this, "onkeyup", {
        configurable: true,
        get: function() {
            return this.keyup;
        },
        set: function(func) {
            this.addEventListener("keyup", func);
            this.keyup = func
        }
    });
    this.load = null;
    Object.defineProperty(this, "onload", {
        configurable: true,
        get: function() {
            return this.load;
        },
        set: function(func) {
            this.addEventListener("load", func);
            this.load = func
        }
    });
    this.loadeddata = null;
    Object.defineProperty(this, "onloadeddata", {
        configurable: true,
        get: function() {
            return this.loadeddata;
        },
        set: function(func) {
            this.addEventListener("loadeddata", func);
            this.loadeddata = func
        }
    });
    this.loadedmetadata = null;
    Object.defineProperty(this, "onloadedmetadata", {
        configurable: true,
        get: function() {
            return this.loadedmetadata;
        },
        set: function(func) {
            this.addEventListener("loadedmetadata", func);
            this.loadedmetadata = func
        }
    });
    this.loadend = null;
    Object.defineProperty(this, "onloadend", {
        configurable: true,
        get: function() {
            return this.loadend;
        },
        set: function(func) {
            this.addEventListener("loadend", func);
            this.loadend = func
        }
    });
    this.loadstart = null;
    Object.defineProperty(this, "onloadstart", {
        configurable: true,
        get: function() {
            return this.loadstart;
        },
        set: function(func) {
            this.addEventListener("loadstart", func);
            this.loadstart = func
        }
    });
    this.lostpointercapture = null;
    Object.defineProperty(this, "onlostpointercapture", {
        configurable: true,
        get: function() {
            return this.lostpointercapture;
        },
        set: function(func) {
            this.addEventListener("lostpointercapture", func);
            this.lostpointercapture = func
        }
    });
    this.mousedown = null;
    Object.defineProperty(this, "onmousedown", {
        configurable: true,
        get: function() {
            return this.mousedown;
        },
        set: function(func) {
            this.addEventListener("mousedown", func);
            this.mousedown = func
        }
    });
    this.mouseenter = null;
    Object.defineProperty(this, "onmouseenter", {
        configurable: true,
        get: function() {
            return this.mouseenter;
        },
        set: function(func) {
            this.addEventListener("mouseenter", func);
            this.mouseenter = func
        }
    });
    this.mouseleave = null;
    Object.defineProperty(this, "onmouseleave", {
        configurable: true,
        get: function() {
            return this.mouseleave;
        },
        set: function(func) {
            this.addEventListener("mouseleave", func);
            this.mouseleave = func
        }
    });
    this.mousemove = null;
    Object.defineProperty(this, "onmousemove", {
        configurable: true,
        get: function() {
            return this.mousemove;
        },
        set: function(func) {
            this.addEventListener("mousemove", func);
            this.mousemove = func
        }
    });
    this.mouseout = null;
    Object.defineProperty(this, "onmouseout", {
        configurable: true,
        get: function() {
            return this.mouseout;
        },
        set: function(func) {
            this.addEventListener("mouseout", func);
            this.mouseout = func
        }
    });
    this.mouseover = null;
    Object.defineProperty(this, "onmouseover", {
        configurable: true,
        get: function() {
            return this.mouseover;
        },
        set: function(func) {
            this.addEventListener("mouseover", func);
            this.mouseover = func
        }
    });
    this.mouseup = null;
    Object.defineProperty(this, "onmouseup", {
        configurable: true,
        get: function() {
            return this.mouseup;
        },
        set: function(func) {
            this.addEventListener("mouseup", func);
            this.mouseup = func
        }
    });
    this.mousewheel = null;
    Object.defineProperty(this, "onmousewheel", {
        configurable: true,
        get: function() {
            return this.mousewheel;
        },
        set: function(func) {
            this.addEventListener("mousewheel", func);
            this.mousewheel = func
        }
    });
    this.wheel = null;
    Object.defineProperty(this, "onwheel", {
        configurable: true,
        get: function() {
            return this.wheel;
        },
        set: function(func) {
            this.addEventListener("wheel", func);
            this.wheel = func
        }
    });
    this.pause = null;
    Object.defineProperty(this, "onpause", {
        configurable: true,
        get: function() {
            return this.pause;
        },
        set: function(func) {
            this.addEventListener("pause", func);
            this.pause = func
        }
    });
    this.play = null;
    Object.defineProperty(this, "onplay", {
        configurable: true,
        get: function() {
            return this.play;
        },
        set: function(func) {
            this.addEventListener("play", func);
            this.play = func
        }
    });
    this.playing = null;
    Object.defineProperty(this, "onplaying", {
        configurable: true,
        get: function() {
            return this.playing;
        },
        set: function(func) {
            this.addEventListener("playing", func);
            this.playing = func
        }
    });
    this.pointerdown = null;
    Object.defineProperty(this, "onpointerdown", {
        configurable: true,
        get: function() {
            return this.pointerdown;
        },
        set: function(func) {
            this.addEventListener("pointerdown", func);
            this.pointerdown = func
        }
    });
    this.pointermov = null;
    Object.defineProperty(this, "onpointermove", {
        configurable: true,
        get: function() {
            return this.pointermov;
        },
        set: function(func) {
            this.addEventListener("pointermov", func);
            this.pointermov = func
        }
    });
    this.pointerup = null;
    Object.defineProperty(this, "onpointerup", {
        configurable: true,
        get: function() {
            return this.pointerup;
        },
        set: function(func) {
            this.addEventListener("pointerup", func);
            this.pointerup = func
        }
    });
    this.pointercancel = null;
    Object.defineProperty(this, "onpointercancel", {
        configurable: true,
        get: function() {
            return this.pointercancel;
        },
        set: function(func) {
            this.addEventListener("pointercancel", func);
            this.pointercancel = func
        }
    });
    this.pointerover = null;
    Object.defineProperty(this, "onpointerover", {
        configurable: true,
        get: function() {
            return this.pointerover;
        },
        set: function(func) {
            this.addEventListener("pointerover", func);
            this.pointerover = func
        }
    });
    this.pointerout = null;
    Object.defineProperty(this, "onpointerout", {
        configurable: true,
        get: function() {
            return this.pointerout;
        },
        set: function(func) {
            this.addEventListener("pointerout", func);
            this.pointerout = func
        }
    });
    this.pointerenter = null;
    Object.defineProperty(this, "onpointerenter", {
        configurable: true,
        get: function() {
            return this.pointerenter;
        },
        set: function(func) {
            this.addEventListener("pointerenter", func);
            this.pointerenter = func
        }
    });
    this.pointerleave = null;
    Object.defineProperty(this, "onpointerleave", {
        configurable: true,
        get: function() {
            return this.pointerleave;
        },
        set: function(func) {
            this.addEventListener("pointerleave", func);
            this.pointerleave = func
        }
    });
    this.pointerlockchange = null;
    Object.defineProperty(this, "onpointerlockchange", {
        configurable: true,
        get: function() {
            return this.pointerlockchange;
        },
        set: function(func) {
            this.addEventListener("pointerlockchange", func);
            this.pointerlockchange = func
        }
    });
    this.pointerlockerror = null;
    Object.defineProperty(this, "onpointerlockerror", {
        configurable: true,
        get: function() {
            return this.pointerlockerror;
        },
        set: function(func) {
            this.addEventListener("pointerlockerror", func);
            this.pointerlockerror = func
        }
    });
    this.progress = null;
    Object.defineProperty(this, "onprogress", {
        configurable: true,
        get: function() {
            return this.progress;
        },
        set: function(func) {
            this.addEventListener("progress", func);
            this.progress = func
        }
    });
    this.ratechange = null;
    Object.defineProperty(this, "onratechange", {
        configurable: true,
        get: function() {
            return this.ratechange;
        },
        set: function(func) {
            this.addEventListener("ratechange", func);
            this.ratechange = func
        }
    });
    this.reset = null;
    Object.defineProperty(this, "onreset", {
        configurable: true,
        get: function() {
            return this.reset;
        },
        set: function(func) {
            this.addEventListener("reset", func);
            this.reset = func
        }
    });
    this.resize = null;
    Object.defineProperty(this, "onresize", {
        configurable: true,
        get: function() {
            return this.resize;
        },
        set: function(func) {
            this.addEventListener("resize", func);
            this.resize = func
        }
    });
    this.scroll = null;
    Object.defineProperty(this, "onscroll", {
        configurable: true,
        get: function() {
            return this.scroll;
        },
        set: function(func) {
            this.addEventListener("scroll", func);
            this.scroll = func
        }
    });
    this.seeked = null;
    Object.defineProperty(this, "onseeked", {
        configurable: true,
        get: function() {
            return this.seeked;
        },
        set: function(func) {
            this.addEventListener("seeked", func);
            this.seeked = func
        }
    });
    this.seeking = null;
    Object.defineProperty(this, "onseeking", {
        configurable: true,
        get: function() {
            return this.seeking;
        },
        set: function(func) {
            this.addEventListener("seeking", func);
            this.seeking = func
        }
    });
    this.select = null;
    Object.defineProperty(this, "onselect", {
        configurable: true,
        get: function() {
            return this.select;
        },
        set: function(func) {
            this.addEventListener("select", func);
            this.select = func
        }
    });
    this.selectstart = null;
    Object.defineProperty(this, "onselectstart", {
        configurable: true,
        get: function() {
            return this.selectstart;
        },
        set: function(func) {
            this.addEventListener("selectstart", func);
            this.selectstart = func
        }
    });
    this.selectionchange = null;
    Object.defineProperty(this, "onselectionchange", {
        configurable: true,
        get: function() {
            return this.selectionchange;
        },
        set: function(func) {
            this.addEventListener("selectionchange", func);
            this.selectionchange = func
        }
    });
    this.show = null;
    Object.defineProperty(this, "onshow", {
        configurable: true,
        get: function() {
            return this.show;
        },
        set: function(func) {
            this.addEventListener("show", func);
            this.show = func
        }
    });
    this.sort = null;
    Object.defineProperty(this, "onsort", {
        configurable: true,
        get: function() {
            return this.sort;
        },
        set: function(func) {
            this.addEventListener("sort", func);
            this.sort = func
        }
    });
    this.stalled = null;
    Object.defineProperty(this, "onstalled", {
        configurable: true,
        get: function() {
            return this.stalled;
        },
        set: function(func) {
            this.addEventListener("stalled", func);
            this.stalled = func
        }
    });
    this.submit = null;
    Object.defineProperty(this, "onsubmit", {
        configurable: true,
        get: function() {
            return this.submit;
        },
        set: function(func) {
            this.addEventListener("submit", func);
            this.submit = func
        }
    });
    this.suspend = null;
    Object.defineProperty(this, "onsuspend", {
        configurable: true,
        get: function() {
            return this.suspend;
        },
        set: function(func) {
            this.addEventListener("suspend", func);
            this.suspend = func
        }
    });
    this.timeupdate = null;
    Object.defineProperty(this, "ontimeupdate", {
        configurable: true,
        get: function() {
            return this.timeupdate;
        },
        set: function(func) {
            this.addEventListener("timeupdate", func);
            this.timeupdate = func
        }
    });
    this.volumechange = null;
    Object.defineProperty(this, "onvolumechange", {
        configurable: true,
        get: function() {
            return this.volumechange;
        },
        set: function(func) {
            this.addEventListener("volumechange", func);
            this.volumechange = func
        }
    });
    this.touchcancel = null;
    Object.defineProperty(this, "ontouchcancel", {
        configurable: true,
        get: function() {
            return this.touchcancel;
        },
        set: function(func) {
            this.addEventListener("touchcancel", func);
            this.touchcancel = func
        }
    });
    this.touchend = null;
    Object.defineProperty(this, "ontouchend", {
        configurable: true,
        get: function() {
            return this.touchend;
        },
        set: function(func) {
            this.addEventListener("touchend", func);
            this.touchend = func
        }
    });
    this.touchmove = null;
    Object.defineProperty(this, "ontouchmove", {
        configurable: true,
        get: function() {
            return this.touchmove;
        },
        set: function(func) {
            this.addEventListener("touchmove", func);
            this.touchmove = func
        }
    });
    this.ontouchstart = null;
    Object.defineProperty(this, "ontouchstart", {
        configurable: true,
        get: function() {
            return this.touchstart;
        },
        set: function(func) {
            this.addEventListener("touchstart", func);
            this.touchstart = func
        }
    });
    this.transitioncancel = null;
    Object.defineProperty(this, "ontransitioncancel", {
        configurable: true,
        get: function() {
            return this.transitioncancel;
        },
        set: function(func) {
            this.addEventListener("transitioncancel", func);
            this.transitioncancel = func
        }
    });
    this.transitionend = null;
    Object.defineProperty(this, "ontransitionend", {
        configurable: true,
        get: function() {
            return this.transitionend;
        },
        set: function(func) {
            this.addEventListener("transitionend", func);
            this.transitionend = func
        }
    });
    this.waiting = null;
    Object.defineProperty(this, "onwaiting", {
        configurable: true,
        get: function() {
            return this.waiting;
        },
        set: function(func) {
            this.addEventListener("waiting", func);
            this.waiting = func
        }
    });
}
GlobalEventHandlers.prototype = EventTarget.prototype;
