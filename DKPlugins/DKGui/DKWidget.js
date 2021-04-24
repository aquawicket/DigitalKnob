"use strict";


const DKWidget = function() {

    DKWidget.prototype.storeInstance = function() {
        this.instance = this;
        for (var i = 0; i < DKWidget.instances.length; i++) {
            if (DKWidget.instances[i].instance === this.instance) {
                return instances[i];
                console.debug("this instance allready exists");
            }
        }
        console.debug("pushing new DKWidget instance");
        DKWidget.instances.push(this);
    }

    DKWidget.prototype.create = function() {
        //console.log("DKWidget.create() called");
    }
    DKWidget.prototype.getInstanceInfo = function(callerName) {
        //console.log("DKWidget.getInstanceIndex() called");
        for (var n = 0; n < instances.length; n++) {
            if (DKWidget.instances[n].instance === this.instance) {
                console.log("(INSTANCE) name:" + callerName + " index:" + n + " total:" + DKWidget.instances.length);
                return n;
            }
        }
    }

    DKWidget.prototype.setElement = function(element){
        console.debug("DKWidget.setElement() called");
        this.element = element;
    }

    DKWidget.prototype.getElement = function(element){
        console.debug("DKWidget.getElement() called");
        return this.element;
    }

    DKWidget.prototype.close = function() {
        console.log("DKWidget.close() called");
        for (var i = 0; i < DKWidget.instances.length; i++) {
            if (DKWidget.instances[i].instance === this.instance) {
                console.debug("instance found");
                //return instances[i];
            }
        }
        let index = DKWidget.instances.indexOf(this.instance);
        if(index > -1)
            console.log("found the instance at index "+index);
    }

    //STARTS HERE
    this.storeInstance();
}

DKWidget.instances = new Array;