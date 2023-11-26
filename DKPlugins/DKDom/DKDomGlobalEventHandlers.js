//https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers
//https://javascript.info/mixins

/*
var GlobalEventHandlers = {
	
	// Methods
	onmousemove(func){
		console.log("onmousemove");
		//get: function onmousemove(){ return this.mousemove; },
		this.addEventListener("mousemove", func); this.mousemove = func;
	}
};
*/

// https://html.spec.whatwg.org/multipage/webappapis.html#idl-definitions
var GlobalEventHandlers = function GlobalEventHandlers(pointer) {
    this.pointer = pointer;

	//IDL: attribute EventHandler onabort;
    this.abort_func = null;
    Object.defineProperty(this, "onabort", {
        get: function onabort() {
            return this.abort_func;
        },
        set: function onabort(func) {
            func && this.addEventListener("abort", func)
			!func && this.removeEventListener("abort", this.abort_func)
            this.abort_func = func
        }
    });
    this.animationcancel_func = null;
    Object.defineProperty(this, "onanimationcancel", {
        get: function onanimationcancel() {
            return this.animationcancel_func;
        },
        set: function onanimationcancel(func) {
            func && this.addEventListener("animationcancel", func)
			!func && this.removeEventListener("animationcancel", this.animationcancel_func)
            this.animationcancel_func = func
        }
    });
    this.animationend_func = null;
    Object.defineProperty(this, "onanimationend", {
        get: function onanimationend() {
            return this.animationend_func;
        },
        set: function onanimationend(func) {
            func && this.addEventListener("animationend", func)
			!func && this.removeEventListener("animationend", this.animationend_func)
            this.animationend_func = func
        }
    });
    this.animationiteration_func = null;
    Object.defineProperty(this, "onanimationiteration", {
        get: function onanimationiteration() {
            return this.animationiteration_func;
        },
        set: function onanimationiteration(func) {
            func && this.addEventListener("animationiteration", func)
			!func && this.removeEventListener("animationiteration", this.animationiteration_func)
            this.animationiteration_func = func
        }
    });
    this.animationstart_func = null;
    Object.defineProperty(this, "onanimationstart", {
        get: function onanimationstart() {
            return this.animationstart_func;
        },
        set: function onanimationstart(func) {
            func && this.addEventListener("animationstart", func)
			!func && this.removeEventListener("animationstart", this.animationstart_func)
            this.animationstart_func = func
        }
    });
    this.auxclick_func = null;
    Object.defineProperty(this, "onauxclick", {
        get: function onauxclick() {
            return this.auxclick_func;
        },
        set: function onauxclick(func) {
            func && this.addEventListener("auxclick", func)
			!func && this.removeEventListener("auxclick", this.auxclick_func)
            this.auxclick_func = func
        }
    });
    this.blur_func = null;
    Object.defineProperty(this, "onblur", {
        get: function onblur() {
            return this.blur_func;
        },
        set: function onblur(func) {
            func && this.addEventListener("blur", func)
			!func && this.removeEventListener("blur", this.blur_func)
            this.blur_func = func
        }
    });
    this.error_func = null;
    Object.defineProperty(this, "onerror", {
        get: function onerror() {
            return this.error_func;
        },
        set: function onerror(func) {
            func && this.addEventListener("error", func)
			!func && this.removeEventListener("error", this.error_func)
            this.error_func = func
        }
    });
    this.focus_func = null;
    Object.defineProperty(this, "onfocus", {
        get: function onfocus() {
            return this.focus_func;
        },
        set: function onfocus(func) {
            func && this.addEventListener("focus", func)
			!func && this.removeEventListener("focus", this.focus_func)
            this.focus_func = func
        }
    });
    this.canplay_func = null;
    Object.defineProperty(this, "oncanplay", {
        get: function oncanplay() {
            return this.canplay_func;
        },
        set: function oncanplay(func) {
            func && this.addEventListener("canplay", func)
			!func && this.removeEventListener("canplay", this.canplay_func)
            this.canplay_func = func
        }
    });
    this.canplaythrough_func = null;
    Object.defineProperty(this, "oncanplaythrough", {
        get: function oncanplaythrough() {
            return this.canplaythrough_func;
        },
        set: function oncanplaythrough(func) {
            func && this.addEventListener("canplaythrough", func)
			!func && this.removeEventListener("canplaythrough", this.canplaythrough_func)
            this.canplaythrough_func = func
        }
    });
    this.change_func = null;
    Object.defineProperty(this, "onchange", {
        get: function onchange() {
            return this.change_func;
        },
        set: function onchange(func) {
            func && this.addEventListener("change", func)
			!func && this.removeEventListener("change", this.change_func)
            this.change_func = func
        }
    });
    this.click_func = null;
    Object.defineProperty(this, "onclick", {
        get: function onclick() {
            return this.click_func;
        },
        set: function onclick(func) {
            func && this.addEventListener("click", func)
			!func && this.removeEventListener("click", this.click_func)
            this.click_func = func
        }
    });
    this.close_func = null;
    Object.defineProperty(this, "onclose", {
        get: function onclose() {
            return this.close_func;
        },
        set: function onclose(func) {
            func && this.addEventListener("close", func)
			!func && this.removeEventListener("close", this.close_func)
            this.close_func = func
        }
    });
    this.contextmenu_func = null;
    Object.defineProperty(this, "oncontextmenu", {
        get: function oncontextmenu() {
            return this.contextmenu_func;
        },
        set: function oncontextmenu(func) {
            func && this.addEventListener("contextmenu", func)
			!func && this.removeEventListener("contextmenu", this.contextmenu_func)
            this.contextmenu_func = func
        }
    });
    this.cuechange_func = null;
    Object.defineProperty(this, "oncuechange", {
        get: function oncuechange() {
            return this.cuechange_func;
        },
        set: function oncuechange(func) {
            func && this.addEventListener("cuechange", func)
			!func && this.removeEventListener("cuechange", this.cuechange_func)
            this.cuechange_func = func
        }
    });
    this.dblclick_func = null;
    Object.defineProperty(this, "ondblclick", {
        get: function ondblclick() {
            return this.dblclick_func;
        },
        set: function ondblclick(func) {
            func && this.addEventListener("dblclick", func)
			!func && this.removeEventListener("dblclick", this.dblclick_func)
            this.dblclick_func = func
        }
    });
    this.drag_func = null;
    Object.defineProperty(this, "ondrag", {
        get: function ondrag() {
            return this.drag_func;
        },
        set: function ondrag(func) {
            func && this.addEventListener("drag", func)
			!func && this.removeEventListener("drag", this.drag_func)
            this.drag_func = func
        }
    });
    this.dragend_func = null;
    Object.defineProperty(this, "ondragend", {
        get: function ondragend() {
            return this.dragend_func;
        },
        set: function ondragend(func) {
            func && this.addEventListener("dragend", func)
			!func && this.removeEventListener("dragend", this.dragend_func)
            this.dragend_func = func
        }
    });
    this.dragenter_func = null;
    Object.defineProperty(this, "ondragenter", {
        get: function ondragenter() {
            return this.dragenter_func;
        },
        set: function ondragenter(func) {
            func && this.addEventListener("dragenter", func)
			!func && this.removeEventListener("dragenter", this.dragenter_func)
            this.dragenter_func = func
        }
    });
    this.dragexit_func = null;
    Object.defineProperty(this, "ondragexit", {
        get: function ondragexit() {
            return this.dragexit_func;
        },
        set: function ondragexit(func) {
            func && this.addEventListener("dragexit", func)
			!func && this.removeEventListener("dragexit", this.dragexit_func)
            this.dragexit_func = func
        }
    });
    this.dragleave_func = null;
    Object.defineProperty(this, "ondragleave", {
        get: function ondragleave() {
            return this.dragleave_func;
        },
        set: function ondragleave(func) {
            func && this.addEventListener("dragleave", func)
			!func && this.removeEventListener("dragleave", this.dragleave_func)
            this.dragleave_func = func
        }
    });
    this.dragover_func = null;
    Object.defineProperty(this, "ondragover", {
        get: function ondragover() {
            return this.dragover_func;
        },
        set: function ondragover(func) {
            func && this.addEventListener("dragover", func)
			!func && this.removeEventListener("dragover", this.dragover_func)
            this.dragover_func = func
        }
    });
    this.dragstart_func = null;
    Object.defineProperty(this, "ondragstart", {
        get: function ondragstart() {
            return this.dragstart_func;
        },
        set: function ondragstart(func) {
            func && this.addEventListener("dragstart", func)
			!func && this.removeEventListener("dragstart", this.dragstart_func)
            this.dragstart_func = func
        }
    });
    this.drop_func = null;
    Object.defineProperty(this, "ondrop", {
        get: function ondrop() {
            return this.drop_func;
        },
        set: function ondrop(func) {
            func && this.addEventListener("drop", func)
			!func && this.removeEventListener("drop", this.drop_func)
            this.drop_func = func
        }
    });
    this.durationchange_func = null;
    Object.defineProperty(this, "ondurationchange", {
        get: function ondurationchange() {
            return this.durationchange_func;
        },
        set: function ondurationchange(func) {
            func && this.addEventListener("durationchange", func)
			!func && this.removeEventListener("durationchange", this.durationchange_func)
            this.durationchange_func = func
        }
    });
    this.emptied_func = null;
    Object.defineProperty(this, "onemptied", {
        get: function onemptied() {
            return this.emptied_func;
        },
        set: function onemptied(func) {
            func && this.addEventListener("emptied", func)
			!func && this.removeEventListener("emptied", this.emptied_func)
            this.emptied_func = func
        }
    });
    this.ended_func = null;
    Object.defineProperty(this, "onended", {
        get: function onended() {
            return this.ended_func;
        },
        set: function onended(func) {
            func && this.addEventListener("ended", func)
			!func && this.removeEventListener("ended", this.ended_func)
            this.ended_func = func
        }
    });
    this.gotpointercapture_func = null;
    Object.defineProperty(this, "ongotpointercapture", {
        get: function ongotpointercapture() {
            return this.gotpointercapture_func;
        },
        set: function ongotpointercapture(func) {
            func && this.addEventListener("gotpointercapture", func)
			!func && this.removeEventListener("gotpointercapture", this.gotpointercapture_func)
            this.gotpointercapture_func = func
        }
    });
    this.input_func = null;
    Object.defineProperty(this, "oninput", {
        get: function oninput() {
            return this.input_func;
        },
        set: function oninput(func) {
            func && this.addEventListener("input", func)
			!func && this.removeEventListener("input", this.input_func)
            this.input_func = func
        }
    });
    this.invalid_func = null;
    Object.defineProperty(this, "oninvalid", {
        get: function oninvalid() {
            return this.invalid_func;
        },
        set: function oninvalid(func) {
            func && this.addEventListener("invalid", func)
			!func && this.removeEventListener("invalid", this.invalid_func)
            this.invalid_func = func
        }
    });
    this.keydown_func = null;
    Object.defineProperty(this, "onkeydown", {
        get: function onkeydown() {
            return this.keydown_func;
        },
        set: function onkeydown(func) {
            func && this.addEventListener("keydown", func)
			!func && this.removeEventListener("keydown", this.keydown_func)
            this.keydown_func = func
        }
    });
    this.keypress_func = null;
    Object.defineProperty(this, "onkeypress", {
        get: function onkeypress() {
            return this.keypress_func;
        },
        set: function onkeypress(func) {
            func && this.addEventListener("keypress", func)
			!func && this.removeEventListener("keypress", this.keypress_func)
            this.keypress_func = func
        }
    });
    this.keyup_func = null;
    Object.defineProperty(this, "onkeyup", {
        get: function onkeyup() {
            return this.keyup_func;
        },
        set: function onkeyup(func) {
            func && this.addEventListener("keyup", func)
			!func && this.removeEventListener("keyup", this.keyup_func)
            this.keyup_func = func
        }
    });
    this.load_func = null;
    Object.defineProperty(this, "onload", {
        get: function onload() {
            return this.load_func;
        },
        set: function onload(func) {
            func && this.addEventListener("load", func)
			!func && this.removeEventListener("load", this.load_func)
            this.load_func = func
        }
    });
    this.loadeddata_func = null;
    Object.defineProperty(this, "onloadeddata", {
        get: function onloadeddata() {
            return this.loadeddata_func;
        },
        set: function onloadeddata(func) {
            func && this.addEventListener("loadeddata", func)
			!func && this.removeEventListener("loadeddata", this.loadeddata_func)
            this.loadeddata_func = func
        }
    });
    this.loadedmetadata_func = null;
    Object.defineProperty(this, "onloadedmetadata", {
        get: function onloadedmetadata() {
            return this.loadedmetadata_func;
        },
        set: function onloadedmetadata(func) {
            func && this.addEventListener("loadedmetadata", func)
			!func && this.removeEventListener("loadedmetadata", this.loadedmetadata_func)
            this.loadedmetadata_func = func
        }
    });
    this.loadend_func = null;
    Object.defineProperty(this, "onloadend", {
        get: function onloadend() {
            return this.loadend_func;
        },
        set: function onloadend(func) {
            func && this.addEventListener("loadend", func)
			!func && this.removeEventListener("loadend", this.loadend_func)
            this.loadend_func = func
        }
    });
    this.loadstart_func = null;
    Object.defineProperty(this, "onloadstart", {
        get: function onloadstart() {
            return this.loadstart_func;
        },
        set: function onloadstart(func) {
            func && this.addEventListener("loadstart", func)
			!func && this.removeEventListener("loadstart", this.loadstart_func)
            this.loadstart_func = func
        }
    });
    this.lostpointercapture_func = null;
    Object.defineProperty(this, "onlostpointercapture", {
        get: function onlostpointercapture() {
            return this.lostpointercapture_func;
        },
        set: function onlostpointercapture(func) {
            func && this.addEventListener("lostpointercapture", func)
			!func && this.removeEventListener("lostpointercapture", this.lostpointercapture_func)
            this.lostpointercapture_func = func
        }
    });
    this.mousedown_func = null;
    Object.defineProperty(this, "onmousedown", {
        get: function onmousedown() {
            return this.mousedown_func;
        },
        set: function onmousedown(func) {
            func && this.addEventListener("mousedown", func)
			!func && this.removeEventListener("mousedown", this.mousedown_func)
            this.mousedown_func = func
        }
    });
    this.mouseenter_func = null;
    Object.defineProperty(this, "onmouseenter", {
        get: function onmouseenter() {
            return this.mouseenter_func;
        },
        set: function onmouseenter(func) {
            func && this.addEventListener("mouseenter", func)
			!func && this.removeEventListener("mouseenter", this.mouseenter_func)
            this.mouseenter_func = func
        }
    });
    this.mouseleave_func = null
    Object.defineProperty(this, "onmouseleave", {
        get: function onmouseleave() {
            return this.mouseleave_func
        },
        set: function onmouseleave(func) {
            func && this.addEventListener("mouseleave", func)
			!func && this.removeEventListener("mouseleave", this.mouseleave_func)	
            this.mouseleave_func = func
        }
    })
    this.mousemove_func = null
    Object.defineProperty(this, "onmousemove", {
        get: function onmousemove() {
            return this.mousemove_func
        },
        set: function onmousemove(func) {
			func && this.addEventListener("mousemove", func)
			!func && this.removeEventListener("mousemove", this.mousemove_func)				
            this.mousemove_func = func
        }
    })
    this.mouseout_func = null
    Object.defineProperty(this, "onmouseout", {
        get: function onmouseout() {
            return this.mouseout_func
        },
        set: function onmouseout(func) {
            func && this.addEventListener("mouseout", func)
			!func && this.removeEventListener("mouseout", this.mouseout_func)				
            this.mouseout_func = func
        }
    })
    this.mouseover_func = null;
    Object.defineProperty(this, "onmouseover", {
        get: function onmouseover() {
            return this.mouseover_func;
        },
        set: function onmouseover(func) {
            func && this.addEventListener("mouseover", func)
			!func && this.removeEventListener("mouseover", this.mouseover_func)
            this.mouseover_func = func
        }
    });
    this.mouseup_func = null;
    Object.defineProperty(this, "onmouseup", {
        get: function onmouseup() {
            return this.mouseup_func;
        },
        set: function onmouseup(func) {
            func && this.addEventListener("mouseup", func)
			!func && this.removeEventListener("mouseup", this.mouseup_func)
            this.mouseup_func = func
        }
    });
    this.mousewheel_func = null;
    Object.defineProperty(this, "onmousewheel", {
        get: function onmousewheel() {
            return this.mousewheel_func;
        },
        set: function onmousewheel(func) {
            func && this.addEventListener("mousewheel", func)
			!func && this.removeEventListener("mousewheel", this.mousewheel_func)
            this.mousewheel_func = func
        }
    });
    this.wheel_func = null;
    Object.defineProperty(this, "onwheel", {
        get: function onwheel() {
            return this.wheel_func;
        },
        set: function onwheel(func) {
            func && this.addEventListener("wheel", func)
			!func && this.removeEventListener("wheel", this.wheel_func)
            this.wheel_func = func
        }
    });
    this.pause_func = null;
    Object.defineProperty(this, "onpause", {
        get: function onpause() {
            return this.pause_func;
        },
        set: function onpause(func) {
            func && this.addEventListener("pause", func)
			!func && this.removeEventListener("pause", this.pause_func)
            this.pause_func = func
        }
    });
    this.play_func = null;
    Object.defineProperty(this, "onplay", {
        get: function onplay() {
            return this.play_func;
        },
        set: function onplay(func) {
            func && this.addEventListener("play", func)
			!func && this.removeEventListener("play", this.play_func)
            this.play_func = func
        }
    });
    this.playing_func = null;
    Object.defineProperty(this, "onplaying", {
        get: function onplaying() {
            return this.playing_func;
        },
        set: function onplaying(func) {
            func && this.addEventListener("playing", func)
			!func && this.removeEventListener("playing", this.playing_func)
            this.playing_func = func
        }
    });
    this.pointerdown_func = null;
    Object.defineProperty(this, "onpointerdown", {
        get: function onpointerdown() {
            return this.pointerdown_func;
        },
        set: function onpointerdown(func) {
            func && this.addEventListener("pointerdown", func)
			!func && this.removeEventListener("pointerdown", this.pointerdown_func)
            this.pointerdown_func = func
        }
    });
    this.pointermove_func = null;
    Object.defineProperty(this, "onpointermove", {
        get: function onpointermove() {
            return this.pointermove_func;
        },
        set: function onpointermove(func) {
            func && this.addEventListener("pointermove", func)
			!func && this.removeEventListener("pointermove", this.pointermove_func)
            this.pointermove_func = func
        }
    });
    this.pointerup_func = null;
    Object.defineProperty(this, "onpointerup", {
        get: function onpointerup() {
            return this.pointerup_func;
        },
        set: function onpointerup(func) {
            func && this.addEventListener("pointerup", func)
			!func && this.removeEventListener("pointerup", this.pointerup_func)
            this.pointerup_func = func
        }
    });
    this.pointercancel_func = null;
    Object.defineProperty(this, "onpointercancel", {
        get: function onpointercancel() {
            return this.pointercancel_func;
        },
        set: function onpointercancel(func) {
            func && this.addEventListener("pointercancel", func)
			!func && this.removeEventListener("pointercancel", this.pointercancel_func)
            this.pointercancel_func = func
        }
    });
    this.pointerover_func = null;
    Object.defineProperty(this, "onpointerover", {
        get: function onpointerover() {
            return this.pointerover_func;
        },
        set: function onpointerover(func) {
            func && this.addEventListener("pointerover", func)
			!func && this.removeEventListener("pointerover", this.pointerover_func)
            this.pointerover_func = func
        }
    });
    this.pointerout_func = null;
    Object.defineProperty(this, "onpointerout", {
        get: function onpointerout() {
            return this.pointerout_func;
        },
        set: function onpointerout(func) {
            func && this.addEventListener("pointerout", func)
			!func && this.removeEventListener("pointerout", this.pointerout_func)
            this.pointerout_func = func
        }
    });
    this.pointerenter_func = null;
    Object.defineProperty(this, "onpointerenter", {
        get: function onpointerenter() {
            return this.pointerenter_func;
        },
        set: function onpointerenter(func) {
            func && this.addEventListener("pointerenter", func)
			!func && this.removeEventListener("pointerenter", this.pointerenter_func)
            this.pointerenter_func = func
        }
    });
    this.pointerleave_func = null;
    Object.defineProperty(this, "onpointerleave", {
        get: function onpointerleave() {
            return this.pointerleave_func;
        },
        set: function onpointerleave(func) {
            func && this.addEventListener("pointerleave", func)
			!func && this.removeEventListener("pointerleave", this.pointerleave_func)
            this.pointerleave_func = func
        }
    });
    this.pointerlockchange_func = null;
    Object.defineProperty(this, "onpointerlockchange", {
        get: function onpointerlockchange() {
            return this.pointerlockchange_func;
        },
        set: function onpointerlockchange(func) {
            func && this.addEventListener("pointerlockchange", func)
			!func && this.removeEventListener("pointerlockchange", this.pointerlockchange_func)
            this.pointerlockchange_func = func
        }
    });
    this.pointerlockerror_func = null;
    Object.defineProperty(this, "onpointerlockerror", {
        get: function onpointerlockerror() {
            return this.pointerlockerror_func;
        },
        set: function onpointerlockerror(func) {
            func && this.addEventListener("pointerlockerror", func)
			!func && this.removeEventListener("pointerlockerror", this.pointerlockerror_func)
            this.pointerlockerror_func = func
        }
    });
    this.progress_func = null;
    Object.defineProperty(this, "onprogress", {
        get: function onprogress() {
            return this.progress_func;
        },
        set: function onprogress(func) {
            func && this.addEventListener("progress", func)
			!func && this.removeEventListener("progress", this.progress_func)
            this.progress_func = func
        }
    });
    this.ratechange_func = null;
    Object.defineProperty(this, "onratechange", {
        get: function onratechange() {
            return this.ratechange_func;
        },
        set: function onratechange(func) {
            func && this.addEventListener("ratechange", func)
			!func && this.removeEventListener("ratechange", this.ratechange_func)
            this.ratechange_func = func
        }
    });
    this.reset_func = null;
    Object.defineProperty(this, "onreset", {
        get: function onreset() {
            return this.reset_func;
        },
        set: function onreset(func) {
            func && this.addEventListener("reset", func)
			!func && this.removeEventListener("reset", this.reset_func)
            this.reset_func = func
        }
    });
    this.resize_func = null;
    Object.defineProperty(this, "onresize", {
        get: function onresize() {
            return this.resize_func;
        },
        set: function onresize(func) {
            func && this.addEventListener("resize", func)
			!func && this.removeEventListener("resize", this.resize_func)
            this.resize_func = func
        }
    });
    this.scroll_func = null;
    Object.defineProperty(this, "onscroll", {
        get: function onscroll() {
            return this.scroll_func;
        },
        set: function onscroll(func) {
            func && this.addEventListener("scroll", func)
			!func && this.removeEventListener("scroll", this.scroll_func)
            this.scroll_func = func
        }
    });
    this.seeked_func = null;
    Object.defineProperty(this, "onseeked", {
        get: function onseeked() {
            return this.seeked_func;
        },
        set: function onseeked(func) {
            func && this.addEventListener("seeked", func)
			!func && this.removeEventListener("seeked", this.seeked_func)
            this.seeked_func = func
        }
    });
    this.seeking_func = null;
    Object.defineProperty(this, "onseeking", {
        get: function onseeking() {
            return this.seeking_func;
        },
        set: function onseeking(func) {
            func && this.addEventListener("seeking", func)
			!func && this.removeEventListener("seeking", this.seeking_func)
            this.seeking_func = func
        }
    });
    this.select_func = null;
    Object.defineProperty(this, "onselect", {
        get: function onselect() {
            return this.select_func;
        },
        set: function onselect(func) {
            func && this.addEventListener("select", func)
			!func && this.removeEventListener("select", this.select_func)
            this.select_func = func
        }
    });
    this.selectstart_func = null;
    Object.defineProperty(this, "onselectstart", {
        get: function onselectstart() {
            return this.selectstart_func;
        },
        set: function onselectstart(func) {
            func && this.addEventListener("selectionstart", func)
			!func && this.removeEventListener("selectionstart", this.selectionstart_func)
            this.selectstart_func = func
        }
    });
    this.selectionchange_func = null;
    Object.defineProperty(this, "onselectionchange", {
        get: function onselectionchange() {
            return this.selectionchange_func;
        },
        set: function onselectionchange(func) {
            func && this.addEventListener("selectionchange", func)
			!func && this.removeEventListener("selectionchange", this.selectionchange_func)
            this.selectionchange_func = func
        }
    });
    this.show_func = null;
    Object.defineProperty(this, "onshow", {
        get: function onshow() {
            return this.show_func;
        },
        set: function onshow(func) {
            func && this.addEventListener("show", func)
			!func && this.removeEventListener("show", this.show_func)
            this.show_func = func
        }
    });
    this.sort_func = null;
    Object.defineProperty(this, "onsort", {
        get: function onsort() {
            return this.sort_func;
        },
        set: function onsort(func) {
            func && this.addEventListener("sort", func)
			!func && this.removeEventListener("sort", this.sort_func)
            this.sort_func = func
        }
    });
    this.stalled_func = null;
    Object.defineProperty(this, "onstalled", {
        get: function onstalled() {
            return this.stalled_func;
        },
        set: function onstalled(func) {
            func && this.addEventListener("stalled", func)
			!func && this.removeEventListener("stalled", this.stalled_func)
            this.stalled_func = func
        }
    });
    this.submit_func = null;
    Object.defineProperty(this, "onsubmit", {
        get: function onsubmit() {
            return this.submit_func;
        },
        set: function onsubmit(func) {
            func && this.addEventListener("submit", func)
			!func && this.removeEventListener("submit", this.submit_func)
            this.submit_func = func
        }
    });
    this.suspend_func = null;
    Object.defineProperty(this, "onsuspend", {
        get: function onsuspend() {
            return this.suspend_func;
        },
        set: function onsuspend(func) {
            func && this.addEventListener("suspend", func)
			!func && this.removeEventListener("suspend", this.suspend_func)
            this.suspend_func = func
        }
    });
    this.timeupdate_func = null;
    Object.defineProperty(this, "ontimeupdate", {
        get: function ontimeupdate() {
            return this.timeupdate_func;
        },
        set: function ontimeupdate(func) {
            func && this.addEventListener("timeupdate", func)
			!func && this.removeEventListener("timeupdate", this.timeupdate_func)
            this.timeupdate_func = func
        }
    });
    this.volumechange_func = null;
    Object.defineProperty(this, "onvolumechange", {
        get: function onvolumechange() {
            return this.volumechange_func;
        },
        set: function onvolumechange(func) {
            func && this.addEventListener("volumechange", func)
			!func && this.removeEventListener("volumechange", this.volumechange_func)
            this.volumechange_func = func
        }
    });
    this.touchcancel_func = null;
    Object.defineProperty(this, "ontouchcancel", {
        get: function ontouchcancel() {
            return this.touchcancel_func;
        },
        set: function ontouchcancel(func) {
            func && this.addEventListener("touchcancel", func)
			!func && this.removeEventListener("touchcancel", this.touchcancel_func)
            this.touchcancel_func = func
        }
    });
    this.touchend_func = null;
    Object.defineProperty(this, "ontouchend", {
        get: function ontouchend() {
            return this.touchend_func;
        },
        set: function ontouchend(func) {
            func && this.addEventListener("touchend", func)
			!func && this.removeEventListener("touchend", this.touchend_func)
            this.touchend_func = func
        }
    });
    this.touchmove_func = null;
    Object.defineProperty(this, "ontouchmove", {
        get: function ontouchmove() {
            return this.touchmove_func;
        },
        set: function ontouchmove(func) {
            func && this.addEventListener("touchmove", func)
			!func && this.removeEventListener("touchmove", this.touchmove_func)
            this.touchmove_func = func
        }
    });
    this.ontouchstart_func = null;
    Object.defineProperty(this, "ontouchstart", {
    	get: function ontouchstart(){ 
			return this.touchstart_func
		},
    	set: function ontouchstart(func){ 
			func && this.addEventListener("touchstart", func)
			!func && this.removeEventListener("touchstart", this.touchstart_func) 
			this.touchstart_func = func 
		}
    });
    this.transitioncancel_func = null;
    Object.defineProperty(this, "ontransitioncancel", {
        get: function ontransitioncancel() {
            return this.transitioncancel_func;
        },
        set: function ontransitioncancel(func) {
            func && this.addEventListener("transitioncancel", func)
			!func && this.removeEventListener("transitioncancel", this.transitioncancel_func)
            this.transitioncancel_func = func
        }
    });
    this.transitionend_func = null;
    Object.defineProperty(this, "ontransitionend", {
        get: function ontransitionend() {
            return this.transitionend_func;
        },
        set: function ontransitionend(func) {
            func && this.addEventListener("transitionend", func)
			!func && this.removeEventListener("transitionend", this.transitionend_func)
            this.transitionend_func = func
        }
    });
    this.waiting_func = null;
    Object.defineProperty(this, "onwaiting", {
        get: function onwaiting() {
            return this.waiting_func;
        },
        set: function onwaiting(func) {
            func && this.addEventListener("waiting", func)
			!func && this.removeEventListener("waiting", this.waiting_func)
            this.waiting_func = func
        }
    });

    return this;
}

// https://html.spec.whatwg.org/multipage/webappapis.html#eventhandler
GlobalEventHandlers.prototype = EventTarget.prototype;  //FIXME: this may not be correct
