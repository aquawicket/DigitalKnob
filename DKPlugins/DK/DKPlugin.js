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
        //return error("running DKPlugin() with no arguments is experamental")
        //return DKPlugin.createInstance();
    }
    // Plugin from Class function
    if (typeof arguments[0] === "function") {
        var args = Array.prototype.slice.call(arguments);
        return DKPlugin.fromClass(args, function callback(result) {
			DKPlugin_callback && DKPlugin_callback(result);
        });
    }
    // Plugin from file
    if (typeof arguments[0] === "string") {
        var args = Array.prototype.slice.call(arguments);
        DKPlugin.fromFile(args, function DKPlugin_fromFile_callback(result) {
            DKPlugin_callback && DKPlugin_callback(result);
        });
    }
}

DKPlugin.fromFile = function DKPlugin_fromFile(args, DKPlugin_fromFile_callback) {
    const url = args[0]
    const color = "color:rgb(200,100,200)"
    console.log("%c *** DKPlugin.fromFile(" + url + ") ***", color);
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
            !DKPlugin.info && (DKPlugin.info = new Array)
            let klassName = null;
            if (DKPlugin.info[url]){
                klassName = DKPlugin.info[url]
			}
            else {
                const newfuncs = dk.getNewFuncs()
                klassName = newfuncs[newfuncs.length - 1]
            }
            if (!globalThis[klassName]) {
                DKPlugin_fromFile_callback && DKPlugin_fromFile_callback(true);
                return true;
            }
            const klass = globalThis[klassName]
            Object.setPrototypeOf(klass, DKPlugin.prototype)
            //klass.prototype = DKPlugin.prototype;// = {};
            //Object.assign(klass.prototype, DKPlugin)
            for (let n = 0; n < args.length; n++) {
                if (args[n] === "singleton") {
                    klass.singleton = "fromFile(): klass.singleton";
                    klass.prototype.singleton = "fromFile(): klass.prototype.singleton";
                }
            }
            !DKPlugin.info && (DKPlugin.info = new Array)
            DKPlugin.info[url] = klass.name
            klass.prototype.url = url
            //console.log("%c DKPlugin.fromFile(): this = "+this.toString(), color);
            //console.log("%c DKPlugin.fromFile(): this.constructor.name = " + this.constructor.name, color);
            //console.log("%c DKPlugin.fromFile(): this.singleton = " + this.singleton, color);
            //console.log("%c DKPlugin.fromFile(): this.prototype = " + this.prototype, color);
            //console.log("%c DKPlugin.fromFile(): klass = "+klass, color);
            //console.log("%c DKPlugin.fromFile(): klass.name = " + klass.name, color);
            //console.log("%c DKPlugin.fromFile(): klass.singleton = " + klass.singleton, color);
            //console.log("%c DKPlugin.fromFile(): klass.prototype = " + klass.prototype, color);
            if (typeof klass.prototype.init === "function") {
                klass.prototype.init(function() {
                    DKPlugin_fromFile_callback && DKPlugin_fromFile_callback(klass);
                })
            } else
                DKPlugin_fromFile_callback && DKPlugin_fromFile_callback(klass);
            return klass;
        }
    }
	DUKTAPE && (script.onload = script.onload()) //FIX script.onload for duktape																		 
}

