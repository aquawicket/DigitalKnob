//https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers
//https://javascript.info/mixins

/*
var GlobalEventHandlers = {
	
	// Methods
	onmousemove(func){
		console.log("onmousemove");
		//get: function(){ return this.mousemove; },
		this.addEventListener("mousemove", func); this.mousemove = func;
	}
};
*/

// https://html.spec.whatwg.org/multipage/webappapis.html#idl-definitions
var GlobalEventHandlers = function(pointer) {
    this.pointer = pointer;

    this.abort_func = null;
    Object.defineProperty(this, "onabort", {
        get: function() {
            return this.abort_func;
        },
        set: function(func) {
            this.addEventListener("abort", func);
            this.abort_func = func
        }
    });
    this.animationcancel_func = null;
    Object.defineProperty(this, "onanimationcancel", {
        get: function() {
            return this.animationcancel_func;
        },
        set: function(func) {
            this.addEventListener("animationcancel", func);
            this.animationcancel_func = func
        }
    });
    this.animationend_func = null;
    Object.defineProperty(this, "onanimationend", {
        get: function() {
            return this.animationend_func;
        },
        set: function(func) {
            this.addEventListener("animationend", func);
            this.animationend_func = func
        }
    });
    this.animationiteration_func = null;
    Object.defineProperty(this, "onanimationiteration", {
        get: function() {
            return this.animationiteration_func;
        },
        set: function(func) {
            this.addEventListener("animationiteration", func);
            this.animationiteration_func = func
        }
    });
    this.animationstart_func = null;
    Object.defineProperty(this, "onanimationstart", {
        get: function() {
            return this.animationstart_func;
        },
        set: function(func) {
            this.addEventListener("animationstart", func);
            this.animationstart_func = func
        }
    });
    this.auxclick_func = null;
    Object.defineProperty(this, "onauxclick", {
        get: function() {
            return this.auxclick_func;
        },
        set: function(func) {
            this.addEventListener("auxclick", func);
            this.auxclick_func = func
        }
    });
    this.blur_func = null;
    Object.defineProperty(this, "onblur", {
        get: function() {
            return this.blur_func;
        },
        set: function(func) {
            this.addEventListener("blur", func);
            this.blur_func = func
        }
    });
    this.error_func = null;
    Object.defineProperty(this, "onerror", {
        get: function() {
            return this.error_func;
        },
        set: function(func) {
            this.addEventListener("error", func);
            this.error_func = func
        }
    });
    this.focus_func = null;
    Object.defineProperty(this, "onfocus", {
        get: function() {
            return this.focus_func;
        },
        set: function(func) {
            this.addEventListener("focus", func);
            this.focus_func = func
        }
    });
    this.canplay_func = null;
    Object.defineProperty(this, "oncanplay", {
        get: function() {
            return this.canplay_func;
        },
        set: function(func) {
            this.addEventListener("canplay", func);
            this.canplay_func = func
        }
    });
    this.canplaythrough_func = null;
    Object.defineProperty(this, "oncanplaythrough", {
        get: function() {
            return this.canplaythrough_func;
        },
        set: function(func) {
            this.addEventListener("canplaythrough", func);
            this.canplaythrough_func = func
        }
    });
    this.change_func = null;
    Object.defineProperty(this, "onchange", {
        get: function() {
            return this.change_func;
        },
        set: function(func) {
            this.addEventListener("change", func);
            this.change_func = func
        }
    });
    this.click_func = null;
    Object.defineProperty(this, "onclick", {
        get: function() {
            return this.click_func;
        },
        set: function(func) {
            this.addEventListener("click", func);
            this.click_func = func
        }
    });
    this.close_func = null;
    Object.defineProperty(this, "onclose", {
        get: function() {
            return this.close_func;
        },
        set: function(func) {
            this.addEventListener("close", func);
            this.close_func = func
        }
    });
    this.contextmenu_func = null;
    Object.defineProperty(this, "oncontextmenu", {
        get: function() {
            return this.contextmenu_func;
        },
        set: function(func) {
            this.addEventListener("contextmenu", func);
            this.contextmenu_func = func
        }
    });
    this.cuechange_func = null;
    Object.defineProperty(this, "oncuechange", {
        get: function() {
            return this.cuechange_func;
        },
        set: function(func) {
            this.addEventListener("cuechange", func);
            this.cuechange_func = func
        }
    });
    this.dblclick_func = null;
    Object.defineProperty(this, "ondblclick", {
        get: function() {
            return this.dblclick_func;
        },
        set: function(func) {
            this.addEventListener("dblclick", func);
            this.dblclick_func = func
        }
    });
    this.drag_func = null;
    Object.defineProperty(this, "ondrag", {
        get: function() {
            return this.drag_func;
        },
        set: function(func) {
            this.addEventListener("drag", func);
            this.drag_func = func
        }
    });
    this.dragend_func = null;
    Object.defineProperty(this, "ondragend", {
        get: function() {
            return this.dragend_func;
        },
        set: function(func) {
            this.addEventListener("dragend", func);
            this.dragend_func = func
        }
    });
    this.dragenter_func = null;
    Object.defineProperty(this, "ondragenter", {
        get: function() {
            return this.dragenter_func;
        },
        set: function(func) {
            this.addEventListener("dragenter", func);
            this.dragenter_func = func
        }
    });
    this.dragexit_func = null;
    Object.defineProperty(this, "ondragexit", {
        get: function() {
            return this.dragexit_func;
        },
        set: function(func) {
            this.addEventListener("dragexit", func);
            this.dragexit_func = func
        }
    });
    this.dragleave_func = null;
    Object.defineProperty(this, "ondragleave", {
        get: function() {
            return this.dragleave_func;
        },
        set: function(func) {
            this.addEventListener("dragleave", func);
            this.dragleave_func = func
        }
    });
    this.dragover_func = null;
    Object.defineProperty(this, "ondragover", {
        get: function() {
            return this.dragover_func;
        },
        set: function(func) {
            this.addEventListener("dragover", func);
            this.dragover_func = func
        }
    });
    this.dragstart_func = null;
    Object.defineProperty(this, "ondragstart", {
        get: function() {
            return this.dragstart_func;
        },
        set: function(func) {
            this.addEventListener("dragstart", func);
            this.dragstart_func = func
        }
    });
    this.drop_func = null;
    Object.defineProperty(this, "ondrop", {
        get: function() {
            return this.drop_func;
        },
        set: function(func) {
            this.addEventListener("drop", func);
            this.drop_func = func
        }
    });
    this.durationchange_func = null;
    Object.defineProperty(this, "ondurationchange", {
        get: function() {
            return this.durationchange_func;
        },
        set: function(func) {
            this.addEventListener("durationchange", func);
            this.durationchange_func = func
        }
    });
    this.emptied_func = null;
    Object.defineProperty(this, "onemptied", {
        get: function() {
            return this.emptied_func;
        },
        set: function(func) {
            this.addEventListener("emptied", func);
            this.emptied_func = func
        }
    });
    this.ended_func = null;
    Object.defineProperty(this, "onended", {
        get: function() {
            return this.ended_func;
        },
        set: function(func) {
            this.addEventListener("ended", func);
            this.ended_func = func
        }
    });
    this.gotpointercapture_func = null;
    Object.defineProperty(this, "ongotpointercapture", {
        get: function() {
            return this.gotpointercapture_func;
        },
        set: function(func) {
            this.addEventListener("gotpointercapture", func);
            this.gotpointercapture_func = func
        }
    });
    this.input_func = null;
    Object.defineProperty(this, "oninput", {
        get: function() {
            return this.input_func;
        },
        set: function(func) {
            this.addEventListener("input", func);
            this.input_func = func
        }
    });
    this.invalid_func = null;
    Object.defineProperty(this, "oninvalid", {
        get: function() {
            return this.invalid_func;
        },
        set: function(func) {
            this.addEventListener("invalid", func);
            this.invalid_func = func
        }
    });
    this.keydown_func = null;
    Object.defineProperty(this, "onkeydown", {
        get: function() {
            return this.keydown_func;
        },
        set: function(func) {
            this.addEventListener("keydown", func);
            this.keydown_func = func
        }
    });
    this.keypress_func = null;
    Object.defineProperty(this, "onkeypress", {
        get: function() {
            return this.keypress_func;
        },
        set: function(func) {
            this.addEventListener("keypress", func);
            this.keypress_func = func
        }
    });
    this.keyup_func = null;
    Object.defineProperty(this, "onkeyup", {
        get: function() {
            return this.keyup_func;
        },
        set: function(func) {
            this.addEventListener("keyup", func);
            this.keyup_func = func
        }
    });
    this.load_func = null;
    Object.defineProperty(this, "onload", {
        get: function() {
            return this.load_func;
        },
        set: function(func) {
            this.addEventListener("load", func);
            this.load_func = func
        }
    });
    this.loadeddata_func = null;
    Object.defineProperty(this, "onloadeddata", {
        get: function() {
            return this.loadeddata_func;
        },
        set: function(func) {
            this.addEventListener("loadeddata", func);
            this.loadeddata_func = func
        }
    });
    this.loadedmetadata_func = null;
    Object.defineProperty(this, "onloadedmetadata", {
        get: function() {
            return this.loadedmetadata_func;
        },
        set: function(func) {
            this.addEventListener("loadedmetadata", func);
            this.loadedmetadata_func = func
        }
    });
    this.loadend_func = null;
    Object.defineProperty(this, "onloadend", {
        get: function() {
            return this.loadend_func;
        },
        set: function(func) {
            this.addEventListener("loadend", func);
            this.loadend_func = func
        }
    });
    this.loadstart_func = null;
    Object.defineProperty(this, "onloadstart", {
        get: function() {
            return this.loadstart_func;
        },
        set: function(func) {
            this.addEventListener("loadstart", func);
            this.loadstart_func = func
        }
    });
    this.lostpointercapture_func = null;
    Object.defineProperty(this, "onlostpointercapture", {
        get: function() {
            return this.lostpointercapture_func;
        },
        set: function(func) {
            this.addEventListener("lostpointercapture", func);
            this.lostpointercapture_func = func
        }
    });
    this.mousedown_func = null;
    Object.defineProperty(this, "onmousedown", {
        get: function() {
            return this.mousedown_func;
        },
        set: function(func) {
            this.addEventListener("mousedown", func);
            this.mousedown_func = func
        }
    });
    this.mouseenter_func = null;
    Object.defineProperty(this, "onmouseenter", {
        get: function() {
            return this.mouseenter_func;
        },
        set: function(func) {
            this.addEventListener("mouseenter", func);
            this.mouseenter_func = func
        }
    });
    this.mouseleave_func = null;
    Object.defineProperty(this, "onmouseleave", {
        get: function() {
            return this.mouseleave_func;
        },
        set: function(func) {
            this.addEventListener("mouseleave", func);
            this.mouseleave_func = func
        }
    });
    this.mousemove_func = null;
    Object.defineProperty(this, "onmousemove", {
        get: function() {
            return this.mousemove_func;
        },
        set: function(func) {
            this.addEventListener("mousemove", func);
            this.mousemove_func = func
        }
    });
    this.mouseout_func = null;
    Object.defineProperty(this, "onmouseout", {
        get: function() {
            return this.mouseout_func;
        },
        set: function(func) {
            this.addEventListener("mouseout", func);
            this.mouseout_func = func
        }
    });
    this.mouseover_func = null;
    Object.defineProperty(this, "onmouseover", {
        get: function() {
            return this.mouseover_func;
        },
        set: function(func) {
            this.addEventListener("mouseover", func);
            this.mouseover_func = func
        }
    });
    this.mouseup_func = null;
    Object.defineProperty(this, "onmouseup", {
        get: function() {
            return this.mouseup_func;
        },
        set: function(func) {
            this.addEventListener("mouseup", func);
            this.mouseup_func = func
        }
    });
    this.mousewheel_func = null;
    Object.defineProperty(this, "onmousewheel", {
        get: function() {
            return this.mousewheel_func;
        },
        set: function(func) {
            this.addEventListener("mousewheel", func);
            this.mousewheel_func = func
        }
    });
    this.wheel_func = null;
    Object.defineProperty(this, "onwheel", {
        get: function() {
            return this.wheel_func;
        },
        set: function(func) {
            this.addEventListener("wheel", func);
            this.wheel_func = func
        }
    });
    this.pause_func = null;
    Object.defineProperty(this, "onpause", {
        get: function() {
            return this.pause_func;
        },
        set: function(func) {
            this.addEventListener("pause", func);
            this.pause_func = func
        }
    });
    this.play_func = null;
    Object.defineProperty(this, "onplay", {
        get: function() {
            return this.play_func;
        },
        set: function(func) {
            this.addEventListener("play", func);
            this.play_func = func
        }
    });
    this.playing_func = null;
    Object.defineProperty(this, "onplaying", {
        get: function() {
            return this.playing_func;
        },
        set: function(func) {
            this.addEventListener("playing", func);
            this.playing_func = func
        }
    });
    this.pointerdown_func = null;
    Object.defineProperty(this, "onpointerdown", {
        get: function() {
            return this.pointerdown_func;
        },
        set: function(func) {
            this.addEventListener("pointerdown", func);
            this.pointerdown_func = func
        }
    });
    this.pointermov_func = null;
    Object.defineProperty(this, "onpointermove", {
        get: function() {
            return this.pointermov_func;
        },
        set: function(func) {
            this.addEventListener("pointermov", func);
            this.pointermov_func = func
        }
    });
    this.pointerup_func = null;
    Object.defineProperty(this, "onpointerup", {
        get: function() {
            return this.pointerup_func;
        },
        set: function(func) {
            this.addEventListener("pointerup", func);
            this.pointerup_func = func
        }
    });
    this.pointercancel_func = null;
    Object.defineProperty(this, "onpointercancel", {
        get: function() {
            return this.pointercancel_func;
        },
        set: function(func) {
            this.addEventListener("pointercancel", func);
            this.pointercancel_func = func
        }
    });
    this.pointerover_func = null;
    Object.defineProperty(this, "onpointerover", {
        get: function() {
            return this.pointerover_func;
        },
        set: function(func) {
            this.addEventListener("pointerover", func);
            this.pointerover_func = func
        }
    });
    this.pointerout_func = null;
    Object.defineProperty(this, "onpointerout", {
        get: function() {
            return this.pointerout_func;
        },
        set: function(func) {
            this.addEventListener("pointerout", func);
            this.pointerout_func = func
        }
    });
    this.pointerenter_func = null;
    Object.defineProperty(this, "onpointerenter", {
        get: function() {
            return this.pointerenter_func;
        },
        set: function(func) {
            this.addEventListener("pointerenter", func);
            this.pointerenter_func = func
        }
    });
    this.pointerleave_func = null;
    Object.defineProperty(this, "onpointerleave", {
        get: function() {
            return this.pointerleave_func;
        },
        set: function(func) {
            this.addEventListener("pointerleave", func);
            this.pointerleave_func = func
        }
    });
    this.pointerlockchange_func = null;
    Object.defineProperty(this, "onpointerlockchange", {
        get: function() {
            return this.pointerlockchange_func;
        },
        set: function(func) {
            this.addEventListener("pointerlockchange", func);
            this.pointerlockchange_func = func
        }
    });
    this.pointerlockerror_func = null;
    Object.defineProperty(this, "onpointerlockerror", {
        get: function() {
            return this.pointerlockerror_func;
        },
        set: function(func) {
            this.addEventListener("pointerlockerror", func);
            this.pointerlockerror_func = func
        }
    });
    this.progress_func = null;
    Object.defineProperty(this, "onprogress", {
        get: function() {
            return this.progress_func;
        },
        set: function(func) {
            this.addEventListener("progress", func);
            this.progress_func = func
        }
    });
    this.ratechange_func = null;
    Object.defineProperty(this, "onratechange", {
        get: function() {
            return this.ratechange_func;
        },
        set: function(func) {
            this.addEventListener("ratechange", func);
            this.ratechange_func = func
        }
    });
    this.reset_func = null;
    Object.defineProperty(this, "onreset", {
        get: function() {
            return this.reset_func;
        },
        set: function(func) {
            this.addEventListener("reset", func);
            this.reset_func = func
        }
    });
    this.resize_func = null;
    Object.defineProperty(this, "onresize", {
        get: function() {
            return this.resize_func;
        },
        set: function(func) {
            this.addEventListener("resize", func);
            this.resize_func = func
        }
    });
    this.scroll_func = null;
    Object.defineProperty(this, "onscroll", {
        get: function() {
            return this.scroll_func;
        },
        set: function(func) {
            this.addEventListener("scroll", func);
            this.scroll_func = func
        }
    });
    this.seeked_func = null;
    Object.defineProperty(this, "onseeked", {
        get: function() {
            return this.seeked_func;
        },
        set: function(func) {
            this.addEventListener("seeked", func);
            this.seeked_func = func
        }
    });
    this.seeking_func = null;
    Object.defineProperty(this, "onseeking", {
        get: function() {
            return this.seeking_func;
        },
        set: function(func) {
            this.addEventListener("seeking", func);
            this.seeking_func = func
        }
    });
    this.select_func = null;
    Object.defineProperty(this, "onselect", {
        get: function() {
            return this.select_func;
        },
        set: function(func) {
            this.addEventListener("select", func);
            this.select_func = func
        }
    });
    this.selectstart_func = null;
    Object.defineProperty(this, "onselectstart", {
        get: function() {
            return this.selectstart_func;
        },
        set: function(func) {
            this.addEventListener("selectstart", func);
            this.selectstart_func = func
        }
    });
    this.selectionchange_func = null;
    Object.defineProperty(this, "onselectionchange", {
        get: function() {
            return this.selectionchange_func;
        },
        set: function(func) {
            this.addEventListener("selectionchange", func);
            this.selectionchange_func = func
        }
    });
    this.show_func = null;
    Object.defineProperty(this, "onshow", {
        get: function() {
            return this.show_func;
        },
        set: function(func) {
            this.addEventListener("show", func);
            this.show_func = func
        }
    });
    this.sort_func = null;
    Object.defineProperty(this, "onsort", {
        get: function() {
            return this.sort_func;
        },
        set: function(func) {
            this.addEventListener("sort", func);
            this.sort_func = func
        }
    });
    this.stalled_func = null;
    Object.defineProperty(this, "onstalled", {
        get: function() {
            return this.stalled_func;
        },
        set: function(func) {
            this.addEventListener("stalled", func);
            this.stalled_func = func
        }
    });
    this.submit_func = null;
    Object.defineProperty(this, "onsubmit", {
        get: function() {
            return this.submit_func;
        },
        set: function(func) {
            this.addEventListener("submit", func);
            this.submit_func = func
        }
    });
    this.suspend_func = null;
    Object.defineProperty(this, "onsuspend", {
        get: function() {
            return this.suspend_func;
        },
        set: function(func) {
            this.addEventListener("suspend", func);
            this.suspend_func = func
        }
    });
    this.timeupdate_func = null;
    Object.defineProperty(this, "ontimeupdate", {
        get: function() {
            return this.timeupdate_func;
        },
        set: function(func) {
            this.addEventListener("timeupdate", func);
            this.timeupdate_func = func
        }
    });
    this.volumechange_func = null;
    Object.defineProperty(this, "onvolumechange", {
        get: function() {
            return this.volumechange_func;
        },
        set: function(func) {
            this.addEventListener("volumechange", func);
            this.volumechange_func = func
        }
    });
    this.touchcancel_func = null;
    Object.defineProperty(this, "ontouchcancel", {
        get: function() {
            return this.touchcancel_func;
        },
        set: function(func) {
            this.addEventListener("touchcancel", func);
            this.touchcancel_func = func
        }
    });
    this.touchend_func = null;
    Object.defineProperty(this, "ontouchend", {
        get: function() {
            return this.touchend_func;
        },
        set: function(func) {
            this.addEventListener("touchend", func);
            this.touchend_func = func
        }
    });
    this.touchmove_func = null;
    Object.defineProperty(this, "ontouchmove", {
        get: function() {
            return this.touchmove_func;
        },
        set: function(func) {
            this.addEventListener("touchmove", func);
            this.touchmove_func = func
        }
    });
    this.ontouchstart_func = null;
    //Object.defineProperty(this, "ontouchstart", {
    //	get: function(){ return this.touchstart_func; },
    //	set: function(func){ this.addEventListener("touchstart", func); this.touchstart_func = func }
    //});
    this.transitioncancel_func = null;
    Object.defineProperty(this, "ontransitioncancel", {
        get: function() {
            return this.transitioncancel_func;
        },
        set: function(func) {
            this.addEventListener("transitioncancel", func);
            this.transitioncancel_func = func
        }
    });
    this.transitionend_func = null;
    Object.defineProperty(this, "ontransitionend", {
        get: function() {
            return this.transitionend_func;
        },
        set: function(func) {
            this.addEventListener("transitionend", func);
            this.transitionend_func = func
        }
    });
    this.waiting_func = null;
    Object.defineProperty(this, "onwaiting", {
        get: function() {
            return this.waiting_func;
        },
        set: function(func) {
            this.addEventListener("waiting", func);
            this.waiting_func = func
        }
    });

    return this;
}

// 
GlobalEventHandlers.prototype = EventTarget.prototype;
