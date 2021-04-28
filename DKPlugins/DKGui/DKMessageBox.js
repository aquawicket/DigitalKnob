"use strict";

dk.messagebox = new Object;
dk.messagebox.boxes = new Array;

dk.messagebox.init = function dk_messagebox_init() {}

dk.messagebox.end = function dk_messagebox_end() {//dk.messagebox.closeAll();
}

dk.messagebox.close = function dk_messagebox_close(node) {
    const box = dk.messagebox.getBox(node);
    box.close = null;
    const frame = dk.frame.getFrame(box);
    if (frame)
        dk.frame.close(box);
    if(box.parentNode)
        box.parentNode.removeChild(box);    
    let index = dk.messagebox.boxes.indexOf(box);
    if (index > -1)
        dk.messagebox.boxes.splice(index, 1);
}

dk.messagebox.closeAll = function dk_messagebox_closeAll() {
    for (let n = 0; n < this.boxes.length; n++) {
        const box = this.boxes[n];
        this.close(box);
    }
}

dk.messagebox.create = function dk_messagebox_create(callback) {
    dk.create("DKGui/DKMessageBox.html", function(box) {
        if (!box)
            return error("invalid box");

        dk.messagebox.boxes.push(box);
        box.close = dk.messagebox.close;
        box.message = box.querySelector("[dk_messagebox='message']");
        box.input = box.querySelector("[dk_messagebox='input']");
        box.cancel = box.querySelector("[dk_messagebox='cancel']");
        box.ok = box.querySelector("[dk_messagebox='ok']");
        dk.frame.create(box);
        callback && callback(box);
    });
}

dk.messagebox.getBox = function dk_messagebox_getBox(node) {
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
    this.create(function(box) {
        box.message.innerHTML = message;
        box.input.style.display = "none";
        box.message.style.display = "block";
        box.message.style.visibility = "visible";
        box.cancel.style.display = "block";
        box.cancel.style.visibility = "visible";
        box.style.display = "block";
        box.style.visibility = "visible";
        box.ok.onclick = function() {
            callback && callback(true);
            dk.messagebox.close(event.currentTarget);
        }
        box.cancel.onclick = function() {
            callback && callback(false);
            dk.messagebox.close(event.currentTarget);
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
