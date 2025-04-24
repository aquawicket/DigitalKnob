//https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers

<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
var GlobalEventHandlers = function GlobalEventHandlers(pointer) {
=======
var GlobalEventHandlers = function GlobalEventHandlers(pointer){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
    this.pointer = pointer;

    this.abort = null;
    Object.defineProperty(this, "onabort", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onabort() {
            return this.abort;
        },
        set: function onabort(func) {
=======
        get: function onabort(){
            return this.abort;
        },
        set: function onabort(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("abort", func);
            this.abort = func
        }
    });
    this.animationcancel = null;
    Object.defineProperty(this, "onanimationcancel", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onanimationcancel() {
            return this.animationcancel;
        },
        set: function onanimationcancel(func) {
=======
        get: function onanimationcancel(){
            return this.animationcancel;
        },
        set: function onanimationcancel(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("animationcancel", func);
            this.animationcancel = func
        }
    });
    this.animationend = null;
    Object.defineProperty(this, "onanimationend", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onanimationend() {
            return this.animationend;
        },
        set: function onanimationend(func) {
=======
        get: function onanimationend(){
            return this.animationend;
        },
        set: function onanimationend(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("animationend", func);
            this.animationend = func
        }
    });
    this.animationiteration = null;
    Object.defineProperty(this, "onanimationiteration", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onanimationiteration() {
            return this.animationiteration;
        },
        set: function onanimationiteration(func) {
=======
        get: function onanimationiteration(){
            return this.animationiteration;
        },
        set: function onanimationiteration(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("animationiteration", func);
            this.animationiteration = func
        }
    });
    this.animationstart = null;
    Object.defineProperty(this, "onanimationstart", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onanimationstart() {
            return this.animationstart;
        },
        set: function onanimationstart(func) {
=======
        get: function onanimationstart(){
            return this.animationstart;
        },
        set: function onanimationstart(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("animationstart", func);
            this.animationstart = func
        }
    });
    this.auxclick = null;
    Object.defineProperty(this, "onauxclick", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onauxclick() {
            return this.auxclick;
        },
        set: function onauxclick(func) {
=======
        get: function onauxclick(){
            return this.auxclick;
        },
        set: function onauxclick(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("auxclick", func);
            this.auxclick = func
        }
    });
    this.blur = null;
    Object.defineProperty(this, "onblur", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onblur() {
            return this.blur;
        },
        set: function onblur(func) {
=======
        get: function onblur(){
            return this.blur;
        },
        set: function onblur(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("blur", func);
            this.blur = func
        }
    });
    this.error = null;
    Object.defineProperty(this, "onerror", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onerror() {
            return this.error;
        },
        set: function onerror(func) {
=======
        get: function onerror(){
            return this.error;
        },
        set: function onerror(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("error", func);
            this.error = func
        }
    });
    this.focus = null;
    Object.defineProperty(this, "onfocus", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onfocus() {
            return this.focus;
        },
        set: function onfocus(func) {
=======
        get: function onfocus(){
            return this.focus;
        },
        set: function onfocus(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("focus", func);
            this.focus = func
        }
    });
    this.canplay = null;
    Object.defineProperty(this, "oncanplay", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function oncanplay() {
            return this.canplay;
        },
        set: function oncanplay(func) {
=======
        get: function oncanplay(){
            return this.canplay;
        },
        set: function oncanplay(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("canplay", func);
            this.canplay = func
        }
    });
    this.canplaythrough = null;
    Object.defineProperty(this, "oncanplaythrough", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function oncanplaythrough() {
            return this.canplaythrough;
        },
        set: function oncanplaythrough(func) {
=======
        get: function oncanplaythrough(){
            return this.canplaythrough;
        },
        set: function oncanplaythrough(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("canplaythrough", func);
            this.canplaythrough = func
        }
    });
    this.change = null;
    Object.defineProperty(this, "onchange", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onchange() {
            return this.change;
        },
        set: function onchange(func) {
=======
        get: function onchange(){
            return this.change;
        },
        set: function onchange(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("change", func);
            this.change = func
        }
    });
    this.click = null;
    Object.defineProperty(this, "onclick", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onclick() {
            return this.click;
        },
        set: function onclick(func) {
=======
        get: function onclick(){
            return this.click;
        },
        set: function onclick(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("click", func);
            this.click = func;
        }
    });
    this.close = null;
    Object.defineProperty(this, "onclose", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onclose() {
            return this.close;
        },
        set: function onclose(func) {
=======
        get: function onclose(){
            return this.close;
        },
        set: function onclose(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("close", func);
            this.close = func
        }
    });
    this.contextmenu = null;
    Object.defineProperty(this, "oncontextmenu", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function oncontextmenu() {
            return this.contextmenu;
        },
        set: function oncontextmenu(func) {
=======
        get: function oncontextmenu(){
            return this.contextmenu;
        },
        set: function oncontextmenu(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("contextmenu", func);
            this.contextmenu = func
        }
    });
    this.cuechange = null;
    Object.defineProperty(this, "oncuechange", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function oncuechange() {
            return this.cuechange;
        },
        set: function oncuechange(func) {
=======
        get: function oncuechange(){
            return this.cuechange;
        },
        set: function oncuechange(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("cuechange", func);
            this.cuechange = func
        }
    });
    this.dblclick = null;
    Object.defineProperty(this, "ondblclick", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ondblclick() {
            return this.dblclick;
        },
        set: function ondblclick(func) {
=======
        get: function ondblclick(){
            return this.dblclick;
        },
        set: function ondblclick(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("dblclick", func);
            this.dblclick = func
        }
    });
    this.drag = null;
    Object.defineProperty(this, "ondrag", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ondrag() {
            return this.drag;
        },
        set: function ondrag(func) {
=======
        get: function ondrag(){
            return this.drag;
        },
        set: function ondrag(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("drag", func);
            this.drag = func
        }
    });
    this.dragend = null;
    Object.defineProperty(this, "ondragend", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ondragend() {
            return this.dragend;
        },
        set: function ondragend(func) {
=======
        get: function ondragend(){
            return this.dragend;
        },
        set: function ondragend(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("dragend", func);
            this.dragend = func
        }
    });
    this.dragenter = null;
    Object.defineProperty(this, "ondragenter", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ondragenter() {
            return this.dragenter;
        },
        set: function ondragenter(func) {
=======
        get: function ondragenter(){
            return this.dragenter;
        },
        set: function ondragenter(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("dragenter", func);
            this.dragenter = func
        }
    });
    this.dragexit = null;
    Object.defineProperty(this, "ondragexit", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ondragexit() {
            return this.dragexit;
        },
        set: function ondragexit(func) {
=======
        get: function ondragexit(){
            return this.dragexit;
        },
        set: function ondragexit(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("dragexit", func);
            this.dragexit = func
        }
    });
    this.dragleave = null;
    Object.defineProperty(this, "ondragleave", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ondragleave() {
            return this.dragleave;
        },
        set: function ondragleave(func) {
=======
        get: function ondragleave(){
            return this.dragleave;
        },
        set: function ondragleave(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("dragleave", func);
            this.dragleave = func
        }
    });
    this.dragover = null;
    Object.defineProperty(this, "ondragover", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ondragover() {
            return this.dragover;
        },
        set: function ondragover(func) {
=======
        get: function ondragover(){
            return this.dragover;
        },
        set: function ondragover(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("dragover", func);
            this.dragover = func
        }
    });
    this.dragstart = null;
    Object.defineProperty(this, "ondragstart", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ondragstart() {
            return this.dragstart;
        },
        set: function ondragstart(func) {
=======
        get: function ondragstart(){
            return this.dragstart;
        },
        set: function ondragstart(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("dragstart", func);
            this.dragstart = func
        }
    });
    this.drop = null;
    Object.defineProperty(this, "ondrop", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ondrop() {
            return this.drop;
        },
        set: function ondrop(func) {
=======
        get: function ondrop(){
            return this.drop;
        },
        set: function ondrop(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("drop", func);
            this.drop = func
        }
    });
    this.durationchange = null;
    Object.defineProperty(this, "ondurationchange", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ondurationchange() {
            return this.durationchange;
        },
        set: function ondurationchange(func) {
=======
        get: function ondurationchange(){
            return this.durationchange;
        },
        set: function ondurationchange(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("durationchange", func);
            this.durationchange = func
        }
    });
    this.emptied = null;
    Object.defineProperty(this, "onemptied", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onemptied() {
            return this.emptied;
        },
        set: function onemptied(func) {
=======
        get: function onemptied(){
            return this.emptied;
        },
        set: function onemptied(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("emptied", func);
            this.emptied = func
        }
    });
    this.ended = null;
    Object.defineProperty(this, "onended", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onended() {
            return this.ended;
        },
        set: function onended(func) {
=======
        get: function onended(){
            return this.ended;
        },
        set: function onended(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("ended", func);
            this.ended = func
        }
    });
    this.gotpointercapture = null;
    Object.defineProperty(this, "ongotpointercapture", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ongotpointercapture() {
            return this.gotpointercapture;
        },
        set: function ongotpointercapture(func) {
=======
        get: function ongotpointercapture(){
            return this.gotpointercapture;
        },
        set: function ongotpointercapture(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("gotpointercapture", func);
            this.gotpointercapture = func
        }
    });
    this.input = null;
    Object.defineProperty(this, "oninput", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function oninput() {
            return this.input;
        },
        set: function oninput(func) {
=======
        get: function oninput(){
            return this.input;
        },
        set: function oninput(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("input", func);
            this.input = func
        }
    });
    this.invalid = null;
    Object.defineProperty(this, "oninvalid", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function oninvalid() {
            return this.invalid;
        },
        set: function oninvalid(func) {
=======
        get: function oninvalid(){
            return this.invalid;
        },
        set: function oninvalid(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("invalid", func);
            this.invalid = func
        }
    });
    this.keydown = null;
    Object.defineProperty(this, "onkeydown", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onkeydown() {
            return this.keydown;
        },
        set: function onkeydown(func) {
=======
        get: function onkeydown(){
            return this.keydown;
        },
        set: function onkeydown(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("keydown", func);
            this.keydown = func
        }
    });
    this.keypress = null;
    Object.defineProperty(this, "onkeypress", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onkeypress() {
            return this.keypress;
        },
        set: function onkeypress(func) {
=======
        get: function onkeypress(){
            return this.keypress;
        },
        set: function onkeypress(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("keypress", func);
            this.keypress = func
        }
    });
    this.keyup = null;
    Object.defineProperty(this, "onkeyup", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onkeyup() {
            return this.keyup;
        },
        set: function onkeyup(func) {
=======
        get: function onkeyup(){
            return this.keyup;
        },
        set: function onkeyup(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("keyup", func);
            this.keyup = func
        }
    });
    this.load = null;
    Object.defineProperty(this, "onload", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onload() {
            return this.load;
        },
        set: function onload(func) {
=======
        get: function onload(){
            return this.load;
        },
        set: function onload(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("load", func);
            this.load = func
        }
    });
    this.loadeddata = null;
    Object.defineProperty(this, "onloadeddata", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onloadeddata() {
            return this.loadeddata;
        },
        set: function onloadeddata(func) {
=======
        get: function onloadeddata(){
            return this.loadeddata;
        },
        set: function onloadeddata(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("loadeddata", func);
            this.loadeddata = func
        }
    });
    this.loadedmetadata = null;
    Object.defineProperty(this, "onloadedmetadata", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onloadedmetadata() {
            return this.loadedmetadata;
        },
        set: function onloadedmetadata(func) {
=======
        get: function onloadedmetadata(){
            return this.loadedmetadata;
        },
        set: function onloadedmetadata(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("loadedmetadata", func);
            this.loadedmetadata = func
        }
    });
    this.loadend = null;
    Object.defineProperty(this, "onloadend", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onloadend() {
            return this.loadend;
        },
        set: function onloadend(func) {
=======
        get: function onloadend(){
            return this.loadend;
        },
        set: function onloadend(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("loadend", func);
            this.loadend = func
        }
    });
    this.loadstart = null;
    Object.defineProperty(this, "onloadstart", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onloadstart() {
            return this.loadstart;
        },
        set: function onloadstart(func) {
=======
        get: function onloadstart(){
            return this.loadstart;
        },
        set: function onloadstart(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("loadstart", func);
            this.loadstart = func
        }
    });
    this.lostpointercapture = null;
    Object.defineProperty(this, "onlostpointercapture", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onlostpointercapture() {
            return this.lostpointercapture;
        },
        set: function onlostpointercapture(func) {
=======
        get: function onlostpointercapture(){
            return this.lostpointercapture;
        },
        set: function onlostpointercapture(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("lostpointercapture", func);
            this.lostpointercapture = func
        }
    });
    this.mousedown = null;
    Object.defineProperty(this, "onmousedown", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onmousedown() {
            return this.mousedown;
        },
        set: function onmousedown(func) {
=======
        get: function onmousedown(){
            return this.mousedown;
        },
        set: function onmousedown(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("mousedown", func);
            this.mousedown = func
        }
    });
    this.mouseenter = null;
    Object.defineProperty(this, "onmouseenter", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onmouseenter() {
            return this.mouseenter;
        },
        set: function onmouseenter(func) {
=======
        get: function onmouseenter(){
            return this.mouseenter;
        },
        set: function onmouseenter(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("mouseenter", func);
            this.mouseenter = func
        }
    });
    this.mouseleave = null;
    Object.defineProperty(this, "onmouseleave", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onmouseleave() {
            return this.mouseleave;
        },
        set: function onmouseleave(func) {
=======
        get: function onmouseleave(){
            return this.mouseleave;
        },
        set: function onmouseleave(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("mouseleave", func);
            this.mouseleave = func
        }
    });
    this.mousemove = null;
    Object.defineProperty(this, "onmousemove", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onmousemove() {
            return this.mousemove;
        },
        set: function onmousemove(func) {
=======
        get: function onmousemove(){
            return this.mousemove;
        },
        set: function onmousemove(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("mousemove", func);
            this.mousemove = func
        }
    });
    this.mouseout = null;
    Object.defineProperty(this, "onmouseout", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onmouseout() {
            return this.mouseout;
        },
        set: function onmouseout(func) {
=======
        get: function onmouseout(){
            return this.mouseout;
        },
        set: function onmouseout(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("mouseout", func);
            this.mouseout = func
        }
    });
    this.mouseover = null;
    Object.defineProperty(this, "onmouseover", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onmouseover() {
            return this.mouseover;
        },
        set: function onmouseover(func) {
=======
        get: function onmouseover(){
            return this.mouseover;
        },
        set: function onmouseover(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("mouseover", func);
            this.mouseover = func
        }
    });
    this.mouseup = null;
    Object.defineProperty(this, "onmouseup", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onmouseup() {
            return this.mouseup;
        },
        set: function onmouseup(func) {
=======
        get: function onmouseup(){
            return this.mouseup;
        },
        set: function onmouseup(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("mouseup", func);
            this.mouseup = func
        }
    });
    this.mousewheel = null;
    Object.defineProperty(this, "onmousewheel", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onmousewheel() {
            return this.mousewheel;
        },
        set: function onmousewheel(func) {
=======
        get: function onmousewheel(){
            return this.mousewheel;
        },
        set: function onmousewheel(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("mousewheel", func);
            this.mousewheel = func
        }
    });
    this.wheel = null;
    Object.defineProperty(this, "onwheel", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onwheel() {
            return this.wheel;
        },
        set: function onwheel(func) {
=======
        get: function onwheel(){
            return this.wheel;
        },
        set: function onwheel(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("wheel", func);
            this.wheel = func
        }
    });
    this.pause = null;
    Object.defineProperty(this, "onpause", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onpause() {
            return this.pause;
        },
        set: function onpause(func) {
=======
        get: function onpause(){
            return this.pause;
        },
        set: function onpause(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("pause", func);
            this.pause = func
        }
    });
    this.play = null;
    Object.defineProperty(this, "onplay", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onplay() {
            return this.play;
        },
        set: function onplay(func) {
=======
        get: function onplay(){
            return this.play;
        },
        set: function onplay(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("play", func);
            this.play = func
        }
    });
    this.playing = null;
    Object.defineProperty(this, "onplaying", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onplaying() {
            return this.playing;
        },
        set: function onplaying(func) {
=======
        get: function onplaying(){
            return this.playing;
        },
        set: function onplaying(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("playing", func);
            this.playing = func
        }
    });
    this.pointerdown = null;
    Object.defineProperty(this, "onpointerdown", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onpointerdown() {
            return this.pointerdown;
        },
        set: function onpointerdown(func) {
=======
        get: function onpointerdown(){
            return this.pointerdown;
        },
        set: function onpointerdown(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("pointerdown", func);
            this.pointerdown = func
        }
    });
    this.pointermov = null;
    Object.defineProperty(this, "onpointermove", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onpointermove() {
            return this.pointermov;
        },
        set: function onpointermove(func) {
=======
        get: function onpointermove(){
            return this.pointermov;
        },
        set: function onpointermove(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("pointermov", func);
            this.pointermov = func
        }
    });
    this.pointerup = null;
    Object.defineProperty(this, "onpointerup", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onpointerup() {
            return this.pointerup;
        },
        set: function onpointerup(func) {
=======
        get: function onpointerup(){
            return this.pointerup;
        },
        set: function onpointerup(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("pointerup", func);
            this.pointerup = func
        }
    });
    this.pointercancel = null;
    Object.defineProperty(this, "onpointercancel", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onpointercancel() {
            return this.pointercancel;
        },
        set: function onpointercancel(func) {
=======
        get: function onpointercancel(){
            return this.pointercancel;
        },
        set: function onpointercancel(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("pointercancel", func);
            this.pointercancel = func
        }
    });
    this.pointerover = null;
    Object.defineProperty(this, "onpointerover", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onpointerover() {
            return this.pointerover;
        },
        set: function onpointerover(func) {
=======
        get: function onpointerover(){
            return this.pointerover;
        },
        set: function onpointerover(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("pointerover", func);
            this.pointerover = func
        }
    });
    this.pointerout = null;
    Object.defineProperty(this, "onpointerout", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onpointerout() {
            return this.pointerout;
        },
        set: function onpointerout(func) {
=======
        get: function onpointerout(){
            return this.pointerout;
        },
        set: function onpointerout(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("pointerout", func);
            this.pointerout = func
        }
    });
    this.pointerenter = null;
    Object.defineProperty(this, "onpointerenter", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onpointerenter() {
            return this.pointerenter;
        },
        set: function onpointerenter(func) {
=======
        get: function onpointerenter(){
            return this.pointerenter;
        },
        set: function onpointerenter(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("pointerenter", func);
            this.pointerenter = func
        }
    });
    this.pointerleave = null;
    Object.defineProperty(this, "onpointerleave", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onpointerleave() {
            return this.pointerleave;
        },
        set: function onpointerleave(func) {
=======
        get: function onpointerleave(){
            return this.pointerleave;
        },
        set: function onpointerleave(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("pointerleave", func);
            this.pointerleave = func
        }
    });
    this.pointerlockchange = null;
    Object.defineProperty(this, "onpointerlockchange", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onpointerlockchange() {
            return this.pointerlockchange;
        },
        set: function onpointerlockchange(func) {
=======
        get: function onpointerlockchange(){
            return this.pointerlockchange;
        },
        set: function onpointerlockchange(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("pointerlockchange", func);
            this.pointerlockchange = func
        }
    });
    this.pointerlockerror = null;
    Object.defineProperty(this, "onpointerlockerror", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onpointerlockerror() {
            return this.pointerlockerror;
        },
        set: function onpointerlockerror(func) {
=======
        get: function onpointerlockerror(){
            return this.pointerlockerror;
        },
        set: function onpointerlockerror(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("pointerlockerror", func);
            this.pointerlockerror = func
        }
    });
    this.progress = null;
    Object.defineProperty(this, "onprogress", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onprogress() {
            return this.progress;
        },
        set: function onprogress(func) {
=======
        get: function onprogress(){
            return this.progress;
        },
        set: function onprogress(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("progress", func);
            this.progress = func
        }
    });
    this.ratechange = null;
    Object.defineProperty(this, "onratechange", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onratechange() {
            return this.ratechange;
        },
        set: function onratechange(func) {
=======
        get: function onratechange(){
            return this.ratechange;
        },
        set: function onratechange(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("ratechange", func);
            this.ratechange = func
        }
    });
    this.reset = null;
    Object.defineProperty(this, "onreset", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onreset() {
            return this.reset;
        },
        set: function onreset(func) {
=======
        get: function onreset(){
            return this.reset;
        },
        set: function onreset(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("reset", func);
            this.reset = func
        }
    });
    this.resize = null;
    Object.defineProperty(this, "onresize", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onresize() {
            return this.resize;
        },
        set: function onresize(func) {
=======
        get: function onresize(){
            return this.resize;
        },
        set: function onresize(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("resize", func);
            this.resize = func
        }
    });
    this.scroll = null;
    Object.defineProperty(this, "onscroll", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onscroll() {
            return this.scroll;
        },
        set: function onscroll(func) {
=======
        get: function onscroll(){
            return this.scroll;
        },
        set: function onscroll(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("scroll", func);
            this.scroll = func
        }
    });
    this.seeked = null;
    Object.defineProperty(this, "onseeked", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onseeked() {
            return this.seeked;
        },
        set: function onseeked(func) {
=======
        get: function onseeked(){
            return this.seeked;
        },
        set: function onseeked(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("seeked", func);
            this.seeked = func
        }
    });
    this.seeking = null;
    Object.defineProperty(this, "onseeking", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onseeking() {
            return this.seeking;
        },
        set: function onseeking(func) {
=======
        get: function onseeking(){
            return this.seeking;
        },
        set: function onseeking(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("seeking", func);
            this.seeking = func
        }
    });
    this.select = null;
    Object.defineProperty(this, "onselect", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onselect() {
            return this.select;
        },
        set: function onselect(func) {
=======
        get: function onselect(){
            return this.select;
        },
        set: function onselect(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("select", func);
            this.select = func
        }
    });
    this.selectstart = null;
    Object.defineProperty(this, "onselectstart", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onselectstart() {
            return this.selectstart;
        },
        set: function onselectstart(func) {
=======
        get: function onselectstart(){
            return this.selectstart;
        },
        set: function onselectstart(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("selectstart", func);
            this.selectstart = func
        }
    });
    this.selectionchange = null;
    Object.defineProperty(this, "onselectionchange", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onselectionchange() {
            return this.selectionchange;
        },
        set: function onselectionchange(func) {
=======
        get: function onselectionchange(){
            return this.selectionchange;
        },
        set: function onselectionchange(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("selectionchange", func);
            this.selectionchange = func
        }
    });
    this.show = null;
    Object.defineProperty(this, "onshow", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onshow() {
            return this.show;
        },
        set: function onshow(func) {
=======
        get: function onshow(){
            return this.show;
        },
        set: function onshow(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("show", func);
            this.show = func
        }
    });
    this.sort = null;
    Object.defineProperty(this, "onsort", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onsort() {
            return this.sort;
        },
        set: function onsort(func) {
=======
        get: function onsort(){
            return this.sort;
        },
        set: function onsort(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("sort", func);
            this.sort = func
        }
    });
    this.stalled = null;
    Object.defineProperty(this, "onstalled", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onstalled() {
            return this.stalled;
        },
        set: function onstalled(func) {
=======
        get: function onstalled(){
            return this.stalled;
        },
        set: function onstalled(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("stalled", func);
            this.stalled = func
        }
    });
    this.submit = null;
    Object.defineProperty(this, "onsubmit", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onsubmit() {
            return this.submit;
        },
        set: function onsubmit(func) {
=======
        get: function onsubmit(){
            return this.submit;
        },
        set: function onsubmit(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("submit", func);
            this.submit = func
        }
    });
    this.suspend = null;
    Object.defineProperty(this, "onsuspend", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onsuspend() {
            return this.suspend;
        },
        set: function onsuspend(func) {
=======
        get: function onsuspend(){
            return this.suspend;
        },
        set: function onsuspend(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("suspend", func);
            this.suspend = func
        }
    });
    this.timeupdate = null;
    Object.defineProperty(this, "ontimeupdate", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ontimeupdate() {
            return this.timeupdate;
        },
        set: function ontimeupdate(func) {
=======
        get: function ontimeupdate(){
            return this.timeupdate;
        },
        set: function ontimeupdate(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("timeupdate", func);
            this.timeupdate = func
        }
    });
    this.volumechange = null;
    Object.defineProperty(this, "onvolumechange", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onvolumechange() {
            return this.volumechange;
        },
        set: function onvolumechange(func) {
=======
        get: function onvolumechange(){
            return this.volumechange;
        },
        set: function onvolumechange(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("volumechange", func);
            this.volumechange = func
        }
    });
    this.touchcancel = null;
    Object.defineProperty(this, "ontouchcancel", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ontouchcancel() {
            return this.touchcancel;
        },
        set: function ontouchcancel(func) {
=======
        get: function ontouchcancel(){
            return this.touchcancel;
        },
        set: function ontouchcancel(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("touchcancel", func);
            this.touchcancel = func
        }
    });
    this.touchend = null;
    Object.defineProperty(this, "ontouchend", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ontouchend() {
            return this.touchend;
        },
        set: function ontouchend(func) {
=======
        get: function ontouchend(){
            return this.touchend;
        },
        set: function ontouchend(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("touchend", func);
            this.touchend = func
        }
    });
    this.touchmove = null;
    Object.defineProperty(this, "ontouchmove", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ontouchmove() {
            return this.touchmove;
        },
        set: function ontouchmove(func) {
=======
        get: function ontouchmove(){
            return this.touchmove;
        },
        set: function ontouchmove(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("touchmove", func);
            this.touchmove = func
        }
    });
    this.ontouchstart = null;
    Object.defineProperty(this, "ontouchstart", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ontouchstart() {
            return this.touchstart;
        },
        set: function ontouchstart(func) {
=======
        get: function ontouchstart(){
            return this.touchstart;
        },
        set: function ontouchstart(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("touchstart", func);
            this.touchstart = func
        }
    });
    this.transitioncancel = null;
    Object.defineProperty(this, "ontransitioncancel", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ontransitioncancel() {
            return this.transitioncancel;
        },
        set: function ontransitioncancel(func) {
=======
        get: function ontransitioncancel(){
            return this.transitioncancel;
        },
        set: function ontransitioncancel(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("transitioncancel", func);
            this.transitioncancel = func
        }
    });
    this.transitionend = null;
    Object.defineProperty(this, "ontransitionend", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function ontransitionend() {
            return this.transitionend;
        },
        set: function ontransitionend(func) {
=======
        get: function ontransitionend(){
            return this.transitionend;
        },
        set: function ontransitionend(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("transitionend", func);
            this.transitionend = func
        }
    });
    this.waiting = null;
    Object.defineProperty(this, "onwaiting", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKGlobalEventHandlers.js
        get: function onwaiting() {
            return this.waiting;
        },
        set: function onwaiting(func) {
=======
        get: function onwaiting(){
            return this.waiting;
        },
        set: function onwaiting(func){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKGlobalEventHandlers.js
            this.addEventListener("waiting", func);
            this.waiting = func
        }
    });
}
GlobalEventHandlers.prototype = EventTarget.prototype;
