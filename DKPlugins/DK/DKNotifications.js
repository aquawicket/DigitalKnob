"use strict";
// https://developer.mozilla.org/en-US/docs/Web/API/Notifications_API
DKNotifications.prototype = Object.create(DKPlugin.prototype);
function DKNotifications(identifier) {
    return DKPlugin.call(this, identifier);
}
dk.notifications = new DKNotifications("DKNotifications");

dk.notifications.notifyMe = function dk_notifications_notifyMe() {
    if (Notification.permission == 'granted') {
        navigator.serviceWorker.getRegistration().then(function dk_notifications_notifyMe_callback(reg) {
            reg.showNotification('Hello world!');
        });
    }
}
