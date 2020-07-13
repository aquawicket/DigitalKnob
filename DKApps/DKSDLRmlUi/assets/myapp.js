//https://stackoverflow.com/a/49434962/688352

DKCreate("DK/DK.css", function(){
DKCreate("DKFile/DKFile.js", function(){
DKCreate("DKWidget/DKWidget.js", function(){
DKCreate("DKGui/DKFrame.js", function(){
DKCreate("DKColorPicker/DKColorPicker.js", function(){
	DKFrame_Widget("DKColorPicker/DKColorPicker.html");
});
});
});
});
});


/*
instances = [];
var Object1 = function(address)
{
	return Object2.call(this, address);
}

var Object2 = function(address)
{
	return Object3.call(this, address);
}

var Object3 = function(address)
{
	this.address = address;
	for(var i=0; i<instances.length; i++){
        if(instances[i].address == address){
			console.log("return existing instance "+address);
            return instances[i];
        }
    }
	
	console.log("creating instance "+address);
	instances.push(this);
	return this;
}

var test1 = new Object1("123");
var test2 = new Object1("123");
var test3 = new Object2("123");


console.log("\n");
console.log("document = "+document);
console.log("test1 = "+test1);
console.log("test2 = "+test2);
console.log("test3 = "+test3);
console.log("test1 == test1: "+(test1 == test1));
console.log("test1 == test2: "+(test1 == test2));
console.log("test1 == test3: "+(test1 == test3));
console.log("\n");
*/