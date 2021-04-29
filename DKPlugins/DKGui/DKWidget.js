"use strict";

//Multiple instances of DKWidget derived objects are allowed by default.
//To make it singleton, simpily pass a unique name to your new DKWidget() call. I.E.  const colorSettingsWindow = new DKWidget("ColorSettingWindow");
//You can also make semi-singleton objects that use an identifier to differentiate between mucitiple objects 
//The identifier vabliable can be a label, name, and item number.. just something unique to that object instance. 
//The DKWidget constructor will not allwow multiple instances with the same identifier value to be created
//After creating the DKWidget object, check it's .ok derived variable before continuing processing.
//To use other gui compenents with your widget, like dk.frame, the you widgets base element with .setElement(element);

//A typical DKWidget might look something like this.
const CreateMyWidget = function()
{
    const myWidget = new DKWidget("myWidget");
    if (!myWidget.ok)
        return;

    const myDiv = document.createElement("div");
    myDiv.id = "My_Widget";
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

    myWidget.setElement(myDiv);
    dk.frame.create(myWidget);
}


const DKWidget = function(identifier) {
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
        console.debug("removed DKWidget("+identifier+") @index "+(index));
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
        if(!element instanceof EventTarget)
            return error("setElement() requires an element node thats an instanceof EventTarget");
        this.element = element;
    }

    DKWidget.prototype.getElement = function() {
        if(!this.element)
            return error("DKWidget.getElement(): element not set, please use yourDKWidget.setElement(elem)");
        return this.element;
    }

    DKWidget.prototype.close = function() {
        const index = DKWidget.instances.indexOf(this.instance);
        if (index <= -1)
            return error("Unable to find instance in DKWidget");
        delete DKWidget.instances[index].singleton;
        DKWidget.instances[index].removeInstance(DKWidget.instances[index]);
        return true;
    }

    //EXECUTION STARTS HERE
    if (arguments.length) {
        if (arguments[0] === undefined) {
            let errmsg = "DKWidget was invoked with an argument that evaluated to undefined.\n";
            errmsg += "Please try a different variable to differentiate this object across multiple instances.\n";
            errmsg += "If you wish to make this object completley singleton, just pass it a unique name\n";
            return error(errmsg);
        }

        const identifier = arguments[0];
        if (identifier) {
            this.identifier = identifier;
            for (let n = 0; n < DKWidget.instances.length; n++) {
                if (DKWidget.instances[n].identifier == this.identifier) {
                    console.debug("DKWidget("+identifier+") already exists");
                    DKWidget.instances[n].ok = false;
                    return DKWidget.instances[n];
                }
            }
        }
    }
    this.instance = this;
    
    //Not sure how this can happen, just to be safe...
    if(DKWidget.instances.includes(this.instance)){
        const index = DKWidget.instances.indexOf(this.instance);
        console.error("this.instance already exists in DKWidget @inxed "+index);
        DKWidget.instances[index].ok = false;
        return DKWidget.instances[index];
    }

    const index = DKWidget.instances.push(this.instance)-1;
    DKWidget.instances[index].ok = true;
    console.debug("created DKWidget("+identifier+") @index "+index);
    return DKWidget.instances[index];
}

DKWidget.instances = new Array;
