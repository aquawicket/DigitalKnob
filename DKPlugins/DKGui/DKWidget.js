"use strict";

const DKWidget = function(singleton) {
    DKWidget.prototype.getInstance = function(instance) {
        //console.debug("DKWidget.getInstance() called");
        const index = DKWidget.instances.indexOf(instance);
        if (index <= -1)
            return error("Unable to find instance in DKWidget");
        return DKWidget.instances[index];
    }

    DKWidget.prototype.removeInstance = function(instance) {
        //console.debug("DKWidget.removeInstance() called");
        const index = DKWidget.instances.indexOf(instance);
        if (index <= -1)
            return error("Unable to find instance in DKWidget");
        DKWidget.instances.splice(index, 1);
        console.debug("removed DKWidget instance @ index " + index);
        return true;
    }

    DKWidget.prototype.getInstanceInfo = function(callerName) {
        //console.log("DKWidget.getInstanceIndex() called");
        const index = DKWidget.instances.indexOf(this.instance);
        if (index <= -1)
            return error("Unable to find instance in DKWidget");
        console.debug("(INSTANCE) name:" + callerName + " index:" + index + " total:" + DKWidget.instances.length);
        return index;
    }

    DKWidget.prototype.setElement = function(element) {
        //console.debug("DKWidget.setElement() called");
        this.element = element;
    }

    DKWidget.prototype.getElement = function(element) {
        //console.debug("DKWidget.getElement() called");
        return this.element;
    }

    DKWidget.prototype.close = function() {
        console.debug("DKWidget.close() called");
        const index = DKWidget.instances.indexOf(this.instance);
        if (index <= -1)
            return error("Unable to find instance in DKWidget");
        delete DKWidget.instances[index].singleton;
        DKWidget.instances[index].removeInstance(DKWidget.instances[index]);
        return true;
    }

    //EXECUTION STARTS HERE

    if (singleton) {
        this.singleton = singleton;
        for(let n=0; n<DKWidget.instances.length; n++){
            if(DKWidget.instances[n].singleton === this.singleton){
                console.error("this.singleton already exists in DKWidget");
                DKWidget.instances[n].ok = false;
                return false;
            }
        }
    }

    this.instance = this;
    const index = DKWidget.instances.indexOf(this.instance);
    if (index > -1) {
        console.warn("this.instance already exists in DKWidget");
        return DKWidget.instances[index];
    }
    console.debug("creating new instance of DKWidget");
    DKWidget.instances.push(this.instance);
    DKWidget.instances[DKWidget.instances.length - 1].ok = true;
    return DKWidget.instances[DKWidget.instances.length - 1];
}

DKWidget.instances = new Array;
