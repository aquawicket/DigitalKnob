//"use strict";

function TestApp(){}
   
TestApp.prototype.init = function init(init_callback){
    //dk.create("DKGui/TestApp.html");
	//dk.create("DKGui/TestApp.css");
    init_callback && init_callback(this)
}

TestApp.prototype.end = function end(){
    //dk.close("DKGui/TestApp.css");
}

TestApp.prototype.create = function create(create_callback) {
    const instance = DKPlugin(TestApp)
    dk.create("DKGui/TestApp.html", function dkcreate_callback(html) {
        if (!html)
            return error("invalid html", create_callback);
        instance.html = html;
        //instance.message = html.querySelector("[TestApp='message']");
        instance.dkframe = DKFrame.prototype.create(instance);
        create_callback && create_callback(instance);
        return instance;
    });
}