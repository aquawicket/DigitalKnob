"use strict";

dk.messagebox = new DKPlugin("dk_messagebox");

dk.messagebox.close = function dk_messagebox_close(node) {/*
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
        */
}

dk.messagebox.closeAll = function dk_messagebox_closeAll() {/*
    for (let n = 0; n < this.boxes.length; n++) {
        const box = this.boxes[n];
        this.close(box);
    }
    */
}

dk.messagebox.create = function dk_messagebox_create(identifier, dk_messagebox_callback) {

    dk.messagebox = new DKPlugin(identifier);
    if (!dk.messagebox)
        return error("box.message invalid", dk_messagebox_callback);
    dk.create("DKGui/DKMessageBox.html", function dk_create_callback(html) {
        if (!html)
            return error("invalid html", dk_messagebox_callback);
        dk.messagebox.message = box.querySelector("[dk_messagebox='message']");
        dk.messagebox.input = box.querySelector("[dk_messagebox='input']");
        dk.messagebox.cancel = box.querySelector("[dk_messagebox='cancel']");
        dk.messagebox.ok = box.querySelector("[dk_messagebox='ok']");
        dk.frame.create(dk.messagebox);
        return dk_messagebox_callback && dk_messagebox_callback(dk.messagebox);
    });

    /*
    dk.create("DKGui/DKMessageBox.html", function dk_create_callback(box) {
        if (!box)
            return error("invalid box", callback);

        dk.messagebox.boxes.push(box);
        box.close = dk.messagebox.close;
        box.message = box.querySelector("[dk_messagebox='message']");
        box.input = box.querySelector("[dk_messagebox='input']");
        box.cancel = box.querySelector("[dk_messagebox='cancel']");
        box.ok = box.querySelector("[dk_messagebox='ok']");
        dk.frame.create(box);
        return callback && callback(box);
    });
    */
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
    const messagebox = dk.messagebox.create("dk_messagebox_confirm", function() {
        messagebox.message.innerHTML = message;
        messagebox.input.style.display = "none";
        messagebox.message.style.display = "block";
        messagebox.message.style.visibility = "visible";
        messagebox.cancel.style.display = "block";
        messagebox.cancel.style.visibility = "visible";
        messagebox.style.display = "block";
        messagebox.style.visibility = "visible";
        messagebox.ok.onclick = function() {
            this.close(event.currentTarget);
            return callback && callback(true);
        }
        messagebox.cancel.onclick = function() {
            this.close(event.currentTarget);
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
