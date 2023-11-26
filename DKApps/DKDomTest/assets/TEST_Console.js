// [IDL] https://console.spec.whatwg.org/#console-namespace
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Console
console.log('\n////// TEST_Console.js //////')

//undefined assert(optional boolean condition = false, any... data);
console.assert("console.assert() test");

//undefined clear();
//console.clear();

//undefined debug(any... data);
console.debug("console.debug() test");

//undefined error(any... data);
console.error("console.error() test");

//undefined info(any... data);
console.info("console.info() test");

//undefined log(any... data);
console.log("console.log() test");
console.log("abc"); 
console.log(1);
console.log(-1);
console.log(1.0);
console.log(-1.0);
console.log(1.1);
console.log(-1.1);
console.log(true);
console.log(null);
console.log(undefined); 
console.log([1, 2, 3, 4]); // array inside log
console.log({a:1, b:2, c:3}); // object inside log

//undefined table(optional any tabularData, optional sequence<DOMString> properties);
//console.table() //TODO

//undefined trace(any... data);
console.trace("console.trace() test");

//undefined warn(any... data);
console.warn("console.warn() test");

//undefined dir(optional any item, optional object? options);
//console.dir(); //TODO

//undefined dirxml(any... data);
console.dirxml("console.dirxml() test");

// Counting
//undefined count(optional DOMString label = "default");
console.count();

//undefined countReset(optional DOMString label = "default");
console.countReset();

// Grouping
//undefined group(any... data);
console.group("console.group() test");

//undefined groupCollapsed(any... data);
console.groupCollapsed("console.groupCollapsed() test");

//undefined groupEnd();
console.groupEnd();

// Timing
//undefined time(optional DOMString label = "default");
console.time();

//undefined timeLog(optional DOMString label = "default", any... data);
console.timeLog("default', 'console.timeLog() test");

//undefined timeEnd(optional DOMString label = "default");
console.timeEnd();