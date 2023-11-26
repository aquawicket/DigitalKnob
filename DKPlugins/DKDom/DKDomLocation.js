//https://developer.mozilla.org/en-US/docs/Web/API/Location

var Location = function Location(pointer) {
    // Properties
    Object.defineProperty(this, "hash", {
        get: function hash() {
            return CPP_DKDomLocation_hash();
        }
    });
    Object.defineProperty(this, "host", {
        get: function host() {
            return CPP_DKDomLocation_host();
        },
        set: function host(val) {
            return CPP_DKDomLocation_host(val);
        }
    });
    Object.defineProperty(this, "hostname", {
        get: function hostname() {
            return CPP_DKDomLocation_hostname();
        },
        set: function hostname(val) {
            return CPP_DKDomLocation_hostname(val);
        }
    });
    Object.defineProperty(this, "href", {
        get: function href() {
            return CPP_DKDomLocation_href();
        },
        set: function href(val) {
            return CPP_DKDomLocation_href(val);
        }
    });
    Object.defineProperty(this, "origin", {
        get: function origin() {
            return CPP_DKDomLocation_origin();
        }
    });
    Object.defineProperty(this, "pathname", {
        get: function pathname() {
            return CPP_DKDomLocation_pathname();
        },
        set: function pathname(val) {
            return CPP_DKDomLocation_pathname(val);
        }
    });
    Object.defineProperty(this, "port", {
        get: function port() {
            return CPP_DKDomLocation_port();
        },
        set: function port(val) {
            return CPP_DKDomLocation_port(val);
        }
    });
    Object.defineProperty(this, "protocol", {
        get: function protocol() {
            return CPP_DKDomLocation_protocol();
        },
        set: function protocol(val) {
            return CPP_DKDomLocation_protocol(val);
        }
    });
    Object.defineProperty(this, "search", {
        get: function search() {
            return CPP_DKDomLocation_search();
        },
        set: function search(val) {
            return CPP_DKDomLocation_search(val);
        }
    });

    // Methods
    Location.prototype.assign = function assign(url) {
        CPP_DKDomLocation_href(url);
    }
    Location.prototype.reload = function reload(forcedReload) {
        CPP_DK_Reload();
        //CPP_DKDomLocation_reload(forcedReload); 
    }
    Location.prototype.replace = function replace(url) {
        CPP_DKDomLocation_href(url);
        //TODO - https://developer.mozilla.org/en-US/docs/Web/API/Location/replace
    }
}

var location = new Location("location");
window.location = location;
