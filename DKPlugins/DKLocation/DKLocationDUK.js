// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window]
// interface Location { // but see also additional creation steps and overridden internal methods
var Location = function Location(address) {
	//console.log("Location("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKLocationDUK();


	// [LegacyUnforgeable] stringifier attribute USVString href;
	Object.defineProperty(this, "href", {
        get: function href()					{ return CPP_DKLocationDUK_href(this.address) },
		set: function href(data)				{ return CPP_DKLocationDUK_href(this.address, data) },
		//configurable: true,
    })
	
	// [LegacyUnforgeable] readonly attribute USVString origin;
	Object.defineProperty(this, "origin", {
        get: function origin()					{ return CPP_DKLocationDUK_origin(this.address) },
		//set: function origin(data)			{ return CPP_DKLocationDUK_origin(this.address, data) },
		//configurable: true,
    })
		
	// [LegacyUnforgeable] attribute USVString protocol;
	Object.defineProperty(this, "protocol", {
        get: function protocol()				{ return CPP_DKLocationDUK_protocol(this.address) },
		set: function protocol(data)			{ return CPP_DKLocationDUK_protocol(this.address, data) },
		//configurable: true,
    })
	
	// [LegacyUnforgeable] attribute USVString host;
	Object.defineProperty(this, "host", {
        get: function host()					{ return CPP_DKLocationDUK_host(this.address) },
		set: function host(data)				{ return CPP_DKLocationDUK_host(this.address, data) },
		//configurable: true,
    })
	
	// [LegacyUnforgeable] attribute USVString hostname;
	Object.defineProperty(this, "hostname", {
        get: function hostname()				{ return CPP_DKLocationDUK_hostname(this.address) },
		set: function hostname(data)			{ return CPP_DKLocationDUK_hostname(this.address, data) },
		//configurable: true,
    })
	
	// [LegacyUnforgeable] attribute USVString port;
	Object.defineProperty(this, "port", {
        get: function port()					{ return CPP_DKLocationDUK_port(this.address) },
		set: function port(data)				{ return CPP_DKLocationDUK_port(this.address, data) },
		//configurable: true,
    })
	
	// [LegacyUnforgeable] attribute USVString pathname;
	Object.defineProperty(this, "pathname", {
        get: function pathname()				{ return CPP_DKLocationDUK_pathname(this.address) },
		set: function pathname(data)			{ return CPP_DKLocationDUK_pathname(this.address, data) },
		//configurable: true,
    })
	
	// [LegacyUnforgeable] attribute USVString search;
	Object.defineProperty(this, "search", {
        get: function search()					{ return CPP_DKLocationDUK_search(this.address) },
		set: function search(data)				{ return CPP_DKLocationDUK_search(this.address, data) },
		//configurable: true,
    })
	
	// [LegacyUnforgeable] attribute USVString hash;
	Object.defineProperty(this, "hash", {
        get: function hash()					{ return CPP_DKLocationDUK_hash(this.address) },
		set: function hash(data)				{ return CPP_DKLocationDUK_hash(this.address, data) },
		//configurable: true,
    })
	
	// [LegacyUnforgeable] undefined assign(USVString url);
	Location.prototype.assign = function assign(url) {
		return CPP_DKLocationDUK_assign(this.address, url)
    }
	
	// [LegacyUnforgeable] undefined replace(USVString url);
	Location.prototype.replace = function replace(url) {
		return CPP_DKLocationDUK_replace(this.address, url)
    }
	
	// [LegacyUnforgeable] undefined reload();
	Location.prototype.reload = function reload() {
		return CPP_DKLocationDUK_reload(this.address)
    }
	
	// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
	Object.defineProperty(this, "ancestorOrigins", {
        get: function ancestorOrigins()			{ return CPP_DKLocationDUK_ancestorOrigins(this.address) },
		//set: function ancestorOrigins(data)	{ return CPP_DKLocationDUK_ancestorOrigins(this.address, data) },
		//configurable: true,
    })
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Location]" }
	
	return this
}