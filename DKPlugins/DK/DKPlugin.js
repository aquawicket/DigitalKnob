//"use strict"; //FIXME: this breaks duktape

//https://www.phpied.com/3-ways-to-define-a-javascript-class/

const DKPlugin = function DKPlugin() {

    // When calls are made to init, end, create and close, DKPlugin will take presidence
    // and control flow. If an object calls you to close completley, you may be in a frame,
    // or container that would get stranded. DKPlugin will determine who goes first and what 
    // cleanup to do. 
    DKPlugin.prototype.superviseFuncs = function DKPlugin_superviseFuncs(plugin) {
        console.debug("DKPlugin.prototype.superviseFuncs():" + plugin.id);

        if (plugin.init)
            plugin.xinit = plugin.init;
        plugin.init = DKPlugin.prototype.init;

        if (plugin.create)
            plugin.xcreate = plugin.create;
        plugin.create = DKPlugin.prototype.create;

        if (plugin.close)
            plugin.xclose = plugin.close;
        plugin.close = DKPlugin.prototype.close;

        if (plugin.end)
            plugin.xend = plugin.end;
        plugin.end = DKPlugin.prototype.end;

        plugin.supervised = true;
    }

    DKPlugin.prototype.init = function DKPlugin_init(callback) {
        console.log("DKPlugin.prototype.init(): " + this.id);
        //!this.plugin && (this.plugin = DKPlugin.prototype);
        !this.supervised && DKPlugin.prototype.superviseFuncs(this);
        this.xinit && this.xinit(function xinit_callback() {
            callback && callback(this);
        });
        return this;
    }

    DKPlugin.prototype.end = function DKPlugin_end() {
        console.log("DKPlugin.prototype.end(): " + this.id);
        if (this.xend)
            this.xend.apply(this, arguments);

        var plugin = dk.getPlugin(this.url);
        delete this;
        delete DKDevTools.prototype;
        delete dk[plugin.name];

        var scripts = document.getElementsByTagName("script");
        for (var n = 0; n < scripts.length; n++) {
            if (scripts[n].src.includes(this.url)) {
                scripts[n].parentNode.removeChild(scripts[n]);
                break;
            }
        }
    }

    DKPlugin.prototype.create = function DKPlugin_create() {
        console.log("DKPlugin.prototype.create(): " + this.id);
        if (this.singleton) {
            this.create = function() {
                console.log("create() is disabled on singletons after first call");
            }
        }
        
        /*
        function cb(instance) {
            callback(instance);
            return instance;
        }

        const instance = this;
        */
        if (this.xcreate) {
            //if (callback) {
                //return this.xcreate.apply(this, arguments, cb);
            //} else
                return this.xcreate.apply(this, arguments);
        }
        return instance;     
    }

    DKPlugin.prototype.close = function DKPlugin_close() {
        console.log("DKPlugin.prototype.close(" + this.id + ")");

        DKPlugin.prototype.removeInstance(this);
        if (this.xclose)
            return this.xclose.apply(this, arguments);
    }

    DKPlugin.prototype.removeInstance = function DKPlugin_removeInstance(instance) {
        console.log("DKPlugin.prototype.removeInstance(): " + instance.id);
        const index = DKPlugin.instances.indexOf(instance);
        if (index <= -1)
            return error("Unable to find instance in DKPlugin");
        DKPlugin.instances.splice(index, 1);
        return true;
    }

    DKPlugin.prototype.setUrl = function DKPlugin_setUrl(url) {
        //console.log("DKPlugin.prototype.setUrl(): " + this.id);
        this.url = url;
    }

    DKPlugin.prototype.getUrl = function DKPlugin_getUrl() {
        //console.log("DKPlugin.prototype.getUrl(): " + this.id);
        if (!this.url)
            return error("this.url invalid");
        return this.url;
    }

    DKPlugin.prototype.setAccessNode = function DKPlugin_setAccessNode(node) {
        //console.log("DKPlugin.prototype.setAccessNode(): " + this.id);
        if (!node instanceof EventTarget)
            return error("setAccessNode() requires an node thats an instanceof EventTarget");
        this.node = node;
    }

    DKPlugin.prototype.getAccessNode = function DKPlugin_getAccessNode() {
        //console.log("DKPlugin.prototype.getAccessNode(): " + this.id);
        if (!this.node)
            return error("DKPlugin.getAccessNode(): node not set, please use yourDKPlugin.setAccessNode(node)");
        return this.node;
    }

    //// EXECUTION STARTS HERE
    const i = DKPlugin.instances.indexOf(this);
    if (i > -1) {
        console.warn("Returning already existing instance with id: " + this.id + " @index " + i);
        DKPlugin.instances[i].ok = false;
        return DKPlugin.instances[i];
    }

    if (arguments[0] && arguments[0][0] && arguments[0][0] === "singleton")
        this.singleton = true;
    else if (typeof arguments[0][0] === "string")
        this.id = arguments[0][0];
    this.type = this.constructor.name;
    //!this.id && (this.id = this.type);

    let num = 0;
    for (let n = 0; n < DKPlugin.instances.length; n++) {
        if (DKPlugin.instances[n].type === this.type) {
            if (this.singleton || DKPlugin.instances[n].singleton) {
                console.warn("Returning existing 'singleton' instance of type: " + this.type + " @index " + index);
                DKPlugin.instances[n].ok = false;
                return DKPlugin.instances[n];
            }
            if ((this.type + num) === DKPlugin.instances[n].id) {
                n = 0;
                num++
            }
        }
    }
    !this.id && (this.id = this.type + num);

    const newIndex = DKPlugin.instances.push(this) - 1;
    DKPlugin.instances[newIndex].ok = true;
    dk.errorCatcher(this, this.type);
    //console.debug("DKPlugin.body: " + this.id);
    this.plugin = DKPlugin.prototype;
    return DKPlugin.instances[newIndex];
}

DKPlugin.instances = new Array;

DKPlugin.create = function DKPlugin_create(url) {
    console.debug("DKPlugin.create(" + url + ")");
    var scripts = document.getElementsByTagName("script");
    for (var n = 0; n < scripts.length; n++) {
        if (scripts[n].src.includes(url)) {
            console.info("%c" + url + " is already loaded", "color:orange;");
            return true;
        }
    }
    var head = document.getElementsByTagName('head')[0];
    var script = document.createElement('script');
    script.id = url;
    script.setAttribute('type', 'text/javascript');
    script.setAttribute('async', true);
    script.setAttribute('src', url);
    head.appendChild(script);
}
