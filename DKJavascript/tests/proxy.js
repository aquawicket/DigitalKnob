const obj = {
  foo: 'bar',
  boop: "beep",
};
const objProx = new Proxy(obj, {
  get(obj, prop) {
    console.log('On obj', obj, 'getting', prop);
    return obj[prop];
  },
  set(obj, prop, newVal) {
    console.log('On obj', obj, 'setting', prop, 'to', newVal);
    return obj[prop] = newVal;
  },
});




objProx.boop = "burp";
objProx.newRand = "a new randomly added prop here";
// invokes getter:
objProx.foo;