DKPlugin.fromClass = function DKPlugin_fromClass(args, DKPlugin_fromFile_callback) {
    const color = "color:rgb(100,190,190)"
    console.log("%c *** DKPlugin.fromClass(" + args[0].name + ") ***", color);
    const klass = args[0]
    const klassName = klass.name
    //console.log("%c DKPlugin.fromClass(): this = "+this, color);
    //console.log("%c DKPlugin.fromClass(): this.constructor.name = " + this.constructor.name, color);
    //console.log("%c DKPlugin.fromClass(): this.singleton = " + this.singleton, color);
    //console.log("%c DKPlugin.fromClass(): this.prototype = " + this.prototype, color);
    //console.log("%c DKPlugin.fromClass(): klass = "+klass, color);
    //console.log("%c DKPlugin.fromClass(): klass.name = " + klass.name, color);
    //console.log("%c DKPlugin.fromClass(): klass.singleton = " + klass.singleton, color);
    //console.log("%c DKPlugin.fromClass(): klass.prototype = " + klass.prototype, color);
    for (let n = 0; n < args.length; n++) {
        if (args[n] === "singleton") {
            klass.singleton = "fromClass(): klass.singleton";
            klass.prototype.singleton = "fromClass(): klass.prototype.singleton";
            //console.log("DKPlugin.fromClass() klass.singleton set");
            //console.log("DKPlugin.fromClass() klass.prototype.singleton set");
            for (let n = 0; n < DKPlugin.instances.length; n++) {
                if (DKPlugin.instances[n].klassName == klassName) {
                    console.log("A singleton instance of " + klassName + " already exists");
                    DKPlugin.instances[n].dkframe.bringToFront(DKPlugin.instances[n].dkframe.frame);
                    //DKPlugin_fromFile_callback && DKPlugin_fromFile_callback(DKPlugin.instances[n])
                    return false;
                    //DKPlugin.instances[n];
                }
            }
        }
    }
    //https://stackoverflow.com/a/50402530/688352
    /*
    this[klassName] = {
        [klassName]: function() {
    */
    const instance = new klass;
    //dk.dump(instance)
    const instance2 = Object.create(klass);
    //dk.dump(instance2)
    //console.log("%c new "+instance.constructor.name, color)
    //console.log("%c DKPlugin.fromClass(): klass.name = " + klass.name, color)
    //console.log("%c DKPlugin.fromClass(): klass.singleton = " + klass.singleton, color)
    //console.log("%c DKPlugin.fromClass(): klass.prototype.singleton = " + klass.prototype.singleton, color)
    //console.log("%c DKPlugin.fromClass(): instance = "+instance.toString(), color);
    //console.log("%c DKPlugin.fromClass(): instance.constructor.name = " + instance.constructor.name, color);
    //console.log("%c DKPlugin.fromClass(): instance.singleton = " + instance.singleton, color);
    //console.log("%c DKPlugin.fromClass(): instance.prototype = " + instance.prototype, color);
    if (instance.__proto__.constructor.name !== klassName) {
        console.error("A new " + klassName + " was defined in the " + instance.__proto__.constructor.name + " scope");
        console.error("instances of " + klassName + " must be constucted with the " + klassName + " class scope");
        return false;
    }
    const result = DKPlugin.createInstance.call(instance, arguments);
    if (result != instance)
        return error("instance !== result");
    !instance.supervised && DKPlugin.prototype.superviseFuncs(instance);
    return result;
    /*
        }
    }
    return this[klassName][klassName]();
    */
}

DKPlugin.createInstance = function DKPlugin_createInstance() {
    const color = "color:rgb(250,200,200);"
    console.log("%c *** DKPlugin.createInstance() ***", color);
    //console.log("%c DKPlugin.createInstance(): this = " + this.toString(), color);
    //console.log("%c DKPlugin.createInstance(): this.constructor.name = " + this.constructor.name, color);
    //console.log("%c DKPlugin.createInstance(): this.singleton = " + this.singleton, color);
    const klassName = this.constructor.name;
    const klass = window[klassName];
    //console.log("%c DKPlugin.createInstance(): klass.singleton = " + klass.singleton, color)
    //console.log("%c DKPlugin.createInstance(): klass.prototype.singleton = " + klass.prototype.singleton, color)
    this.klassName = this.constructor.name;
    //Is this instance already running?
    const i = DKPlugin.instances.indexOf(this);
    if (i > -1) {
        console.warn("Returning already existing instance with id: " + this.id + " @index " + i);
        DKPlugin.instances[i].ok = false;
        return DKPlugin.instances[i];
    }
    //Set the ID or kick out existing singletons, while looping
    let num = 0;
    for (let n = 0; n < DKPlugin.instances.length; n++) {
        if (DKPlugin.instances[n].klassName === this.klassName) {
            //if (this.prototype.singleton || DKPlugin.instances[n].prototype.singleton) {
            //    console.warn(this.klassName + " already has a 'singleton' instance");
            //    return false;
            //}
            if ((this.klassName + num) === DKPlugin.instances[n].id) {
                n = 0;
                num++
            }
        }
    }
    !this.id && (this.id = this.klassName + num);
    // Wrap the plugins memeber functions with error catching
    dk.errorCatcher(this, this.klassName);
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
    //This function is never called
    console.group("%c DKPlugin.prototype.init(): " + this.constructor.name, "color:orange;");
    return;
    if (!this) {
        console.groupEnd();
        return error("this is invalid");
    }
    if (this.constructor.name === "Object") {
        console.groupEnd();
        return error("the instance in DKPlugin.prototype.init() is a constructor of 'Object' and should be the class name");
    }
    if (this.xinit && this.xinit !== this.init) {
        console.group(this.constructor.name + ".xinit()");
        const rval = this.xinit.apply(this, arguments);
        console.groupEnd();
        console.groupEnd();
        return rval;
    }
    console.groupEnd();
    return this;
}

