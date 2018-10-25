var window;
var document;
var location;
var screen;
var poin;

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
		location = new Location();
		screen = new Screen();
		this.document = document;
		this.location = location;
		this.screen = screen;

		Window.prototype.alert = function(str){
			DKLog("alert: "+str+'\n');
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
				//if(key == "innerHeight"){ DKRocket_SetHeight(Number(val)); }  //TODO
				//if(key == "innerWidth"){ DKRocket_SetWidth(Number(val)); }    //TODO
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
	function Location(){
		
		return new Proxy(this, { // Wrap it behind a proxy
			has: function (targ, key) {
				return key in targ;  // return unmodified existence status
			},
			get: function (targ, key, recv) {
				if(key == "hash"){ targ[key] = DKRocket_GetHash(); }
				return targ[key];  // return unmodified value
			},
			set: function (targ, key, val, recv) {
				if(key == "hash"){ DKRocket_SetHash(val); }
				targ[key] = val;  // must perform write to target manually if 'set' defined
				return true;      // true: indicate that property write was allowed
			},

			deleteProperty: function (targ, key) {
				delete targ[key];  // must perform delete to target manually if 'deleteProperty' defined
				return true;       // true: indicate that property delete was allowed
			}
		});
	}
	
	//////////////////
	function Screen(){
		
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
	
	////////////////////
	function Document(){

		Document.prototype.getElementById = function(id){
			var pointer = DKRocket_getElementById(id);
			var element = new Element(pointer);
			return element;
		}
		
		Document.prototype.getElementsByClassName = function(name){
			var addressList = DKRocket_getElementsByClassName(name);
			var arry = addressList.split(",");
			var nodeList = [];
			for(var i=0; i<arry.length; i++){
				DKLog("arry["+i+"]: "+arry[i]+"\n")
				nodeList.push(new Element(arry[i])) //Will these duplicate and grow memory usage?
			}
			return nodeList;
		}
		
		Document.prototype.getElementsByTagName = function(name){
			var addressList = DKRocket_getElementsByTagName(name);
			if(!addressList){ return; }
			var arry = addressList.split(",");
			var nodeList = [];
			for(var i=0; i<arry.length; i++){
				nodeList.push(new Element(arry[i])) //Will these duplicate and grow memory usage?
			}
			return nodeList;
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
		//DKLog("this.pointer = "+this.pointer+"\n")
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
			get: function(targ, key, recv){
				//DKLog("Element(): get:("+key+")\n");
				//DKLog("targ[pointer]: "+targ["pointer"]+"\n");
				if(typeof targ[key] === "function" || key == "pointer" || key == "style"){ return targ[key]; }
				if(key == "innerHTML"){ 
					targ[key] = DKRocket_innerHTML(targ["pointer"], key); 
				}
				else{
					DKLog("targ[key]: "+targ[key]+"\n")
					DKLog("targ[pointer]: "+targ["pointer"]+"\n")
					targ[key] = DKRocket_getAttribute(targ["pointer"], key); 
				}
				return targ[key];
			},
			set: function (targ, key, val, recv){
				if(typeof targ[key] === "function" || key == "pointer" || key == "style"){ return true; }
				DKRocket_setAttribute(targ["pointer"], key, val);
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
				targ[key] = DKRocket_getPropertyValue(targ["pointer"], key);
				return targ[key];
			},
			set: function (targ, key, val, recv){
				if(typeof targ[key] === "function" || key == "pointer"){ return true; }
				DKRocket_setProperty(targ["pointer"], key, val);
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
	DKLog("\n");
	//window tests
	DKLog("##### window tests #####\n");
	window.alert("test");
	DKLog("window.innerHeight: "+window.innerHeight+"\n");
	DKLog("window.innerWidth: "+window.innerWidth+"\n");
	DKLog("window.name: "+window.name+"\n");
	DKLog("\n");

	//document tests
	DKLog("##### document tests #####\n");
	document.name = "test_doc_name";
	DKLog("document.name: "+document.name+"\n");
	var nodeList = document.getElementsByTagName("body");
	DKLog("nodeList.length: "+nodeList.length+"\n");
	DKLog("nodeList[0].innerHTML: "+nodeList[0].innerHTML+"\n");
	/*
	var nodeList = document.getElementsByTagName("div");
	//DKLog("nodelist.length: "+nodeList.length+"\n");
	for(var i=0; i<nodeList.length; i++){
		DKLog(nodeList[i]+'\n');
	}
	*/
	DKLog("\n");
	
	/*
	//element tests 
	DKLog("##### element tests #####\n");
	var element = document.getElementById("BugReport_Image");
	DKLog("element.id: "+element.id+"\n");
	DKLog("element.hasAttribute(id): "+element.hasAttribute("id")+"\n");
	element.setAttribute("test", "http://digitalknob.com/image.png");
	DKLog("element.getAttribute(test): "+element.getAttribute("test")+"\n");
	DKLog("\n");
	
	//style tests
	DKLog("##### style tests #####\n");
	DKLog("element.style.width: "+element.style.width+"\n");
	DKLog("element.style.height: "+element.style.height+"\n");
	element.style.setProperty("position", "relative");
	DKLog("element.style.getPropertyValue(position): "+element.style.getPropertyValue("position")+"\n");
	DKLog("\n");
	*/
}