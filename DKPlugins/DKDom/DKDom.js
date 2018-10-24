/////////////////////
function DKDom_init()
{
	DKDebug();
	DKDom_Test();
}

////////////////////
function DKDom_end()
{
	DKDebug();
}

/////////////////////////////
function DKDom_OnEvent(event)
{
	DKDebug(event);
}

//////////////////////////
function DKDom_Test(event)
{
	// Underlying plain object.
	var target = { foo: 'bar' };

	// Handler table, provides traps for interaction (can be modified on-the-fly).
	var handler = {
		has: function (targ, key) {
			DKLog('has called for key=' + key);
			return key in targ;  // return unmodified existence status
		},

		get: function (targ, key, recv) {
			DKLog('get called for key=' + key);
			return targ[key];  // return unmodified value
		},

		set: function (targ, key, val, recv) {
			DKLog('set called for key=' + key + ', val=' + val);
			targ[key] = val;  // must perform write to target manually if 'set' defined
			return true;      // true: indicate that property write was allowed
		},

		deleteProperty: function (targ, key) {
			DKLog('deleteProperty called for key=' + key);
			delete targ[key];  // must perform delete to target manually if 'deleteProperty' defined
			return true;       // true: indicate that property delete was allowed
		}
	};

	// Create proxy object.
	var proxy = new Proxy(target, handler);

	// Proxy object is then accessed normally.
	DKLog('foo' in proxy);
	proxy.foo = 321;
	DKLog(proxy.foo);
	delete proxy.foo;
}