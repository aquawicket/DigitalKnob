
console.log("\n\n ___Variable Test___");
const const_variable = "This is the value of a 'const' variable";
console.log(const_variable);

var var_variable = "This is the value of a 'var' variable";
console.log(var_variable);

let let_variable = "This is the value of a 'let' variable";
console.log(let_variable);


// Event test
console.log("\n\n ___Event Test___");

function myCallback(){
	console.log("hello world")
}

const myObject = new EventTarget('myObject');

myObject.addEventListener('myEvent', myCallback)

const myEvent = new Event('myEvent')
myObject.dispatchEvent(myEvent);

myObject.removeEventListener('myEvent', myCallback)
myObject.dispatchEvent(myEvent);