
"use strict";

dk.testWidget = new DKWidget;

dk.testWidget.create = function dk_testWidget_create(){
    console.log("dk.testWidget.create() called");
    this.getInstanceInfo("testWidget");
}


const David = new DKWidget;
David.getInstanceInfo("David");

const Johnny = new DKWidget;
Johnny.getInstanceInfo("Johnny");

const Tony = new DKWidget;
David.getInstanceInfo("Tony");