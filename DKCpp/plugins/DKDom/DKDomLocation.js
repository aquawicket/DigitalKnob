//https://developer.mozilla.org/en-US/docs/Web/API/Location

<<<<<<< HEAD:DKPlugins/DKDom/DKDomLocation.js
var Location = function Location(pointer) {
    // Properties
    Object.defineProperty(this, "hash", {
        get: function hash() {
=======
var Location = function Location(pointer){
    // Properties
    Object.defineProperty(this, "hash", {
        get: function hash(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomLocation.js
            return CPP_DKDomLocation_hash();
        }
    });
    Object.defineProperty(this, "host", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomLocation.js
        get: function host() {
            return CPP_DKDomLocation_host();
        },
        set: function host(val) {
=======
        get: function host(){
            return CPP_DKDomLocation_host();
        },
        set: function host(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomLocation.js
            return CPP_DKDomLocation_host(val);
        }
    });
    Object.defineProperty(this, "hostname", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomLocation.js
        get: function hostname() {
            return CPP_DKDomLocation_hostname();
        },
        set: function hostname(val) {
=======
        get: function hostname(){
            return CPP_DKDomLocation_hostname();
        },
        set: function hostname(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomLocation.js
            return CPP_DKDomLocation_hostname(val);
        }
    });
    Object.defineProperty(this, "href", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomLocation.js
        get: function href() {
            return CPP_DKDomLocation_href();
        },
        set: function href(val) {
=======
        get: function href(){
            return CPP_DKDomLocation_href();
        },
        set: function href(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomLocation.js
            return CPP_DKDomLocation_href(val);
        }
    });
    Object.defineProperty(this, "origin", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomLocation.js
        get: function origin() {
=======
        get: function origin(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomLocation.js
            return CPP_DKDomLocation_origin();
        }
    });
    Object.defineProperty(this, "pathname", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomLocation.js
        get: function pathname() {
            return CPP_DKDomLocation_pathname();
        },
        set: function pathname(val) {
=======
        get: function pathname(){
            return CPP_DKDomLocation_pathname();
        },
        set: function pathname(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomLocation.js
            return CPP_DKDomLocation_pathname(val);
        }
    });
    Object.defineProperty(this, "port", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomLocation.js
        get: function port() {
            return CPP_DKDomLocation_port();
        },
        set: function port(val) {
=======
        get: function port(){
            return CPP_DKDomLocation_port();
        },
        set: function port(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomLocation.js
            return CPP_DKDomLocation_port(val);
        }
    });
    Object.defineProperty(this, "protocol", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomLocation.js
        get: function protocol() {
            return CPP_DKDomLocation_protocol();
        },
        set: function protocol(val) {
=======
        get: function protocol(){
            return CPP_DKDomLocation_protocol();
        },
        set: function protocol(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomLocation.js
            return CPP_DKDomLocation_protocol(val);
        }
    });
    Object.defineProperty(this, "search", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomLocation.js
        get: function search() {
            return CPP_DKDomLocation_search();
        },
        set: function search(val) {
=======
        get: function search(){
            return CPP_DKDomLocation_search();
        },
        set: function search(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomLocation.js
            return CPP_DKDomLocation_search(val);
        }
    });

    // Methods
<<<<<<< HEAD:DKPlugins/DKDom/DKDomLocation.js
    Location.prototype.assign = function assign(url) {
        CPP_DKDomLocation_href(url);
    }
    Location.prototype.reload = function reload(forcedReload) {
        CPP_DK_Reload();
        //CPP_DKDomLocation_reload(forcedReload); 
    }
    Location.prototype.replace = function replace(url) {
=======
    Location.prototype.assign = function assign(url){
        CPP_DKDomLocation_href(url);
    }
    Location.prototype.reload = function reload(forcedReload){
        CPP_DK_Reload();
        //CPP_DKDomLocation_reload(forcedReload); 
    }
    Location.prototype.replace = function replace(url){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomLocation.js
        CPP_DKDomLocation_href(url);
        //TODO - https://developer.mozilla.org/en-US/docs/Web/API/Location/replace
    }
}

var location = new Location("location");
window.location = location;