DKPlugin.prototype.end = function DKPlugin_end() {
    color = "color:rgb(250,150,150);"
    console.log("%c *** DKPlugin.prototype.end() ***", color);
    //console.log("%c DKPlugin.prototype.end(): this = " + this.toString(), color);
    //console.log("%c DKPlugin.prototype.end(): this.constructor.name = " + this.constructor.name, color);
    //console.log("%c DKPlugin.prototype.end(): this.singleton = " + this.singleton, color);
    const klassName = this.constructor.name;
    const klass = window[klassName];
    //console.log("%c DKPlugin.prototype.end(): klass.singleton = " + klass.singleton, color)
    //console.log("%c DKPlugin.prototype.end(): klass.prototype.singleton = " + klass.prototype.singleton, color)
    if (this.xend) {
        console.group(this.constructor.name + ".xend()");
        this.xend.apply(this, arguments);
        console.groupEnd();
    }
    DKPlugin.prototype.unsuperviseFuncs(this);
    var scripts = document.getElementsByTagName("script");
    for (var n = 0; n < scripts.length; n++) {
        if (scripts[n].src.includes(this.url)) {
            if (!scripts[n].parentNode.removeChild(scripts[n]))
                console.error("Failed to remove " + url);
            console.log("Unloaded " + this.url);
        }
    }
    if (!delete this)
        console.error("delete this failed")
    else
        console.log("sussesfully deleted this." + this.klassName)
    //if(!delete window[this.klassName])
    //    console.error("delete window['"+this.klassName+"'] failed")
    //else
    //    console.log("successfully deleted window[]'"+this.klassName+"']")
    //this = undefined;
    //window[this.klassName] = undefined;
    console.groupEnd();
}

DKPlugin.prototype.create = function DKPlugin_create(klass) {
    console.group("DKPlugin.prototype.create(" + klass + ")");
    //console.group("DKPlugin.prototype.create(): " + this.constructor.name);
    if (!this) {
        console.groupEnd();
        return error("this is invalid");
    }
    if ((this && this.singleton) || (this.prototype && this.prototype.singleton))
        this.create = function() {
            console.log("create() is disabled on singletons after first call");
        }
    if (typeof klass === "function") {
        klass.prototype.create()
    } else if (this.xcreate) {
        console.group(this.constructor.name + ".xcreate()");
        const rval = this.xcreate.apply(this, arguments);
        console.groupEnd();
        console.groupEnd();
        return rval;
    }
    console.groupEnd();
    return this;
}

DKPlugin.prototype.close = function DKPlugin_close() {
    console.group("DKPlugin.prototype.close(): " + this.id);
    /*
	var arr = [];
	for (let key in this) {
		arr.push(key);
	}
	for (let n = arr.length; n--; ){
		let key = arr[n];
	*/
    for (let key in this) {
        if (this[key] instanceof Element) {
            if (!this[key].parentNode) {
                console.error(this.constructor.name + " parentNode invalid");
                continue;
            }
			if(typeof this[key].parentNode.removeChild !== "function")
				console.error(this.constructor.name + "removeChild is not a function")
			this[key].parentNode.removeChild(this[key])
		    if (!delete this[key])
                console.error(this.constructor.name + " could not be deleted")
        }
    }
    if (this.xclose && this.xclose !== this.close) {
        console.group(this.constructor.name + ".close");
        this.xclose();        
        console.groupEnd();
    }
    DKPlugin.prototype.unsuperviseFuncs(this);
    DKPlugin.prototype.removeInstance(this);
    //if any more of this type exist, don't end
    for (let n = 0; n < DKPlugin.instances.length; n++) {
        if (DKPlugin.instances[n].klassName === this.klassName) {
            console.groupEnd();
            return
        }
    }
    //TODO - This can be handles by the user
    //this.end();
    console.groupEnd();
}

DKPlugin.prototype.removeInstance = function DKPlugin_removeInstance(instance) {
    console.log("DKPlugin.prototype.removeInstance(): " + instance.constructor.name);
    const index = DKPlugin.instances.indexOf(instance);
    if (index <= -1) {
        console.error("Unable to find instance in DKPlugin");
        return;
    }
    DKPlugin.instances.splice(index, 1);
    return true;
}

DKPlugin.prototype.superviseFuncs = function DKPlugin_superviseFuncs(instance) {
    //console.log("DKPlugin.prototype.superviseFuncs(): " + instance.constructor.name);
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
    //console.log("DKPlugin.prototype.unsuperviseFuncs(): " + instance.constructor.name);
    if (!instance.supervised)
        return;
    if (instance.xinit)
        instance.init = instance.xinit;
    //instance.xinit = DKPlugin.prototype.init;
    if (instance.xcreate)
        instance.create = instance.xcreate;
    //instance.xcreate = DKPlugin.prototype.create;
    if (instance.xclose)
        instance.close = instance.xclose;
    //instance.xclose = DKPlugin.prototype.close;
    if (instance.xend)
        instance.end = instance.xend;
    //instance.xend = DKPlugin.prototype.end;
    instance.supervised = false;
}

DKPlugin.instances = new Array;
