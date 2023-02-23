// Event test
console.log("\n\n ___Event Test___");

function myCallback(){
	console.log("hello world")
}

const myObject = new EventTarget('myObject')

myObject.addEventListener('myEvent', myCallback)

const myEvent = new Event('myEvent')
myObject.dispatchEvent(myEvent);

myObject.removeEventListener('myEvent', myCallback)
myObject.dispatchEvent(myEvent);