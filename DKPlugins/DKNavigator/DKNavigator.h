// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Navigator.idl
// [SOURCE] https://html.spec.whatwg.org/multipage/system-state.html#the-navigator-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Navigator
#pragma once
#ifndef DKNavigator_H
#define DKNavigator_H

#include "DK/DK.h"


class DKNavigator
{
public:
	
	////// Instance properties //////
	////// Standard properties //////
	// [Navigator.connection](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/connection
	// [Navigator.cookieEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/cookieEnabled
	// [Navigator.credentials](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/credentials
	// [Navigator.deviceMemory](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/deviceMemory
	// [Navigator.geolocation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/geolocation
	// [Navigator.gpu](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/gpu
	// [Navigator.hid](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/hid
	// [Navigator.hardwareConcurrency](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/hardwareConcurrency
	// [Navigator.ink](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/ink
	// [Navigator.keyboard](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/keyboard
	// [Navigator.language](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/language
	// [Navigator.languages](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/languages
	// [Navigator.locks](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/locks
	// [Navigator.maxTouchPoints](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/maxTouchPoints
	// [Navigator.mediaCapabilities](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/mediaCapabilities
	// [Navigator.mediaDevices](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/mediaDevices
	// [Navigator.mediaSession](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/mediaSession
	// [Navigator.onLine](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/onLine
	// [Navigator.pdfViewerEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/pdfViewerEnabled
	// [Navigator.permissions](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/permissions
	// [Navigator.presentation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/presentation
	// [Navigator.serial](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/serial
	// [Navigator.serviceWorker](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/serviceWorker
	// [Navigator.storage](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/storage
	// [Navigator.userActivation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/userActivation
	// [Navigator.userAgent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/userAgent
	// [Navigator.userAgentData](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/userAgentData
	// [Navigator.virtualKeyboard](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/virtualKeyboard
	// [Navigator.webdriver](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/webdriver
	// [Navigator.windowControlsOverlay](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/windowControlsOverlay
	// [Navigator.xr](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/xr

	
	////// Non-standard properties //////
	// [Navigator.buildID](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/buildID
	// [Navigator.contacts](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/contacts
	// [Navigator.globalPrivacyControl](Non-standard)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/globalPrivacyControl
	// [Navigator.securitypolicy](Non-standard)
	// [Navigator.standalone](Non-standard)
	// [Navigator.wakeLock](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/wakeLock
	
	
	////// Deprecated properties //////
	// [Navigator.appCodeName](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/appCodeName
	// [Navigator.appName](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/appName
	// [Navigator.appVersion](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/appVersion
	// [Navigator.activeVRDisplays](Read only)(Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/activeVRDisplays
	// [Navigator.doNotTrack](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/doNotTrack
	// [Navigator.mimeTypes](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/mimeTypes
	// [Navigator.oscpu](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/oscpu
	// [Navigator.platform](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/platform
	// [Navigator.plugins](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/plugins
	// [Navigator.product](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/product
	// [Navigator.productSub](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/productSub
	// [Navigator.vendor](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/vendor
	// [Navigator.vendorSub](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/vendorSub

	
	////// Instance methods //////
	// [Navigator.canShare()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/canShare
	// [Navigator.clearAppBadge()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/clearAppBadge
	// [Navigator.getAutoplayPolicy()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/getAutoplayPolicy
	// [Navigator.getBattery()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/getBattery
	// [Navigator.registerProtocolHandler()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/registerProtocolHandler
	// [Navigator.unregisterProtocolHandler()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/unregisterProtocolHandler
	// [Navigator.requestMediaKeySystemAccess()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/requestMediaKeySystemAccess
	// [Navigator.requestMIDIAccess()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/requestMIDIAccess
	// [Navigator.sendBeacon()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/sendBeacon
	// [Navigator.setAppBadge()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/setAppBadge
	// [Navigator.share()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/share
	// [Navigator.vibrate()] https://developer.mozilla.org/en-US/docs/Web/API/Navigator/vibrate


	////// Deprecated methods //////
	// [Navigator.getVRDisplays()](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/getVRDisplays
	// [Navigator.getUserMedia()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/getUserMedia
	// [Navigator.taintEnabled()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/taintEnabled
	// [Navigator.javaEnabled()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Navigator/javaEnabled
};


#endif //DKNavigator_H