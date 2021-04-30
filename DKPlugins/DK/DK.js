"use strict";

window.dk = new Object;
const duktape = window.duktape;

dk.init = function dk_init() {
    eval("var __temp = null");
    const use_strict = (typeof __temp === "undefined");
    console.debug("*** DigitalKnob ***");
    console.debug("use_strict is set to: " + use_strict);
    console.debug("Browser = " + dk.getBrowser());
    console.debug("JSEngine = " + dk.getJSEngine());

    dk.localIP = "127.0.0.1";
    dk.networkIP = "192.168.1.210";
    dk.publicIP = "47.148.252.2";
    dk.port = "2393";
    /*
    var LOG_DEBUG = false;
    var LOG_INFO = true;
    var LOG_WARNINGS = true;
    var LOG_ERRORS = true;
    var LOG_FILE = true;
    var LOG_SHOW = "";
    //comma seperated
    var LOG_HIDE = "";
    //comma seperated
    var LOG_LINES = false;
    var DK_ERROR = 1;
    var DK_WARN = 2;
    var DK_INFO = 3;
    var DK_DEBUG = 4;
    var DK_SHOW = 5;
    var DK_HIDE = 6;
    //var events = [];
    */
}

var byId = function(id) {
    return document.getElementById(id);
}

function error(str, callback, rtnval=false) {
    console.error(str);
    callback && callback(rtnval);
    return rtnval;
}

function warn(str, callback, rtnval=true) {
    console.warn(str);
    callback && callback(rtnval);
    return rtnval;
}

//These are use for rem units and zoom level. They are already in DK.css
//document.getElementsByTagName("html")[0].style.fontSize = "1.0px";
//document.body.style.fontSize = "13em";

//prevent screen highlighting while dragging
document.onselectstart = function() {
    return false;
}

// Dummy functions only implemented in c++
//function DK_DoFrame(){ /*console.warn("DK_ClearEvents(): not available for "+dk.getBrowser());*/ }
//function EventLoop(){ /*console.warn("DK_ClearEvents(): not available for "+dk.getBrowser());*/ }
//EventLoop.run = function(){};

//https://stackoverflow.com/a/11035042/688352
/*
if(dk.getBrowser() !== "CEF" && dk.getBrowser() !== "RML"){
	var DK_ClearEvents = function(){ console.warn("DK_ClearEvents(): not available for "+dk.getBrowser()); }
	var DKRocket_Reload = function(){ console.warn("DKRocket_Reload(): not available for "+dk.getBrowser()); }
	var DK_CallFunc = function(var1, var2, var3){ console.warn("DK_CallFunc(): not available for "+dk.getBrowser()); return ""; }
	var DK_Queue = function(var1, var2, var3){ console.warn("DK_Queue(): not available for "+dk.getBrowser()); }
	var DK_LeftClick = function(){ console.warn("DK_LeftClick(): not available for "+dk.getBrowser()); }
	var DK_RightClick = function(){ console.warn("DK_RightClick(): not available for "+dk.getBrowser()); }
	var DK_SetCursorPos = function(){ console.warn("DK_SetCursorPos(): not available for "+dk.getBrowser()); }
	var DKHook_GetWindows = function(){ console.warn("DKHook_GetWindows(): not available for "+dk.getBrowser()); }
	var DK_Crash = function(){ console.warn("DK_Crash(): not available for "+dk.getBrowser()); }
	var DK_LogGuiConsole = function(){ console.warn("DK_LogGuiConsole(): not available for "+dk.getBrowser()); }
	var DK_GetFunctions = function(){ console.warn("DK_GetFunctions(): not available for "+dk.getBrowser()); }
	var DK_PrintFunctions = function(){ console.warn("DK_PrintFunctions(): not available for "+dk.getBrowser()); }
	var DK_GetPixelUnderMouse = function(){ console.warn("DK_GetPixelUnderMouse(): not available for "+dk.getBrowser()); return ""; }
	var DK_ShowConsole = function(){ console.warn("DK_ShowConsole(): not available for "+dk.getBrowser()); return ""; }
	var DK_HideConsole = function(){ console.warn("DK_HideConsole(): not available for "+dk.getBrowser()); return ""; }
	var DK_CpuUsed = function(){console.warn("DK_CpuUsed(): not available for "+dk.getBrowser()); return ""; }
	var DK_CpuUsedByApp = function(){ console.warn("DK_CpuUsedByApp(): not available for "+dk.getBrowser()); return ""; }
	var DK_PhysicalMemory = function(){ console.warn("DK_PhysicalMemory(): not available for "+dk.getBrowser()); return ""; }
	var DK_PhysicalMemoryUsedByApp = function(){ console.warn("DK_PhysicalMemoryUsedByApp(): not available for "+dk.getBrowser()); return ""; }
}
*/

/*
var myVar = setInterval(myTimer, 1000);
function myTimer() {
    DKSendEvent("window", "second", "");
}
*/

