DKLog("*************  DKRocket.js *******************\n");
var DKERROR = 1;
var DKWARN = 2;
var DKINFO = 3;
var DKDEBUG = 4;
var DKSHOW = 5;
var DKHIDE = 6;
//DKCreate("DKWidget");

var navigator = new Navigator();
var document = new Document();
var window = new Window();

///////////////////
function Document()
{
	this.body = new Element("body");
	this.getElementById = function(id){ return Element(id); }
	this.hasFocus = function(){ return true;}
}

////////////////////
function Element(id)
{
	this.id = id;
	this.parentNode = function(id){ return Element(DKWidget_GetParent(id)); }
}

////////////////////
function Navigator()
{
	this.appCodeName = "Rocket";
	this.appName = "Rocket";
	this.appVersion = "Rocket/1.3.1";
	this.cookieEnabled = false;
	//this.geolocation;
	this.javaEnabled = function(){ return false; }
	this.language = "en-US";
	this.onLine = false; 
	this.platform = DK_GetOS();
	this.product = "Rocket";
	this.userAgent = "Rocket/1.3.1";
}

/////////////////
function Window()
{
	//this.closed = false;
	//this.defaultStatus;
	this.document = document;
	//this.frameElement = new Element();
}
