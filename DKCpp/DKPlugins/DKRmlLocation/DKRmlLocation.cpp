#include "DKRmlLocation/DKRmlLocation.h"
#include "DKRmlDocument/DKRmlDocument.h"

// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window]
// interface Location { // but see also additional creation steps and overridden internal methods

// [LegacyUnforgeable] stringifier attribute USVString href;
const USVString& DKRmlLocation::href() {					// getter
	DKDEBUGFUNC();
	_href = _dkRmlInterface->href_;
	return _href;
}
void DKRmlLocation::href(const USVString& href) { 			// setter
	DKDEBUGFUNC(href);
	
	DKLocation::href(href);
	_dkRmlInterface->LoadUrl(href);
		
	DKINFO("load_event!\n");
	DKEvent load_event("load", "");
	DKRmlDocument* dkRmlDocument = DKRmlDocument::instance(_dkRmlInterface, _dkRmlEventListener);
	dkRmlDocument->dispatchEvent(&load_event);
}

// [LegacyUnforgeable] readonly attribute USVString origin;
const USVString& DKRmlLocation::origin() {					// getter
	DKDEBUGFUNC();
	DKTODO();
	return _origin;
}
void DKRmlLocation::origin(const USVString& origin) { 		// setter
	DKDEBUGFUNC(origin);
	DKTODO();
}
	
// [LegacyUnforgeable] attribute USVString protocol;
const USVString& DKRmlLocation::protocol() {				// getter
	DKDEBUGFUNC();
	DKTODO();
	return _protocol;
}
void DKRmlLocation::protocol(const USVString& protocol) { 	// setter
	DKDEBUGFUNC(protocol);
	DKTODO();
}
	
// [LegacyUnforgeable] attribute USVString host;
const USVString& DKRmlLocation::host() {					// getter
	DKDEBUGFUNC();
	DKTODO();
	return _host;
}
void DKRmlLocation::host(const USVString& host) { 			// setter
	DKDEBUGFUNC(host);
	DKTODO();
}
	
// [LegacyUnforgeable] attribute USVString hostname;
const USVString& DKRmlLocation::hostname() {				// getter
	DKDEBUGFUNC();
	DKTODO();
	return _hostname;
}
void DKRmlLocation::hostname(const USVString& hostname) { 	// setter
	DKDEBUGFUNC(hostname);
	DKTODO();
}
	
// [LegacyUnforgeable] attribute USVString port;
const USVString& DKRmlLocation::port() {					// getter
	DKDEBUGFUNC();
	DKTODO();
	return _port;
}
void DKRmlLocation::port(const USVString& port) { 			// setter
	DKDEBUGFUNC(port);
	DKTODO();
}
	
// [LegacyUnforgeable] attribute USVString pathname;
const USVString& DKRmlLocation::pathname() {				// getter
	DKDEBUGFUNC();
	DKTODO();
	return _pathname;
}
void DKRmlLocation::pathname(const USVString& pathname) { 	// setter
	DKDEBUGFUNC(pathname);
	DKTODO();
}
	
// [LegacyUnforgeable] attribute USVString search;
const USVString& DKRmlLocation::search() {					// getter
	DKDEBUGFUNC();
	DKTODO();
	return _search;
}
void DKRmlLocation::search(const USVString& search) { 		// setter
	DKDEBUGFUNC(search);
	DKTODO();
}
	
// [LegacyUnforgeable] attribute USVString hash;
const USVString& DKRmlLocation::hash() {					// getter
	DKDEBUGFUNC();
	DKTODO();
	return _hash;
}
void DKRmlLocation::hash(const USVString& hash) { 			// setter
	DKDEBUGFUNC(hash);
	DKTODO();
}
	
// [LegacyUnforgeable] undefined assign(USVString url);
void DKRmlLocation::assign(const USVString& url) {
	DKDEBUGFUNC(url);
	DKTODO();
}
	
// [LegacyUnforgeable] undefined replace(USVString url);
void DKRmlLocation::replace(const USVString& url) {
	DKDEBUGFUNC(url);
	DKTODO();
}
	
// [LegacyUnforgeable] undefined reload();
void DKRmlLocation::reload() {
	DKDEBUGFUNC();
	DKTODO();
}
	
// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
const DKString& DKRmlLocation::ancestorOrigins() {						// getter
	DKDEBUGFUNC();
	DKTODO();
	return _hash;
}
void DKRmlLocation::ancestorOrigins(const DKString& ancestorOrigins) { 	// setter
	DKDEBUGFUNC(ancestorOrigins);
	DKTODO();
}
	
// };