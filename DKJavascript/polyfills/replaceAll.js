// String.prototype.replaceAll (Polyfill)

if(typeof String.prototype.replaceAll !== "function") {
	String.prototype.replaceAll = function replaceAll(search, replace) { 
		return this.split(search).join(replace); 
	}
}
