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
const myEventB = new CustomEvent('myeventB');
obj.addEventListener('myeventB', function(){
	console.log('myeventB')
})
obj.dispatchEvent(new CustomEvent('myeventB'));

// DOES NOT WORK
console.log('\n');
//const myEventC = new Event('myeventC');
obj.addEventListener('myeventC', function(){
	console.log('myeventC')
})
obj.dispatchEvent(new Event('myeventC'));
