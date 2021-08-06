//"use strict"; //FIXME: this breaks duktape
//https://www.phpied.com/3-ways-to-define-a-javascript-class/

// EXAMPLES
//
// DKPlugin2("api/myJavascript.js")
//  This will load a javascript file, ready to create an instance
//
// DKPlugin2(MyClass)
//   This will creat an instance of the class.
//
console.log("Loading DKPlugin2s.js")
const DKPlugin2 = function DKPlugin2() {
    //console.debug("*** DKPlugin2() ***");
    //DKPlugin2.dumpInfo.apply(this, arguments);

    let DKPlugin2_callback = null;
    if (arguments && typeof (arguments[arguments.length - 1]) === "function")
        DKPlugin2_callback = arguments[arguments.length - 1];

    //Determine what type of plugin to make here

    //This is experamental
    if (!arguments.length) {
        //return error("running DKPlugin2() with no arguments is experamental")
        //return DKPlugin2.createInstance();
    }
    // Plugin from Class function
    if (typeof arguments[0] === "function") {
        var args = Array.prototype.slice.call(arguments);
        //return DKPlugin2.fromClass(args, function callback(result) {
        //    DKPlugin2_callback && DKPlugin2_callback(result);
        //});
    }
    // Plugin from file
    if (typeof arguments[0] === "string") {
        var args = Array.prototype.slice.call(arguments);
        //DKPlugin2.fromFile(args, function callback(result) {
        //    DKPlugin2_callback && DKPlugin2_callback(result);
        //});
    }
}

