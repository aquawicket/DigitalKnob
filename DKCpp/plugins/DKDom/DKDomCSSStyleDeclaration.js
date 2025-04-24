// https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration
// https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface

<<<<<<< HEAD:DKPlugins/DKDom/DKDomCSSStyleDeclaration.js
var CSSStyleDeclaration = function CSSStyleDeclaration(pointer) {
=======
var CSSStyleDeclaration = function CSSStyleDeclaration(pointer){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomCSSStyleDeclaration.js
    this.pointer = pointer;

    // Attributes - TODO
    //cssText
    //length
    //parentRule

    // Properties
	//cssFloat

    // Methods
<<<<<<< HEAD:DKPlugins/DKDom/DKDomCSSStyleDeclaration.js
	CSSStyleDeclaration.prototype.getPropertyPriority = function getPropertyPriority(propertyName) {
=======
	CSSStyleDeclaration.prototype.getPropertyPriority = function getPropertyPriority(propertyName){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomCSSStyleDeclaration.js
        this[propertyName] = CPP_DKDomCSSStyleDeclaration_getPropertyPriority(this.pointer, propertyName)
        return this[propertyName];
    }
	
<<<<<<< HEAD:DKPlugins/DKDom/DKDomCSSStyleDeclaration.js
    CSSStyleDeclaration.prototype.getPropertyValue = function getPropertyValue(propertyName) {
=======
    CSSStyleDeclaration.prototype.getPropertyValue = function getPropertyValue(propertyName){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomCSSStyleDeclaration.js
        this[propertyName] = CPP_DKDomCSSStyleDeclaration_getPropertyValue(this.pointer, propertyName)
        return this[propertyName];
    }
	
	// item:  https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration/item
<<<<<<< HEAD:DKPlugins/DKDom/DKDomCSSStyleDeclaration.js
	CSSStyleDeclaration.prototype.item = function item(index) {
=======
	CSSStyleDeclaration.prototype.item = function item(index){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomCSSStyleDeclaration.js
        this[index] = CPP_DKDomCSSStyleDeclaration_item(this.pointer, index)
        return this[index];
    }
	
<<<<<<< HEAD:DKPlugins/DKDom/DKDomCSSStyleDeclaration.js
    CSSStyleDeclaration.prototype.removeProperty = function removeProperty(propertyName) {
=======
    CSSStyleDeclaration.prototype.removeProperty = function removeProperty(propertyName){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomCSSStyleDeclaration.js
        var oldValue = CPP_DKDomCSSStyleDeclaration_removeProperty(this.pointer, propertyName)
        return oldValue;
    }
	
<<<<<<< HEAD:DKPlugins/DKDom/DKDomCSSStyleDeclaration.js
    CSSStyleDeclaration.prototype.setProperty = function setProperty(propertyName, propertyValue, priority) {
=======
    CSSStyleDeclaration.prototype.setProperty = function setProperty(propertyName, propertyValue, priority){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomCSSStyleDeclaration.js
        CPP_DKDomCSSStyleDeclaration_setProperty(this.pointer, propertyName, propertyValue)
        this[propertyName] = propertyValue;
    }
	
    const proxy = new Proxy(this,{
<<<<<<< HEAD:DKPlugins/DKDom/DKDomCSSStyleDeclaration.js
        has: function Proxy(target, key) {
            return key in target;
        },
        get: function Proxy(target, key, recv) {
=======
        has: function Proxy(target, key){
            return key in target;
        },
        get: function Proxy(target, key, recv){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomCSSStyleDeclaration.js
            //console.log("Style:get("+target+","+key+")")
            if (typeof target[key] === "function" || key === "pointer")
                return target[key];
            var realKey = key;
            //Replace characters ( C ) with ( -c )    EXAMPLE:  backgroundColor becomes background-color
            for (var i = 0; i < realKey.length; i++){
                if (realKey.charAt(i) === realKey.charAt(i).toUpperCase()){
                    //is uppercase?
                    if (realKey.charAt(i) === "-")
                        continue;
                    realKey = realKey.substr(0, i) + "-" + realKey.charAt(i).toLowerCase() + realKey.substr(i + 1, realKey.length)
                }
            }
            target[key] = CPP_DKDomCSSStyleDeclaration_getPropertyValue(target["pointer"], realKey)
            return target[key];
        },
<<<<<<< HEAD:DKPlugins/DKDom/DKDomCSSStyleDeclaration.js
        set: function Proxy(target, key, val, recv) {
=======
        set: function Proxy(target, key, val, recv){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomCSSStyleDeclaration.js
            //console.log("Style:set("+target+","+key+","+val+")")
            if (typeof target[key] === "function" || key === "pointer")
                return true;
            var realKey = key;
            //Replace characters ( C ) with ( -c )    EXAMPLE:  backgroundColor becomes background-color
            for (var i = 0; i < realKey.length; i++){
                if (realKey.charAt(i) === realKey.charAt(i).toUpperCase()){
                    //is uppercase?
                    if (realKey.charAt(i) === "-")
                        continue;
                    realKey = realKey.substr(0, i) + "-" + realKey.charAt(i).toLowerCase() + realKey.substr(i + 1, realKey.length)
                }
            }
<<<<<<< HEAD:DKPlugins/DKDom/DKDomCSSStyleDeclaration.js
            if (realKey === "background-image") {
=======
            if (realKey === "background-image"){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomCSSStyleDeclaration.js
                realKey = "decorator";
                var img = val.replace("url(\"", "")
                img = img.replace("\")", "")
                val = "image(" + img + " scale-none left top)";
            }
            CPP_DKDomCSSStyleDeclaration_setProperty(target["pointer"], realKey, val)
            target[key] = val;
            return true;
        },
<<<<<<< HEAD:DKPlugins/DKDom/DKDomCSSStyleDeclaration.js
        deleteProperty: function Proxy(target, key) {
=======
        deleteProperty: function Proxy(target, key){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomCSSStyleDeclaration.js
            delete target[key];
            return true;
        }
    })
    return proxy;
}
