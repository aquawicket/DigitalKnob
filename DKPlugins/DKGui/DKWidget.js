"use strict";


var instances = []
const DKWidget = function() {
    //find an available index number for the instance
    this.instance = this;
    for(var i=0; i<instances.length; i++){
        if(instances[i].instance === this.instance){
            return instances[i]; //return already existing instance
        }
    }
    instances.push(this);

    DKWidget.prototype.create = function(){
        console.log("DKWidget.create() called");
    }
    DKWidget.prototype.getInstanceInfo = function(callerName){
        console.log("DKWidget.getInstanceIndex() called");
        for(var n=0; n<instances.length; n++){
            if(instances[n].instance === this.instance){
                console.log("(INSTANCE) name:"+callerName+" index:"+n+" total:"+instances.length);
                return n;
            }
        }
    }
    DKWidget.prototype.close = function(){
		console.log("DKWidget.close() called");
	}

    
}
