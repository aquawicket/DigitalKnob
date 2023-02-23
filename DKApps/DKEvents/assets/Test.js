// Event test
console.log("\n\n ___Event Test___\n");

/////////// MyObjectA /////////////////////
console.log("/////////// MyObjectA /////////////////////")

const myObjectA = new MyObject('myObjectA')
//console.log("myObjectA = "+myObjectA)
//console.log("myObjectA.value = "+myObjectA.value)
//console.log("myObjectA.test() = "+myObjectA.test())
//console.log("\n")

function myCallbackA(){
	console.log("myCallbackA()\n")
}
myObjectA.addEventListener('myEventA', myCallbackA)
const myEventA = new Event('myEventA')
myObjectA.dispatchEvent(myEventA);
myObjectA.removeEventListener('myEventA', myCallbackA)
myObjectA.dispatchEvent(myEventA);
console.log("\n\n")



/////////// MyObjectB /////////////////////
console.log("/////////// MyObjectB /////////////////////")

const myObjectB = new MyObject('myObjectB')
//console.log("myObjectB = "+myObjectB)
//console.log("myObjectB.value = "+myObjectB.value)
//console.log("myObjectB.test() = "+myObjectB.test())
//console.log("\n")


function myCallbackB(){
	console.log("myCallbackB()\n")
}
myObjectB.addEventListener('myEventB', myCallbackB)
//const myEventB = new Event('myEventB')
//myObjectB.dispatchEvent(myEventB);
//myObjectB.removeEventListener('myEventB', myCallbackB)
//myObjectB.dispatchEvent(myEventB);


function myObjectB_onmessage(){
	console.log("myObjectB_onmessage()\n")
}
myObjectB.onmessage = myObjectB_onmessage;
//const myEventB_onmessage = new Event('message')
//myObjectB.dispatchEvent(myEventB_onmessage);

/*
function myObjectB_ontest(){
	console.log("myObjectB_ontest()\n")
}
myObjectB.ontest = myObjectB_ontest;
const myEventB_ontest = new Event('test')
myObjectB.dispatchEvent(myEventB_ontest);
*/

myObjectB.test()
console.log("\n\n")
