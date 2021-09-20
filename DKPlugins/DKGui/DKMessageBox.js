//"use strict";

function DKMessageBox(){}
   
DKMessageBox.prototype.init = function init(init_callback){
    dk.create("DKGui/DKMessageBox.css");
    init_callback && init_callback(this);
}

DKMessageBox.prototype.end = function end(){
    dk.close("DKGui/DKMessageBox.css");
}

DKMessageBox.prototype.create = function create(create_callback) {
    const instance = DKPlugin(DKMessageBox)
    dk.create("DKGui/DKMessageBox.html", function dkcreate_callback(html) {
        if (!html)
            return error("invalid html", create_callback);
        instance.html = html;
        instance.message = html.querySelector("[dkmessagebox='message']");
        instance.input = html.querySelector("[dkmessagebox='input']");
        instance.cancel = html.querySelector("[dkmessagebox='cancel']");
        instance.ok = html.querySelector("[dkmessagebox='ok']");
        instance.dkframe = DKFrame.prototype.create(instance);
        create_callback && create_callback(instance);
        return instance;
    });
}

DKMessageBox.prototype.createMessage = function createMessage(message, createMessage_callback) {
    const title = "Message"    
    this.create(function create_callback(instance) {
        instance.dkframe.setTitle(title);
        instance.message.innerHTML = message;
        instance.input.style.display = "none";
        instance.message.style.display = "block";
        instance.message.style.visibility = "visible";
        instance.cancel.style.display = "none";
        instance.cancel.style.visibility = "hidden";
        instance.ok.onclick = function ok_onclick() {
            instance.dkframe.close();
            createMessage_callback && createMessage_callback(instance, true);
        }
        createMessage_callback && createMessage_callback(instance);
        return instance;
    });
}

DKMessageBox.prototype.createConfirm = function createConfirm(message, createConfirm_callback) {
    const title = "Confirm?"    
    this.create(function create_callback(instance) {
        instance.dkframe.setTitle(title);
        //instance.html.panel = true;
        //instance.html.setAttribute("panel", "true");
        instance.message.innerHTML = message;
        instance.input.style.display = "none";
        instance.message.style.display = "block";
        instance.message.style.visibility = "visible";
        instance.cancel.style.display = "block";
        instance.cancel.style.visibility = "visible";
        instance.ok.onclick = function ok_onclick() {
            instance.dkframe.close();
            createConfirm_callback && createConfirm_callback(true);
            return true;
        }
        instance.cancel.onclick = function cancel_callback() {
            instance.dkframe.close();
            createConfirm_callback && createConfirm_callback(false);
            return false;
        }
    });
}
