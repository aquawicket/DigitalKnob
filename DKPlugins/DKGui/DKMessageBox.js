"use strict";

dk.messagebox = new DKPlugin("dk_messagebox");
//const messagebox = function(pointer){}
//messagebox.prototype = DKPlugin.prototype;
//dk.messagebox = new messagebox();

dk.messagebox.init = function dK_messagebox_init(callback){
    dk.create("DKGui/DKMessageBox.css");
    callback(true);
}

dk.messagebox.end = function dk_messagebox_end(callback){
    dk.close("DKGui/DKMessagebox.css");
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

dk.messagebox.close = function dk_messagebox_close(instance) {
    dk.frame.close(instance);
}

dk.messagebox.createConfirm = function dk_messagebox_createConfirm(message, callback) {
    dk.messagebox.create(function(instance) {
        instance.message.innerHTML = message;
        instance.input.style.display = "none";
        instance.message.style.display = "block";
        instance.message.style.visibility = "visible";
        instance.cancel.style.display = "block";
        instance.cancel.style.visibility = "visible";
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
