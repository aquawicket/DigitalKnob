//"use strict"; //FIXME: this breaks duktape

//Multiple instances of DKPlugin derived objects are allowed by default.
//To make it singleton, simpily pass a unique name to your new DKPlugin() call. I.E.  const colorSettingsWindow = new DKPlugin("ColorSettingWindow");
//You can also make semi-singleton objects that use an identifier to differentiate between mucitiple objects 
//The identifier vabliable can be a label, name, and item number.. just something unique to that object instance. 
//The DKPlugin constructor will not allwow multiple instances with the same identifier value to be created
//After creating the DKPlugin object, check it's .ok derived variable before continuing processing.
//To use other gui compenents with your widget, like dk.frame, the you widgets base element with .setElement(element);

//A typical DKPlugin might look something like this.
const CreateMyPlugin = function CreateMyPlugin() {
    const myPlugin = new DKPlugin("myPlugin");
    if (!myPlugin.ok)
        return;

    const myDiv = document.createElement("div");
    myDiv.id = "My_Plugin";
    myDiv.style.width = "200px";
    myDiv.style.height = "200px";
    myDiv.style.backgroundColor = "rgb(50,50,50)";

    const text = document.createElement("span");
    text.innerHTML = "some content"
    text.style.position = "absolute";
    text.style.bottom = "60px";
    text.style.right = "70px";
    text.style.color = "rgb(0,0,0)";
    myDiv.appendChild(text);

    myPlugin.setElement(myDiv);
    dk.frame.create(myPlugin);
}

/**
 * returns a newly created DKPlugin instance 
 *
 * Example: const myThing = new DKPlugin(identifier)
 *
 * @param {identifier} "new" to create a new instance or a unique identifier
 * @returns the instance of the created DKPlugin object
 * @type object
 */
const DKPlugin = function DKPlugin(identifier) {

    DKPlugin.prototype.init = function DKPlugin_init(callback) {
        console.log("DKPlugin.prototype.init()");
        DKPlugin.errorCatcher(this);
        var scripts = document.getElementsByTagName("script");
        this.url = scripts[scripts.length-1].src;
        callback && callback(this);
        return this;
    }
    DKPlugin.prototype.end = function DKPlugin_end() {
        console.log("DKPlugin.prototype.end()");
        const plugin = dk.getPlugin(this.url);
        delete dk[plugin.name];
        var scripts = document.getElementsByTagName("script");
        for(let n=0; n<scripts.length; n++){
            if(scripts[n].src === this.url){
               scripts[n].parentNode.removeChild(scripts[n]);
               break;
            }
        }
        return true;
    }
    DKPlugin.prototype.create = function DKPlugin_create(callback) {
        console.log("DKPlugin.prototype.create()");
        callback && callback(this);
        return true;
    }
    DKPlugin.prototype.close = function DKPlugin_close() {
        console.log("DKPlugin.prototype.close()");
        const index = DKPlugin.instances.indexOf(this);
        if (index <= -1)
            return error("Unable to find instance in DKPlugin");
        DKPlugin.instances[index].removeInstance(DKPlugin.instances[index]);
        return true;
    }

    DKPlugin.prototype.getInstance = function DKPlugin_getInstance(instance) {
        console.log("DKPlugin.prototype.getInstance()");
        const index = DKPlugin.instances.indexOf(instance);
        if (index <= -1)
            return error("Unable to find instance of DKPlugin");
        return DKPlugin.instances[index];
    }

    DKPlugin.prototype.removeInstance = function DKPlugin_removeInstance(instance) {
        console.log("DKPlugin.prototype.removeInstance()");
        const index = DKPlugin.instances.indexOf(instance);
        if (index <= -1)
            return error("Unable to find instance in DKPlugin");
        DKPlugin.instances.splice(index, 1);
        return true;
    }

    DKPlugin.prototype.setUrl = function DKPlugin_setUrl(url) {
        console.log("DKPlugin.prototype.setUrl()");
        this.url = url;
    }

    DKPlugin.prototype.getUrl = function DKPlugin_getUrl() {
        console.log("DKPlugin.prototype.getUrl()");
       if (!this.url)
            return error("this.url invalid");
       return this.url;
    }

    DKPlugin.prototype.setAccessNode = function DKPlugin_setAccessNode(node) {
        console.log("DKPlugin.prototype.setAccessNode()");
        if (!node instanceof EventTarget)
            return error("setAccessNode() requires an node thats an instanceof EventTarget");
        this.node = node;
    }

    DKPlugin.prototype.getAccessNode = function DKPlugin_getAccessNode() {
        console.log("DKPlugin.prototype.getAccessNode()");
        if (!this.node)
            return error("DKPlugin.getAccessNode(): node not set, please use yourDKPlugin.setAccessNode(node)");
        return this.node;
    }

    //EXECUTION STARTS HERE
    if (arguments.length) {
        if (arguments[0] === undefined) {
            let errmsg = "DKPlugin was invoked with an argument that evaluated to undefined.\n";
            errmsg += "You can use the 'new' keyword to create new instances or,...\n";
            errmsg += "If you wish to make this object completley singleton, just pass it a unique constructor name like the name of the class\n";
            return error(errmsg);
        }

        let identifier = arguments[0];
        if (identifier) {
            //using the "new" keyword when callin DKPlugin() will create a new instance.
            if(identifier === "new")
                identifier = identifier+DKPlugin.instances.length;
            this.identifier = identifier;
            for (let n = 0; n < DKPlugin.instances.length; n++) {
                if (DKPlugin.instances[n].identifier == this.identifier) {
                    console.debug("DKPlugin(" + identifier + ") already exists");
                    DKPlugin.instances[n].ok = false;
                    return DKPlugin.instances[n];
                }
            }
        }
    }

    //Not sure how this can happen, but just to be safe...
    if (DKPlugin.instances.includes(this)) {
        const index = DKPlugin.instances.indexOf(this);
        console.error("An instance of this already exists in DKPlugin @index " + index);
        DKPlugin.instances[index].ok = false;
        return DKPlugin.instances[index];
    }

    const index = DKPlugin.instances.push(this) - 1;
    DKPlugin.instances[index].ok = true;
    //console.debug("created DKPlugin("+identifier+") @index "+index);
    return DKPlugin.instances[index];
}

DKPlugin.instances = new Array;


//https://humanwhocodes.com/blog/2009/04/28/javascript-error-handling-anti-pattern/
DKPlugin.errorCatcher = function dk_errorCatcher(object) {
    require({
        object
    });

    for (let obj in dk) {
        const dkObj = dk[obj];
        if (object !== dkObj)
            continue;
        for (let func in dkObj) {
            if(func.includes("_try"))
                continue;
            const method = dkObj[func];
            if (typeof method === "function") {
                Object.defineProperty(method, 'name', {
                    value: func
                })
                console.debug("dk." + obj + "." + func + "()");
                const funcName = func;
                dkObj[func] = function errorCatcher(func, method) {
                    return dkObj[func + "_try"] = function() {
                        try {
                            return method.apply(this, arguments);
                        } catch (err) {
                            //const stack = dk.trace.stackToConsoleString(err);
                            if (dk.console && dk.console.error) {
                                dk.console.error(err);
                                xconsole && xconsole.error(err);
                            } else
                                console.error(err);
                        }
                    }
                }(func, method);
            }
        }
    }
}


DKPlugin.dummyfunc = function DKPlugin_dummyfunc(){
    console.log("test dummy function");
}