///////////////////////////////////////////////////
document.addEventListener("mousemove", function(e) {
    if (dk.iE()) {
        // grab the x-y pos.s if browser is IE
        window.mouseX = e.clientX + document.body.scrollLeft
        window.mouseY = e.clientY + document.body.scrollTop
    }
    //FIXME
    if (dk.getBrowser() === "RML") {
        window.mouseX = e.clientX;
        window.mouseY = e.clientY;
    } else {
        // grab the x-y pos.s if browser is NS
        window.mouseX = e.pageX
        window.mouseY = e.pageY
    }
    // catch possible negative values in NS4
    if (window.mouseX < 0) {
        window.mouseX = 0
    }
    if (window.mouseY < 0) {
        window.mouseY = 0
    }
    return true;
});

/*
function DKERROR(string){ Log(string, DK_ERROR); }
function DKWARN(string){ Log(string, DK_WARN); }
function DKINFO(string){ Log(string, DK_INFO); }
function DKDEBUG(string){ Log(string, DK_DEBUG); }

function Log(string, lvl) {
    if (!lvl)
        lvl = DK_INFO;

    //check for LOG_HIDE
    if (LOG_HIDE) {
        var arry = LOG_HIDE.split(",");
        for (var i = 0; i < arry.length; i++) {
            if (arry[i] && string.includes(arry[i])) {
                return;
            }
        }
    }

    if (window.console) {
        var flag = false;
        if (LOG_SHOW) {
            var arry = LOG_SHOW.split(",");
            for (var i = 0; i < arry.length; i++) {
                if (arry[i] && string.includes(arry[i])) {
                    flag = true;
                    break;
                }
            }
        }
        if (!flag) {
            if (lvl === DK_ERROR && !LOG_ERRORS) {
                return;
            }
            if (lvl === DK_WARN && !LOG_WARNINGS) {
                return;
            }
            if (lvl === DK_INFO && !LOG_INFO) {
                return;
            }
            if (lvl === DK_DEBUG && !LOG_DEBUG) {
                return;
            }
        }
        var color = "";
        if (lvl === DK_ERROR) {
            color = "color:red";
        }
        if (lvl === DK_WARN) {
            color = "color:#B8860B";
        }
        if (lvl === DK_INFO) {
            color = "color:grey";
        }
        if (lvl === DK_DEBUG) {
            color = "color:blue";
        }
        if (!color) {
            color = "color:grey";
        }
        string = string.replace("\n", "");

        function getFileLine() {
            var stack = Error().stack;
            if (!stack || !LOG_LINES) {
                return "";
            }
            var lines = stack.split("\n");
            var n = 0;
            while (lines[n].indexOf("Log") === -1) {
                n++;
            }
            var fileline = lines[n + 1];
            var start = fileline.lastIndexOf("/");
            var end = fileline.lastIndexOf(":");
            fileline = fileline.substring(start + 1, end + 1);
            return fileline + "  ";
        }

        if (dk.getBrowser() === "CHROME" || dk.getBrowser() === "CEF") {
            if (lvl === DK_ERROR) {
                //alert("ERROR: "+string);
                //throw "ERROR: "+string;
                console.error(getFileLine() + string);
            } else if (lvl === DK_WARN) {
                console.warn(getFileLine() + string);
            } else if (lvl === DK_INFO) {
                console.log(getFileLine() + string);
            } else if (lvl === DK_DEBUG) {
                //console.info("%c"+getFileLine()+string, color);
                console.debug("%c" + getFileLine() + string, color);
            } else {
                console.log("%c" + getFileLine() + string, color);
            }
        } else {
            if (lvl === DK_ERROR) {
                //alert("ERROR: "+string);
                //throw "ERROR: "+string;
                console.error(getFileLine() + string);
            } else if (lvl === DK_WARN) {
                console.warn(getFileLine() + string);
            } else if (lvl === DK_INFO) {
                console.log(getFileLine() + string);
            } else if (lvl === DK_DEBUG) {
                console.debug(getFileLine() + string);
            } else {
                console.log(getFileLine() + string);
            }
        }
    }
    //DKSendEvent("DKConsole.html", "DKNotify", string);
}
*/
dk.hasCPP = function dk_hasCPP() {
    if (dk.getBrowser() === "CEF")
        return true;
    if (dk.getBrowser() === "RML")
        return true;
    if (dk.getJSEngine() === "Duktape") {
        dk.duktape = true;
        return false;
    }
}

dk.getPlugin = function(url) {
    if (!url)
        return error("url invalid");
    var file = url;
    file = file.substring(file.lastIndexOf("/") + 1);
    if (!file)
        return error("file invalid");
    var pluginName = file;
    if (!pluginName)
        return error("pluginName invalid");
    pluginName = pluginName.substring(0, pluginName.lastIndexOf("."));
    pluginName = pluginName.toLowerCase();
    /*
    if(pluginName.substring(0,3) === "dk."){
        //pluginName = pluginName.slice(3);
        const dk_ = window["dk"];
        const dk_notepad = dk_["notepad"];
        if(dk_notepad){
            const dk_notepad_file = dk_notepad["file"];
            const dk_npf = window["dk"]["notepad"]["file"];
            console.log("yup");
        }
    }
    */
    if (pluginName.substring(0, 2) === "dk") {
        pluginName = pluginName.slice(2);
    } else {
        return false;
    }
    let plugin = dk[pluginName];
    if (!plugin) {
        return warn(file + " does not contain a dk." + pluginName + " Object");
    }
    plugin.name = pluginName;
    return plugin;
}

