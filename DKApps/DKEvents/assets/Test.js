// Event test
console.log("\n\n ___Event Test___");

/////////// MyObjectA /////////////////////
console.log("/////////// MyObjectA /////////////////////")
function myCallbackA(){
	console.log("myCallbackA()")
}
const myObjectA = new MyObject('myObjectA')
console.log("myObjectA = "+myObjectA)
console.log("myObjectA.value = "+myObjectA.value)
console.log("myObjectA.test() = "+myObjectA.test())

myObjectA.addEventListener('myEventA', myCallbackA)
const myEventA = new Event('myEventA')
myObjectA.dispatchEvent(myEventA);
myObjectA.removeEventListener('myEventA', myCallbackA)
myObjectA.dispatchEvent(myEventA);
console.log("\n\n")



/////////// MyObjectB /////////////////////
console.log("/////////// MyObjectB /////////////////////")
function myCallbackB(){
	console.log("myCallbackB()")
}
function myObjectB_onmessage(){
	console.log("myObjectB_onmessage()")
}
const myObjectB = new MyObject('myObjectB')
console.log("myObjectB = "+myObjectB)
console.log("myObjectB.value = "+myObjectB.value)
console.log("myObjectB.test() = "+myObjectB.test())

myObjectB.addEventListener('myEventB', myCallbackB)
const myEventB = new Event('myEventB')
myObjectB.dispatchEvent(myEventB);
myObjectB.removeEventListener('myEventB', myCallbackB)
myObjectB.dispatchEvent(myEventB);

myObjectB.onmessage = myObjectB_onmessage;
const myEventB_onmessage = new Event('message')
myObjectB.dispatchEvent(myEventB_onmessage);
console.log("\n\n")
