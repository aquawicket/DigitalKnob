// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
#pragma once
#ifndef DKRmlLocation_H
#define DKRmlLocation_H

#include "DKLocation/DKLocation.h"
#include "DKRmlInterface/DKRmlInterface.h"
#include "DKRmlEventListener/DKRmlEventListener.h"

// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window]
// interface Location { // but see also additional creation steps and overridden internal methods
class DKRmlLocation : virtual public DKLocation //, public DKObjectT<DKRmlLocation>
{
public:
	DKRmlInterface* _dkRmlInterface = nullptr;
	DKRmlEventListener* _dkRmlEventListener = nullptr;

	DKRmlLocation(DKRmlInterface* dkRmlInterface, DKRmlEventListener* dkRmlEventListener) : DKLocation() {
		DKDEBUGFUNC();
		DKASSERT(dkRmlInterface);
		DKASSERT(dkRmlEventListener);
		
		interfaceName = "RmlLocation";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
		
		_dkRmlInterface = dkRmlInterface;
		_dkRmlEventListener = dkRmlEventListener;
	}

	// [LegacyUnforgeable] stringifier attribute USVString href;
	const USVString& href()	override;						// getter
	void href(const USVString& href) override;				// setter
	
	// [LegacyUnforgeable] readonly attribute USVString origin;
	const USVString& origin()	override;					// getter
	void origin(const USVString& origin) override;			// setter
	
	// [LegacyUnforgeable] attribute USVString protocol;
	const USVString& protocol()	override;					// getter
	void protocol(const USVString& protocol) override;		// setter
	
	// [LegacyUnforgeable] attribute USVString host;
	const USVString& host()	override;						// getter
	void host(const USVString& host) override;				// setter
	
	// [LegacyUnforgeable] attribute USVString hostname;
	const USVString& hostname()	override;					// getter
	void hostname(const USVString& hostname) override;		// setter
	
	// [LegacyUnforgeable] attribute USVString port;
	const USVString& port()	override;						// getter
	void port(const USVString& port) override;				// setter
	
	// [LegacyUnforgeable] attribute USVString pathname;
	const USVString& pathname()	override;					// getter
	void pathname(const USVString& pathname) override;		// setter
	
	// [LegacyUnforgeable] attribute USVString search;
	const USVString& search()	override;					// getter
	void search(const USVString& search) override;			// setter
	
	// [LegacyUnforgeable] attribute USVString hash;
	const USVString& hash()	override;						// getter
	void hash(const USVString& hash) override;				// setter
	
	// [LegacyUnforgeable] undefined assign(USVString url);
	void assign(const USVString& url);
	
	// [LegacyUnforgeable] undefined replace(USVString url);
	void replace(const USVString& url);
	
	// [LegacyUnforgeable] undefined reload();
	virtual void reload();
	
	// [LegacyUnforgeable, SameObject] readonly attribute DOMStringList ancestorOrigins;
	const DKString& ancestorOrigins();						// getter
	void ancestorOrigins(const DKString& ancestorOrigins);	// setter
	
// };
};
//REGISTER_OBJECT(DKRmlLocation, true);


#endif //DKLocation_H