dk.create = function dk_create(data, dk_create_callback) {
    if (!data)
        return error("data is invalid", dk_create_callback(false));
    if (dk.getBrowser() === "CEF" || dk.getBrowser() === "RML")
        CPP_DK_Create(data);

    var arry = data.split(",");

    if (arry[0].includes(".js")) {
        if (!dk.loadJs(arry[0], function dk_loadJs_callback(rval) {
            if (dk_create_callback)
                return dk_create_callback(rval);
            //else
            //    console.warn("dk.create(" + data + "): does not have a callback");
        }))
            return dk_create_callback && dk_create_callback(false);
    }
    if (arry[0].includes(".html")) {
        if (!dk.loadHtml(arry[0], arry[1], function dk_loadHtml_callback(element) {
            if (typeof dk_create_callback === "function")
                return dk_create_callback(element);
            //else
            //    console.warn("dk.create(" + data + "): does not have a callback");
        }))
            return error("DK_LoadHtml failed", dk_create_callback(false));
    }
    if (arry[0].includes(".css")) {
        if (!dk.loadCss(arry[0]))
            return error("dk.loadCss failed", dk_create_callback(false));
        if (dk_create_callback)
            return dk_create_callback();
        //else
        //    console.warn("dk.create(" + data + "): does not have a callback");
    }
    return true;
}

dk.close = function dk_close(data) {
    if (!data)
        return error("data is invalid");

    data = data.split(",");
    if (data[0].includes(".css"))
        data.splice(0, 0, "DKCss");
    else if (data[0].includes(".html"))
        data.splice(0, 0, "DKHtml");
    else if (data[0].includes(".js"))
        data.splice(0, 0, "DKJavascript");
    else
        CPP_DK_Close(data);

    if (data[0] === "DKJavascript") {
        var plugin = dk.getPlugin(data[1]);
        console.log("closing dk." + plugin.name + " plugin");
        if (plugin && plugin.end) {
            console.log("running dk." + plugin.name + ".end()");
            plugin.end();
        }
        var script = byId(data[1]);
        if (!script)
            return warn("script invalid");
        script.parentNode.removeChild(script);
        return true;
    }

    if (data[0] === "DKHtml") {
        var element = byId(data[1]);
        if (!element)
            return warn("element invalid");
        element.parentNode.removeChild(element);
        return true;
    }

    if (data[0] === "DKCss") {
        var css = byId(data[1]);
        if (!css)
            return warn("css invalid");
        css.parentNode.removeChild(css);
        return true;
    }

    return error("data[1] invalid");
}

dk.loadCss = function dk_loadCss(url) {
    if (!url)
        return error("url invalid");

    if (dk.getObjects().includes(url)) {
        console.warn(url + " already loaded. Reloading...");
        byId(url) && byId(url).parentNode.removeChild(byId(url));
    }

    var head = document.getElementsByTagName('head')[0];
    var link = document.createElement('link');
    link.setAttribute('href', url);
    link.id = url;
    link.setAttribute('rel', 'stylesheet');
    link.setAttribute('type', 'text/css');
    head.appendChild(link);
    return true;
}

