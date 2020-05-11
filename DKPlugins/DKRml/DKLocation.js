//https://developer.mozilla.org/en-US/docs/Web/API/Location

var location;

////////////////////////////////
var Location = function(pointer)
{
	Object.defineProperty(this, "hash", { get: function(){ return DKLocation_hash(); } });
	Object.defineProperty(this, "host", {
		get: function()   { return DKLocation_host();      },
		set: function(val){ return DKLocation_host(val);   }
	});
	Object.defineProperty(this, "hostname", {
		get: function()   { return DKLocation_hostname();      },
		set: function(val){ return DKLocation_hostname(val);   }
	});
	Object.defineProperty(this, "href", {
		get: function()   { return DKLocation_href();      },
		set: function(val){ return DKLocation_href(val);   }
	});
	Object.defineProperty(this, "origin", { get: function(){ return DKLocation_origin(); } });
	Object.defineProperty(this, "pathname", {
		get: function()   { return DKLocation_pathname();      },
		set: function(val){ return DKLocation_pathname(val);   }
	});
	Object.defineProperty(this, "port", {
		get: function()   { return DKLocation_port();      },
		set: function(val){ return DKLocation_port(val);   }
	});
	Object.defineProperty(this, "protocol", {
		get: function()   { return DKLocation_protocol();      },
		set: function(val){ return DKLocation_protocol(val);   }
	});
	Object.defineProperty(this, "search", {
		get: function()   { return DKLocation_search();      },
		set: function(val){ return DKLocation_search(val);   }
	});
	
	Location.prototype.assign = function(url){
		DKLocation_href(url); 
	}
	Location.prototype.reload = function(forcedReload){
		DKLocation_reload(forcedReload); 
	}
	Location.prototype.replace = function(url){
		DKLocation_href(url); //TODO - https://developer.mozilla.org/en-US/docs/Web/API/Location/replace
	}
	Location.prototype.toString = function(){
		return DKLocation_href(); 
	}
	Location.prototype.valueOf = function(){
		return DKLocation_href(); 
	}
}

location = new Location("location");