//"use strict";
// @https://console.spec.whatwg.org/
// https://developer.mozilla.org/en-US/docs/Web/API/console
// https://developer.mozilla.org/en-US/docs/Web/API/Console#outputting_text_to_the_console
// https://developer.chrome.com/docs/devtools/console/api/

//dk.console = DKPlugin(DKConsole, "singleton")

function DKConsole(){}
dk.console = DKPlugin(DKConsole)//, "singleton")
dk.xconsole = Object()

//intercept console and reroute it to xconsole and dk.console
//Example:
// If you use console.log, it will now go to the dk.console AND the browser console.
// If you use dk.console.log, it will only log to the dk.console.
// If you use dk.xconsolelog, it will only log the browser console.
// Note: some messages cannot be withheld from the browser console.

<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
DKConsole.prototype.setXConsole = function DKConsole_setXConsole() {
=======
DKConsole.prototype.setXConsole = function DKConsole_setXConsole(){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
    dk.xconsole.assert = console.assert;
    dk.xconsole.clear = console.clear;
    dk.xconsole.context = console.context;
    dk.xconsole.count = console.count;
    dk.xconsole.countReset = console.countReset;
    //dk.xconsole.debug = console.debug;
    dk.xconsole.dir = console.dir;
    dk.xconsole.dirxml = console.dirxml;
    //dk.xconsole.error = console.error;
    dk.xconsole.group = console.group;
    dk.xconsole.groupCollapsed = console.groupCollapsed;
    dk.xconsole.groupEnd = console.groupEnd;
    dk.xconsole.info = console.info;
    //dk.xconsole.log = console.log;
    dk.xconsole.memory = console.memory;
    dk.xconsole.profile = console.profile;
    dk.xconsole.profileEnd = console.profileEnd;
    dk.xconsole.table = console.table;
    dk.xconsole.time = console.time;
    dk.xconsole.timeEnd = console.timeEnd;
    dk.xconsole.timeLog = console.timeLog;
    dk.xconsole.timeStamp = console.timeStamp;
    dk.xconsole.trace = console.trace;
    //dk.xconsole.warn = console.warn;
    dk.xconsole.on = true;

<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    console.assert = function console_assert() {
        dk.xconsole.on && dk.xconsole.assert.apply(this, Array.prototype.slice.call(arguments));
        dk.console.assert && dk.console.assert.apply(this, Array.prototype.slice.call(arguments));
    }
    console.clear = function console_clear() {
        dk.xconsole.on && dk.xconsole.clear.apply(this, Array.prototype.slice.call(arguments));
        dk.console.clear && dk.console.clear.apply(this, Array.prototype.slice.call(arguments));
    }
    console.context = function console_context() {
        dk.xconsole.on && dk.xconsole.context.apply(this, Array.prototype.slice.call(arguments));
        dk.console.context && dk.console.context.apply(this, Array.prototype.slice.call(arguments));
    }
    console.count = function console_count() {
        dk.xconsole.on && dk.xconsole.count.apply(this, Array.prototype.slice.call(arguments));
        dk.console.count && dk.console.count.apply(this, Array.prototype.slice.call(arguments));
    }
    console.countReset = function console_countReset() {
        dk.xconsole.on && dk.xconsole.countReset.apply(this, Array.prototype.slice.call(arguments));
        dk.console.countReset && dk.console.countReset.apply(this, Array.prototype.slice.call(arguments));
    }
    console.debug = function console_debug() {
        dk.xconsole.on && dk.xconsole.debug.apply(this, Array.prototype.slice.call(arguments));
        dk.console.debug && dk.console.debug.apply(this, Array.prototype.slice.call(arguments));
    }
    console.dir = function console_dir() {
        dk.xconsole.on && dk.xconsole.dir.apply(this, Array.prototype.slice.call(arguments));
        dk.console.dir && dk.console.dir.apply(this, Array.prototype.slice.call(arguments));
    }
    console.dirxml = function console_dirxml() {
        dk.xconsole.on && dk.xconsole.dirxml.apply(this, Array.prototype.slice.call(arguments));
        dk.console.dirxml && dk.console.dirxml.apply(this, Array.prototype.slice.call(arguments));
    }
    console.error = function console_error() {
        dk.xconsole.on && dk.xconsole.error.apply(this, Array.prototype.slice.call(arguments));
        dk.console.error && dk.console.error.apply(this, Array.prototype.slice.call(arguments));
    }
    console.group = function console_group() {
        dk.xconsole.on && dk.xconsole.group.apply(this, Array.prototype.slice.call(arguments));
        dk.console.group && dk.console.group.apply(this, Array.prototype.slice.call(arguments));
    }
    console.groupCollapsed = function console_groupCollapsed() {
        dk.xconsole.on && dk.xconsole.groupCollapsed.apply(this, Array.prototype.slice.call(arguments));
        dk.console.groupCollapsed && dk.console.groupCollapsed.apply(this, Array.prototype.slice.call(arguments));
    }
    console.groupEnd = function console_groupEnd() {
        dk.xconsole.on && dk.xconsole.groupEnd.apply(this, Array.prototype.slice.call(arguments));
        dk.console.groupEnd && dk.console.groupEnd.apply(this, Array.prototype.slice.call(arguments));
    }
    console.info = function console_info() {
        dk.xconsole.on && dk.xconsole.info.apply(this, Array.prototype.slice.call(arguments));
        dk.console.info && dk.console.info.apply(this, Array.prototype.slice.call(arguments));
    }
    console.log = function console_log() {
=======
    console.assert = function console_assert(){
        dk.xconsole.on && dk.xconsole.assert.apply(this, Array.prototype.slice.call(arguments));
        dk.console.assert && dk.console.assert.apply(this, Array.prototype.slice.call(arguments));
    }
    console.clear = function console_clear(){
        dk.xconsole.on && dk.xconsole.clear.apply(this, Array.prototype.slice.call(arguments));
        dk.console.clear && dk.console.clear.apply(this, Array.prototype.slice.call(arguments));
    }
    console.context = function console_context(){
        dk.xconsole.on && dk.xconsole.context.apply(this, Array.prototype.slice.call(arguments));
        dk.console.context && dk.console.context.apply(this, Array.prototype.slice.call(arguments));
    }
    console.count = function console_count(){
        dk.xconsole.on && dk.xconsole.count.apply(this, Array.prototype.slice.call(arguments));
        dk.console.count && dk.console.count.apply(this, Array.prototype.slice.call(arguments));
    }
    console.countReset = function console_countReset(){
        dk.xconsole.on && dk.xconsole.countReset.apply(this, Array.prototype.slice.call(arguments));
        dk.console.countReset && dk.console.countReset.apply(this, Array.prototype.slice.call(arguments));
    }
    console.debug = function console_debug(){
        dk.xconsole.on && dk.xconsole.debug.apply(this, Array.prototype.slice.call(arguments));
        dk.console.debug && dk.console.debug.apply(this, Array.prototype.slice.call(arguments));
    }
    console.dir = function console_dir(){
        dk.xconsole.on && dk.xconsole.dir.apply(this, Array.prototype.slice.call(arguments));
        dk.console.dir && dk.console.dir.apply(this, Array.prototype.slice.call(arguments));
    }
    console.dirxml = function console_dirxml(){
        dk.xconsole.on && dk.xconsole.dirxml.apply(this, Array.prototype.slice.call(arguments));
        dk.console.dirxml && dk.console.dirxml.apply(this, Array.prototype.slice.call(arguments));
    }
    console.error = function console_error(){
        dk.xconsole.on && dk.xconsole.error.apply(this, Array.prototype.slice.call(arguments));
        dk.console.error && dk.console.error.apply(this, Array.prototype.slice.call(arguments));
    }
    console.group = function console_group(){
        dk.xconsole.on && dk.xconsole.group.apply(this, Array.prototype.slice.call(arguments));
        dk.console.group && dk.console.group.apply(this, Array.prototype.slice.call(arguments));
    }
    console.groupCollapsed = function console_groupCollapsed(){
        dk.xconsole.on && dk.xconsole.groupCollapsed.apply(this, Array.prototype.slice.call(arguments));
        dk.console.groupCollapsed && dk.console.groupCollapsed.apply(this, Array.prototype.slice.call(arguments));
    }
    console.groupEnd = function console_groupEnd(){
        dk.xconsole.on && dk.xconsole.groupEnd.apply(this, Array.prototype.slice.call(arguments));
        dk.console.groupEnd && dk.console.groupEnd.apply(this, Array.prototype.slice.call(arguments));
    }
    console.info = function console_info(){
        dk.xconsole.on && dk.xconsole.info.apply(this, Array.prototype.slice.call(arguments));
        dk.console.info && dk.console.info.apply(this, Array.prototype.slice.call(arguments));
    }
    console.log = function console_log(){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        dk.xconsole.on && dk.xconsole.info.apply(this, Array.prototype.slice.call(arguments));
        dk.console.log && dk.console.info.apply(this, Array.prototype.slice.call(arguments));
    }
    //console.memory;
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    console.profile = function console_profile() {
        dk.xconsole.on && dk.xconsole.profile.apply(this, Array.prototype.slice.call(arguments));
        dk.console.profile && dk.console.profile.apply(this, Array.prototype.slice.call(arguments));
    }
    console.profileEnd = function console_profileEnd() {
        dk.xconsole.on && dk.xconsole.profileEnd.apply(this, Array.prototype.slice.call(arguments));
        dk.console.profileEnd && dk.console.profileEnd.apply(this, Array.prototype.slice.call(arguments));
    }
    console.table = function console_table() {
        dk.xconsole.on && dk.xconsole.table.apply(this, Array.prototype.slice.call(arguments));
        dk.console.table && dk.console.table.apply(this, Array.prototype.slice.call(arguments));
    }
    console.time = function console_time() {
        dk.xconsole.on && dk.xconsole.time.apply(this, Array.prototype.slice.call(arguments));
        dk.console.time && dk.console.time.apply(this, Array.prototype.slice.call(arguments));
    }
    console.timeEnd = function console_timeEnd() {
        dk.xconsole.on && dk.xconsole.timeEnd.apply(this, Array.prototype.slice.call(arguments));
        dk.console.timeEnd && dk.console.timeEnd.apply(this, Array.prototype.slice.call(arguments));
    }
    console.timeLog = function console_timeLog() {
        dk.xconsole.on && dk.xconsole.timeLog.apply(this, Array.prototype.slice.call(arguments));
        dk.console.timeLog && dk.console.timeLog.apply(this, Array.prototype.slice.call(arguments));
    }
    console.timeStamp = function console_timeStamp() {
        dk.xconsole.on && dk.xconsole.timeStamp.apply(this, Array.prototype.slice.call(arguments));
        dk.console.timeStamp && dk.console.timeStamp.apply(this, Array.prototype.slice.call(arguments));
    }
    console.trace = function console_trace() {
        dk.xconsole.on && dk.xconsole.trace.apply(this, Array.prototype.slice.call(arguments));
        dk.console.trace && dk.console.trace.apply(this, Array.prototype.slice.call(arguments));
    }
    console.warn = function console_warn() {
=======
    console.profile = function console_profile(){
        dk.xconsole.on && dk.xconsole.profile.apply(this, Array.prototype.slice.call(arguments));
        dk.console.profile && dk.console.profile.apply(this, Array.prototype.slice.call(arguments));
    }
    console.profileEnd = function console_profileEnd(){
        dk.xconsole.on && dk.xconsole.profileEnd.apply(this, Array.prototype.slice.call(arguments));
        dk.console.profileEnd && dk.console.profileEnd.apply(this, Array.prototype.slice.call(arguments));
    }
    console.table = function console_table(){
        dk.xconsole.on && dk.xconsole.table.apply(this, Array.prototype.slice.call(arguments));
        dk.console.table && dk.console.table.apply(this, Array.prototype.slice.call(arguments));
    }
    console.time = function console_time(){
        dk.xconsole.on && dk.xconsole.time.apply(this, Array.prototype.slice.call(arguments));
        dk.console.time && dk.console.time.apply(this, Array.prototype.slice.call(arguments));
    }
    console.timeEnd = function console_timeEnd(){
        dk.xconsole.on && dk.xconsole.timeEnd.apply(this, Array.prototype.slice.call(arguments));
        dk.console.timeEnd && dk.console.timeEnd.apply(this, Array.prototype.slice.call(arguments));
    }
    console.timeLog = function console_timeLog(){
        dk.xconsole.on && dk.xconsole.timeLog.apply(this, Array.prototype.slice.call(arguments));
        dk.console.timeLog && dk.console.timeLog.apply(this, Array.prototype.slice.call(arguments));
    }
    console.timeStamp = function console_timeStamp(){
        dk.xconsole.on && dk.xconsole.timeStamp.apply(this, Array.prototype.slice.call(arguments));
        dk.console.timeStamp && dk.console.timeStamp.apply(this, Array.prototype.slice.call(arguments));
    }
    console.trace = function console_trace(){
        dk.xconsole.on && dk.xconsole.trace.apply(this, Array.prototype.slice.call(arguments));
        dk.console.trace && dk.console.trace.apply(this, Array.prototype.slice.call(arguments));
    }
    console.warn = function console_warn(){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        dk.xconsole.on && dk.xconsole.warn.apply(this, Array.prototype.slice.call(arguments));
        dk.console.warn && dk.console.warn.apply(this, Array.prototype.slice.call(arguments));
    }
}

<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
DKConsole.prototype.init = function DKConsole_init() {
=======
DKConsole.prototype.init = function DKConsole_init(){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
	console.log("DKConsole.prototype.init")
    dk.create("DKGui/DKConsole.css");
}

<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
DKConsole.prototype.end = function DKConsole_end() {
    dk.close("DKGui/DKConsole.css");
}

DKConsole.prototype.create = function DKConsole_create(parent, top, bottom, left, right, width, height) {
=======
DKConsole.prototype.end = function DKConsole_end(){
    dk.close("DKGui/DKConsole.css");
}

DKConsole.prototype.create = function DKConsole_create(parent, top, bottom, left, right, width, height){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
											
    dk.console.limit = 200;

	//NOTE: A lot of these elements were created JSON style and DUKTAPE wasn't working.
	//Most of the problem was stylesheets not having any effect, so thi is a temporary fix
	//So I commented out the old format and wore them directly under in a more compatable standard
	//Everything I recoded will be marked with //## USE_CSS ##    or     //## NO_CSS ##
	USE_CSS = false;

	//## USE_CSS ##
	if(USE_CSS){
		dk.console.container = dk.gui.createTag("div", parent, {
			style: {
				top: top,
				bottom: bottom,
				left: left,
				right: right,
				width: width,
				height: height
			},
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
			oncontextmenu: function container_oncontextmenu(event) {
				event.preventDefault();
				DKPlugin("DKGui/DKMenu.js", function(DKClass) {
					// const dkmenu = DKClass.prototype.create();
					dkmenu.addItem("Clear console", function DKMenu_Clear() {
=======
			oncontextmenu: function container_oncontextmenu(event){
				event.preventDefault();
				DKPlugin("DKGui/DKMenu.js", function(DKClass){
					// const dkmenu = DKClass.prototype.create();
					dkmenu.addItem("Clear console", function DKMenu_Clear(){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
						dk.console.clear();
					});
				});
			}
		});
		dk.console.container.setAttribute("dk_console", "container")
	}
	else{
		dk.console.container = document.createElement("div")
		dk.console.container.setAttribute("dk_console", "container")
		//dk.console.container.style.position = "absolute"; //+++ addded
		dk.console.container.style.padding = "0rem"       //+++ addded
		dk.console.container.style.margin = "0rem"        //+++ addded
		dk.console.container.style.top = top
		dk.console.container.style.bottom = bottom
		dk.console.container.style.left = left
		dk.console.container.style.right = right
		dk.console.container.style.width = width
		dk.console.container.style.height = height
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
		dk.console.container.oncontextmenu = function container_oncontextmenu(event) {
			event.preventDefault();
			DKPlugin("DKGui/DKMenu.js", function(DKClass) {
				const dkmenu = DKClass.prototype.create();
				dkmenu.addItem("Clear console", function DKMenu_Clear() {
=======
		dk.console.container.oncontextmenu = function container_oncontextmenu(event){
			event.preventDefault();
			DKPlugin("DKGui/DKMenu.js", function(DKClass){
				const dkmenu = DKClass.prototype.create();
				dkmenu.addItem("Clear console", function DKMenu_Clear(){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
						dk.console.clear();
				});
			});
		}
		parent.appendChild(dk.console.container)
	}
	
	
	
	//## USE_CSS ##
	if(USE_CSS){
		dk.console.toolbar = dk.gui.createTag("div", dk.console.container, {});
		dk.console.toolbar.setAttribute("dk_console", "toolbar")
	}
	else{
		dk.console.toolbar = document.createElement("div")
		dk.console.toolbar.setAttribute("dk_console", "toolbar");
		dk.console.toolbar.style.position = "absolute"               //+++ addded
		dk.console.toolbar.style.width = "100%"                      //+++ addded       
		dk.console.toolbar.style.height = "20rem"                    //+++ addded 
		dk.console.toolbar.style.boxSizing = "border-box"            //+++ addded
		dk.console.toolbar.style.borderStyle = "solid"               //+++ addded
		dk.console.toolbar.style.borderWidth = ".1rem"               //+++ addded
		dk.console.toolbar.style.borderLeftWidth = "0rem"            //+++ addded
		dk.console.toolbar.style.borderRightWidth = "0rem"           //+++ addded
		dk.console.toolbar.style.borderColor = "rgba(100,100,100,1)" //+++ addded
		dk.console.toolbar.style.backgroundColor = "rgb(45,45,45)"   //+++ addded
		dk.console.container.appendChild(dk.console.toolbar)
	}
	
	
	
	//## USE_CSS ##
	if(USE_CSS){
		dk.console.logDiv = dk.gui.createTag("div", dk.console.container, {});
		dk.console.logDiv.setAttribute("dk_console", "logDiv");
	}
	else{
		dk.console.logDiv = document.createElement("div")
		dk.console.logDiv.setAttribute("dk_console", "logDiv")
		dk.console.logDiv.style.position = "absolute"               //+++ addded
		dk.console.logDiv.style.padding = "0rem"                    //+++ addded
		dk.console.logDiv.style.fontSize = "10rem"                  //+++ addded
		dk.console.logDiv.style.backgroundColor = "rgb(36,36,36)"   //+++ addded
		dk.console.logDiv.style.color = "white"                     //+++ addded
		/*font-color = "white"*/                                    //+++ addded
		dk.console.logDiv.style.top = "20rem"                       //+++ addded
		dk.console.logDiv.style.bottom = "0rem"                     //+++ addded
		dk.console.logDiv.style.left = "0rem"                       //+++ addded
		dk.console.logDiv.style.right = "0rem"                      //+++ addded
		dk.console.logDiv.style.visibility = "visible"              //+++ addded
		dk.console.logDiv.style.overflow = "auto"                   //+++ addded
		dk.console.container.appendChild(dk.console.logDiv)
	}



	//## USE_CSS ##
	if(USE_CSS){
		dk.console.commandDiv = dk.gui.createTag("div", dk.console.logDiv, {});
		dk.console.commandDiv.setAttribute("dk_console", "commandDiv");
	}
	else{
		dk.console.commandDiv = document.createElement("div")
		dk.console.commandDiv.setAttribute("dk_console", "commandDiv");
		//dk.console.commandDiv.style.position = "absolute"          //+++ addded
		dk.console.commandDiv.style.width = "100%"                 //+++ addded  
		dk.console.commandDiv.style.height = "30rem"               //+++ addded     
		dk.console.commandDiv.style.whiteSpace = "pre-wrap"        //+++ addded     
		dk.console.commandDiv.style.boxSizing = "border-box"       //+++ addded   
		dk.console.commandDiv.style.padding = "0rem"               //+++ addded      
		dk.console.commandDiv.style.paddingLeft = "6rem"           //+++ addded      
		dk.console.logDiv.appendChild(dk.console.commandDiv)            
	}




	//## USE_CSS ##
	if(USE_CSS){
		dk.console.command = dk.gui.createTag("input", dk.console.commandDiv, {
			type: "text",
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
			onkeydown: function command_onkeydown(event) {
				if (event.code === "Enter") {
					if (event.currentTarget.value === "clear" || event.currentTarget.value === "cls") {
=======
			onkeydown: function command_onkeydown(event){
				if (event.code === "Enter"){
					if (event.currentTarget.value === "clear" || event.currentTarget.value === "cls"){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
						dk.console.clear();
						event.currentTarget.value = "";
						return;
					}
					//console.debug("RUN Javascript -> " + event.currentTarget.value);
					try {
						eval(event.currentTarget.value);
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
					} catch (x) {
=======
					} catch (x){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
						console.error("eval failed");
					}
					event.currentTarget.value = "";
				}
			}
		}).setAttribute("dk_console", "command");
	}
	else {
		dk.console.command = document.createElement("input")
		dk.console.command.type = "text";
		dk.console.command.setAttribute("dk_console", "command");
		dk.console.command.style.position = "absolute"
		dk.console.command.style.left = "17rem"
		dk.console.command.style.fontFamily = "Consolas, Lucinda, Console, Courier New, monospace;"
		dk.console.command.style.fontSize = "10rem"
		dk.console.command.style.width = "95%"
		dk.console.command.style.backgroundColor = "rgba(0,0,0,0)"
		dk.console.command.style.borderColor = "rgba(0,0,0,0)"
		dk.console.command.style.color = "white"
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
		dk.console.command.onkeydown = function command_onkeydown(event) {
			if (event.code === "Enter") {
				if (event.currentTarget.value === "clear" || event.currentTarget.value === "cls") {
=======
		dk.console.command.onkeydown = function command_onkeydown(event){
			if (event.code === "Enter"){
				if (event.currentTarget.value === "clear" || event.currentTarget.value === "cls"){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
					dk.console.clear();
					event.currentTarget.value = "";
					return;
				}
				//console.debug("RUN Javascript -> " + event.currentTarget.value);
				try {
					eval(event.currentTarget.value);
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
				} catch (x) {
=======
				} catch (x){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
					console.error("eval failed");
				}
				event.currentTarget.value = "";
			}
		}
		dk.console.commandDiv.appendChild(dk.console.command);
	}

	

    

    //FIXME: initiating before dk.console.commandDiv
    /*
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    dk.console.logDiv.onclick = function() {
        setTimeout(function() {
=======
    dk.console.logDiv.onclick = function(){
        setTimeout(function(){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            dk.console.command.focus();
        }, 100);
    }
    */




    //## USE_CSS ##
	if(USE_CSS){
		dk.gui.createTag("img", dk.console.commandDiv, {
			src: "DKGui/cmndArrow.png",
		}).setAttribute("dk_console", "cmnd");
	}
	else{
		const commandDivImage = document.createElement("img")
		commandDivImage.src = "DKGui/cmndArrow.png"          
		commandDivImage.setAttribute("dk_console", "cmnd")
		commandDivImage.style.position = "relative"             //+++added
		commandDivImage.style.top = "3rem"                      //+++added  
		commandDivImage.style.height = "7rem"                   //+++added 
		dk.console.commandDiv.appendChild(commandDivImage)
	}


<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    function _toArray(arr) {
        return _arrayWithHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray(arr) || _nonIterableRest();
    }
    function _nonIterableRest() {
        throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.");
    }
    function _unsupportedIterableToArray(o, minLen) {
=======
    function _toArray(arr){
        return _arrayWithHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray(arr) || _nonIterableRest();
    }
    function _nonIterableRest(){
        throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.");
    }
    function _unsupportedIterableToArray(o, minLen){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        if (!o)
            return;
        if (typeof o === "string")
            return _arrayLikeToArray(o, minLen);
        var n = Object.prototype.toString.call(o).slice(8, -1);
        if (n === "Object" && o.constructor)
            n = o.constructor.name;
        if (n === "Map" || n === "Set")
            return Array.from(o);
        if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n))
            return _arrayLikeToArray(o, minLen);
    }
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    function _arrayLikeToArray(arr, len) {
=======
    function _arrayLikeToArray(arr, len){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        if (len == null || len > arr.length)
            len = arr.length;
        for (var i = 0, arr2 = new Array(len); i < len; i++){
            arr2[i] = arr[i];
		}
        return arr2;
    }
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    function _iterableToArray(iter) {
        if (typeof Symbol !== "undefined" && iter[Symbol.iterator] != null || iter["@@iterator"] != null)
            return Array.from(iter);
    }
    function _arrayWithHoles(arr) {
=======
    function _iterableToArray(iter){
        if (typeof Symbol !== "undefined" && iter[Symbol.iterator] != null || iter["@@iterator"] != null)
            return Array.from(iter);
    }
    function _arrayWithHoles(arr){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        if (Array.isArray(arr))
            return arr;
    }
    // https://console.spec.whatwg.org/#logger
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.Logger = function DKConsole_Logger(logLevel, args) {
=======
    DKConsole.prototype.Logger = function DKConsole_Logger(logLevel, args){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        if (!args)
            return;
        //const [first,...rest] = args;
        var _args = _toArray(args)
          , first = _args[0]
          , rest = _args.slice(1);

<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (!rest) {
=======
        if (!rest){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            dk.console.Printer(legLevel, first);
            return;
        }
        if (first === "undefined")
            first = "undefined"
        //return error("first invalid: "+first);
        if (first.includes && !first.includes("%"))
            dk.console.Printer(logLevel, args);
        else
            dk.console.Printer(logLevel, dk.console.Formatter(args));
        return;
    }

    // https://console.spec.whatwg.org/#formatter
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.Formatter = function DKConsole_Formatter(args) {
=======
    DKConsole.prototype.Formatter = function DKConsole_Formatter(args){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        if (!args.length)
            return;
        var target = args[0];
        if (!target.indexOf)
            return args;
        const current = args[1];
        const index = target.indexOf("%");
        if (index <= -1)
            return args;
        const specifier = target.substring(index, index + 2);
        var converted = undefined;
        if (specifier === "%s")
            converted = current.toString();
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (specifier === "%d" || specifier === "%i") {
=======
        if (specifier === "%d" || specifier === "%i"){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            if (typeof current === "symbol")
                converted = NaN;
            else
                converted = parseInt(current, 10);
        }
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (specifier === "%f") {
=======
        if (specifier === "%f"){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            if (typeof current === "symbol")
                converted = NaN;
            else
                converted = parseFloat(current, 10);
        }
        // 4. If specifier is %o, optionally let converted be current with optimally useful formatting applied.
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (specifier === "%o") {// TODO
        }
        // 5. If specifier is %O, optionally let converted be current with generic JavaScript object formatting applied.
        if (specifier === "%O") {// TODO
        }
        // 6. TODO: process %c
        if (specifier === "%c") {
=======
        if (specifier === "%o"){// TODO
        }
        // 5. If specifier is %O, optionally let converted be current with generic JavaScript object formatting applied.
        if (specifier === "%O"){// TODO
        }
        // 6. TODO: process %c
        if (specifier === "%c"){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            if (typeof current === "symbol")
                converted = NaN;
            if (typeof current === "undefined")
                converted = "<a style='undefined'>";
            else
                converted = "<a style='" + current.toString() + "'>";
        }
        if (converted)
            target = target.replace(specifier, converted);
        const result = [];
        result.push(target);
        var n = 2;
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        while (args[n]) {
=======
        while (args[n]){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            result.push(args[n]);
            n++;
        }
        const index2 = target.indexOf("%");
        if (index2 <= -1)
            return result;
        if (result.length === 1)
            return result;
        return dk.console.Formatter(result);
    }

    // https://console.spec.whatwg.org/#printer
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.Printer = function DKConsole_Printer(logLevel, args) {
=======
    DKConsole.prototype.Printer = function DKConsole_Printer(logLevel, args){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        //const _args = dk.console.ColorChromeConsole(arguments);
        if ((dk.console.logDiv.scrollHeight - dk.console.logDiv.scrollTop) < (dk.console.logDiv.offsetHeight + 1))
            dk.console.logDiv.scroll = true;
        else
            dk.console.logDiv.scroll = false;
        const msgDiv = document.createElement("div");
        msgDiv.setAttribute("dk_console", "msgDiv");
		
		//## NO_CSS ##
		if(!USE_CSS){
			//msgDiv.style.position = "absolute";           //+++ addded
			msgDiv.style.width = "100%"                   //+++ addded 
			msgDiv.style.fontSize = "10rem"               //+++ addded
			msgDiv.style.fontFamily = "Consolas, Lucinda, Console, Courier New, monospace"   //+++addded
			msgDiv.style.whiteSpace = "pre-wrap"             //+++addded
			msgDiv.style.boxSizing = "border-box"            //+++addded
			msgDiv.style.padding = "2rem"                    //+++addded
			msgDiv.style.paddingLeft = "20rem"               //+++addded
			msgDiv.style.borderStyle = "solid"               //+++addded
			msgDiv.style.borderWidth = ".1rem"               //+++addded
			msgDiv.style.borderTopWidth = "0rem"             //+++addded
			msgDiv.style.borderLeftWidth = "0rem"            //+++addded
			msgDiv.style.backgroundColor = "rgb(36,36,36)"   //+++addded
			msgDiv.style.borderColor = "rgb(58,58,58)"       //+++addded
		}
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (logLevel !== "group" && logLevel !== "groupCollapsed" && dk.console.currentGroup) {
=======
        if (logLevel !== "group" && logLevel !== "groupCollapsed" && dk.console.currentGroup){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            msgDiv.setAttribute("group", dk.console.currentGroup.id);
            msgDiv.style.display = dk.console.currentGroup.display;
        }
        
		
		
		
		//## USE_CSS ##
		if(USE_CSS){
			const magIcon = dk.gui.createTag("div", msgDiv, {
				style: {
					position: "absolute",
					left: "6rem",
					width: "12rem",
					height: "12rem",
				}
			})
		} 
		else{
			const magIcon = document.createElement("div")
			magIcon.style.position = "absolute"
			magIcon.style.left = "6rem"
			magIcon.style.width = "12rem"
			magIcon.style.height = "12rem"
			msgDiv.appendChild(magIcon)
		}

        const msgSpan = document.createElement("span");
        msgSpan.setAttribute("dk_console", "msgSpan");
		
		//## NO_CSS ##
		if( !USE_CSS ){
			msgSpan.style.position = "absolute"
			msgSpan.style.color = "rgb(213,213,213)"
		}
		
		
        //If the message is the same as the last, just increase a count next to the original.
        const lastMsgDiv = dk.console.logDiv.lastChild.previousSibling;
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (lastMsgDiv) {
            const lastMsgSpan = lastMsgDiv.firstChild.nextSibling;
            if ((arguments[1] == lastMsgSpan.innerText) || (arguments[1].includes && arguments[1].includes(lastMsgSpan.innerText))) {
                const lastMsgIcon = lastMsgDiv.firstChild;
                if (!lastMsgIcon.childElementCount) {
=======
        if (lastMsgDiv){
            const lastMsgSpan = lastMsgDiv.firstChild.nextSibling;
            if ((arguments[1] == lastMsgSpan.innerText) || (arguments[1].includes && arguments[1].includes(lastMsgSpan.innerText))){
                const lastMsgIcon = lastMsgDiv.firstChild;
                if (!lastMsgIcon.childElementCount){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
					
					
					
					//## USE_CSS ##
					if(USE_CSS){
						dk.gui.createTag("img", lastMsgIcon, {
							src: "DKGui/circle.png",
							style: {
								height: "12rem",
								verticalAlign: "middle"
							}
						});
					}
					else{
						const lastMsgImg = document.createElement("img")
						lastMsgImg.src = "DKGui/circle.png"
						lastMsgImg.style.position = "absolute"        //+++ added
						lastMsgImg.style.height = "12rem"           
						lastMsgImg.style.verticalAlign = "middle"
						lastMsgIcon.appendChild(lastMsgImg)
					}
					
					
					
					//## USE_CSS ##
					if(USE_CSS){
						const count = dk.gui.createTag("div", lastMsgIcon, {
							style: {
								position: "absolute",
								top: "50%",
								left: "50%",
								transform: "translate(-50%, -50%)",
								color: "black"
							},
							innerHTML: 2
						});
					}
					else{
						const count = document.createElement("div")
						count.style.position = "absolute"
						count.style.top = "50%"
						count.style.left = "50%"
						count.style.transform = "translate(-50%, -50%)"
						count.style.color = "black"
						count.innerHTML = 2
						lastMsgIcon.appendChild(count)
					}
					
					
					
                } else {
                    const total = (parseInt(lastMsgIcon.firstChild.nextSibling.innerHTML) + 1);
                    lastMsgIcon.firstChild.nextSibling.innerHTML = total.toString();
                }
                return;
            }
        }

<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (arguments[1] && arguments[1].includes && arguments[1].includes("<anonymous>")) {
            arguments[1] = arguments[1].replace("<anonymous>", "&lt;anonymous&gt;");
        }
        if (logLevel === "group" || logLevel === "groupCollapsed") {
=======
        if (arguments[1] && arguments[1].includes && arguments[1].includes("<anonymous>")){
            arguments[1] = arguments[1].replace("<anonymous>", "&lt;anonymous&gt;");
        }
        if (logLevel === "group" || logLevel === "groupCollapsed"){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            const group = arguments[1];
            if (arguments.length === 3)
                logLevel = arguments[2][1];
			
			
			
			//## USE_CSS ##
			if(USE_CSS){
				const groupArrow = dk.gui.createTag("img", msgSpan, {
					src: "DKGui/groupArrow2.png",
					style: {
						height: "6rem",
						paddingRight: "4rem"//TODO: This should be multiplied by the number of open groups
						// This should effect all other console entries as well
					}
				});
			}
			else{
				const groupArrow = document.createElement("img")
				msgSpan.src = "DKGui/groupArrow2.png"
				msgSpan.style.position = "absolute"        //+++ added
				msgSpan.style.height = "6rem"
				msgSpan.style.paddingRight = "4rem"
				msgSpan.appendChild(groupArrow)
			}
			
			
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
            if (group.display === "none") {
                groupArrow.setAttribute("src", "DKGui/groupArrow1.png");
            }
            dk.gui.createTag("a", msgSpan, {}).innerHTML = group.label;
            msgDiv.onclick = function() {
                if (group.display === "block") {
=======
            if (group.display === "none"){
                groupArrow.setAttribute("src", "DKGui/groupArrow1.png");
            }
            dk.gui.createTag("a", msgSpan, {}).innerHTML = group.label;
            msgDiv.onclick = function(){
                if (group.display === "block"){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
                    groupArrow.setAttribute("src", "DKGui/groupArrow1.png");
                    group.display = "none";
                } else {
                    groupArrow.setAttribute("src", "DKGui/groupArrow2.png");
                    group.display = "block";
                }
                const elements = dk.console.logDiv.querySelectorAll("[group='" + group.id + "']");
                for (var n = 0; n < elements.length; n++){
                    elements[n].style.display = group.display;
				}
            }

        } else {
            msgSpan.innerHTML = arguments[1];
        }

<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (logLevel === "error") {
=======
        if (logLevel === "error"){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
			msgDiv.setAttribute("dk_console", "msgDivError");
			msgSpan.setAttribute("dk_console", "msgSpanError");
			//## NO_CSS ##
			if(!USE_CSS){
				msgDiv.style.position = "absolute"
				msgDiv.style.backgroundColor = "rgb(41,0,0)"
				msgDiv.style.borderColor = "rgb(92,0,0)"
				msgSpan.style.color = "rgb(255,128,128)"
			}
        }
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (logLevel === "warn") {
=======
        if (logLevel === "warn"){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            msgDiv.setAttribute("dk_console", "msgDivWarn");
			msgSpan.setAttribute("dk_console", "msgSpanWarn");
			//## NO_CSS ##
			if(!USE_CSS){
				msgDiv.style.backgroundColor = "rgb(51,43,0)"
				msgDiv.style.borderColor = "rgb(102,85,0)"
				msgSpan.style.color = "rgb(255,221,158)"
			}
        }
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (logLevel === "debug") {
=======
        if (logLevel === "debug"){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            msgDiv.setAttribute("dk_console", "msgDivDebug");
			msgSpan.setAttribute("dk_console", "msgSpanDebug");
			//## NO_CSS ##
			if(!USE_CSS){
				msgDiv.style.backgroundColor = "rgb(36,36,36)"
				msgDiv.style.borderColor = "rgb(58,58,58)"
				msgSpan.style.color = "rgb(77,136,255)"
			}
        }
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (logLevel === "green") {
=======
        if (logLevel === "green"){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            msgDiv.setAttribute("dk_console", "msgDivGreen");
			msgSpan.setAttribute("dk_console", "msgSpanGreen");
			//## NO_CSS ##
			if(!USE_CSS){
				msgDiv.style.backgroundColor = "rgb(0,41,0)"
				msgDiv.style.borderColor = "rgb(0,92,0)"
				msgSpan.style.color = "rgb(128,255,128)"
			}
        }

        dk.console.logDiv.appendChild(msgDiv);
        dk.console.logDiv.appendChild(dk.console.commandDiv);
        msgDiv.appendChild(msgSpan);

        //Limit the number of stored lines
        if (dk.console.logDiv.childElementCount > dk.console.limit)
            dk.console.logDiv.removeChild(dk.console.logDiv.firstChild);
		
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
		setTimeout(function() {
=======
		setTimeout(function(){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
			dk.console.logDiv.scrollTop = (dk.console.logDiv.scrollHeight - dk.console.logDiv.style.height);
		}, 0);

        return msgDiv.innerHTML;
    }

    // https://console.spec.whatwg.org/#assert
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.assert = function DKConsole_assert(condition) {
        for (var _len = arguments.length, data = new Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
=======
    DKConsole.prototype.assert = function DKConsole_assert(condition){
        for (var _len = arguments.length, data = new Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            data[_key - 1] = arguments[_key];
        }

        !condition && (condition = false);
        if (condition)
            return;
        // 2. Let message be a string without any formatting specifiers indicating generically an assertion failure (such as "Assertion failed").

        var message = "Assertion failed";
        // 3. If data is empty, append message to data.

<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (!data) {
=======
        if (!data){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            data = message;
        } else {
            // 4. Otherwise: 
            //     1. Let first be data[0].
            var first = data[0];
            //     2. If Type(first) is not String, then prepend message to data.

            if (typeof first !== "String")
                data = message + "\n" + data;
            else {//     3. Otherwise:
            //        1. Let concat be the concatenation of message, U+003A (:), U+0020 SPACE, and first.
            //        2. Set data[0] to concat.
            }
            //     5. Perform Logger("assert", data).

            dk.console.Logger("assert", data);
        }
    }

    // https://console.spec.whatwg.org/#clear
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.clear = function DKConsole_clear() {
=======
    DKConsole.prototype.clear = function DKConsole_clear(){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        // 1. Empty the appropriate group stack.
        dk.console.groupStack = [];
        // 2. If possible for the environment, clear the console. (Otherwise, do nothing.)
        const backup = dk.console.commandDiv;
        dk.console.logDiv.innerHTML = "";
        dk.console.logDiv.appendChild(backup);
    }

    //dk.console.context;

    // https://console.spec.whatwg.org/#count
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.count = function DKConsole_count(label) {
=======
    DKConsole.prototype.count = function DKConsole_count(label){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        !label && (label = "default");
        // 1. Let map be the associated count map.
        !dk.console.map && (dk.console.map = new Object);
        // 2. If map[label] exists, set map[label] to map[label] + 1.
        if (dk.console.map[label])
            dk.console.map[label] = dk.console.map[label] + 1;
            // 3. Otherwise, set map[label] to 1.
        else
            dk.console.map[label] = 1;
        // 4. Let concat be the concatenation of label, U+003A (:), U+0020 SPACE, and ToString(map[label]).
        const concat = label + ":" + " " + toString(dk.console.map[label]);
        // 5. Perform Logger("count", concat).
        dk.console.Logger("count", concat);
    }

    // https://console.spec.whatwg.org/#countReset
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.countReset = function DKConsole_countReset(label) {
=======
    DKConsole.prototype.countReset = function DKConsole_countReset(label){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        !label && (label = "default");
        // 1. Let map be the associated count map.
        !dk.console.map && (dk.console.map = new Object);
        // 2. If map[label] exists, set map[label] to 0.
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        if (dk.console.map[label]) {
=======
        if (dk.console.map[label]){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            dk.console.map[label] = 0;
        }// 3. Otherwise:
        else {
            // 1. Let message be a string without any formatting specifiers indicating generically that the given label does not have an associated count.
            // 2. Perform Logger("countReset", message); 
            dk.console.Logger("countReset", message);
        }
    }

    // https://console.spec.whatwg.org/#debug
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.debug = function DKConsole_debug() {
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++) {
=======
    DKConsole.prototype.debug = function DKConsole_debug(){
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            data[_key] = arguments[_key];
        }

        dk.console.Logger("debug", data);
    }

    // https://console.spec.whatwg.org/#dir
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.dir = function DKConsole_dir(item, options) {// 1. Let object be item with generic JavaScript object formatting applied.
=======
    DKConsole.prototype.dir = function DKConsole_dir(item, options){// 1. Let object be item with generic JavaScript object formatting applied.
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
    // 2. Perform Printer("dir", object, options).
    }

    // https://console.spec.whatwg.org/#dirxml
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.dirxml = function DKConsole_dirxml() {// 1. Let finalList be a new list, initially empty.
=======
    DKConsole.prototype.dirxml = function DKConsole_dirxml(){// 1. Let finalList be a new list, initially empty.
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
    // 2. For each item of data:
    //     1. Let converted be a DOM tree representation of item if possible; otherwise let converted be item with optimally useful formatting applied.
    //     2. Append converted to finalList.
    // 3. Perform Logger("dirxml", finalList).
    }

    // https://console.spec.whatwg.org/#error
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.error = function DKConsole_error() {
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++) {
=======
    DKConsole.prototype.error = function DKConsole_error(){
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            data[_key] = arguments[_key];
        }
        if (!data)
            return warn("data invalid");
        dk.console.groupCollapsed(data, "error");
        const stack = dk.trace.stackToConsoleString("", "console.error");
        dk.console.Logger("error", stack);
        dk.console.groupEnd();
    }

    //////  GROUP STACK
    dk.console.groupStack = [];

    // https://console.spec.whatwg.org/#group
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.group = function DKConsole_group() {
        var n = 0;
        while (dk.console.logDiv.querySelector("[group='" + n + "']")) {
=======
    DKConsole.prototype.group = function DKConsole_group(){
        var n = 0;
        while (dk.console.logDiv.querySelector("[group='" + n + "']")){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            n++;
        }
        // 1. Let group be a new group.
        var group = {
            label: "dk.console.group",
            display: "block",
            id: n
        };
        // 2. If data is not empty, let groupLabel be the result of Formatter(data). Otherwise, let groupLabel be an implementation-chosen label representing a group.
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++) {
=======
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            data[_key] = arguments[_key];
        }
        if (data)
            group.label = dk.console.Formatter(data);
        // 3. Incorporate groupLabel as a label for group.
        dk.console.currentGroup = group;
        // 4. Optionally, if the environment supports interactive groups, group should be expanded by default.
        // 5. Perform Printer("group", group).
        dk.console.Printer("group", group, data);
        // 6. Push group onto the appropriate group stack.
        dk.console.groupStack.push(group);
    }

    // https://console.spec.whatwg.org/#groupcollapsed
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.groupCollapsed = function DKConsole_groupCollapsed() {
        var n = 0;
        while (dk.console.logDiv.querySelector("[group='" + n + "']")) {
=======
    DKConsole.prototype.groupCollapsed = function DKConsole_groupCollapsed(){
        var n = 0;
        while (dk.console.logDiv.querySelector("[group='" + n + "']")){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            n++;
        }
        // 1. Let group be a new group.
        var group = {
            label: "dk.console.group",
            display: "none",
            id: n
        };
        // 2. If data is not empty, let groupLabel be the result of Formatter(data). Otherwise, let groupLabel be an implementation-chosen label representing a group.
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++) {
=======
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            data[_key] = arguments[_key];
        }
        if (data)
            group.label = dk.console.Formatter(data);
        // 3. Incorporate groupLabel as a label for group.
        dk.console.currentGroup = group;
        // 4. Optionally, if the environment supports interactive groups, group should be expanded by default.
        // 5. Perform Printer("group", group).
        dk.console.Printer("groupCollapsed", group, data);
        // 6. Push group onto the appropriate group stack.
        dk.console.groupStack.push(group);
    }

    // https://console.spec.whatwg.org/#groupend
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.groupEnd = function DKConsole_groupEnd() {
=======
    DKConsole.prototype.groupEnd = function DKConsole_groupEnd(){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        // Pop the last group from the group stack.
        dk.console.groupStack.pop();
        if (dk.console.groupStack.length)
            dk.console.currentGroup = dk.console.groupStack[dk.console.groupStack.length - 1];
        else
            dk.console.currentGroup = null;
    }

    // https://console.spec.whatwg.org/#info
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.info = function DKConsole_info() {
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++) {
=======
    DKConsole.prototype.info = function DKConsole_info(){
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            data[_key] = arguments[_key];
        }
        dk.console.Logger("info", data);
    }

    // https://console.spec.whatwg.org/#log
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.log = function DKConsole_log() {
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++) {
=======
    DKConsole.prototype.log = function DKConsole_log(){
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            data[_key] = arguments[_key];
        }
        dk.console.Logger("log", data);
    }

    //dk.console.memory;
    //dk.console.profile;
    //dk.console.profileEnd;

    // https://console.spec.whatwg.org/#table
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.table = function DKConsole_table(tabularData, properties) {// Try to construct a table with the columns of the properties of tabularData (or use properties) and rows of tabularData 
=======
    DKConsole.prototype.table = function DKConsole_table(tabularData, properties){// Try to construct a table with the columns of the properties of tabularData (or use properties) and rows of tabularData 
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
    // and log it with a logLevel of "log". Fall back to just logging the argument if it can be parsed as tabular.
    }

    // https://console.spec.whatwg.org/#time
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.time = function DKConsole_time(label) {
=======
    DKConsole.prototype.time = function DKConsole_time(label){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        !label && (label = "default");
        // 1. If the associated timer table contains an entry with key label, return, optionally reporting a warning to the console indicating that a timer with label label has already been started.
        // 2. Otherwise, set the value of the entry with key label in the associated timer table to the current time.
    }

    // https://console.spec.whatwg.org/#timeEnd
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.timeEnd = function DKConsole_timeEnd(label) {
=======
    DKConsole.prototype.timeEnd = function DKConsole_timeEnd(label){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        !label && (label = "default");
        // 1. Let timerTable be the associated timer table.
        // 2. Let startTime be timerTable[label].
        // 3. Remove timerTable[label].
        // 4. Let duration be a string representing the difference between the current time and startTime, in an implementation-defined format.
        // 5. Let concat be the concatenation of label, U+003A (:), U+0020 SPACE, and duration.
        // 6. Perform Printer("timeEnd", concat).
    }

    // https://console.spec.whatwg.org/#timeLog
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.timeLog = function DKConsole_timeLog(label) {
=======
    DKConsole.prototype.timeLog = function DKConsole_timeLog(label){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        !label && (label = "default");
        // 1. Let timerTable be the associated timer table.
        // 2. Let startTime be timerTable[label].
        // 3. Let duration be a string representing the difference between the current time and startTime, in an implementation-defined format.
        // 4. Let concat be the concatenation of label, U+003A (:), U+0020 SPACE, and duration.
        // 5. Prepend concat to data.
        // 6. Perform Printer("timeLog", data).
    }

    //DKConsole.prototype.timeStamp;

    // https://console.spec.whatwg.org/#trace
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.trace = function DKConsole_trace() {
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++) {
=======
    DKConsole.prototype.trace = function DKConsole_trace(){
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            data[_key] = arguments[_key];
        }
        // 1. Let trace be some implementation-specific, potentially-interactive representation of the callstack from where this function was called.
        // 2. Optionally, let formattedData be the result of Formatter(data), and incorporate formattedData as a label for trace.
        // 3. Perform Printer("trace", trace).
        if (!data)
            return warn("data invalid");
        dk.console.group(data);
        var stack = dk.trace.stackToConsoleString("", "console.trace");
        dk.console.Logger("info", stack);
        dk.console.groupEnd();
    }

    // https://console.spec.whatwg.org/#warn
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
    DKConsole.prototype.warn = function DKConsole_warn() {
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++) {
=======
    DKConsole.prototype.warn = function DKConsole_warn(){
        for (var _len = arguments.length, data = new Array(_len), _key = 0; _key < _len; _key++){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            data[_key] = arguments[_key];
        }
        if (!data)
            return warn("data invalid");
        dk.console.groupCollapsed(data, "warn");
        var stack = dk.trace.stackToConsoleString("", "console.warn");
        dk.console.Logger("warn", stack);
        dk.console.groupEnd();
    }

    dk.console.setXConsole();
	dk.console.record = dk.x.record
	delete dk.x;
	//restore the record of messages from the program beginning
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
	for (var n = 0; n < dk.console.record.length; n++) {
=======
	for (var n = 0; n < dk.console.record.length; n++){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
		const lvl = Object.keys(dk.console.record[n])[0];
		const msg = dk.console.record[n][lvl];
		dk.console[lvl](msg);
	}
	delete dk.console.record;
	console.log("DKConsole.prototype.create() -> return")
    return dk.console.container;
}

<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
DKConsole.prototype.SpanFilter = function DKConsole_SpanFilter(args) {
    var argArray = [];
    if (args.length) {
=======
DKConsole.prototype.SpanFilter = function DKConsole_SpanFilter(args){
    var argArray = [];
    if (args.length){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
        const startTagRe = /<span\s+style=(['"])([^'"]*)\1\s*>/gi;
        const endTagRe = /<\/span>/gi;
        var reResultArray;
        if (typeof args[0].replace !== "function")
            return args;
        argArray.push(args[0].replace(startTagRe, '%c').replace(endTagRe, '%c'));
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
        while (reResultArray = startTagRe.exec(args[0])) {
=======
        while (reResultArray = startTagRe.exec(args[0])){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
            argArray.push(reResultArray[2]);
            argArray.push('');
        }
        // pass through subsequent args since chrome dev tools does not (yet) support console.log styling of the following form: console.log('%cBlue!', 'color: blue;', '%cRed!', 'color: red;');
        for (var n = 1; n < args.length; n++){
            argArray.push(args[n]);
		}
    }
    return argArray;
}

/*
<<<<<<< HEAD:DKPlugins/DKGui/DKConsoleDUKTAPE.js
DKConsole.prototype.ColorChromeConsole = function DKConsole_ColorChromeConsole(args) {
=======
DKConsole.prototype.ColorChromeConsole = function DKConsole_ColorChromeConsole(args){
>>>>>>> Development:DKCpp/plugins/DKGui/DKConsoleDUKTAPE.js
    var argArray = [];
    argArray.push("%c " + args[0]);
    if (args[1] === "red")
        argArray.push(["padding: 2px 10px 2px 0px", "background-color: rgb(41,0,0)", "color: rgb(255,128,128)"].join(";"));
    if (args[1] === "yellow")
        argArray.push(["padding: 2px 10px 2px 0px", "background-color: rgb(51,43,0)", "color: rgb(255,221,158)"].join(";"));
    if (args[1] === "blue")
        argArray.push(["padding: 2px 10px 2px 0px", "background-color: rgb(36,36,36)", "color: rgb(77,136,255)"].join(";"));
    if (args[1] === "green")
        argArray.push(["padding: 2px 10px 2px 0px", "background-color: rgb(0,41,0)", "color: rgb(128,255,128)"].join(";"));
    return argArray;
}
*/
