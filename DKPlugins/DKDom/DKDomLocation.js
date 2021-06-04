//https://developer.mozilla.org/en-US/docs/Web/API/Location

var Location = function(pointer) {
    // Properties
    Object.defineProperty(this, "hash", {
        get: function() {
            return CPP_DKDomLocation_hash();
        }
    });
    Object.defineProperty(this, "host", {
        get: function() {
            return CPP_DKDomLocation_host();
        },
        set: function(val) {
            return CPP_DKDomLocation_host(val);
        }
    });
    Object.defineProperty(this, "hostname", {
        get: function() {
            return CPP_DKDomLocation_hostname();
        },
        set: function(val) {
            return CPP_DKDomLocation_hostname(val);
        }
    });
    Object.defineProperty(this, "href", {
        get: function() {
            return CPP_DKDomLocation_href();
        },
        set: function(val) {
            return CPP_DKDomLocation_href(val);
        }
    });
    Object.defineProperty(this, "origin", {
        get: function() {
            return CPP_DKDomLocation_origin();
        }
    });
    Object.defineProperty(this, "pathname", {
        get: function() {
            return CPP_DKDomLocation_pathname();
        },
        set: function(val) {
            return CPP_DKDomLocation_pathname(val);
        }
    });
    Object.defineProperty(this, "port", {
        get: function() {
            return CPP_DKDomLocation_port();
        },
        set: function(val) {
            return CPP_DKDomLocation_port(val);
        }
    });
    Object.defineProperty(this, "protocol", {
        get: function() {
            return CPP_DKDomLocation_protocol();
        },
        set: function(val) {
            return CPP_DKDomLocation_protocol(val);
        }
    });
    Object.defineProperty(this, "search", {
        get: function() {
            return CPP_DKDomLocation_search();
        },
        set: function(val) {
            return CPP_DKDomLocation_search(val);
        }
    });

    // Methods
    Location.prototype.assign = function(url) {
        CPP_DKDomLocation_href(url);
    }
    Location.prototype.reload = function(forcedReload) {
        CPP_DK_Reload();
        //CPP_DKDomLocation_reload(forcedReload); 
    }
    Location.prototype.replace = function(url) {
        CPP_DKDomLocation_href(url);
        //TODO - https://developer.mozilla.org/en-US/docs/Web/API/Location/replace
    }
}

var location = new Location("location");
