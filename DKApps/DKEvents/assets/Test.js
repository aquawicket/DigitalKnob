// Event test
console.log("\n\n ___Event Test___");

/////////// MyObjectA /////////////////////
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



/////////// MyObjectB /////////////////////
function myCallbackB(){
	console.log("myCallbackB()")
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
