// Event test
console.log("\n\n ___Event Test___");

function myCallback(){
	console.log("myCallback()")
}
const myObject = new MyObject('myObject')
console.log("myObject = "+myObject)
console.log("myObject.value = "+myObject.value)
console.log("myObject.test() = "+myObject.test())

myObject.addEventListener('myEvent', myCallback)
const myEvent = new Event('myEvent')
myObject.dispatchEvent(myEvent);
myObject.removeEventListener('myEvent', myCallback)
myObject.dispatchEvent(myEvent);
