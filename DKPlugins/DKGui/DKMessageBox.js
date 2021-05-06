"use strict";

dk.messagebox = new DKPlugin("dk_messagebox");

dk.messagebox.close = function dk_messagebox_close(node) {
    console.debug("dk.messagebox.close("+node+")");
    const frame = dk.frame.getFrame(node);
    if (frame)
        dk.frame.close(node);
}

dk.messagebox.closeAll = function dk_messagebox_closeAll() {/*
    for (let n = 0; n < this.boxes.length; n++) {
        const box = this.boxes[n];
        this.close(box);
    }
    */
}

dk.messagebox.create = function dk_messagebox_create(identifier, dk_messagebox_create_callback) {

    dk.messagebox.box = new DKPlugin(identifier);
    if (!dk.messagebox.box)
        return error("dk.messagebox.box invalid", dk_messagebox_create_callback);
    dk.create("DKGui/DKMessageBox.html", function dk_create_callback(html) {
        if (!html)
            return error("invalid html", dk_messagebox_create_callback);
        dk.messagebox.box.html = html;
        dk.messagebox.box.setAccessNode(html);
        dk.messagebox.box.message = html.querySelector("[dk_messagebox='message']");
        dk.messagebox.box.input = html.querySelector("[dk_messagebox='input']");
        dk.messagebox.box.cancel = html.querySelector("[dk_messagebox='cancel']");
        dk.messagebox.box.ok = html.querySelector("[dk_messagebox='ok']");
        dk.frame.create(dk.messagebox.box);
        return dk_messagebox_create_callback && dk_messagebox_create_callback(dk.messagebox.box);
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
    dk.messagebox.create("dk_messagebox_confirm", function(box) {
        box.message.innerHTML = message;
        box.input.style.display = "none";
        box.message.style.display = "block";
        box.message.style.visibility = "visible";
        box.cancel.style.display = "block";
        box.cancel.style.visibility = "visible";
        //box.style.display = "block";
        //box.style.visibility = "visible";
        box.ok.onclick = function() {
            dk.messagebox.close(box);
            return callback && callback(true);
        }
        box.cancel.onclick = function() {
            dk.messagebox.close(box);
            return callback && callback(false);
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
