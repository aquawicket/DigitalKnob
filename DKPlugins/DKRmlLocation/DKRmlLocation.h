// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Location.idl
// [SOURCE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
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
	void href(const USVString& href) override;
};
//REGISTER_OBJECT(DKRmlLocation, true);


#endif //DKLocation_H