dk.loadJs = function dk_loadJs(url, dk_loadJs_callback) {
    if (!url)
        return error("url invalid", dk_loadJs_callback(false));

    if (dk.getObjects().includes(url)) {
        console.warn(url + " already loaded. Reloading...");
        byId(url) && byId(url).parentNode.removeChild(byId(url));
    }

    // Adding the script tag to the head as suggested before
    var head = document.getElementsByTagName('head')[0];
    var script = document.createElement('script');
    //script.type = 'text/javascript';
    script.setAttribute('type', 'text/javascript');
    script.id = url;
    //script.async = true; // optionally
    script.setAttribute('async', true);
    script.setAttribute('src', url);
    head.appendChild(script);

    ////// CALLBACKS
    var done = false;
    script.onload = script.onreadystatechange = function script_onload() {
        //FIXME - DigitalKnob can't trigger onload yet.
        if (!done && (!this.readyState || this.readyState === "loaded" || this.readyState === "complete")) {

            //FIXME: This is the old way to run init on plugins
            var old_plugin = url.substring(url.lastIndexOf("/") + 1);
            old_plugin = old_plugin.substring(0, old_plugin.lastIndexOf("."));
            old_plugin = old_plugin + "_init()";
            old_plugin = window[old_plugin];
            if (typeof old_plugin === 'function')
                return error("FIXME: (" + url + ") This plugin uses Init the old way", dk_loadJs_callback(false));

            var plugin = dk.getPlugin(url);
            plugin && console.log("loading dk." + plugin.name + " plugin");

            if (plugin && plugin.init) {
                console.log("running dk." + plugin.name + ".init()");
                plugin.init(function() {
                    done = true;
                    return dk_loadJs_callback && dk_loadJs_callback(true);
                });
            } else {
                done = true;
                return dk_loadJs_callback && dk_loadJs_callback(true);
            }
        }
    }
    script.onerror = function script_onerror() {
        done = true;
        return error("onerror: "+url, dk_loadJs_callback(false));
    }

    //FIXME - DigitalKnob can't trigger onload yet, so we do this

    if (dk.getJSEngine() === "Duktape") {
        var plugin = dk.getPlugin(url);
        plugin && console.log("loading dk." + plugin.name + " plugin");
        if (plugin && plugin.init) {
            console.log("running dk." + plugin.name + ".init()");
            plugin.init();
        } else if (typeof old_plugin === 'function') {
            return error("FIXME: (" + url + ") This plugin uses Init the old way", dk_loadJs_callback(false));
            old_plugin();
        }
        //else {
        done = true;
        return dk_loadJs_callback && dk_loadJs_callback(true);
        // }
        /*
        var func = init;
        //Plugin_init() 
        if (eval("typeof " + func) === "function") {
            eval(func)();
        } else {
            console.warn(init + " is not defined");
        }
        */
        //dk_loadJs_callback && dk_loadJs_callback(true);
    }
    return dk_loadJs_callback && dk_loadJs_callback(true);
}

dk.loadHtml = function dk_loadHtml(url, parent, dk_loadHtml_callback) {
    //TODO: the id of the root element in the html file should be the file path..   I.E. MyPlugin/MyPlugin.html
    if (!url)
        return error("url is invalid", dk_loadHtml_callback(false));

    if (dk.getObjects().includes(url)) {
        console.warn(url + " already loaded. Reloading...");
        byId(url) && byId(url).parentNode.removeChild(byId(url));
    }

    if (url.indexOf(".html") === -1)
        return error("url is not a valid .html file", dk_loadHtml_callback(false));
    //if (url === ".html")
    //    url = "New.html";

    dk.fileToStringAsync(url, function(string) {
        //Create an empty widget
        //if (!string)
        //    string = "<div id=\"" + url + "\" style=\"position:absolute;top:200rem;left:200rem;width:200rem;height:200rem;background-color:rgb(230,230,230);\"></div>";

        var container = document.createElement("div");
        container.innerHTML = string.trim();
        var nodes = container.childNodes;
        if (!nodes)
            return error("Could not get nodes from " + url, dk_loadHtml_callback(false));
        if (nodes.length > 1)
            console.warn("Multiple root nodes in " + url + ", wrapping in a new div");
        else
            container = nodes[0];
        if(!container)
            return error("container invalid", dk_loadHtml_callback);    
        container.id = dk.getAvailableId(url);
        container.setAttribute("url", url);
        if (parent && byId(parent)) {
            console.warn("An element should be used instaed of an id here");
            byId(parent).appendChild(container);
        } else {
            document.body.appendChild(container);
        }

        //FIXME - CEF seems to do this automatically. DKRml need to act the same.
        //var elements = document.getElementsByTagName("temp");
        //if(elements){ console.log("getElementsByTagName(temp).length: "+elements.length); }
        //if(elements[0]){ console.log("elements[0].innerHTML: "+elements[0].innerHTML); }
        //if(elements[0]){ document.removeChild(elements[0]); }

        return dk_loadHtml_callback && dk_loadHtml_callback(container);
    });
    return dk_loadHtml_callback && dk_loadHtml_callback();
}

dk.checkFileSupport = function dk_checkFileSupport() {
    if (window.File && window.FileReader && window.FileList && window.Blob) {
        console.log("File support OK");
    } else {
        console.warn("The File APIs are not fully supported in this browser");
    }
}

/*
dk.preventDefault = function dk_preventDefault(event)
{
	if(event.stopPropagation) {
        event.preventDefault();
    } else {
        event.cancelBubble = true;
    }
}

dk.stopPropagation = function dk_stopPropagation(event)
{
	if(event.stopPropagation) {
        event.stopPropagation();
    } else {
        event.cancelBubble = true;
    }
}
*/

dk.setCookie = function dk_setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}

dk.getCookie = function dk_getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) === ' ')
            c = c.substring(1);
        if (c.indexOf(name) === 0)
            return c.substring(name.length, c.length);
    }
    return "";
}

dk.makeStruct = function dk_makeStruct(names) {
    var names = names.split(' ');
    var count = names.length;
    function constructor() {
        for (var i = 0; i < count; i++) {
            this[names[i]] = arguments[i];
        }
    }
    return constructor;

    //Usage:
    //var Item = makeStruct("id speaker country");
    //var row = new Item(1, 'john', 'au');
    //alert(row.speaker); // displays: john
}

dk.replace = function dk_replace(str, old, newstr) {
    var re = new RegExp(old,'g');
    return str.replace(re, newstr);
}

