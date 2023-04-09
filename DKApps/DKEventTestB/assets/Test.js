// create EventTarget
const obj = new EventTarget();

////// Event //////
console.log('\n');
const myEventA = new Event('myeventA');
obj.addEventListener('myeventA', function(e){
	console.log('onmyeventA')
	console.log('e = '+e)
	console.log('e.type = '+e.type)
	console.log('e.target = '+e.target)
})
obj.dispatchEvent(myEventA);

console.log('\n');
obj.addEventListener('myeventB', function(e){
	console.log('onmyeventB')
	console.log('e = '+e)
	console.log('e.type = '+e.type)
	console.log('e.target = '+e.target)
})
obj.dispatchEvent(new Event('myeventB'));


////// CustomEvent //////
console.log('\n');
const myCustomEvent = new CustomEvent('customevent');
obj.addEventListener('customevent', function(e){
	console.log('oncustomevent')
	console.log('e = '+e)
	console.log('e.type = '+e.type)
	console.log('e.target = '+e.target)
	console.log('e.detail = '+e.detail)
})
obj.dispatchEvent(myCustomEvent);
