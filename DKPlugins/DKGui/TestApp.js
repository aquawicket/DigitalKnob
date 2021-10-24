//"use strict";

console.log("function TestApp(){}")
function TestApp(){}
   
TestApp.prototype.init = function init(init_callback){
	console.log("TestApp.prototype.init")
    //dk.create("DKGui/TestApp.html");
	//dk.create("DKGui/TestApp.css");
    init_callback && init_callback(this)
}

TestApp.prototype.end = function end(){
	console.log("TestApp.prototype.end")
    //dk.close("DKGui/TestApp.css");
}

TestApp.prototype.create = function create(create_callback) {
	console.log("TestApp.prototype.create")
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
