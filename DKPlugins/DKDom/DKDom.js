var window;
var document;

/////////////////////
function DKDom_Init()
{
	//DKDebug();
	DKDom_Create();
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

////////////////////////////
function DKDom_Create(event)
{
	//////////////////
	function Window(){
		document = new Document();
		this.document = document;
		this.name;
		this.innerWidth;
		this.innerHeight;

		Window.prototype.alert = function(str){
			DKLog("alert: "+str+'\n');
		}
	
		return new Proxy(this, { // Wrap it behind a proxy
			has: function (targ, key) {
				return key in targ;  // return unmodified existence status
			},
			get: function (targ, key, recv) {
				if(key == "innerHeight"){ targ[key] = DKWindow_GetHeight(); }
				if(key == "innerWidth"){ targ[key] = DKWindow_GetWidth(); }
				return targ[key];  // return unmodified value
			},
			set: function (targ, key, val, recv) {
				if(key == "innerHeight"){ DKWindow_SetHeight(Number(val)); }
				if(key == "innerWidth"){ DKWindow_SetWidth(Number(val)); }
				targ[key] = val;  // must perform write to target manually if 'set' defined
				return true;      // true: indicate that property write was allowed
			},

			deleteProperty: function (targ, key) {
				delete targ[key];  // must perform delete to target manually if 'deleteProperty' defined
				return true;       // true: indicate that property delete was allowed
			}
		});
	}
	
	////////////////////
	function Document(){
		this.title;

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
				if(key == "height"){ targ[key] = DKWidget_GetProperty(targ["id"], "height"); }
				if(key == "id"){ targ[key] = DKWidget_GetAttribute(targ["id"], "id"); }
				if(key == "position"){ targ[key] = DKWidget_GetProperty(targ["id"], "position"); }
				if(key == "width"){ targ[key] = DKWidget_GetProperty(targ["id"], "width"); }
				return targ[key];
			},
			set: function (targ, key, val, recv){
				if(key == "height"){ targ[key] = DKWidget_SetProperty(targ["id"], "height", val); }
				//if(key == "id"){ targ[key] = DKWidget_SetAttribute(targ["id"], "id", val); }
				if(key == "position"){ targ[key] = DKWidget_SetProperty(targ["id"], "position", val); }
				if(key == "width"){ targ[key] = DKWidget_SetProperty(targ["id"], "width", val); }
				targ[key] = val;
				return true;
			},
			deleteProperty: function (targ, key){
				delete targ[key];
				return true;
			}
		});
	}
	
	window = new Window();
}

/////////////////////
function DKDom_Test()
{
	var element = document.getElementById("BugReport_Image");
	DKLog("element.id = "+element.id+"\n");
	DKLog("element.position = "+element.position+"\n");
	DKLog("element.width = "+element.width+"\n");
	DKLog("element.height = "+element.height+"\n");
	//window.innerWidth = 100;
	//element.height = "20px";
	//DKLog("element.width = "+element.width+"\n");
	
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