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






/*
// Event
console.log('\n');
const myEvent = new Event('myevent');
obj.addEventListener('myevent', function(){
	console.log('myevent')
})
obj.dispatchEvent(myEvent);


// CustomEvent
console.log('\n');
const myCustomEvent = new CustomEvent('mycustomevent');
obj.addEventListener('mycustomevent', function(){
	console.log('mycustomevent')
})
obj.dispatchEvent(myCustomEvent);


// UIEvent
console.log('\n');
const myUIEvent = new UIEvent('myuievent');
obj.addEventListener('myuievent', function(){
	console.log('myuievent')
})
obj.dispatchEvent(myUIEvent);


// FocusEvent
console.log('\n');
const myFocusEvent = new FocusEvent('myfocusevent');
obj.addEventListener('myfocusevent', function(){
	console.log('myfocusevent')
})
obj.dispatchEvent(myFocusEvent);


// MouseEvent
console.log('\n');
const myMouseEvent = new MouseEvent('mymouseevent');
obj.addEventListener('mymouseevent', function(){
	console.log('mymouseevent')
})
obj.dispatchEvent(myMouseEvent);


// WheelEvent
console.log('\n');
const myWheelEvent = new WheelEvent('mywheelevent');
obj.addEventListener('mywheelevent', function(){
	console.log('mywheelevent')
})
obj.dispatchEvent(myWheelEvent);


// InputEvent
console.log('\n');
const myInputEvent = new InputEvent('myinputevent');
obj.addEventListener('myinputevent', function(){
	console.log('myinputevent')
})
obj.dispatchEvent(myInputEvent);


// KeyboardEvent
console.log('\n');
const myKeyboardEvent = new KeyboardEvent('mykeyboardevent');
obj.addEventListener('mykeyboardevent', function(){
	console.log('mykeyboardevent')
})
obj.dispatchEvent(myKeyboardEvent);


// CompositionEvent
console.log('\n');
const myCompositionEvent = new CompositionEvent('mycompositionevent');
obj.addEventListener('mycompositionevent', function(){
	console.log('mycompositionevent')
})
obj.dispatchEvent(myCompositionEvent);
*/