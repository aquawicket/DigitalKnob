var location;

////////////////////////////////
var Location = function(pointer)
{
	Object.defineProperty(this, "hash", { get: function(){ return DKLocation_hash(); } });
	Object.defineProperty(this, "host",{
		value: "TODO",
	});
	Object.defineProperty(this, "hostname",{
		value: "TODO",
	});
	Object.defineProperty(this, "href", {
		get: function()   { return DKLocation_href();      },
		set: function(val){ return DKLocation_href(val);   }
	});
	Object.defineProperty(this, "origin",{
		value: "TODO",
	});
	Object.defineProperty(this, "pathname",{
		value: "TODO",
	});
	Object.defineProperty(this, "port",{
		value: "TODO",
	});
	Object.defineProperty(this, "protocol",{
		value: "TODO",
	});
	Object.defineProperty(this, "search",{
		value: "TODO",
	});
	
	Location.prototype.assign = function(url){
		return DKLocation_assign(url);
	}
	Location.prototype.reload = function(forceGet){
		//TODO
	}
	Location.prototype.replace = function(newUrl){
		//TODO
	}
}

location = new Location("location");