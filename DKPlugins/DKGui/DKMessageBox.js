"use strict";

function DKMessageBox(){}
   
DKMessageBox.prototype.init = function init(init_callback){
    console.log("DKMessageBox.prototype.init()");
    dk.create("DKGui/DKMessageBox.css");
    init_callback && init_callback(this);
}

DKMessageBox.prototype.end = function end(){
    console.log("DKMessageBox.prototype.end()");
    dk.close("DKGui/DKMessageBox.css");
}

DKMessageBox.prototype.create = function create(create_callback) {
    console.log("DKMessageBox.prototype.create()");
    const instance = new DKPlugin(DKMessageBox)
    if (!instance)
        return error("instance invalid", create_callback);
    dk.create("DKGui/DKMessageBox.html", function dkcreate_callback(html) {
        if (!html)
            return error("invalid html", create_callback);
        instance.html = html;
        instance.message = html.querySelector("[dkmessagebox='message']");
        instance.input = html.querySelector("[dkmessagebox='input']");
        instance.cancel = html.querySelector("[dkmessagebox='cancel']");
        instance.ok = html.querySelector("[dkmessagebox='ok']");
        instance.frame = DKFrame.prototype.create(instance);
        create_callback && create_callback(instance);
        return instance;
    });
}

DKMessageBox.prototype.createMessage = function createMessage(message, createMessage_callback) {
    const title = "Message"    
    this.xcreate(function create_callback(instance) {
        instance.frame.setTitle(title);
        instance.html.message.innerHTML = message;
        instance.html.input.style.display = "none";
        instance.html.message.style.display = "block";
        instance.html.message.style.visibility = "visible";
        instance.html.cancel.style.display = "none";
        instance.html.cancel.style.visibility = "hidden";
        instance.html.ok.onclick = function ok_onclick() {
            instance.frame.close();
            createMessage_callback && createMessage_callback(true);
            return true;
        }
    });
}

DKMessageBox.prototype.createConfirm = function createConfirm(message, createConfirm_callback) {
    const title = "Confirm?"    
    this.create(function create_callback(instance) {
        instance.frame.setTitle(title);
        //instance.html.panel = true;
        //instance.html.setAttribute("panel", "true");
        instance.message.innerHTML = message;
        instance.input.style.display = "none";
        instance.message.style.display = "block";
        instance.message.style.visibility = "visible";
        instance.cancel.style.display = "block";
        instance.cancel.style.visibility = "visible";
        instance.ok.onclick = function ok_onclick() {
            instance.frame.close();
            createConfirm_callback && createConfirm_callback(true);
            return true;
        }
        instance.cancel.onclick = function cancel_callback() {
            instance.frame.close();
            createConfirm_callback && createConfirm_callback(false);
            return false;
        }
    });
}
