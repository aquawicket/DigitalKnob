//"use strict"; //FIXME: this breaks duktape
//https://www.phpied.com/3-ways-to-define-a-javascript-class/

// EXAMPLES
//
// DKPlugin("api/myJavascript.js")
//  This will load a javascript file, ready to create an instance
//
// DKPlugin(MyClass)
//   This will creat an instance of the class. MyClass must be available. 
//

const DKPlugin = function DKPlugin() {
    //DKPlugin.dumpInfo.apply(this, arguments);

    let DKPlugin_callback = null;
    if (arguments && typeof (arguments[arguments.length - 1]) === "function")
        DKPlugin_callback = arguments[arguments.length - 1];

    //Determine what type of plugin to make here

    //This is experamental
    if (!arguments.length) {
        return error("running DKPlugin() with no arguments is experamental")
        //return DKPlugin.createInstance();
    }
    // Plugin from Class function
    if (typeof arguments[0] === "function") {
        const clss = arguments[0];
        return DKPlugin.fromClass(clss);
    }
    // Plugin from file
    if (typeof arguments[0] === "string") {
        DKPlugin.fromFile(arguments, function callback(result) {
            DKPlugin_callback && DKPlugin_callback(result);
        });
    }
}

DKPlugin.dumpInfo = function DKPlugin_dumpArguments() {
    console.group("%c ***** DUMPINFO *****", "color: rgb(0,200,0);")
    dk.trace && console.log("%c" + dk.trace.getFunctionName(), "color: rgb(0,200,0);")
    console.log("%cthis.constructor.name: " + this.constructor.name, "color: rgb(0, 150, 0);")

    if (arguments.length && arguments[0].toString() == "[object Arguments]")
        arguments.length = 0;
    if (arguments.length) {
        console.group("%c **arguments(" + arguments.length + ")**", "color: rgb(0, 150, 0);")
        for (let n = 0; n < arguments.length; n++) {
            console.log("%c [" + n + "]: " + arguments[n], "color: rgb(0, 150, 0);")
        }
        console.groupEnd();
    }
    console.groupEnd()
}

DKPlugin.fromFile = function DKPlugin_fromFile(args, DKPlugin_fromFile_callback) {
    //DEBUG && console.debug(" *** DKPlugin.fromFile(" + url + ") ***");
    //DKPlugin.dumpInfo.apply(this, arguments);
    /*
    const url = arguments[0];
    if (typeof (arguments[arguments.length - 1]) === "function")
        DKPlugin_fromFile_callback = arguments[arguments.length - 1];
    else
        DKPlugin_fromFile_callback = undefined;
    */ 
    const url = args[0]

    //update the current list of functions
    dk.getNewFuncs();

    //Is the javascript file already loaded?
    var scripts = document.getElementsByTagName("script");
    for (var n = 0; n < scripts.length; n++) {
        if (scripts[n].src === url) {
            console.info(url + ": is already loaded");
            DKPlugin_fromFile_callback && DKPlugin_fromFile_callback(true);
            return true;
        }
    }

    // Adding the script tag to the head of the document
    var head = document.getElementsByTagName('head')[0];
    var script = document.createElement('script');
    script.setAttribute('type', 'text/javascript');
    script.setAttribute('async', true);
    script.setAttribute('src', url);
    head.appendChild(script);

    script.onerror = function script_onerror(err) {
        return error("script.onerror", DKPlugin_fromFile_callback(false));
    }
    script.onload = function script_onload() {
        if (!this.readyState || this.readyState === "loaded" || this.readyState === "complete") {
            console.log("%cLoaded " + url, "color:green;");
            const newfuncs = dk.getNewFuncs();
            const n = newfuncs.length - 1
            if (!window[newfuncs[n]]) {
                DKPlugin_fromFile_callback && DKPlugin_fromFile_callback(true);
                return true;
            }
            const dkClass = window[newfuncs[n]];
            dkClass.url = url;
            dkClass.script = script;
            dkClass.prototype.url = url;
            //dkClass.prototype.script = script;
            if (typeof dkClass.prototype.init === "function") {
                dkClass.prototype.init(function() {
                    DKPlugin_fromFile_callback && DKPlugin_fromFile_callback(dkClass);
                })
            } else
                DKPlugin_fromFile_callback && DKPlugin_fromFile_callback(dkClass);
            return dkClass;
        }
    }
}

