//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

var window;
var document;
var location;
var screen;
var console;

/////////////////////
function DKDom_Init()
{
	DKDEBUGFUNC();
	if(DK_GetBrowser() != "Rocket"){ return; }  //This class is a wrapper for libRocket only
	DKDom_Create();
	//DKDom_Test();
}

////////////////////
function DKDom_End()
{
	DKDEBUGFUNC();
}

/////////////////////////////
function DKDom_OnEvent(event)
{
	DKDEBUGFUNC(event);
}

////////////////////////////
function DKDom_Create(event)
{
	DKDEBUGFUNC();
	
	//////////////////
	function Console()
	{
		DKDEBUGFUNC();
		Console.prototype.assert = function(condition, str){
			if(condition){ return; }
			DKERROR(str+"\n");
		}
		Console.prototype.clear = function(){
			DK_System("cls");
		}
		Console.prototype.debug = function(str){
			DKDEBUG(str+"\n");
		}
		Console.prototype.error = function(str){
			DKERROR(str+"\n");
		}
		Console.prototype.info = function(str){
			DKINFO(str+"\n");
		}
		Console.prototype.log = function(str){
			DKINFO(str+"\n");
		}
		Console.prototype.trace = function(){
			DKERROR("console.trace() not implemented\n");
		}
		Console.prototype.warn = function(str){
			DKWARN(str+"\n");
		}
	}
	
	/////////////////
	function Window()
	{
		DKDEBUGFUNC();
		document = new Document();
		this.document = document;
		location = new Location();
		this.location = location;
		screen = new Screen();
		this.screen = screen;

		Window.prototype.alert = function(str){
			DKINFO("alert: "+str+'\n');
		}
	
		return new Proxy(this, { // Wrap it behind a proxy
			has: function (targ, key) {
				return key in targ;  // return unmodified existence status
			},
			get: function (targ, key, recv) {
				if(key == "innerHeight"){ targ[key] = DKRocket_innerHeight(); }
				if(key == "innerWidth"){ targ[key] = DKRocket_innerWidth(); }
				if(key == "name"){ targ[key] = DKRocket_name(); }
				return targ[key];  // return unmodified value
			},
			set: function (targ, key, val, recv) {
				//if(key == "innerHeight"){ DKRocket_SetInnerHeight(val); }  //TODO
				//if(key == "innerWidth"){ DKRocket_SetInnerWidth(val); }    //TODO
				//if(key == "name"){ DKRocket_SetName(val); }    //TODO
				targ[key] = val;  // must perform write to target manually if 'set' defined
				return true;      // true: indicate that property write was allowed
			},

			deleteProperty: function (targ, key) {
				delete targ[key];  // must perform delete to target manually if 'deleteProperty' defined
				return true;       // true: indicate that property delete was allowed
			}
		});
	}
	
	///////////////////
	function Location()
	{
		DKDEBUGFUNC();
		return new Proxy(this, { // Wrap it behind a proxy
			has: function (targ, key) {
				return key in targ;  // return unmodified existence status
			},
			get: function (targ, key, recv){
				//DKINFO("key = "+key+"\n");
				if(key == "hash"){ targ[key] = DKRocket_GetHash(); }
				return targ[key];  // return unmodified value
			},
			set: function (targ, key, val, recv){
				if(key == "hash"){ DKRocket_SetHash(val); }
				targ[key] = val;  // must perform write to target manually if 'set' defined
				return true;      // true: indicate that property write was allowed
			},

			deleteProperty: function (targ, key){
				delete targ[key];  // must perform delete to target manually if 'deleteProperty' defined
				return true;       // true: indicate that property delete was allowed
			}
		});
	}
	
	/////////////////
	function Screen()
	{
		DKDEBUGFUNC();
		return new Proxy(this, { // Wrap it behind a proxy
			has: function (targ, key) {
				return key in targ;  // return unmodified existence status
			},
			get: function (targ, key, recv) {
				if(key == "hash"){ targ[key] = DKRocket_GetHash(); }
				return targ[key];  // return unmodified value
			},
			set: function (targ, key, val, recv) {
				targ[key] = val;  // must perform write to target manually if 'set' defined
				return true;      // true: indicate that property write was allowed
			},

			deleteProperty: function (targ, key) {
				delete targ[key];  // must perform delete to target manually if 'deleteProperty' defined
				return true;       // true: indicate that property delete was allowed
			}
		});
	}
	
	///////////////////
	function Document()
	{
		DKDEBUGFUNC();
		
		Document.prototype.createElement = function(tag){
			var pointer = DKRocket_createElement(tag);
			var element;
			if(tag == "script"){
				element = new Script(pointer);
			}
			else{
				element = new Element(pointer);
			}
			return element;
		}
		
		Document.prototype.getElementById = function(id){
			var pointer = DKRocket_getElementById(id);
			if(!pointer){ return null; }
			var element = new Element(pointer);
			return element;
		}
		
		Document.prototype.getElementsByClassName = function(name){
			var addressList = DKRocket_getElementsByClassName(name);
			if(!addressList){ return []; }
			var arry = addressList.split(",");
			var nodeList = [];
			for(var i=0; i<arry.length; i++){
				DKINFO("arry["+i+"]: "+arry[i]+"\n")
				nodeList.push(new Element(arry[i]))
			}
			return nodeList;
		}
		
		Document.prototype.getElementsByTagName = function(name){
			var addressList = DKRocket_getElementsByTagName(name);
			if(!addressList){ return []; }
			var arry = addressList.split(",");
			var nodeList = [];
			for(var i=0; i<arry.length; i++){
				nodeList.push(new Element(arry[i]))
			}
			return nodeList;
		}
	
		return new Proxy(this, {
			has: function (targ, key){
				return key in targ;
			},
			get: function (targ, key, recv){
				if(key == "body"){ 
					var bodyList = DKRocket_getElementsByTagName("body");
					if(!bodyList){ return; }
					var arry = bodyList.split(",");
					targ[key] = new Element(arry[0]);
				}
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
	
	/////////////////////////
	function Element(pointer)
	{
		DKDEBUGFUNC();
		this.pointer = pointer;
		this.style = new Style(pointer);

		Element.prototype.appendChild = function(element){
			var pointer = DKRocket_appendChild(this.pointer, element.pointer);
			var element = new Element(pointer);
			return element;
		}
		Element.prototype.getAttribute = function(attribute){
			this[attribute] = DKRocket_getAttribute(this.pointer, attribute);
			return this[attribute];
		}
		Element.prototype.hasAttribute = function(attribute){
			if(DKRocket_hasAttribute(this.pointer, attribute)){ return true; }
			else{ return false; }
		}
		Element.prototype.removeChild = function(element){
			var pointer = DKRocket_removeChild(this.pointer, element.pointer);
			var element = new Element(pointer);
			return element;
		}
		Element.prototype.setAttribute = function(attribute, value){
			DKRocket_setAttribute(this.pointer, attribute, value);
			this[attribute] = value;
		}
		Element.prototype.toString = function(){
			DKINFO("element.toString()\n");
		}
		
		return new Proxy(this, {
			has: function (targ, key){
				return key in targ;
			},
			get: function(targ, key, recv){
				if(typeof targ[key] === "function" || key == "pointer" || key == "style"){ return targ[key]; }
				if(key == "innerHTML"){
					targ[key] = DKRocket_innerHTML(targ["pointer"], key); 
				}
				else if(key == "parentNode"){
					var parentNode = DKRocket_parentNode(targ["pointer"], key);
					targ[key] = new Element(parentNode);
				}
				else{
					targ[key] = DKRocket_getAttribute(targ["pointer"], key); 
				}
				return targ[key];
			},
			set: function (targ, key, val, recv){
				if(typeof targ[key] === "function" || key == "pointer" || key == "style"){ return true; }
				if(key == "innerHTML"){
					DKRocket_setInnerHTML(targ["pointer"], val);
				}
				else{
					DKRocket_setAttribute(targ["pointer"], key, val);
				}
				targ[key] = val;
				return true;
			},
			deleteProperty: function (targ, key){
				delete targ[key];
				return true;
			}
		});
	}
	
	///////////////////////
	function Style(pointer)
	{
		DKDEBUGFUNC();
		this.pointer = pointer;
		
		Style.prototype.setProperty = function(propertyName, propertyValue, priority){
			DKRocket_setProperty(this.pointer, propertyName, propertyValue);
			this[propertyName] = propertyValue;
		}
		Style.prototype.getPropertyValue = function(propertyName){
			this[propertyName] = DKRocket_getPropertyValue(this.pointer, propertyName);
			return this[propertyName];
		}
		
		return new Proxy(this, {
			has: function (targ, key){
				return key in targ;
			},
			get: function (targ, key, recv){
				if(typeof targ[key] === "function" || key == "pointer"){ return targ[key]; }
				if(key == "backgroundColor"){ targ[key] = DKRocket_getPropertyValue(targ["pointer"], "background-color"); }
				else{ targ[key] = DKRocket_getPropertyValue(targ["pointer"], key); }
				return targ[key];
			},
			set: function (targ, key, val, recv){
				if(typeof targ[key] === "function" || key == "pointer"){ return true; }
				if(key == "backgroundColor"){ DKRocket_setProperty(targ["pointer"], "background-color", val); }
				else{ DKRocket_setProperty(targ["pointer"], key, val); }
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
	function Script(pointer)
	{
		DKDEBUGFUNC();
		//this.prototype = new Element();
		Element.call(this, pointer);
		this.pointer = pointer;
		
		/*
		return new Proxy(this, {
			has: function (targ, key){
				return key in targ;
			},
			get: function (targ, key, recv){
				if(typeof targ[key] === "function" || key == "pointer"){ return targ[key]; }
				return targ[key];
			},
			set: function (targ, key, val, recv){
				if(typeof targ[key] === "function" || key == "pointer"){ return true; }
				targ[key] = val;
				return true;
			},
			deleteProperty: function (targ, key){
				delete targ[key];
				return true;
			}
		});
		*/
	}
	
	Script.prototype = new Element();
	
	window = new Window();
	console = new Console();
}

/////////////////////
function DKDom_Test()
{
	DKDEBUGFUNC();
	DKINFO("\n");
	//window tests
	DKINFO("##### window tests #####\n");
	window.alert("test");
	DKINFO("window.innerHeight: "+window.innerHeight+"\n");
	DKINFO("window.innerWidth: "+window.innerWidth+"\n");
	DKINFO("window.name: "+window.name+"\n");
	DKINFO("\n");

	//document tests
	DKINFO("##### document tests #####\n");
	document.name = "test_doc_name";
	DKINFO("document.name: "+document.name+"\n");
	var nodeList = document.getElementsByTagName("body");
	DKINFO("nodeList.length: "+nodeList.length+"\n");
	DKINFO("nodeList[0].innerHTML: "+nodeList[0].innerHTML+"\n");
	
	//TODO - we need to be able to set the innerHTML too
	nodeList[0].innerHTML = "<div>This was replaced</div>";
	DKINFO("nodeList[0].innerHTML: "+nodeList[0].innerHTML+"\n");
	
	/*
	var nodeList = document.getElementsByTagName("div");
	//DKINFO("nodelist.length: "+nodeList.length+"\n");
	for(var i=0; i<nodeList.length; i++){
		DKINFO(nodeList[i]+'\n');
	}
	*/
	DKINFO("\n");
	
	/*
	//element tests 
	DKINFO("##### element tests #####\n");
	var element = document.getElementById("BugReport_Image");
	DKINFO("element.id: "+element.id+"\n");
	DKINFO("element.hasAttribute(id): "+element.hasAttribute("id")+"\n");
	element.setAttribute("test", "http://digitalknob.com/image.png");
	DKINFO("element.getAttribute(test): "+element.getAttribute("test")+"\n");
	DKINFO("\n");
	
	//style tests
	DKINFO("##### style tests #####\n");
	DKINFO("element.style.width: "+element.style.width+"\n");
	DKINFO("element.style.height: "+element.style.height+"\n");
	element.style.setProperty("position", "relative");
	DKINFO("element.style.getPropertyValue(position): "+element.style.getPropertyValue("position")+"\n");
	DKINFO("\n");
	*/
}