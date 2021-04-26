"use strict";

const DKWidget = function() {
    /*
    DKWidget.prototype.storeInstance = function() {
        this.instance = this;
        const index = DKWidget.instances.indexOf(this.instance);
        if (index > -1) {
            console.warn("this.instance already exists in DKWidget");
            return DKWidget.instances[index];
        }
        console.debug("pushing new DKWidget instance");
        DKWidget.instances.push(this);
        return DKWidget.instances[DKWidget.instances.length - 1];
    }
    */

    DKWidget.prototype.create = function() {//console.log("DKWidget.create() called");
    }

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
        DKWidget.instances[index].removeInstance(DKWidget.instances[index]);
        return true;
    }

    //EXECUTION STARTS HERE
    this.instance = this;
    const index = DKWidget.instances.indexOf(this.instance);
    if (index > -1) {
        console.warn("this.instance already exists in DKWidget");
        return DKWidget.instances[index];
    }
    //this.storeInstance();
    console.debug("pushing new DKWidget instance");
    DKWidget.instances.push(this);
    return DKWidget.instances[DKWidget.instances.length - 1];
}

DKWidget.instances = new Array;