// trim for IE8
if (typeof String.prototype.trim !== 'function') {
    String.prototype.trim = function() {
        return this.replace(/^\s+|\s+$/g, '');
    }
}

/*
This is a misleading function.
dk.isLocal = function dk_isLocal() {
    switch (window.location.protocol) {
    case 'http:':
    case 'https:':
        //remote file over http or https
        return false;
        break;
    case 'file:':
        //local file
        return true;
        break;
    default:
        //some other protocol
    }
}
*/

dk.available = function dk_available(name) {
    //FIXME: This function needs to be investigated
    if (name === "DKWidget") {
        return true;
    }
    if (name === "DKWidgetJS") {
        //FIXME: is this needed?
        console.log("DKAvailable(" + name + "): name === DKWidgetJS!  check DK.js line 235");
        return true;
    }
    return false;
}

dk.getObjects = function dk_getObjects() {
    // Search the Dom for all scripts (.js files)
    var jsfiles = "";
    var elements = document.getElementsByTagName("script");
    for (var i = 0; elements && i < elements.length; i++) {
        if (!elements[i].id) {
            if (elements[i].src) {
                elements[i].id = elements[i].src;
            }
            //console.warn(elements[i].src+": script object has no id");
            //continue;
        }
        jsfiles += elements[i].id + ",";
    }

    // Search the Dom for all css (.css files)
    var cssfiles = "";
    var elements = document.getElementsByTagName("link");
    if (elements) {
        for (var i = 0; i < elements.length; i++) {
            if (!elements[i].id) {
                //console.warn(elements[i].href+": css object has no id");
                continue;
            }
            cssfiles += elements[i].id + ",";
        }
    }

    // Search the Dom for all widgets (.html id's)
    var htmlfiles = "";
    var divs = document.getElementsByTagName("div");
    if (divs) {
        for (var i = divs.length; i; ) {
            var div = divs[--i];
            if (!div.id) {
                //console.warn(div + ": html object has no id");
                continue;
            }
            if (div.id.indexOf(".html") > -1) {
                htmlfiles += div.id + ",";
            }
        }
    }

    return jsfiles + cssfiles + htmlfiles;
}

dk.getOS = function dk_GetOS() {
    var userAgent = navigator.userAgent || navigator.vendor || window.opera;
    // Windows Phone must come first because its UA also contains "Android"
    if (/windows phone/i.test(userAgent)) {
        return "Windows Phone";
    }
    if (/android/i.test(userAgent)) {
        return "Android";
    }
    // iOS detection from: http://stackoverflow.com/a/9039885/177710
    if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
        return "iOS";
    }
    var os_value = navigator.platform;
    if (navigator.userAgent.indexOf("WOW64") !== -1 || navigator.userAgent.indexOf("Win64") !== -1) {
        os_value = os_value.replace("32", "64");
    }
    os_value = os_value.replace("Intel", "");
    //Mac
    os_value = os_value.replace(" x86_64", "");
    //Linux
    return os_value;
}

dk.getBrowser = function dk_getBrowser() {
    if (navigator.userAgent.indexOf("Rml") !== -1) {
        return "RML";
    } else if ((navigator.userAgent.indexOf("Opera") || navigator.userAgent.indexOf('OPR')) !== -1) {
        return "OPERA";
    } else if (navigator.userAgent.indexOf("Chrome") !== -1 && navigator.userAgent.indexOf("Cef") === -1) {
        return "CHROME";
    } else if (navigator.userAgent.indexOf("Cef") !== -1) {
        return "CEF";
    } else if (navigator.userAgent.indexOf("Safari") !== -1) {
        return "SAFARI";
    } else if (navigator.userAgent.indexOf("Firefox") !== -1) {
        return "FIREFOX";
    } else if ((navigator.userAgent.indexOf("MSIE") !== -1) || (!!document.documentMode === true)) {
        //IF IE > 10
        return "IE";
    } else {
        return "UNKNOWN BROWSER";
    }
}

dk.getJSEngine = function dk_getJSEngine() {
    if (navigator.product === "Duktape") {
        return "Duktape"
    }
    var v8string = 'function%20javaEnabled%28%29%20%7B%20%5Bnative%20code%5D%20%7D';
    if ('WebkitAppearance'in document.documentElement.style) {
        //If (probably) WebKit browser
        if (escape(navigator.javaEnabled.toString()) === v8string) {
            return "V8";
        } else {
            return "JSC";
        }
    }
    return "UNKNOWN JAVASCRIPT ENGINE"
}

dk.iE = function dk_iE() {
    var rv = 0;
    if (navigator.appName === 'Microsoft Internet Explorer') {
        var ua = navigator.userAgent;
        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) !== null)
            rv = parseFloat(RegExp.$1);
    } else if (navigator.appName === 'Netscape') {
        var ua = navigator.userAgent;
        var re = new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) !== null)
            rv = parseFloat(RegExp.$1);
    }

    // Returns the version of Internet Explorer or a 0
    // (indicating the use of another browser).
    return rv;
}

