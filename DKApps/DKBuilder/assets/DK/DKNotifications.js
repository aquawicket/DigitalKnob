"use strict";

// https://developer.mozilla.org/en-US/docs/Web/API/Notifications_API
dk.notifications = DKPlugin(DKNotifications)

function DKNotifications() {}


DKNotifications.prototype.notifyMe = function DKNotifications_notifyMe() {
    if (Notification.permission == 'granted') {
        navigator.serviceWorker.getRegistration().then(function DKNotifications_notifyMe_callback(reg) {
            reg.showNotification('Hello world!');
        });
    }
}
