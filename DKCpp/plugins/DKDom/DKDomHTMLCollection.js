//https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection

// https://dom.spec.whatwg.org/#interface-htmlcollection
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLCollection.js
var HTMLCollection = function HTMLCollection(pointers) {
=======
var HTMLCollection = function HTMLCollection(pointers){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLCollection.js
    var arry = pointers.split(",");
    for (var i = 0; i < arry.length; i++){
        this.push(new HTMLElement(arry[i]));
    }

<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLCollection.js
    HTMLCollection.prototype.item = function item(index) {
        return this[index];
    }
    HTMLCollection.prototype.namedItem = function namedItem(name) {
        for (var i = 0; i < this.length; i++) {
            if (this.id && this.id === name) {
=======
    HTMLCollection.prototype.item = function item(index){
        return this[index];
    }
    HTMLCollection.prototype.namedItem = function namedItem(name){
        for (var i = 0; i < this.length; i++){
            if (this.id && this.id === name){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLCollection.js
                return this[i];
            }
            if (this.name && this.name === name){
                return this[i];
            }
        }
        return null;
    }

    return this;
}

// https://dom.spec.whatwg.org/#interface-htmlcollection
// interface HTMLCollection
HTMLCollection.prototype = [];