/*
dk.fileToString = function dk_fileToString(url) {
    return ajaxGetUrl(url);
}
*/

dk.fileToStringAsync = function dk_fileToStringAsync(url, dk_fileToStringAsync_callback) {
    dk.sendRequest(url, function dk_sendRequest_callback(success, url, data) {
        return dk_fileToStringAsync_callback && dk_fileToStringAsync_callback(data);
    });
}

dk.sleep = function dk_sleep(milliseconds) {
    var start = new Date().getTime();
    for (var i = 0; i < 1e7; i++) {
        if ((new Date().getTime() - start) > milliseconds) {
            break;
        }
    }
}

dk.clearSelection = function dk_clearSelection() {
    //Clear text selection
    if (document.selection) {
        document.selection.empty();
    } else if (window.getSelection) {
        window.getSelection().removeAllRanges();
    }
}

dk.getElements = function dk_getElements(element) {
    var string;

    if (!element)
        return error("element invalid");
    //var nodes = element.getElementsByTagName('*'); //all children recursively    
    var nodes = element.childNodes;
    if (!nodes)
        return error("nodes invalid");
    for (var n = 0; n < nodes.length; n++) {
        if (nodes[i].id) {
            string += nodes[i].id;
            string += ",";
        }
    }
    return string;
}

dk.getAvailableId = function dk_getAvailableId(id) {
    var out = id;
    var i = 0;
    while (byId(out)) {
        //if there is a .  the number must come before
        var n = id.lastIndexOf(".");
        if (n > 0) {
            out = id.substring(0, n) + String(i) + id.substring(n);
        } else {
            out = id + toString(i);
            out = id + String(i);
        }
        i++;
    }
    return out;
}

// *** UNKNOWN *please test* *** //

dk.getInnerHtmlString = function dk_getInnerHtmlString(id) {
    if (!id) {
        return error("id invalid");
    }
    var element = byId(id);
    for (var i = 0; i < element.childNodes.length; i++) {
        var curNode = element.childNodes[i];
        if (curNode.nodeName === "#text") {
            return curNode.nodeValue;
        }
    }
}

dk.setInnerHtmlString = function dk_setInnerHtmlString(id, string) {
    var element = byId(id);
    for (var i = 0; i < element.childNodes.length; i++) {
        var curNode = element.childNodes[i];
        if (curNode.nodeName === "#text") {
            curNode.nodeValue = string;
            return;
        }
    }
}

// *** EVENTS & VALUES *** //

dk.getValue = function dk_getValue(variable) {
    //FIXME: phase this function out. This function will become obsolete.
    console.error("dk.getValue(): this function is deprecated and will be obsolete");

    if (typeof variable === "string") {
        //id
        var ele = byId(variable);
        if (!ele) {
            return error("ele invalid");
        }
        if (ele) {
            if (ele.type && ele.type === "checkbox") {
                console.debug("dk.getValue(): returning ele.checked\n");
                return ele.checked;
            }
            if (!ele.value) {
                console.debug("dk.getValue(): returning ele.innerHTML\n");
                return ele.innerHTML;
            }
            console.debug("dk.getValue(): returning ele.value\n");
            return ele.value;
        }

        return error("return value invalid");
    }

    if (typeof variable === "object") {
        if (variable.nodeType === 1) {
            if (variable.tagName === "INPUT") {
                console.debug("dk.getValue(): returning variable.value");
                return variable.value;
            }
            console.debug("dk.getValue(): returning variable.innerHTML");
            return variable.innerHTML;
        }
        if (variable.type) {
            //event
            var event = variable;
            if (variable.type === "mousedown") {
                console.debug("dk.getValue(): returning GetMouseButton(variable)");
                return GetMouseButton(variable);
            }
            if (variable.type === "mouseup") {
                console.debug("dk.getValue(): returning GetMouseButton(variable)");
                return GetMouseButton(variable);
            }
            if (variable.type === "click") {
                if (variable.target && variable.target.value) {
                    console.debug("dk.getValue(): returning variable.target.value");
                    return variable.target.value;
                }
                console.debug("dk.getValue(): returning GetMouseButton(variable)");
                return GetMouseButton(variable);
            }
            if (variable.type === "dblclick") {
                console.debug("dk.getValue(): returning GetMouseButton(variable)\n");
                return GetMouseButton(variable);
            }
            if (variable.type === "contextmenu") {
                console.debug("dk.getValue(): returning GetMouseButton(variable)\n");
                return GetMouseButton(variable);
            }
            if (variable.type === "mousemove") {
                console.debug("dk.getValue(): returning event.clientX+", "+event.clientY+", "+event.screenX+", "+event.screenY\n");
                return event.clientX + "," + event.clientY + "," + event.screenX + "," + event.screenY;
            }
            if (variable.type === "mouseover") {
                if (!event.target) {
                    return window.event.srcElement.id;
                }
                //if(!event.target){ return event.srcElement.id; }
                console.debug("dk.getValue(): returning event.target.id\n");
                return event.target.id;
            }
            if (variable.type === "mouseout") {
                if (!event.target) {
                    return window.event.srcElement.id;
                }
                //if(!event.target){ return event.srcElement.id; }
                console.debug("dk.getValue(): returning event.target.id\n");
                return event.target.id;
            }
            if (variable.type === "wheel") {
                var o = variable
                //.originalEvent,
                d = o.detail,
                w = o.wheelDelta,
                n = 225,
                n1 = n - 1;

                // Normalize delta
                d = d ? w && (f = w / d) ? d / f : -d / 1.35 : w / 120;
                // Quadratic scale if |d| > 1
                d = d < 1 ? d < -1 ? (-Math.pow(d, 2) - n1) / n : d : (Math.pow(d, 2) + n1) / n;
                // Delta *should* not be greater than 2...
                event.delta = Math.min(Math.max(d / 2, -1), 1) * 2;
                console.debug("dk.getValue(): returning event.delta\n");
                return event.delta;
            }
            if (variable.type === "keypress") {
                console.debug("dk.getValue(): returning GetCharCode(variable)\n");
                return GetCharCode(variable);
            }
            if (variable.type === "keydown") {
                console.debug("dk.getValue(): returning GetKeyCode(variable)\n");
                return GetKeyCode(variable);
            }
            if (variable.type === "keyup") {
                console.debug("dk.getValue(): returning GetCharCode(variable)\n");
                return GetKeyCode(variable);
            }
            if (variable.type === "resize") {
                var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
                var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
                console.debug("dk.getValue(): returning width+", "+height\n");
                return width + "," + height;
            }
            var ele = DK_GetElement(event);
            //FIXME
            console.debug("dk.getValue(): returning ele.value\n");
            return ele.value;
        } else {
            //element or other object
            if (variable.value) {
                console.debug("dk.getValue(): returning variable.value\n");
                return variable.value;
            }
            console.debug("dk.getValue(): returning variable[2]\n");
            return variable[2];
        }
    }

    return error("ERROR: dk.getValue(): unknown type\n");
}