/*
DKPlugin2.fromFile = function DKPlugin2_fromFile(args, DKPlugin2_fromFile_callback) {
    const url = args[0]
    const color = "color:rgb(200,100,200)"
    console.log("%c *** DKPlugin2.fromFile(" + url + ") ***", color);

    //update the current list of functions
    dk.getNewFuncs();

    //Is the javascript file already loaded?
    var scripts = document.getElementsByTagName("script");
    for (var n = 0; n < scripts.length; n++) {
        if (scripts[n].src === url) {
            console.info(url + ": is already loaded");
            DKPlugin2_fromFile_callback && DKPlugin2_fromFile_callback(true);
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
        return error("script.onerror", DKPlugin2_fromFile_callback(false));
    }
    script.onload = function script_onload() {
        if (!this.readyState || this.readyState === "loaded" || this.readyState === "complete") {
            console.log("%cLoaded " + url, "color:green;");
            !DKPlugin2.info && (DKPlugin2.info = new Array)
            let klassName = null;
            if (DKPlugin2.info[url])
                klassName = DKPlugin2.info[url]
            else {
                const newfuncs = dk.getNewFuncs()
                klassName = newfuncs[newfuncs.length - 1]
            }
            if (!window[klassName]) {
                DKPlugin2_fromFile_callback && DKPlugin2_fromFile_callback(true);
                return true;
            }
            const klass = window[klassName];
            Object.setPrototypeOf(klass, DKPlugin2.prototype)
            //klass.prototype = DKPlugin2.prototype;// = {};
            //Object.assign(klass.prototype, DKPlugin2)

            for (let n = 0; n < args.length; n++) {
                if (args[n] === "singleton") {
                    klass.singleton = "fromFile(): klass.singleton";
                    klass.prototype.singleton = "fromFile(): klass.prototype.singleton";
                }
            }

            !DKPlugin2.info && (DKPlugin2.info = new Array)
            DKPlugin2.info[url] = klass.name
            klass.prototype.url = url

            //console.log("%c DKPlugin2.fromFile(): this = "+this.toString(), color);
            //console.log("%c DKPlugin2.fromFile(): this.constructor.name = " + this.constructor.name, color);
            //console.log("%c DKPlugin2.fromFile(): this.singleton = " + this.singleton, color);
            //console.log("%c DKPlugin2.fromFile(): this.prototype = " + this.prototype, color);
            //console.log("%c DKPlugin2.fromFile(): klass = "+klass, color);
            //console.log("%c DKPlugin2.fromFile(): klass.name = " + klass.name, color);
            //console.log("%c DKPlugin2.fromFile(): klass.singleton = " + klass.singleton, color);
            //console.log("%c DKPlugin2.fromFile(): klass.prototype = " + klass.prototype, color);

            if (typeof klass.prototype.init === "function") {
                klass.prototype.init(function() {

                    DKPlugin2_fromFile_callback && DKPlugin2_fromFile_callback(klass);
                })
            } else
                DKPlugin2_fromFile_callback && DKPlugin2_fromFile_callback(klass);
            return klass;
        }
    }
}

DKPlugin2.fromClass = function DKPlugin2_fromClass(args, DKPlugin2_fromFile_callback) {
    const color = "color:rgb(100,190,190)"
    console.log("%c *** DKPlugin2.fromClass(" + args[0].name + ") ***", color);
    const klass = args[0]
    const klassName = klass.name

    //console.log("%c DKPlugin2.fromClass(): this = "+this, color);
    //console.log("%c DKPlugin2.fromClass(): this.constructor.name = " + this.constructor.name, color);
    //console.log("%c DKPlugin2.fromClass(): this.singleton = " + this.singleton, color);
    //console.log("%c DKPlugin2.fromClass(): this.prototype = " + this.prototype, color);
    //console.log("%c DKPlugin2.fromClass(): klass = "+klass, color);
    //console.log("%c DKPlugin2.fromClass(): klass.name = " + klass.name, color);
    //console.log("%c DKPlugin2.fromClass(): klass.singleton = " + klass.singleton, color);
    //console.log("%c DKPlugin2.fromClass(): klass.prototype = " + klass.prototype, color);

    for (let n = 0; n < args.length; n++) {
        if (args[n] === "singleton") {
            klass.singleton = "fromClass(): klass.singleton";
            klass.prototype.singleton = "fromClass(): klass.prototype.singleton";
            //console.log("DKPlugin2.fromClass() klass.singleton set");
            //console.log("DKPlugin2.fromClass() klass.prototype.singleton set");
            for (let n = 0; n < DKPlugin2.instances.length; n++) {
                if (DKPlugin2.instances[n].klassName == klassName) {
                    console.log("A singleton instance of " + klassName + " already exists");
                    DKPlugin2.instances[n].dkframe.bringToFront(DKPlugin2.instances[n].dkframe.frame);
                    //DKPlugin2_fromFile_callback && DKPlugin2_fromFile_callback(DKPlugin2.instances[n])
                    return false;
                    //DKPlugin2.instances[n];
                }
            }
        }
    }

    //https://stackoverflow.com/a/50402530/688352
    
    //this[klassName] = {
    //    [klassName]: function() {
    

    const instance = new klass;
    //dk.dump(instance)
    const instance2 = Object.create(klass);
    //dk.dump(instance2)
    

    //console.log("%c new "+instance.constructor.name, color)
    //console.log("%c DKPlugin2.fromClass(): klass.name = " + klass.name, color)
    //console.log("%c DKPlugin2.fromClass(): klass.singleton = " + klass.singleton, color)
    //console.log("%c DKPlugin2.fromClass(): klass.prototype.singleton = " + klass.prototype.singleton, color)
    //console.log("%c DKPlugin2.fromClass(): instance = "+instance.toString(), color);
    //console.log("%c DKPlugin2.fromClass(): instance.constructor.name = " + instance.constructor.name, color);
    //console.log("%c DKPlugin2.fromClass(): instance.singleton = " + instance.singleton, color);
    //console.log("%c DKPlugin2.fromClass(): instance.prototype = " + instance.prototype, color);
    

    if (instance.__proto__.constructor.name !== klassName) {
        console.error("A new " + klassName + " was defined in the " + instance.__proto__.constructor.name + " scope");
        console.error("instances of " + klassName + " must be constucted with the " + klassName + " class scope");
        return false;
    }
    const result = DKPlugin2.createInstance.call(instance, arguments);
    if (result != instance)
        return error("instance !== result");
    !instance.supervised && DKPlugin2.prototype.superviseFuncs(instance);
    return result;

    //    }
    //}
    //return this[klassName][klassName]();
}

DKPlugin2.createInstance = function DKPlugin2_createInstance() {
    const color = "color:rgb(250,200,200);"
    console.log("%c *** DKPlugin2.createInstance() ***", color);
    //console.log("%c DKPlugin2.createInstance(): this = " + this.toString(), color);
    //console.log("%c DKPlugin2.createInstance(): this.constructor.name = " + this.constructor.name, color);
    //console.log("%c DKPlugin2.createInstance(): this.singleton = " + this.singleton, color);
    const klassName = this.constructor.name;
    const klass = window[klassName];
    //console.log("%c DKPlugin2.createInstance(): klass.singleton = " + klass.singleton, color)
    //console.log("%c DKPlugin2.createInstance(): klass.prototype.singleton = " + klass.prototype.singleton, color)

    this.klassName = this.constructor.name;

    //Is this instance already running?
    const i = DKPlugin2.instances.indexOf(this);
    if (i > -1) {
        console.warn("Returning already existing instance with id: " + this.id + " @index " + i);
        DKPlugin2.instances[i].ok = false;
        return DKPlugin2.instances[i];
    }

    //Set the ID or kick out existing singletons, while looping
    let num = 0;
    for (let n = 0; n < DKPlugin2.instances.length; n++) {
        if (DKPlugin2.instances[n].klassName === this.klassName) {
            //if (this.prototype.singleton || DKPlugin2.instances[n].prototype.singleton) {
            //    console.warn(this.klassName + " already has a 'singleton' instance");
            //    return false;
            //}
            if ((this.klassName + num) === DKPlugin2.instances[n].id) {
                n = 0;
                num++
            }
        }
    }
    !this.id && (this.id = this.klassName + num);

    // Wrap the plugins memeber functions with error catching
    dk.errorCatcher(this, this.klassName);

    //Add the new instance to the plugin stack
    const newIndex = DKPlugin2.instances.push(this) - 1;
    //DKPlugin2.instances[newIndex].ok = true;
    this.DKPlugin2 = true;
    return DKPlugin2.instances[newIndex];
}

// When calls are made to init, end, create and close, DKPlugin2 will take presidence
// and control the flow. If an object calls a DKPlugin2 to close completley, you may be in a frame,
// or container that would get stranded. For this reason, DKPlugin2 will determine who goes first and what 
// cleanup to do. The idea it to accomplish most of the work here, leaving less worries about instance management.
DKPlugin2.prototype.init = function DKPlugin2_init() {
    //This function is never called
    console.group("%c DKPlugin2.prototype.init(): " + this.constructor.name, "color:orange;");
    return;
    if (!this) {
        console.groupEnd();
        return error("this is invalid");
    }
    if (this.constructor.name === "Object") {
        console.groupEnd();
        return error("the instance in DKPlugin2.prototype.init() is a constructor of 'Object' and should be the class name");
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

DKPlugin2.prototype.end = function DKPlugin2_end() {
    color = "color:rgb(250,150,150);"
    console.log("%c *** DKPlugin2.prototype.end() ***", color);
    //console.log("%c DKPlugin2.prototype.end(): this = " + this.toString(), color);
    //console.log("%c DKPlugin2.prototype.end(): this.constructor.name = " + this.constructor.name, color);
    //console.log("%c DKPlugin2.prototype.end(): this.singleton = " + this.singleton, color);
    const klassName = this.constructor.name;
    const klass = window[klassName];
    //console.log("%c DKPlugin2.prototype.end(): klass.singleton = " + klass.singleton, color)
    //console.log("%c DKPlugin2.prototype.end(): klass.prototype.singleton = " + klass.prototype.singleton, color)

    if (this.xend) {
        console.group(this.constructor.name + ".xend()");
        this.xend.apply(this, arguments);
        console.groupEnd();
    }

    DKPlugin2.prototype.unsuperviseFuncs(this);

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

DKPlugin2.prototype.create = function DKPlugin2_create(klass) {
    console.group("DKPlugin2.prototype.create(" + klass + ")");
    //console.group("DKPlugin2.prototype.create(): " + this.constructor.name);
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

DKPlugin2.prototype.close = function DKPlugin2_close() {
    console.group("DKPlugin2.prototype.close(): " + this.id);

    //remove any owned html elements from the DOM
    for (let key in this) {
        if (this[key]instanceof Element) {
            if (!this[key].parentNode) {
                console.error(this.constructor.name + " parentNode invalid");
                continue;
            }
            this[key].parentNode.removeChild(this[key]);
            if (!delete this[key])
                console.error(this.constructor.name + " could not be deleted");
        }
    }

    

    if (this.xclose && this.xclose !== this.close) {
        console.group(this.constructor.name + ".close");
        this.xclose();        
        console.groupEnd();
    }

    DKPlugin2.prototype.unsuperviseFuncs(this);
    DKPlugin2.prototype.removeInstance(this);
    

    //if any more of this type exist, don't end
    for (let n = 0; n < DKPlugin2.instances.length; n++) {
        if (DKPlugin2.instances[n].klassName === this.klassName) {
            console.groupEnd();
            return
        }
    }

    //TODO - This can be handles by the user
    //this.end();
    console.groupEnd();
}

DKPlugin2.prototype.removeInstance = function DKPlugin2_removeInstance(instance) {
    console.log("DKPlugin2.prototype.removeInstance(): " + instance.constructor.name);
    const index = DKPlugin2.instances.indexOf(instance);
    if (index <= -1) {
        console.error("Unable to find instance in DKPlugin2");
        return;
    }
    DKPlugin2.instances.splice(index, 1);
    return true;
}

DKPlugin2.prototype.superviseFuncs = function DKPlugin2_superviseFuncs(instance) {
    //console.log("DKPlugin2.prototype.superviseFuncs(): " + instance.constructor.name);
    if (instance.supervised)
        return;
    if (instance.init)
        instance.xinit = instance.init;
    instance.init = DKPlugin2.prototype.init;
    if (instance.create)
        instance.xcreate = instance.create;
    instance.create = DKPlugin2.prototype.create;
    if (instance.close)
        instance.xclose = instance.close;
    instance.close = DKPlugin2.prototype.close;
    if (instance.end)
        instance.xend = instance.end;
    instance.end = DKPlugin2.prototype.end;
    instance.supervised = true;
}

DKPlugin2.prototype.unsuperviseFuncs = function DKPlugin2_unsuperviseFuncs(instance) {
    //console.log("DKPlugin2.prototype.unsuperviseFuncs(): " + instance.constructor.name);
    if (!instance.supervised)
        return;
    if (instance.xinit)
        instance.init = instance.xinit;
    //instance.xinit = DKPlugin2.prototype.init;
    if (instance.xcreate)
        instance.create = instance.xcreate;
    //instance.xcreate = DKPlugin2.prototype.create;
    if (instance.xclose)
        instance.close = instance.xclose;
    //instance.xclose = DKPlugin2.prototype.close;
    if (instance.xend)
        instance.end = instance.xend;
    //instance.xend = DKPlugin2.prototype.end;
    instance.supervised = false;
}
*/

DKPlugin2.instances = new Array;
