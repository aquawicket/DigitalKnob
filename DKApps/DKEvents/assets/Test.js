// Event test
console.log("\n\n ___Event Test___");


///////////////////////////////////////////////
function testCallback(){
	console.log("testCallback()")
}
const testObject = new EventTarget('testObject')
testObject.addEventListener('testEvent', testCallback)
const testEvent = new Event('testEvent')
testObject.dispatchEvent(testEvent);
testObject.removeEventListener('testEvent', testCallback)
testObject.dispatchEvent(testEvent);



///////////////////////////////////////////////
function myCallback(){
	console.log("myCallback()")
}
const myObject = new MyObject('myObject')
myObject.addEventListener('myEvent', myCallback)
const myEvent = new Event('myEvent')
myObject.dispatchEvent(myEvent);
myObject.removeEventListener('myEvent', myCallback)
myObject.dispatchEvent(myEvent);