dk.preloadFile = function dk_preloadFile(url) {
    var file = new Object();
    file.src = url;
    return file;
}

dk.preloadImage = function dk_preloadImage(url) {
    var img = new Image();
    img.src = url;
    return img;
}

dk.saveToLocalStorage = function dk_saveToLocalStorage(name, string) {
    //console.debug("dk_saveToLocalStorage("+name+", "+string+")");
    if (!name)
        return error("name invalid");
    if (!string)
        return error("string invalid");
    localStorage.setItem(name, string);
}

dk.loadFromLocalStorage = function dk_loadFromLocalStorage(name) {
    if (!name)
        return error("name invalid");
    return localStorage.getItem(name);
}

dk.removeFromLocalStorage = function dk_removeFromLocalStorage(name) {
    localStorage.removeItem(name);
}

dk.isOnline = function dk_isOnline() {
    if (navigator.onLine)
        return true;
    else
        return false;
}

/**
 * Returns a number whose value is limited to the given range.
 *
 * Example: limit the output of this computation to between 0 and 255
 * (x * 255).clamp(0, 255)
 *
 * @param {Number} min The lower boundary of the output range
 * @param {Number} max The upper boundary of the output range
 * @returns A number in the range [min, max]
 * @type Number
 */
Number.prototype.clamp = function(min, max) {
    return Math.min(Math.max(this, min), max);
}

/*
dk.ajaxGet = function dk_ajaxGet(url, output) {
    var request = "";
    try {
        request = new XMLHttpRequest();
    } catch (e) {}
    try {
        request = new ActiveXObject("Msxml3.XMLHTTP");
    } catch (e) {}
    try {
        request = new ActiveXObject("Msxml2.XMLHTTP.6.0");
    } catch (e) {}
    try {
        request = new ActiveXObject("Msxml2.XMLHTTP.3.0");
    } catch (e) {}
    try {
        request = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {}
    try {
        request = new ActiveXObject("Microsoft.XMLHTTP");
    } catch (e) {}

    if (!request) {
        return error("AJAX ERROR: Error creating request object");
    }

    request.onreadystatechange = function() {
        if (request.readyState === 4) {
            if (request.status === 200 || request.status === 0) {
                output.value = request.responseText;
                //console.log("AJAX RETURN: "+output.value);
                return true;
            } else {
                console.warn("status: " + request.status);
                return error("AJAX ERROR: " + url + " " + request.statusText);
            }
        }
    }

    //try{ 
    request.open("GET", url, false);
    //FIXME
    request.send();
    //}
    //catch(err){
    //	output.value = "";
    //	return false;
    //}
    return true;
}
*/

