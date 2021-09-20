//"use strict";
const DEBUG = true;
window.dk = new Object;
let DUKTAPE = window.DUKTAPE
dk.useCPP = false;

//Keep a object reference to the old console
if(!DUKTAPE) {
    dk.xconsole = new Object;
    //Create a logger for console
    dk.x = new Object;
    dk.xconsole.debug = console.debug;
    dk.xconsole.error = console.error;
    dk.xconsole.log = console.log;
    dk.xconsole.warn = console.warn;
    dk.x.record = [];
    dk.x.logger = function(lvl, args) {
        !DUKTAPE && dk.xconsole[lvl] && dk.xconsole[lvl].apply(this, Array.prototype.slice.call(args));
        DUKTAPE && dk && dk.x && dk.x.log && dk.x.log.apply(this, Array.prototype.slice.call(args));
        var obj = {};
        (obj[lvl] = args[0]) && (dk.x && dk.x.record.push(obj))
    }
    console.debug = function() {
        dk.x && dk.x.logger("debug", arguments);
    }
    console.error = function() {
        dk.x && dk.x.logger("error", arguments);
    }
    console.log = function() {
        dk.x && dk.x.logger("log", arguments);
    }
    console.warn = function() {
        dk.x && dk.x.logger("warn", arguments);
    }
}

const required = function required() {
    for (let n = 0; n < arguments.length; n++) {
        if (typeof arguments[n] !== "object")
            throw new Error(" Must use {} around variables when using require. EXAMPLE: required({var1}, {var2})");
        var name = Object.keys(arguments[n])[0];
        var value = arguments[n][name];
        if (value === undefined)
            throw new Error("'" + name + "' is undefined");
    }
}

const byId = function byId(id) {
    return document.getElementById(id);
}

const error = function error(str, callback, result) {
    !result && (result = false);
    console.error(str);
    callback && callback(result);
    
    if (DEBUG) {
        //debugger ;
    }
    throw new Error(str);
    //FIXME: this code is never reached because of throw. Set an argument to determine if the error is fatal. 
    return result;
}

const warn = function warn(str, callback, result) {
    !result && (result = false);
    console.warn(str);
    callback && callback(result);
    return result;
}

const ok = function ok(callback, result) {
    !result && (result = true);
    callback && callback(result);
    return result;
}

//prevent screen highlighting while dragging
document.onselectstart = function document_onselectstart() {
    return false;
}

