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
		this.document = new Document();
		this.name = 'WindowName';
		this.innerWidth;// = 0;

		Window.prototype.alert = function(str){
			DKLog("alert: "+str+'\n');
		}
	
		return new Proxy(this, { // Wrap it behind a proxy
			has: function (targ, key) {
				//DKLog('has called for key=' + key+'\n');
				return key in targ;  // return unmodified existence status
			},

			get: function (targ, key, recv) {
				//DKLog('get called for key=' + key+'\n');
				if(key == "innerWidth"){ targ[key] = DKWindow_GetWidth(); }
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
	
	function Document(){
		this.title = 'DocumentTitle';

		Document.prototype.getElementById = function(str){
			DKLog("document.getElementById("+str+")\n");
		}
	
		return new Proxy(this, {
			has: function (targ, key){
				return key in targ;
			},
			get: function (targ, key, recv){
				return targ[key];
			},
			set: function (targ, key, val, recv){
				targ[key] = val;
				return true;
			},
			deleteProperty: function (targ, key){
				delete targ[key];
				return true;
			}
		});
	}

	var window = new Window();
	window.alert("This is a test alert");
	if(!'name' in window){ DKLog("we could not find the property\n"); }
	DKLog("window.name = "+window.name+'\n');
	window.name = 321;
	DKLog("window.name now = "+window.name+'\n');
	DKLog("window.document.title = "+window.document.title+"\n");
	window.document.getElementById("ElementId");
	DKLog("window.innerWidth = "+window.innerWidth+"\n");
	delete window;
}