//"use strict"; //FIXME: this breaks duktape
//https://www.phpied.com/3-ways-to-define-a-javascript-class/

const DKPlugin = function DKPlugin() {
    // When calls are made to init, end, create and close, DKPlugin will take presidence
    // and control the flow. If an object calls a plugin to close completley, you may be in a frame,
    // or container that would get stranded. For this reason, DKPlugin will determine who goes first and what 
    // cleanup to do. The idea it to accomplish most of the work here, leaving plugins to not worry about instance management.
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

    DKPlugin.prototype.unsuperviseFuncs = function DKPlugin_unsuperviseFuncs(plugin) {
        console.debug("DKPlugin.prototype.unsuperviseFuncs():" + plugin.id);
        if (plugin.xinit)
            plugin.init = plugin.xinit;
        plugin.xinit = DKPlugin.prototype.init;
        if (plugin.xcreate)
            plugin.create = plugin.xcreate;
        plugin.xcreate = DKPlugin.prototype.create;
        if (plugin.xclose)
            plugin.close = plugin.xclose;
        plugin.xclose = DKPlugin.prototype.close;
        if (plugin.xend)
            plugin.end = plugin.xend;
        plugin.xend = DKPlugin.prototype.end;
        plugin.supervised = false;
    }

    DKPlugin.prototype.init = function DKPlugin_init() {
        console.log("DKPlugin.prototype.init(): " + this.id);
        this.plugin.url = this.url;
        !this.supervised && DKPlugin.prototype.superviseFuncs(this);
        if (this.xinit)
            return this.xinit.apply(this, arguments);
        return this;
    }

    DKPlugin.prototype.end = function DKPlugin_end() {
        console.log("DKPlugin.prototype.end(): " + this.id);
        if (this.xend)
            this.xend.apply(this, arguments);
        DKPlugin.prototype.unsuperviseFuncs(this);
        const plugin = dk.getPlugin(this.url);
        this.singleton = false;
        delete this.plugin;
        delete dk[plugin.name];
        const scripts = document.getElementsByTagName("script");
        for (let n = 0; n < scripts.length; n++) {
            if (scripts[n].src.includes(this.url)) {
                scripts[n].parentNode.removeChild(scripts[n]);
                console.log("Unloaded " + this.url);
                break;
            }
        }
    }

    DKPlugin.prototype.create = function DKPlugin_create() {
        console.log("DKPlugin.prototype.create(): " + this.id);
        if (this.singleton)
            this.create = function() {
                console.log("create() is disabled on singletons after first call");
            }
        if (this.xcreate)
            return this.xcreate.apply(this, arguments);
        return instance;
    }

    DKPlugin.prototype.close = function DKPlugin_close() {
        console.log("DKPlugin.prototype.close(" + this.id + ")");
        //if only one instance exists, go ahead and call end to clean up
        let count = 0;
        for (let n = 0; n < DKPlugin.instances.length; n++) {
            if (DKPlugin.instances[n].type === this.type)
                count++;
            if (count > 1)
                break;
        }
        DKPlugin.prototype.removeInstance(this);
        if (this.xclose) {
            if (count > 1)
                return this.xclose.apply(this, arguments);
            else if (count)
                this.xclose.apply(this, arguments);
            else
                return error("Instance called to close, but does not exist in the instance list.")
        }
        if (count < 2)
            this.end();
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
    this.plugin = DKPlugin.prototype;
    return DKPlugin.instances[newIndex];
}

DKPlugin.instances = new Array;

// TODO
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
