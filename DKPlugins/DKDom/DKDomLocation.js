//https://developer.mozilla.org/en-US/docs/Web/API/Location

////////////////////////////////
var Location = function(pointer)
{
	Object.defineProperty(this, "hash", { 
		get: function(){ return DKDomLocation_hash(); } 
	});
	Object.defineProperty(this, "host", {
		get: function()   { return DKDomLocation_host();    },
		set: function(val){ return DKDomLocation_host(val); }
	});
	Object.defineProperty(this, "hostname", {
		get: function()   { return DKDomLocation_hostname();    },
		set: function(val){ return DKDomLocation_hostname(val); }
	});
	Object.defineProperty(this, "href", {
		get: function()   { return DKDomLocation_href();    },
		set: function(val){ return DKDomLocation_href(val); }
	});
	Object.defineProperty(this, "origin", {
		get: function(){ return DKDomLocation_origin(); } 
	});
	Object.defineProperty(this, "pathname", {
		get: function()   { return DKDomLocation_pathname();    },
		set: function(val){ return DKDomLocation_pathname(val); }
	});
	Object.defineProperty(this, "port", {
		get: function()   { return DKDomLocation_port();    },
		set: function(val){ return DKDomLocation_port(val); }
	});
	Object.defineProperty(this, "protocol", {
		get: function()   { return DKDomLocation_protocol();    },
		set: function(val){ return DKDomLocation_protocol(val); }
	});
	Object.defineProperty(this, "search", {
		get: function()   { return DKDomLocation_search();    },
		set: function(val){ return DKDomLocation_search(val); }
	});
	
	Location.prototype.assign = function(url){
		DKDomLocation_href(url); 
	}
	Location.prototype.reload = function(forcedReload){
		DKDomLocation_reload(forcedReload); 
	}
	Location.prototype.replace = function(url){
		DKDomLocation_href(url); //TODO - https://developer.mozilla.org/en-US/docs/Web/API/Location/replace
	}
}

var location = new Location("location");