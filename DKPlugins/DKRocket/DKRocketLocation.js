//https://developer.mozilla.org/en-US/docs/Web/API/Locationc

var location;

////////////////////////////////
var Location = function(pointer)
{
	Object.defineProperty(this, "hash", { get: function(){ return DKRocketLocation_hash(); } });
	Object.defineProperty(this, "host", {
		get: function()   { return DKRocketLocation_host();      },
		set: function(val){ return DKRocketLocation_host(val);   }
	});
	Object.defineProperty(this, "hostname", {
		get: function()   { return DKRocketLocation_hostname();      },
		set: function(val){ return DKRocketLocation_hostname(val);   }
	});
	Object.defineProperty(this, "href", {
		get: function()   { return DKRocketLocation_href();      },
		set: function(val){ return DKRocketLocation_href(val);   }
	});
	Object.defineProperty(this, "origin", { get: function(){ return DKRocketLocation_origin(); } });
	Object.defineProperty(this, "pathname", {
		get: function()   { return DKRocketLocation_pathname();      },
		set: function(val){ return DKRocketLocation_pathname(val);   }
	});
	Object.defineProperty(this, "port", {
		get: function()   { return DKRocketLocation_port();      },
		set: function(val){ return DKRocketLocation_port(val);   }
	});
	Object.defineProperty(this, "protocol", {
		get: function()   { return DKRocketLocation_protocol();      },
		set: function(val){ return DKRocketLocation_protocol(val);   }
	});
	Object.defineProperty(this, "search", {
		get: function()   { return DKRocketLocation_search();      },
		set: function(val){ return DKRocketLocation_search(val);   }
	});
	
	Location.prototype.assign = function(url){
		DKRocketLocation_href(url); 
	}
	Location.prototype.reload = function(forcedReload){
		DKRocketLocation_reload(forcedReload); 
	}
	Location.prototype.replace = function(url){
		DKRocketLocation_href(url); //TODO - https://developer.mozilla.org/en-US/docs/Web/API/Location/replace
	}
}

location = new Location("location");