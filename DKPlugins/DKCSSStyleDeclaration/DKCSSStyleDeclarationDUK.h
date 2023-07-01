// [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration
#if HAVE_DKDuktape

#pragma once
#ifndef DKCSSStyleDeclarationDUK_H
#define DKCSSStyleDeclarationDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
// [Exposed=Window]
// interface CSSStyleDeclaration {
class DKCSSStyleDeclarationDUK : public DKObjectT<DKCSSStyleDeclarationDUK>
{
public:
	bool Init(){
		DKDuktape::AttachFunction("CPP_DKCSSStyleDeclarationDUK_constructor",			DKCSSStyleDeclarationDUK::constructor);
		
		// [CEReactions] attribute CSSOMString cssText;
		DKDuktape::AttachFunction("CPP_DKCSSStyleDeclarationDUK_cssText",				DKCSSStyleDeclarationDUK::cssText);
		
		// readonly attribute unsigned long length;
		DKDuktape::AttachFunction("CPP_DKCSSStyleDeclarationDUK_length",				DKCSSStyleDeclarationDUK::length);
		
		// getter CSSOMString item(unsigned long index);
		DKDuktape::AttachFunction("CPP_DKCSSStyleDeclarationDUK_item",					DKCSSStyleDeclarationDUK::item);
		
		// CSSOMString getPropertyValue(CSSOMString property);
		DKDuktape::AttachFunction("CPP_DKCSSStyleDeclarationDUK_getPropertyValue",		DKCSSStyleDeclarationDUK::getPropertyValue);
		
		// CSSOMString getPropertyPriority(CSSOMString property);
		DKDuktape::AttachFunction("CPP_DKCSSStyleDeclarationDUK_getPropertyPriority",	DKCSSStyleDeclarationDUK::getPropertyPriority);
		
		// [CEReactions] undefined setProperty(CSSOMString property, [LegacyNullToEmptyString] CSSOMString value, optional [LegacyNullToEmptyString] CSSOMString priority = "");
		DKDuktape::AttachFunction("CPP_DKCSSStyleDeclarationDUK_setProperty",			DKCSSStyleDeclarationDUK::setProperty);
		
		// [CEReactions] CSSOMString removeProperty(CSSOMString property);
		DKDuktape::AttachFunction("CPP_DKCSSStyleDeclarationDUK_removeProperty",		DKCSSStyleDeclarationDUK::removeProperty);
		
		// readonly attribute CSSRule? parentRule;
		DKDuktape::AttachFunction("CPP_DKCSSStyleDeclarationDUK_parentRule",			DKCSSStyleDeclarationDUK::parentRule);
		
		// [CEReactions] attribute [LegacyNullToEmptyString] CSSOMString cssFloat;
		DKDuktape::AttachFunction("CPP_DKCSSStyleDeclarationDUK_cssFloat",				DKCSSStyleDeclarationDUK::cssFloat);
		
		
		////// Load .js files //////
		DKClass::DKCreate("DKCSSStyleDeclaration/DKCSSStyleDeclarationDUK.js");
		
		return true;
	}
	
	static DKCSSStyleDeclaration* cssStyleDeclaration(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKCSSStyleDeclaration*)addressToPointer(eventTargetAddress);
	}
	static bool GetBool(duk_context* ctx, int index = 1){
		if (duk_is_boolean(ctx, index))
			return duk_to_boolean(ctx, index);
		return false;
	}
	static double GetDouble(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_number(ctx, index);
		return 0.0;
	}
	static int GetInt(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_int(ctx, index);
		return 0;
	}
	static DKString GetString(duk_context* ctx, int index = 1){
		if (duk_is_string(ctx, index))
			return duk_to_string(ctx, index);
		return "";
	}
	static unsigned int GetUint(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_uint(ctx, index);
		return 0;
	}

	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		DKINFO("CPP_DKElementDUK_constructor()\n");
		DKCSSStyleDeclaration* _cssStyleDeclaration = new DKCSSStyleDeclaration();
		dukglue_push(ctx, _cssStyleDeclaration->interfaceAddress);
		return true;
	}
	
	// [CEReactions] attribute CSSOMString cssText;
	static int cssText(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			cssStyleDeclaration(ctx)->cssText(GetString(ctx));
		dukglue_push(ctx, cssStyleDeclaration(ctx)->cssText());
		return true;
	}
	
	// readonly attribute unsigned long length;
	static int length(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			cssStyleDeclaration(ctx)->length(GetUint(ctx));
		dukglue_push(ctx, cssStyleDeclaration(ctx)->length());
		return true;
	}
	
	// getter CSSOMString item(unsigned long index);
	static int item(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, cssStyleDeclaration(ctx)->item(GetUint(ctx)) );
		return true;
	}
	
	// CSSOMString getPropertyValue(CSSOMString property);
	static int getPropertyValue(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, cssStyleDeclaration(ctx)->getPropertyValue(GetString(ctx)) );
		return true;
	}
	
	// CSSOMString getPropertyPriority(CSSOMString property);
	static int getPropertyPriority(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, cssStyleDeclaration(ctx)->getPropertyPriority(GetString(ctx)) );
		return true;
	}
	
	// [CEReactions] undefined setProperty(CSSOMString property, [LegacyNullToEmptyString] CSSOMString value, optional [LegacyNullToEmptyString] CSSOMString priority = "");
	static int setProperty(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		CSSOMString property = GetString(ctx, 1);
		CSSOMString value = GetString(ctx, 2);
		//CSSOMString priority = GetString(ctx, 3);
		cssStyleDeclaration(ctx)->setProperty(property, value);
		return true;
	}
	
	// [CEReactions] CSSOMString removeProperty(CSSOMString property);
	static int removeProperty(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, cssStyleDeclaration(ctx)->removeProperty(GetString(ctx)) );
		return true;
	}
	
	// readonly attribute CSSRule? parentRule;
	static int parentRule(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			cssStyleDeclaration(ctx)->parentRule(GetString(ctx));
		dukglue_push(ctx, cssStyleDeclaration(ctx)->parentRule());
		return true;
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] CSSOMString cssFloat;
	static int cssFloat(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			cssStyleDeclaration(ctx)->cssFloat(GetString(ctx));
		dukglue_push(ctx, cssStyleDeclaration(ctx)->cssFloat());
		return true;
	}
};
REGISTER_OBJECT(DKCSSStyleDeclarationDUK, true)


#endif //DKCSSStyleDeclarationDUK_H
#endif //HAVE_DKDuktape