/*
dk.ajaxGetUrl = function dk_ajaxGetUrl(url) {
    var response = new Object();
    AjaxGet(url, response);

    if (!response.value) {
        return "ERROR";
    }

    /*
    //php has a console.log() function that injects return messages with {"strings"}
    //The response may contain {"log data"}, let's extract and print it.
    //Also remove them and pass the remaining data on
    //TODO - upgrade this to JSON date transfers
    var place = 0;
    var n = response.value.indexOf("{", place);
    while (n !== -1) {
        place = response.value.indexOf("}");
        var res = response.value.substring(n + 1, place);
        response.value = response.value.replace("{" + res + "}", "");
        //console.log("PHPLog: "+res);
        n = response.value.indexOf("{");
    }
    */

//return response.value;
//}

//https://developer.mozilla.org/en-US/docs/Web/HTTP
//https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers
//https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods
//https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
//https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

dk.sendRequest = function dk_sendRequest(url, dk_sendRequest_callback, httpMethod) {
    const debugXhr = false;
    if (!url)
        return error("url invalid", dk_sendRequest_callback(false));
    if (dk_sendRequest_callback.length < 3)
        return error("dk_sendRequest_callback requires 3 arguments (success, url, data)", dk_sendRequest_callback(false));

    var xhr;
    try {
        !xhr && (xhr = new XMLHttpRequest());
    } catch (e) {}
    try {
        !xhr && (xhr = new ActiveXObject("Msxml3.XMLHTTP"));
    } catch (e) {}
    try {
        !xhr && (xhr = new ActiveXObject("Msxml2.XMLHTTP.6.0"));
    } catch (e) {}
    try {
        !xhr && (xhr = new ActiveXObject("Msxml2.XMLHTTP.3.0"));
    } catch (e) {}
    try {
        !xhr && (xhr = new ActiveXObject("Msxml2.XMLHTTP"));
    } catch (e) {}
    try {
        !xhr && (xhr = new ActiveXObject("Microsoft.XMLHTTP"));
    } catch (e) {}
    if (!xhr)
        return error("Error creating xhr object", dk_sendRequest_callback(false));

    if (httpMethod) {
        switch (httpMethod) {
        case "GET":
        case "POST":
        case "PUT":
        case "HEAD":
        case "DELETE":
        case "PATCH":
        case "OPTIONS":
        case "CONNECT":
        case "TRACE":
            break;
        default:
            return error("httpMethod invalid", dk_sendRequest_callback(false));
        }
    } else
        httpMethod = "GET";

    //DEBUG
    let file;
    debugXhr && (file = url.substring(url.lastIndexOf("/") + 1));
    debugXhr && file.includes("?") && (file = file.substring(0, file.lastIndexOf("?")));

    //FIXME: duktape
    xhr.open(httpMethod, url, true);
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.timeout = 20000;

    //Possible error codes
    //https://github.com/richardwilkes/cef/blob/master/cef/enums_gen.go
    xhr.onabort = function(event) {
        dk.console.error && dk.console.error("GET <a href=' " + url + " ' target='_blank' style='color:rgb(213,213,213)'>" + url + "</a> onabort");
        debugXhr && console.debug("XMLHttpRequest.onabort(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        return dk_sendRequest_callback(false, url, xhr.responseText);
    }
    xhr.onerror = function(event) {
        dk.console.error && dk.console.error("GET <a href=' " + url + " ' target='_blank' style='color:rgb(213,213,213)'>" + url + "</a> onerror");
        debugXhr && console.debug("XMLHttpRequest.onabort(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        return dk_sendRequest_callback(false, url, xhr.responseText);
    }
    xhr.onload = function(event) {
        debugXhr && console.debug("XMLHttpRequest.onload(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        return dk_sendRequest_callback(true, url, xhr.responseText);
    }
    xhr.onloadend = function(event) {
        debugXhr && console.debug("XMLHttpRequest.onloadend(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    }
    xhr.onloadstart = function(event) {
        debugXhr && console.debug("XMLHttpRequest.onloadstart(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    }
    xhr.onprogress = function(event) {
        debugXhr && console.debug("XMLHttpRequest.onprogress(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    }
    xhr.onreadystatechange = function(event) {
        debugXhr && console.log("XMLHttpRequest.onreadystatechange(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        /*
        if (xhr.readyState === 4) {
            if (xhr.status >= 200 && xhr.status < 400 || !xhr.status)
                dk_sendRequest_callback(true, url, xhr.responseText);
            else
                dk_sendRequest_callback(false, url, xhr.responseText);
        }
        */
    }
    xhr.ontimeout = function(event) {
        dk.console.error && dk.console.error("GET <a href=' " + url + " ' target='_blank' style='color:rgb(213,213,213)'>" + url + "</a> net::ERR_CONNECTION_TIMED_OUT");
        debugXhr && console.debug("XMLHttpRequest.onabort(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        return dk_sendRequest_callback(false, url, xhr.responseText);
    }

    xhr.send();
}

dk.checkForUNICODE = function dk_checkForUNICODE(str) {
    for (let i = 0, n = str.length; i < n; i++) {
        if (str.charCodeAt(i) > 255) {
            console.warn("Found UNICODE character at " + i);
            console.log(0, str.substring(i));
            return true;
        }
    }
    return false;
}

dk.validateStrict = function dk_validateStrict(str) {
    return str;
}

dk.init();
