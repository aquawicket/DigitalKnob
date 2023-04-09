// create EventTarget
const obj = new EventTarget();

// WORKS
console.log('\n');
const myEventA = new Event('myeventA');
obj.addEventListener('myeventA', function(){
	console.log('myeventA')
})
obj.dispatchEvent(myEventA);

// WORKS
console.log('\n');
obj.addEventListener('myeventB', function(){
	console.log('myeventB')
})
obj.dispatchEvent(new Event('myeventB'));
