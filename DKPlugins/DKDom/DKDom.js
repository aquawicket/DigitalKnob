/////////////////////
function DKDom_Init()
{
	//DKDebug();
	DKDom_Test();
}

////////////////////
function DKDom_End()
{
	//DKDebug();
}

/////////////////////////////
function DKDom_OnEvent(event)
{
	//DKDebug(event);
}

//////////////////////////
function DKDom_Test(event)
{
	
	function Window(){
		this.name = 'WindowName';

		Window.prototype.alert = function(str){
			DKLog("alert: "+str+'\n');
		}
	
		return new Proxy(this, { // Wrap it behind a proxy
			// proxy traps
			has: function (targ, key) {
				//DKLog('has called for key=' + key+'\n');
				return key in targ;  // return unmodified existence status
			},

			get: function (targ, key, recv) {
				//DKLog('get called for key=' + key+'\n');
				return targ[key];  // return unmodified value
			},

			set: function (targ, key, val, recv) {
				//DKLog('set called for key=' + key + ', val=' + val+'\n');
				targ[key] = val;  // must perform write to target manually if 'set' defined
				return true;      // true: indicate that property write was allowed
			},
		
			deleteProperty: function (targ, key) {
				//DKLog('deleteProperty called for key=' + key+'\n');
				delete targ[key];  // must perform delete to target manually if 'deleteProperty' defined
				return true;       // true: indicate that property delete was allowed
			}
		});
	}


	var window = new Window();
	
	//Test object funtion
	window.alert("This is a test alert");
	
	//Test object property
	if(!'name' in window){
		DKLog("we could not find the property\n");
	}
	DKLog("window.name = "+window.name+'\n');
	window.name = 321;
	DKLog("window.name now = "+window.name+'\n');

	delete window.name;
}