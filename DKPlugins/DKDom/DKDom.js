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
	//////////////////
	function Window(){
		this.document = new Document();
		this.name = 'WindowName';
		this.innerWidth;
		this.innerHeight;

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
				if(key == "innerHeight"){ targ[key] = DKWindow_GetHeight(); }
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
	
	////////////////////
	function Document(){
		this.title = 'DocumentTitle';

		Document.prototype.getElementById = function(id){
			DKLog("document.getElementById("+id+")\n");
			if(DKWidget_ElementExists(id)){
				var element = new Element();
				element.id = id;
				return element;
			}
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
	
	///////////////////
	function Element(){
		this.id;
		this.position;
		this.width;
		this.height;

		Element.prototype.toString = function(){
			DKLog("element.toString()\n");
		}
	
		return new Proxy(this, {
			has: function (targ, key){
				return key in targ;
			},
			get: function (targ, key, recv){
				//if(key == "id"){ targ[key] = DKWidget_GetProperty(targ["id"], "id"); }
				if(key == "height"){ targ[key] = DKWidget_GetProperty(targ["id"], "height"); }
				if(key == "position"){ targ[key] = DKWidget_GetProperty(targ["id"], "position"); }
				if(key == "width"){ targ[key] = DKWidget_GetProperty(targ["id"], "width"); }
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
	var element = window.document.getElementById("body");
	DKLog("element.id = "+element.id+"\n");
	DKLog("element.position = "+element.position+"\n");
	DKLog("element.width = "+element.width+"\n");
	DKLog("element.height = "+element.height+"\n");
	
	/*
	window.alert("This is a test alert");
	if(!'name' in window){ DKLog("we could not find the property\n"); }
	DKLog("window.name = "+window.name+'\n');
	window.name = 321;
	DKLog("window.name now = "+window.name+'\n');
	DKLog("window.document.title = "+window.document.title+"\n");
	window.document.getElementById("ElementId");
	DKLog("window.innerWidth = "+window.innerWidth+"\n");
	delete window;
	*/
}