DKPlugin.fromClass = function DKPlugin_fromClass(clss) {
    //DEBUG && console.debug(" *** DKPlugin.fromClass(" + clss.name + ") ***");
    const className = clss.name;

    //https://stackoverflow.com/a/50402530/688352
    /*
    this[className] = {
        [className]: function() {
    */

    const instance = new clss;
    if (instance.__proto__.constructor.name !== className) {
        console.error("A new " + className + " was defined in the " + instance.__proto__.constructor.name + " scope");
        console.error("instances of " + className + " must be constucted with the " + className + " class scope");
        return false;
    }
    instance.dkplugin = DKPlugin.prototype;
    const result = DKPlugin.createInstance.call(instance, arguments);
    if (result != instance)
        return error("instance !== result");
    //DKPlugin.prototype.init.call(result);
    !instance.supervised && DKPlugin.prototype.superviseFuncs(instance);
    return result;

    /*
        }
    }
    return this[className][className]();
    */
}

DKPlugin.createInstance = function DKPlugin_createInstance() {
    this.type = this.constructor.name;

    //Is this instance already running?
    const i = DKPlugin.instances.indexOf(this);
    if (i > -1) {
        console.warn("Returning already existing instance with id: " + this.id + " @index " + i);
        DKPlugin.instances[i].ok = false;
        return DKPlugin.instances[i];
    }

    //Is this a singleton plugin?
    if (arguments[0] && arguments[0][0] && arguments[0][0] === "singleton") {
        this.singleton = true;
        console.error("nested arguments are a issue.  if you landed here, investigate them");
        debugger ;
    } else if (typeof arguments[0][0] === "string") {
        this.id = arguments[0][0];
        console.error("nested arguments are a issue.  if you landed here, investigate them");
        debugger ;
    }

    //Set the ID or kick out existing singletons, while looping
    let num = 0;
    for (let n = 0; n < DKPlugin.instances.length; n++) {
        if (DKPlugin.instances[n].type === this.type) {
            if (this.singleton || DKPlugin.instances[n].singleton) {
                console.warn(this.type + " already has a 'singleton' instance");
                return false;
            }
            if ((this.type + num) === DKPlugin.instances[n].id) {
                n = 0;
                num++
            }
        }
    }
    !this.id && (this.id = this.type + num);

    // Wrap the plugins memeber functions with error catching
    dk.errorCatcher(this, this.type);

    //Add the new instance to the plugin stack
    const newIndex = DKPlugin.instances.push(this) - 1;
    //DKPlugin.instances[newIndex].ok = true;
    this.dkplugin = true;
    return DKPlugin.instances[newIndex];
}

// When calls are made to init, end, create and close, DKPlugin will take presidence
// and control the flow. If an object calls a dkplugin to close completley, you may be in a frame,
// or container that would get stranded. For this reason, DKPlugin will determine who goes first and what 
// cleanup to do. The idea it to accomplish most of the work here, leaving less worries about instance management.
DKPlugin.prototype.init = function DKPlugin_init() {
    DEBUG && console.group("DKPlugin.prototype.init(): " + this.constructor.name);
    if (!this) {
        console.groupEnd();
        return error("this is invalid");
    }
    if (this.constructor.name === "Object") {
        console.groupEnd();
        return error("the instane in DKPlugin.prototype.init() is a constructor of 'Object' and should be the class name");
    }

    //this.dkplugin.url = this.url;
    //!this.supervised && DKPlugin.prototype.superviseFuncs(this);
    if (this.xinit) {
        DEBUG && console.group(this.constructor.name + ".xinit()");
        const rval = this.xinit.apply(this, arguments);
        DEBUG && console.groupEnd();
        DEBUG && console.groupEnd();
        return rval;
    }
    DEBUG && console.groupEnd();
    return this;
}

DKPlugin.prototype.end = function DKPlugin_end() {
    DEBUG && console.group("DKPlugin.prototype.end(): " + this.constructor.name);
    if (!this) {
        DEBUG && console.groupEnd();
        return error("this is invalid");
    }
    if (this.xend) {
        DEBUG && console.group(this.constructor.name + ".xend()");
        this.xend.apply(this, arguments);
        DEBUG && console.groupEnd();
    }
    DKPlugin.prototype.unsuperviseFuncs(this);
    //const dkplugin = dk.getPlugin(this.url);
    this.singleton = false;
    //delete this.dkplugin;
    //delete dk[dkplugin.name];
    //FIXME: unload the script by dkClass.prototype.url
    if (this.script && this.script.parentNode) {
        this.script.parentNode.removeChild(this.script);
        DEBUG && console.debug("Unloaded " + this.url);
    }

    //window[this.type] = undefined;
    delete this;
    delete window[this.type]
    DEBUG && console.groupEnd();
}

DKPlugin.prototype.create = function DKPlugin_create(dkClass) {
    DEBUG && console.group("DKPlugin.prototype.create(" + dkClass + ")");
    DEBUG && console.group("DKPlugin.prototype.create(): " + this.constructor.name);
    if (!this) {
        console.groupEnd();
        return error("this is invalid");
    }
    if (this.singleton)
        this.create = function() {
            console.debug("create() is disabled on singletons after first call");
        }
    if (typeof dkClass === "function") {
        dkClass.prototype.create()
    } else if (this.xcreate) {
        DEBUG && console.group(this.constructor.name + ".xcreate()");
        const rval = this.xcreate.apply(this, arguments);
        DEBUG && console.groupEnd();
        DEBUG && console.groupEnd();
        return rval;
    }
    DEBUG && console.groupEnd();
    return this;
}

