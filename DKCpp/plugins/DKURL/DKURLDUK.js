// [IDL] https://url.spec.whatwg.org/#url-class
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/URL


// Source: URL Standard (https://url.spec.whatwg.org/)
// [Exposed=*,
// LegacyWindowAlias=webkitURL]
// interface URL {
// constructor(USVString url, optional USVString base);
var URL = function URL(url, base, address) {	
	//console.log("URL("+url+","+base+","+address+")");
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKURLDUK_constructor(url, base);
	
	
	// static boolean canParse(USVString url, optional USVString base);
	URL.prototype.canParse = function canParse(url, base) {
		return CPP_DKURLDUK_canParse(this.address, url, base);
    }
	
	// stringifier attribute USVString href;
	Object.defineProperty(this, "href", {
        get: function href()					{ return CPP_DKURLDUK_href(this.address) },
		set: function href(data)				{ return CPP_DKURLDUK_href(this.address, data) },
    })
	
	// readonly attribute USVString origin;
	Object.defineProperty(this, "origin", {
        get: function origin()					{ return CPP_DKURLDUK_origin(this.address) },
		set: function origin(data)				{ return CPP_DKURLDUK_origin(this.address, data) },
    })
	
	// attribute USVString protocol;
	Object.defineProperty(this, "protocol", {
        get: function protocol()				{ return CPP_DKURLDUK_protocol(this.address) },
		set: function protocol(data)			{ return CPP_DKURLDUK_protocol(this.address, data) },
    })
	
	// attribute USVString username;
	Object.defineProperty(this, "username", {
        get: function username()				{ return CPP_DKURLDUK_username(this.address) },
		set: function username(data)			{ return CPP_DKURLDUK_username(this.address, data) },
    })
	
	// attribute USVString password;
	Object.defineProperty(this, "password", {
        get: function password()				{ return CPP_DKURLDUK_password(this.address) },
		set: function password(data)			{ return CPP_DKURLDUK_password(this.address, data) },
    })
	
	// attribute USVString host;
	Object.defineProperty(this, "host", {
        get: function host()					{ return CPP_DKURLDUK_host(this.address) },
		set: function host(data)				{ return CPP_DKURLDUK_host(this.address, data) },
    })
	
	// attribute USVString hostname;
	Object.defineProperty(this, "hostname", {
        get: function hostname()				{ return CPP_DKURLDUK_hostname(this.address) },
		set: function hostname(data)			{ return CPP_DKURLDUK_hostname(this.address, data) },
    })
	
	// attribute USVString port;
	Object.defineProperty(this, "port", {
        get: function port()					{ return CPP_DKURLDUK_port(this.address) },
		set: function port(data)				{ return CPP_DKURLDUK_port(this.address, data) },
    })
	
	// attribute USVString pathname;
	Object.defineProperty(this, "pathname", {
        get: function pathname()				{ return CPP_DKURLDUK_pathname(this.address) },
		set: function pathname(data)			{ return CPP_DKURLDUK_pathname(this.address, data) },
    })
	
	// attribute USVString search;
	Object.defineProperty(this, "search", {
        get: function search()					{ return CPP_DKURLDUK_search(this.address) },
		set: function search(data)				{ return CPP_DKURLDUK_search(this.address, data) },
    })
	
	// [SameObject] readonly attribute URLSearchParams searchParams;
	Object.defineProperty(this, "searchParams", {
        get: function searchParams()			{ return CPP_DKURLDUK_searchParams(this.address) },
		set: function searchParams(data)		{ return CPP_DKURLDUK_searchParams(this.address, data) },
    })
	
	// attribute USVString hash;
	Object.defineProperty(this, "hash", {
        get: function hash()					{ return CPP_DKURLDUK_hash(this.address) },
		set: function hash(data)				{ return CPP_DKURLDUK_hash(this.address, data) },
    })
	
	// USVString toJSON();
	URL.prototype.toJSON = function toJSON() {
		return CPP_DKURLDUK_toJSON(this.address);
    }
	
	// };	

	// Source: File API (https://www.w3.org/TR/FileAPI/)
	// [Exposed=(Window,DedicatedWorker,SharedWorker)]
	// partial interface URL {
	// static DOMString createObjectURL((Blob or MediaSource) obj);
	URL.prototype.createObjectURL = function createObjectURL(obj) {
		return CPP_DKURLDUK_createObjectURL(this.address, obj);
    }
	
	// static undefined revokeObjectURL(DOMString url);
	URL.prototype.revokeObjectURL = function revokeObjectURL(url) {
		CPP_DKURLDUK_revokeObjectURL(this.address, url);
    }
	
	//};
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object URL]" }
	
	return this;
}