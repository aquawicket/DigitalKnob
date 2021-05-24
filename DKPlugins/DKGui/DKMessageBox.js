"use strict";

dk.messagebox = new DKPlugin("dk_messagebox");
//const messagebox = function(pointer){}
//messagebox.prototype = DKPlugin.prototype;
//dk.messagebox = new messagebox();

dk.messagebox.init = function dK_messagebox_init(callback){
    dk.create("DKGui/DKMessageBox.css");
    callback(true);
}

dk.messagebox.close = function dk_messagebox_close(instance) {
    console.debug("dk.messagebox.close("+instance+")");
    const frame = dk.frame.getFrame(instance);
    if (frame)
        dk.frame.close(instance);
}

dk.messagebox.closeAll = function dk_messagebox_closeAll() {/*
    for (let n = 0; n < this.boxes.length; n++) {
        const box = this.boxes[n];
        this.close(box);
    }
    */
}

dk.messagebox.create = function dk_messagebox_create(dk_messagebox_create_callback) {
    const instance = new DKPlugin("new");
    //const instance = new messagebox();
    if (!instance)
        return error("instance invalid", dk_messagebox_create_callback);

    dk.create("DKGui/DKMessageBox.html", function dk_create_callback(html) {
        if (!html)
            return error("invalid html", dk_messagebox_create_callback);
        instance.html = html;
        instance.setAccessNode(html);
        instance.message = html.querySelector("[dk_messagebox='message']");
        instance.input = html.querySelector("[dk_messagebox='input']");
        instance.cancel = html.querySelector("[dk_messagebox='cancel']");
        instance.ok = html.querySelector("[dk_messagebox='ok']");
        dk.frame.create(instance);
        return dk_messagebox_create_callback(instance);
    });
}

dk.messagebox.getBox = function dk_messagebox_getBox(node) {/*
    if (!node)
        return error("node invalid");
    while (node && node !== document) {
        for (let n = 0; n < dk.messagebox.boxes.length; n++) {
            if (dk.messagebox.boxes[n] && dk.messagebox.boxes[n] === node)
                return dk.messagebox.boxes[n];
        }
        node = node.parentNode;
    }
    return error("dk.messagebox.boxes[n] invalid");
    */
}

dk.messagebox.onevent = function dk_messagebox_onevent(event) {/*
    if (event.currentTarget.id === "DKMessageBoxOk") {
        if (byId("DKMessageBoxInput").value)
            dk.messagebox.callback && dk.messagebox.callback(byId("DKMessageBoxInput").value);
        else
            dk.messagebox.callback && dk.messagebox.callback(true);
        dk.frame.close(byId("DKGui/DKMessageBox.html"));
        return true;
    }

    if (event.currentTarget.id === "DKMessageBoxCancel") {
        dk.messagebox.callback && dk.messagebox.callback(false);
        dk.frame.close(byId("DKGui/DKMessageBox.html"));
        return true;
    }
    */
}

dk.messagebox.message = function dk_messagebox_message(message) {/*
    byId("DKMessageBoxText").innerHTML = message;
    byId("DKMessageBoxInput").style.display = "none";
    byId("DKMessageBoxCancel").style.display = "none";
    byId("DKMessageBoxText").style.display = "block";
    byId("DKMessageBoxText").style.visibility = "visible";
    byId("DKGui/DKMessageBox.html").style.display = "block";
    byId("DKGui/DKMessageBox.html").style.visibility = "visible";
    */
}

dk.messagebox.confirm = function dk_messagebox_confirm(message, callback) {
    dk.messagebox.create(function(instance) {
        instance.message.innerHTML = message;
        instance.input.style.display = "none";
        instance.message.style.display = "block";
        instance.message.style.visibility = "visible";
        instance.cancel.style.display = "block";
        instance.cancel.style.visibility = "visible";
        //instance.style.display = "block";
        //instance.style.visibility = "visible";
        instance.ok.onclick = function() {
            dk.messagebox.close(instance);
            return callback(true);
        }
        instance.cancel.onclick = function() {
            dk.messagebox.close(instance);
            return callback(false);
        }
    });
}

dk.messagebox.value = function dk_messagebox_value(message, callback) {/*
    byId("DKMessageBoxText").innerHTML = message;
    byId("DKMessageBoxText").style.display = "block";
    byId("DKMessageBoxText").style.visibility = "visible";
    byId("DKMessageBoxInput").style.display = "block";
    byId("DKMessageBoxInput").style.visibility = "visible";
    byId("DKMessageBoxCancel").style.display = "block";
    byId("DKMessageBoxCancel").style.visibility = "visible";
    byId("DKGui/DKMessageBox.html").style.display = "block";
    byId("DKGui/DKMessageBox.html").style.visibility = "visible";
    dk.messagebox.callback = callback;
    */
}
