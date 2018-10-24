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

		Document.prototype.getElementById = function(id){
			var pointer = DKRocket_getElementById(id);
			var element = new Element(pointer);
			return element;
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
	
	//////////////////////////
	function Element(pointer){
		this.pointer = pointer;
		this.style = new Style(pointer);

		Element.prototype.getAttribute = function(attribute){
			this[attribute] = DKRocket_getAttribute(this.pointer, attribute);
			return this[attribute];
		}
		Element.prototype.hasAttribute = function(attribute){
			if(DKRocket_hasAttribute(this.pointer, attribute)){ return true; }
			else{ return false; }
		}
		Element.prototype.setAttribute = function(attribute, value){
			DKRocket_setAttribute(this.pointer, attribute, value);
			this[attribute] = value;
		}
		Element.prototype.toString = function(){
			DKLog("element.toString()\n");
		}
		
		return new Proxy(this, {
			has: function (targ, key){
				return key in targ;
			},
			get: function (targ, key, recv){
				//if(key == "height"){ targ[key] = DKWidget_GetProperty(targ["id"], "height"); }
				//if(key == "id"){ targ[key] = DKWidget_GetAttribute(targ["id"], "id"); }
				//if(key == "position"){ targ[key] = DKWidget_GetProperty(targ["id"], "position"); }
				//if(key == "width"){ targ[key] = DKWidget_GetProperty(targ["id"], "width"); }
				return targ[key];
			},
			set: function (targ, key, val, recv){
				//if(key == "height"){ targ[key] = DKWidget_SetProperty(targ["id"], "height", val); }
				//if(key == "id"){ targ[key] = DKWidget_SetAttribute(targ["id"], "id", val); }
				//if(key == "position"){ targ[key] = DKWidget_SetProperty(targ["id"], "position", val); }
				//if(key == "width"){ targ[key] = DKWidget_SetProperty(targ["id"], "width", val); }
				targ[key] = val;
				return true;
			},
			deleteProperty: function (targ, key){
				delete targ[key];
				return true;
			}
		});
	}
	
	////////////////////////
	function Style(pointer){
		this.pointer = pointer;
		return new Proxy(this, {
			has: function (targ, key){
				return key in targ;
			},
			get: function (targ, key, recv){
				//DKLog("targ[id] = "+targ["id"]+"\n");
				//if(key == "id"){ return true; }
				//if(key == "width"){ targ[key] = DKWidget_GetProperty(targ["id"], "width"); }
				targ[key] = DKWidget_GetProperty(this.pointer, key);
				return targ[key];
			},
			set: function (targ, key, val, recv){
				//if(key == "id"){ return true; }
				//if(key == "width"){ targ[key] = DKWidget_SetProperty(targ["id"], "width", val); }
				DKWidget_SetProperty(this.pointer, key, val);
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
	DKLog("element.hasAttribute(id) = "+element.hasAttribute("id")+"\n");
	DKLog("element.getAttribute(id) = "+element.getAttribute("id")+"\n");
	element.setAttribute("id", "test_name");
	DKLog("element.getAttribute(id) = "+element.getAttribute("id")+"\n");
	/*
	DKLog("\n");
	//window tests
	DKLog("##### window tests #####\n");
	window.alert("test");
	DKLog("window.innerHeight: "+window.innerHeight+"\n");
	DKLog("window.innerWidth: "+window.innerWidth+"\n");
	DKLog("\n");
	
	//document tests
	DKLog("##### document tests #####\n");
	//TODO
	DKLog("\n");
	
	//element tests 
	DKLog("##### element tests #####\n");
	var element = document.getElementById("BugReport_Image");
	DKLog("element.id = "+element.id+"\n");
	DKLog("element.hasAttribute(id) = "+element.hasAttribute("id")+"\n");
	element.setAttribute("test", "http://digitalknob.com/image.png");
	DKLog("element.getAttribute(test) = "+element.getAttribute("test")+"\n");
	DKLog("\n");
	
	//style tests
	DKLog("##### style tests #####\n");
	DKLog("element.style.width = "+element.style.width+"\n");
	DKLog("element.style.height = "+element.style.height+"\n");
	DKLog("\n");
	*/
}