document.addEventListener("mousemove", function document_addEventListener(event) {
    if (dk.iE()) {
        // grab the x-y pos.s if browser is IE
        window.mouseX = event.clientX + document.body.scrollLeft
        window.mouseY = event.clientY + document.body.scrollTop
    }
    //FIXME
    if (dk.getBrowser() === "Rml") {
        window.mouseX = event.clientX;
        window.mouseY = event.clientY;
    } else {
        // grab the x-y pos.s if browser is NS
        window.mouseX = event.pageX
        window.mouseY = event.pageY
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

dk.init = function dk_init() {
    eval("var __temp = null");
    const use_strict = (typeof __temp === "undefined");
    console.debug("*** DigitalKnob ***");
    console.debug("use_strict: " + use_strict);
    console.debug("Browser: " + dk.getBrowser());
    console.debug("JSEngine: " + dk.getJSEngine());
    dk.create("DK/DK.css");
}

dk.hasCPP = function dk_hasCPP() {
    if (dk.useCPP === false) {
        return false;
    }
    dk.cpp = false;
    if (dk.getBrowser() === "Cef") {
        dk.cpp = true;
        dk.cef = true;
    }
    if (dk.getBrowser() === "Rml") {
        dk.cpp = true;
        dk.rml = true;
    }
    if (dk.getJSEngine() === "Duktape") {
        dk.cpp = true;
        dk.duktape = true;
    }
    if (dk.getJSEngine() === "V8") {
        dk.cpp = true;
        dk.v8 = true;
    }
    return dk.cpp;
}

dk.create = function dk_create(data, dk_create_callback) {
    if (dk.hasCPP())
        CPP_DK_Create(data);

    var arry = data.split(",");

    if (arry[0].includes(".js")) {
        if (!dk.loadJs(arry[0], function dk_loadJs_callback(data) {
            if (dk_create_callback)
                return dk_create_callback(data);
            //else
            //    console.warn("dk.create(" + data + "): does not have a callback");
        })) {
            if (dk.getJSEngine() === "Duktape") {
                console.log("dk.loadJS(" + arry[0] + ") failed");
                dk_create_callback && dk_create_callback(true);
                return true;
            }
            console.error("dk.loadJs failed ");
            dk_create_callback && dk_create_callback(false);
        }
    }
    if (arry[0].includes(".html")) {
        if (!dk.loadHtml(arry[0], arry[1], function dk_loadHtml_callback(element) {
            if (typeof dk_create_callback === "function")
                return dk_create_callback(element);
            else
                console.warn("dk.create(" + data + "): does not have a callback");
        })) {
            console.error("dk.loadHtml failed");
            //return dk_create_callback && dk_create_callback(false);
        }
    }
    if (arry[0].includes(".css")) {
        if (!dk.loadCss(arry[0], function dk_loadCss_callback(data) {
            if (dk_create_callback)
                return dk_create_callback(data);
            //else
            //    console.warn("dk.create(" + data + "): does not have a callback");
        })) {
            console.error("dk.loadCss failed");
            //return dk_create_callback && dk_create_callback(false);
        }

    }
    return true;
}

dk.close = function dk_close(data) {
    required({
        data
    });
    data = data.split(",");
    if (data[0].includes(".css"))
        data.splice(0, 0, "DKCss");
    else if (data[0].includes(".html"))
        data.splice(0, 0, "DKHtml");
    else if (data[0].includes(".js"))
        data.splice(0, 0, "DKJavascript");
    else if (dk.hasCPP)
        CPP_DK_Close(data);

    if (data[0] === "DKJavascript") {

        //var plugin = dk.getPlugin(data[1]);
        //console.log("closing dk." + plugin.name + " plugin");
        //if (plugin && plugin.end) {
        //    console.log("running dk." + plugin.name + ".end()");
        //    plugin.end();
        //}

        const scripts = document.getElementsByTagName("script");
        for (let n = 0; n < scripts.length; n++) {
            if (scripts[n].src.includes(data[1])) {
                scripts[n].parentNode.removeChild(scripts[n]);
                console.debug("Unloaded " + data[1]);
                return true;
            }
        }
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
        const links = document.getElementsByTagName("link");
        for (let n = 0; n < links.length; n++) {
            if (links[n].href.includes(data[1])) {
                links[n].parentNode.removeChild(links[n]);
                console.debug("Unloaded " + data[1]);
                return true;
            }
        }
        return true;
    }

    return error("data[1] invalid");
}

dk.getPlugin = function dk_getPlugin(url) {
    required({
        url
    });
    var file = url;
    file = file.substring(file.lastIndexOf("/") + 1);
    if (!file)
        return error("file invalid");
    var pluginName = file;
    if (!pluginName)
        return error("pluginName invalid");
    pluginName = pluginName.substring(0, pluginName.lastIndexOf("."));
    let instanceName = pluginName.toLowerCase();
    if (instanceName.substring(0, 2) === "dk")
        instanceName = instanceName.slice(2);
    let plugin = {};
    if (window[instanceName]) {
        plugin = window[instanceName];
        plugin.instance = instanceName;
    }
    if (dk[instanceName]) {
        plugin = dk[instanceName];
        plugin.instance = instanceName;
    }
    plugin.name = pluginName;

    let nameCSS = "color: red;"
    let instanceCSS = "color: red;"
    let initCSS = "color: red;"
    plugin.name && (nameCSS = "color: green;")
    plugin.instance && (instanceCSS = "color: green;")
    plugin.init && (initCSS = "color: green;")

    console.group("%cdk.plugin("+url+")" + plugin.name, "color:rgb(100,100,200);");
    console.debug("plugin.name: %c" + plugin.name, nameCSS);
    console.debug("plugin.instance: %c" + plugin.instance, instanceCSS);
    console.debug("plugin.init(): %c" + typeof plugin.init, initCSS);
    console.groupEnd();
    return plugin;
}

dk.loadJs = function dk_loadJs(url, dk_loadJs_callback) {
    console.warn("Use DKPlugin() instead of dk.create to load .js files now");
    required({
        url
    });
    //if (dk.getObjects().indexOf(url) > -1) {
    //    console.log(url + " script already loaded...");
    //    dk_loadJs_callback(true);
    //    return true;
    //}
    var scripts = document.getElementsByTagName("script");
    for (var n = 0; scripts && n < scripts.length; n++) {
        if (scripts[n].src && scripts[n].src.includes(url)) {
            console.info(url + ": is already loaded");
            dk_loadJs_callback && dk_loadJs_callback(true);
            return true;
        }
    }

    // Adding the script tag to the head node 
    var head = document.getElementsByTagName('head')[0];
    var script = document.createElement('script');
    script.setAttribute('type', 'text/javascript');
    script.setAttribute('async', true);
    script.setAttribute('src', url);
    head.appendChild(script);

    ////// CALLBACKS
    var done = false;
    script.onload = script.onreadystatechange = function script_onload() {
        //FIXME - DigitalKnob can't trigger onload yet.
        if (!done && (!this.readyState || this.readyState === "loaded" || this.readyState === "complete")) {
            console.log("Loaded " + url);
            var plugin = dk.getPlugin(url);
            plugin.url = url;
            if (plugin.init) {
                DKPlugin.prototype.init.call(plugin, function callback(instance) {
                    done = true;
                    dk_loadJs_callback && dk_loadJs_callback(true);
                    return true;
                });
            } else {
                done = true;
                dk_loadJs_callback && dk_loadJs_callback(true);
                return true;
            }
        }
    }
    script.onerror = function script_onerror() {
        done = true;
        return error("onerror: " + url, dk_loadJs_callback(false));
    }

    //FIXME - DigitalKnob can't trigger onload yet, so we do this

    if (dk.getJSEngine() === "Duktape") {
        console.log("Duktape Loading: " + url);
        var plugin = dk.getPlugin(url);
        plugin && console.log("loading dk." + plugin.name + " plugin");
        if (plugin && plugin.init) {
            //console.debug("running dk." + plugin.name + ".init()");
            plugin.init();
        } else if (typeof old_plugin === 'function') {
            return error("FIXME: (" + url + ") This plugin uses Init the old way", dk_loadJs_callback(false));
            old_plugin();
        }
        done = true;
        dk_loadJs_callback && dk_loadJs_callback(true);
        return true;
    }
    return true;
}

dk.loadHtml = function dk_loadHtml(url, parent, dk_loadHtml_callback) {
    required({
        url
    });
    if (url.indexOf(".html") === -1)
        return error("url is not a valid .html file", dk_loadHtml_callback(false));

    dk.fileToString(url, function dk_fileToString(string) {
		//console.log("dk.fileToString() string = "+string)
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
        if (!container)
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
    return true;
}

dk.loadCss = function dk_loadCss(url, dk_loadCss_callback) {
    required({
        url
    });
    const links = document.getElementsByTagName("link");
    if (!links)
        return false;
    for (let n = 0; n < links.length; n++) {
        if (links[n].href && links[n].href.includes(url)) {
            console.log(url + " already loaded.");
            dk_loadCss_callback && dk_loadCss_callback(links[n]);
            return links[n];
        }
    }
    var head = document.getElementsByTagName('head')[0];
    var link = document.createElement('link');
    link.setAttribute('href', url);
    link.setAttribute('rel', 'stylesheet');
    link.setAttribute('type', 'text/css');
    link.setAttribute('async', true);
    head.appendChild(link);
    dk_loadCss_callback && dk_loadCss_callback(link);
    return link;
}

dk.checkFileSupport = function dk_checkFileSupport() {
    if (window.File && window.FileReader && window.FileList && window.Blob) {
        console.log("File support OK");
    } else {
        console.warn("The File APIs are not fully supported in this browser");
    }
}

/*
dk.preventDefault = function dk_preventDefault(event){
    required({event});
	if(event.stopPropagation) {
        event.preventDefault();
    } else {
        event.cancelBubble = true;
    }
}

dk.stopPropagation = function dk_stopPropagation(event){
    required({event});
	if(event.stopPropagation) {
        event.stopPropagation();
    } else {
        event.cancelBubble = true;
    }
}
*/

dk.setCookie = function dk_setCookie(cname, cvalue, exdays) {
    required({
        cname
    }, {
        cvalue
    }, {
        exdays
    });
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}

dk.getCookie = function dk_getCookie(cname) {
    required({
        cname
    });
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
    required({
        names
    });
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

/*
dk.replace = function dk_replace(str, old, newstr) {
    required({str},{old},{newstr});
    var re = new RegExp(old,'g');
    return str.replace(re, newstr);
}
*/

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
    required({
        name
    });
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
        dk.rml = true;
        return "Rml";
    } else if ((navigator.userAgent.indexOf("Opera") || navigator.userAgent.indexOf('OPR')) !== -1) {
        return "Opera";
    } else if (navigator.userAgent.indexOf("Chrome") !== -1 && navigator.userAgent.indexOf("Cef") === -1) {
        return "Chrome";
    } else if (navigator.userAgent.indexOf("Cef") !== -1) {
        return "Cef";
    } else if (navigator.userAgent.indexOf("Safari") !== -1) {
        return "Safari";
    } else if (navigator.userAgent.indexOf("Firefox") !== -1) {
        return "Firefox";
    } else if ((navigator.userAgent.indexOf("MSIE") !== -1) || (!!document.documentMode === true)) {
        //IF IE > 10
        return "IE";
    } else {
        return "UNKNOWN BROWSER";
    }
}

dk.getJSEngine = function dk_getJSEngine() {
    if (navigator.product === "Duktape") {
        dk.duktape = true;
        return "Duktape"
    }
    var v8string = 'function%20javaEnabled%28%29%20%7B%20%5Bnative%20code%5D%20%7D';
    if ('WebkitAppearance'in document.documentElement.style) {
        //If (probably) WebKit browser
        if (escape(navigator.javaEnabled.toString()) === v8string) {
            dk.v8 = true;
            return "V8";
        } else {
            dk.jsc = true;
            return "Jsc";
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

dk.fileToString = function dk_fileToString(url, dk_fileToString_callback) {
    required({
        url
    }, {
        dk_fileToString_callback
    });
    dk.sendRequest("GET", url, function dk_sendRequest_callback(success, url, data) {
        return dk_fileToString_callback(data);
    });
}

dk.sleep = function dk_sleep(milliseconds) {
    required({
        milliseconds
    });
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
    required({
        element
    });
    var string;
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
    required({
        id
    });
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
    required({
        id
    });
    var element = byId(id);
    for (var i = 0; i < element.childNodes.length; i++) {
        var curNode = element.childNodes[i];
        if (curNode.nodeName === "#text") {
            return curNode.nodeValue;
        }
    }
}

dk.setInnerHtmlString = function dk_setInnerHtmlString(id, string) {
    required({
        id
    }, {
        string
    });
    var element = byId(id);
    for (var i = 0; i < element.childNodes.length; i++) {
        var curNode = element.childNodes[i];
        if (curNode.nodeName === "#text") {
            curNode.nodeValue = string;
            return true;
        }
    }
}

// *** EVENTS & VALUES *** //
/*
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
            //NOTE:  Found in DKInputTest/DKInputTest.js
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
*/

dk.preloadFile = function dk_preloadFile(url) {
    required({
        url
    });
    var file = new Object();
    file.src = url;
    return file;
}

dk.preloadImage = function dk_preloadImage(url) {
    required({
        url
    });
    if (!DUKTAPE) {
        var img = new Image();
        img.src = url;
        return img;
    }
}

dk.saveToLocalStorage = function dk_saveToLocalStorage(name, string) {
    required({
        name
    }, {
        string
    });
    localStorage.setItem(name, string);
}

dk.loadFromLocalStorage = function dk_loadFromLocalStorage(name) {
    required({
        name
    });
    return localStorage.getItem(name);
}

dk.removeFromLocalStorage = function dk_removeFromLocalStorage(name) {
    required({
        name
    });
    localStorage.removeItem(name);
}

//https://developer.mozilla.org/en-US/docs/Web/HTTP
//https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers
//https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods
//https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
//https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy
dk.sendRequest = function dk_sendRequest(httpMethod, url, dk_sendRequest_callback) {
    required({
        httpMethod
    }, {
        url
    }, {
        dk_sendRequest_callback
    });
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
            return error("httpMethod '" + httpMethod + "' invalid", dk_sendRequest_callback(false));
        }
    }

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

    //FIXME: duktape
    //url = encodeURIComponent(url).replace(";", "%3B");
    xhr.open(httpMethod, url, true);
    //https://en.wikipedia.org/wiki/List_of_HTTP_header_fields
    if (httpMethod === "POST" || httpMethod === "Put")
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.timeout = 20000;

    //Possible error codes
    //https://github.com/richardwilkes/cef/blob/master/cef/enums_gen.go
    xhr.onabort = function xhr_onabort(event) {
        dk.console.error && dk.console.error("GET <a href=' " + url + " ' target='_blank' style='color:rgb(213,213,213)'>" + url + "</a> onabort");
        //console.debug("XMLHttpRequest.onabort(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        return dk_sendRequest_callback(false, url, xhr.responseText);
    }
    xhr.onerror = function xhr_onerror(event) {
        dk.console.error && dk.console.error("GET <a href=' " + url + " ' target='_blank' style='color:rgb(213,213,213)'>" + url + "</a> onerror");
        //console.debug("XMLHttpRequest.onerror(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        return dk_sendRequest_callback(false, url, xhr.responseText);
    }
    xhr.onload = function xhr_onload(event) {
        //console.debug("XMLHttpRequest.onload(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        return dk_sendRequest_callback(true, url, xhr.responseText);
    }
    xhr.onloadend = function xhr_onloadend(event) {//console.debug("XMLHttpRequest.onloadend(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    }
    xhr.onloadstart = function xhr_onloadstart(event) {//console.debug("XMLHttpRequest.onloadstart(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    }
    xhr.onprogress = function xhr_onprogress(event) {//console.debug("XMLHttpRequest.onprogress(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    }
    xhr.onreadystatechange = function xhr_onreadystatechange(event) {//console.log("XMLHttpRequest.onreadystatechange(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    /*
        if (xhr.readyState === 4) {
            if (xhr.status >= 200 && xhr.status < 400 || !xhr.status)
                dk_sendRequest_callback(true, url, xhr.responseText);
            else
                dk_sendRequest_callback(false, url, xhr.responseText);
        }
        */
    }
    xhr.ontimeout = function xhr_ontimeout(event) {
        dk.console.error && dk.console.error("GET <a href=' " + url + " ' target='_blank' style='color:rgb(213,213,213)'>" + url + "</a> net::ERR_CONNECTION_TIMED_OUT");
        //console.debug("XMLHttpRequest.ontimeout(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        return dk_sendRequest_callback(false, url, "ontimeout");
    }

    console.debug("dk.sendRequest("+httpMethod+","+decodeURIComponent(url)+")")
    xhr.send();
}

dk.checkForUNICODE = function dk_checkForUNICODE(str) {
    required({
        str
    });
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
    required({
        str
    });
    return str;
}

//https://stackoverflow.com/a/54430417/688352
dk.stringToBinary = function dk_sringToBinary(string) {
    //for BINARY maxBytes = 255
    //for VARBINARY maxBytes = 65535
    const maxBytes = 255;
    let binaryOutput = '';
    if (string.length > maxBytes)
        string = string.substring(0, maxBytes);
    for (let i = 0; i < string.length; i++)
        binaryOutput += string[i].charCodeAt(0).toString(2) + ' ';
    return binaryOutput;
}

dk.binaryToString = function dk_binaryToString(binary) {
    const arrayOfBytes = binary.split(' ');
    let stringOutput = '';
    for (let i = 0; i < arrayOfBytes.length; i++)
        stringOutput += String.fromCharCode(parseInt(arrayOfBytes[i], 2));
    return stringOutput;
}

dk.hide = function dk_hide(id){
	var element = byId(id)
	if(!element)
		return error("element invalid")
	element.style.display = "none"
}

dk.show = function dk_show(id){
	var element = byId(id)
	if(!element)
		return error("element invalid")
	element.style.display = "block"
	element.style.visibility = "visible"
}

///// Pollyfils and Prototypes

// trim for IE8
if (typeof String.prototype.trim !== 'function') {
    String.prototype.trim = function String_trim() {
        return this.replace(/^\s+|\s+$/g, '');
    }
}

if (!Array.prototype.includes) {
    Array.prototype.includes = function(searchElement /*, fromIndex*/
    ) {
        required({
            searchElement
        });
        if (this == null) {
            throw new TypeError('Array.prototype.includes called on null or undefined');
        }

        var O = Object(this);
        var len = parseInt(O.length, 10) || 0;
        if (len === 0) {
            return false;
        }
        var n = parseInt(arguments[1], 10) || 0;
        var k;
        if (n >= 0) {
            k = n;
        } else {
            k = len + n;
            if (k < 0) {
                k = 0;
            }
        }
        var currentElement;
        while (k < len) {
            currentElement = O[k];
            if (searchElement === currentElement || (searchElement !== searchElement && currentElement !== currentElement)) {
                // NaN !== NaN
                return true;
            }
            k++;
        }
        return false;
    }
    ;
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
Number.prototype.clamp = function Number_clamp(min, max) {
    required({
        min
    }, {
        max
    });
    return Math.min(Math.max(this, min), max);
}

/*
Object.prototype.clone = Array.prototype.clone = function() {
    if (Object.prototype.toString.call(this) === '[object Array]') {
        var clone = [];
        for (var i = 0; i < this.length; i++)
            clone[i] = this[i].clone();
        return clone;
    } else if (typeof (this) == "object") {
        var clone = {};
        for (var prop in this)
            if (this.hasOwnProperty(prop))
                clone[prop] = this[prop].clone();
        return clone;
    } else
        return this;
}
*/

//https://humanwhocodes.com/blog/2009/04/28/javascript-error-handling-anti-pattern/
dk.errorCatcher = function dk_errorCatcher(obj, name) {
    required({
        obj
    });

    dk.errorCatcher.bypass = ["init", "end", "create", "close"]

    !name && (name = obj.constructor.name);
    for (let func in obj) {
        if (func.includes("_try"))
            continue;
        if (obj[func + "_try"])
            continue;
        if (obj[func] == DKPlugin.prototype[func])
            continue;
        const method = obj[func];
        if (typeof method === "function") {
            if (dk.errorCatcher.bypass.includes(func))
                continue;
            Object.defineProperty(method, 'name', {
                value: func
            })
            //console.debug(name + "." + func + "()");
            obj[func] = function errorCatcher(func, method) {
                return obj[func + "_try"] = function() {
                    try {
                        return method.apply(this, arguments);
                    } catch (err) {
                        //const stack = dk.trace.stackToConsoleString(err);
                        //if (dk.console && dk.console.error) {
                            //dk.console.error(err);
                            //dk.xconsole && dk.dk.xconsole.error(err);
                        //} else
                            console.error(err);
                    }
                }
            }(func, method);
        }
    }
}

// https://stackoverflow.com/a/63785848/688352
dk.testSyntax = function dk_testSyntax(code) {
    required({
        code
    });
    try {
        new Function([],code)
    } catch (err) {
        throw err
    }
}

dk.getNewFuncs = function dk_getNewFuncs() {
    !dk.windowfuncs && (dk.windowfuncs = new Array)
    const newfuncs = new Array
    const removedfuncs = new Array
    const obj = window

    //remove any function that have been removed from obj
    for (var i in dk.windowfuncs) {
        if (!obj[dk.windowfuncs[i]]) {
            obj[dk.windowfuncs[i]] = undefined
            //delete obj[dk.windowfuncs[i]]
            removedfuncs.push(dk.windowfuncs[i])
            dk.windowfuncs.splice(i, 1);
        }
    }

    //update windowfuncs and newfuncs
    for (var i in obj) {
        if ((typeof obj[i]).toString() == "function" && obj[i].toString().indexOf("[native code]") == -1) {
            if (!dk.windowfuncs.includes(obj[i].name) && obj[obj[i].name]) {
                newfuncs.push(obj[i].name);
                dk.windowfuncs.push(obj[i].name);
            }
        }
    }

    return newfuncs;
}

//Useage: Object.byString(someObj, 'part3[0].name');  
Object.byString = function(o, s) {
    // convert indexes to properties
    s = s.replace(/\[(\w+)\]/g, '.$1');
    // strip a leading dot
    s = s.replace(/^\./, '');
    var a = s.split('.');
    for (var i = 0, n = a.length; i < n; ++i) {
        var k = a[i];
        if (k in o)
            o = o[k];
        else
            return;
    }
    return o;
}

dk.insert = function dk_insert(str, index, value) {
    return str.substr(0, index) + value + str.substr(index);
}

// https://stackoverflow.com/a/24032179/688352
dk.renameFunction = function dk_renameFunction(func, name) {
    const oldName = func.name;
    let funcString = func.toString();
    funcString = funcString.replace("function(", "function " + name + "(")
    funcString = funcString.replace("function (", "function " + name + "(")
    funcString = funcString.replace("function " + oldName + "(", "function " + name + "(")
    funcString += "\nreturn " + name + ";"
    const parent = window;
    let scope = parent;
    let values = [];
    if (!Array.isArray(scope) || !Array.isArray(values)) {
        if (typeof scope == "object") {
            var keys = Object.keys(scope);
            values = keys.map(function(p) {
                return scope[p];
            });
            scope = keys;
        } else
            scope = [];
    }
    parent[name] = Function(scope, funcString).apply(null, values)
    return parent[name]
}

// https://stackoverflow.com/a/24032179/688352
dk.editFunctionBody = function dk_editFunctionBody(func, newBody) {
    const name = func.name;
    newBody = newBody.replace("function(", "function " + name + "(")
    newBody = newBody.replace("function (", "function " + name + "(")
    newBody = newBody.replace("function " + name + "(", "function " + name + "(")
    newBody += "\nreturn " + name + ";"
    const parent = window;
    let scope = parent;
    let values = [];
    if (!Array.isArray(scope) || !Array.isArray(values)) {
        if (typeof scope == "object") {
            var keys = Object.keys(scope);
            values = keys.map(function(p) {
                return scope[p];
            });
            scope = keys;
        } else
            scope = [];
    }
    parent[name] = Function(scope, newBody).apply(null, values)
    return parent[name]
}

// https://stackoverflow.com/a/24032179/688352
dk.StringToFunction = function dk_StringToFunction(name, str) {
    str = str.replace("function(", "function " + name + "(")
    str = str.replace("function (", "function " + name + "(")
    str = str.replace("function " + name + "(", "function " + name + "(")
    str += "\nreturn " + name + ";"
    const parent = window;
    let scope = parent;
    let values = [];
    if (!Array.isArray(scope) || !Array.isArray(values)) {
        if (typeof scope == "object") {
            var keys = Object.keys(scope);
            values = keys.map(function(p) {
                return scope[p];
            });
            scope = keys;
        } else
            scope = [];
    }
    parent[name] = Function(scope, str).apply(null, values)
    return parent[name]
}

// https://eli.thegreenplace.net/2013/10/22/classical-inheritance-in-javascript-es5
dk.classExtends = function dk_classExtends(child_class, parent_class) {
    const child_prototype = child_class.prototype;
    const funcString = "function " + child_class.name + "(){\n\tconsole.log('" + child_class.name + "() constructor')\n\t" + parent_class.name + ".call(this, arguments)\n}";
    let child = dk.StringToFunction(child_class.name, funcString)
    child.prototype = Object.create(parent_class.prototype)
    child.prototype.constructor = child
    Object.assign(child.prototype, child_prototype)
    child_class = child
    return child_class
}

dk.dump = function dk_dumpVariable(variable) {
    const pink = "color:rgb(220,120,220);"
    const white = "color:rgb(213.213.213);"
    const blue = "color:rgb(113,113,263); font-style:italic;"
    const color = "color:rgb(100,100,250);"
    const lightBlue = "color:rgb(91,171,209);"
    const grey = "color:rgb(142,142,142);"
    const orange = "color:rgb(226,131,81);"

    let name;
    if (typeof variable === "object") {
        console.group("%c" + variable.constructor.name + " {}", "color:rgb(213,213,213);font-style:italic;")

        //const type = Object.prototype.toString.call(variable).slice(8, -1);

        //console.log("%c valueOf: %c"+ variable.valueOf(), pink, color);
        //console.log("%c typeof: %c" + typeof variable, pink, color);

        for (let key in variable) {
            if (variable[key] === variable) {
                continue;
                return error("infinate loop")
            }
            if (typeof variable[key] === "function")
                console.log("%c " + key + "%c: %c f %c" + variable[key].name + "()", pink, white, blue, white);
            else if (typeof variable[key] === "object") {
                if (variable[key]instanceof HTMLElement)
                    console.log("%c " + key + "%c: %c" + variable[key].localName, pink, white, lightBlue);
                else if (variable[key] && variable[key].constructor && variable[key].constructor.name === "Array")
                    console.log("%c " + key + "%c: %c" + variable[key], pink, white, grey);
                else
                    console.log("%c " + key + "%c: %c" + variable[key], pink, white, grey);
            } else if (typeof variable[key] === "string") {
                console.log("%c " + key + "%c: %c\"" + variable[key] + "\"", pink, white, orange);
            } else
                console.log("%c " + key + "%c: " + variable[key], pink, white);
        }

        //console.log("%c variable = " + variable, color);
        console.log("%c variable.constructor = " + variable.constructor, color);
        console.log("%c variable.constructor.name = " + variable.constructor.name, color);
        console.log("%c variable.__proto__ = " + variable.__proto__, color);
        console.log("%c variable.__proto__.constructor = " + variable.__proto__.constructor, color);
        console.log("%c variable.prototype = " + variable.prototype, color);
        console.groupEnd();

    }

    if (typeof variable === "function")
        console.group("%c" + variable, "color:rgb(213,213,213);font-style:italic;")
    if (typeof variable === "array")
        console.group("%c" + variable, "color:rgb(213,213,213);font-style:italic;")

    //for(let key in variable)
    //    console.log("%c variable."+key+" = "+variable[key], color);

    //for(let key in variable.__proto__.constructor)
    //console.log("%c variable.__proto__."+key+" = "+variable.__proto__[key], color);

    console.log(variable)
    /*
    if (typeof variable === "object")
        console.log(variable)
    if (typeof variable === "function")
        console.log(variable.prototype)
    if (typeof variable === "array")
        console.log(variable)
    */
}

dk.init();
