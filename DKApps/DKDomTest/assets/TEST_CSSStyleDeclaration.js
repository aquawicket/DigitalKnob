// [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration
console.log("\n////// TEST_CSSStyleDeclaration.js //////")


function printCSSStyleDeclarationProperties(cssStyleDeclaration){
	console.log("cssStyleDeclaration = "	+cssStyleDeclaration)
	
	// [CEReactions] attribute CSSOMString cssText;
	console.log("cssStyleDeclaration.cssText = "				+cssStyleDeclaration.cssText)
	
	// readonly attribute unsigned long length;
	console.log("cssStyleDeclaration.length = "					+cssStyleDeclaration.length)
	
	// getter CSSOMString item(unsigned long index);
	console.log("cssStyleDeclaration.item = "					+cssStyleDeclaration.item)
	
	// CSSOMString getPropertyValue(CSSOMString property);
	console.log("cssStyleDeclaration.getPropertyValue = "		+cssStyleDeclaration.getPropertyValue)
	
	// CSSOMString getPropertyPriority(CSSOMString property);
	console.log("cssStyleDeclaration.getPropertyPriority = "	+cssStyleDeclaration.getPropertyPriority)
	
	// [CEReactions] undefined setProperty(CSSOMString property, [LegacyNullToEmptyString] CSSOMString value, optional [LegacyNullToEmptyString] CSSOMString priority = "");
	console.log("cssStyleDeclaration.setProperty = "			+cssStyleDeclaration.setProperty)
	
	// [CEReactions] CSSOMString removeProperty(CSSOMString property);
	console.log("cssStyleDeclaration.removeProperty = "			+cssStyleDeclaration.removeProperty)
	
	// readonly attribute CSSRule? parentRule;
	console.log("cssStyleDeclaration.parentRule = "				+cssStyleDeclaration.parentRule)
	
	// [CEReactions] attribute [LegacyNullToEmptyString] CSSOMString cssFloat;
	console.log("cssStyleDeclaration.cssFloat = "				+cssStyleDeclaration.cssFloat)
}


var cssStyleDeclaration = new CSSStyleDeclaration();
printCSSStyleDeclarationProperties(cssStyleDeclaration);