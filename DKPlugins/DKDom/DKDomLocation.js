//https://developer.mozilla.org/en-US/docs/Web/API/Location

////////////////////////////////
var Location = function(pointer)
{
	Object.defineProperty(this, "hash", { 
		get: function(){ return DKCPP_DKDomLocation_hash(); } 
	});
	Object.defineProperty(this, "host", {
		get: function()   { return DKCPP_DKDomLocation_host();    },
		set: function(val){ return DKCPP_DKDomLocation_host(val); }
	});
	Object.defineProperty(this, "hostname", {
		get: function()   { return DKCPP_DKDomLocation_hostname();    },
		set: function(val){ return DKCPP_DKDomLocation_hostname(val); }
	});
	Object.defineProperty(this, "href", {
		get: function()   { return DKCPP_DKDomLocation_href();    },
		set: function(val){ return DKCPP_DKDomLocation_href(val); }
	});
	Object.defineProperty(this, "origin", {
		get: function(){ return DKCPP_DKDomLocation_origin(); } 
	});
	Object.defineProperty(this, "pathname", {
		get: function()   { return DKCPP_DKDomLocation_pathname();    },
		set: function(val){ return DKCPP_DKDomLocation_pathname(val); }
	});
	Object.defineProperty(this, "port", {
		get: function()   { return DKCPP_DKDomLocation_port();    },
		set: function(val){ return DKCPP_DKDomLocation_port(val); }
	});
	Object.defineProperty(this, "protocol", {
		get: function()   { return DKCPP_DKDomLocation_protocol();    },
		set: function(val){ return DKCPP_DKDomLocation_protocol(val); }
	});
	Object.defineProperty(this, "search", {
		get: function()   { return DKCPP_DKDomLocation_search();    },
		set: function(val){ return DKCPP_DKDomLocation_search(val); }
	});
	
	Location.prototype.assign = function(url){
		DKCPP_DKDomLocation_href(url); 
	}
	Location.prototype.reload = function(forcedReload){
		DKCPP_DKDomLocation_reload(forcedReload); 
	}
	Location.prototype.replace = function(url){
		DKCPP_DKDomLocation_href(url); //TODO - https://developer.mozilla.org/en-US/docs/Web/API/Location/replace
	}
}

var location = new Location("location");