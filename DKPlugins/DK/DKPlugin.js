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
        //dk.errorCatcher(this);
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
    DKPlugin.prototype.create = function DKPlugin_create() {
        console.log("DKPlugin.prototype.create()");
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
        //console.debug("DKPlugin.getInstance() called");
        const index = DKPlugin.instances.indexOf(instance);
        if (index <= -1)
            return error("Unable to find instance in DKPlugin");
        return DKPlugin.instances[index];
    }

    DKPlugin.prototype.removeInstance = function DKPlugin_removeInstance(instance) {
        //console.debug("DKPlugin.removeInstance() called");
        const index = DKPlugin.instances.indexOf(instance);
        if (index <= -1)
            return error("Unable to find instance in DKPlugin");
        DKPlugin.instances.splice(index, 1);
        //console.debug("removed DKPlugin("+identifier+") @index "+(index));
        return true;
    }

    DKPlugin.prototype.getInstanceInfo = function DKPlugin_getInstanceInfo(callerName) {
        const index = DKPlugin.instances.indexOf(this);
        if (index <= -1)
            return error("Unable to find instance in DKPlugin");
        //console.debug("(INSTANCE) name:" + callerName + " index:" + index + " total:" + DKPlugin.instances.length);
        return index;
    }

    DKPlugin.prototype.setUrl = function DKPlugin_setUrl(url) {
        this.url = url;
    }

    DKPlugin.prototype.getUrl = function DKPlugin_getUrl() {
       if (!this.url)
            return error("DKPlugin.getUrl(): url not set, please use yourDKPlugin.setUrl(url)");
       return this.url;
    }

    DKPlugin.prototype.setAccessNode = function DKPlugin_setAccessNode(node) {
        if (!node instanceof EventTarget)
            return error("setAccessNode() requires an node thats an instanceof EventTarget");
        this.node = node;
    }

    DKPlugin.prototype.getAccessNode = function DKPlugin_getAccessNode() {
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

    //Not sure how this can happen, just to be safe...
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