DKPlugin.prototype.close = function DKPlugin_close() {
    DEBUG && console.group("DKPlugin.prototype.close(): " + this.constructor.name);
    if (!this) {
        console.groupEnd();
        return error("this is invalid");
    }

    //close the innermost child plugins first
    if (this.dkplugin && (typeof this.dkplugin === "object") && this.dkplugin.close) {
        if (this !== this.dkplugin)
            this.dkplugin.close();
    }
    if (this.xclose) {
        DEBUG && console.group(this.constructor.name + ".xclose");
        this.xclose();
        DEBUG && console.groupEnd();
    }

    //remove any owned html elements from the DOM
    for (let key in this) {
        if (this[key]instanceof HTMLElement) {
            if (this[key].parentNode)
                this[key].parentNode.removeChild(this[key]);
            delete this[key];
        }
    }

    DKPlugin.prototype.removeInstance(this);

    //if any more of this type exist, don't end
    for (let n = 0; n < DKPlugin.instances.length; n++)
        if (DKPlugin.instances[n].type === this.type) {
            DEBUG && console.groupEnd();
            return;
        }
    //that was the last, go ahead and end
    this.end();
    DEBUG && console.groupEnd();
}

DKPlugin.prototype.setUrl = function DKPlugin_setUrl(url) {
    if (!this)
        return error("this is invalid");
    //DEBUG && console.debug("DKPlugin.prototype.setUrl(): " + this.constructor.name);
    this.url = url;
}

DKPlugin.prototype.getUrl = function DKPlugin_getUrl() {
    if (!this)
        return error("this is invalid");
    //DEBUG && console.debug("DKPlugin.prototype.getUrl(): " + this.constructor.name);
    if (!this.url)
        return error("this.url invalid");
    return this.url;
}

DKPlugin.prototype.removeInstance = function DKPlugin_removeInstance(instance) {
    //DEBUG && console.debug("DKPlugin.prototype.removeInstance(): " + instance.constructor.name);
    const index = DKPlugin.instances.indexOf(instance);
    if (index <= -1) {
        console.log("Unable to find instance in DKPlugin");
        return;
    }
    DKPlugin.instances.splice(index, 1);
    return true;
}

DKPlugin.prototype.superviseFuncs = function DKPlugin_superviseFuncs(instance) {
    //DEBUG && console.debug("DKPlugin.prototype.superviseFuncs(): " + instance.constructor.name);
    if (instance.supervised)
        return;
    if (instance.init)
        instance.xinit = instance.init;
    instance.init = DKPlugin.prototype.init;
    if (instance.create)
        instance.xcreate = instance.create;
    instance.create = DKPlugin.prototype.create;
    if (instance.close)
        instance.xclose = instance.close;
    instance.close = DKPlugin.prototype.close;
    if (instance.end)
        instance.xend = instance.end;
    instance.end = DKPlugin.prototype.end;
    instance.supervised = true;
}

DKPlugin.prototype.unsuperviseFuncs = function DKPlugin_unsuperviseFuncs(instance) {
    //DEBUG && console.debug("DKPlugin.prototype.unsuperviseFuncs(): " + instance.constructor.name);
    if (!instance.supervised)
        return;
    if (instance.xinit)
        instance.init = instance.xinit;
    instance.xinit = DKPlugin.prototype.init;
    if (instance.xcreate)
        instance.create = instance.xcreate;
    instance.xcreate = DKPlugin.prototype.create;
    if (instance.xclose)
        instance.close = instance.xclose;
    instance.xclose = DKPlugin.prototype.close;
    if (instance.xend)
        instance.end = instance.xend;
    instance.xend = DKPlugin.prototype.end;
    instance.supervised = false;
}

DKPlugin.instances = new Array;

// TODO
/*
DKPlugin.create = function DKPlugin_create(url) {
    console.debug("DKPlugin.create(" + url + ")");
    const scripts = document.getElementsByTagName("script");
    for (let n = 0; n < scripts.length; n++) {
        if (scripts[n].src.includes(url)) {
            console.info("%c" + url + " is already loaded", "color:orange;");
            return true;
        }
    }
    const head = document.getElementsByTagName('head')[0];
    const script = document.createElement('script');
    script.id = url;
    script.setAttribute('type', 'text/javascript');
    script.setAttribute('async', true);
    script.setAttribute('src', url);
    head.appendChild(script);
}
*/
