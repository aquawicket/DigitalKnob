"use strict";
// https://developer.mozilla.org/en-US/docs/Web/API/Notifications_API

dk.notifications = new DKPlugin("dk.notifications");

dk.notifications.notifyMe = function dk_notifications_notifyMe() {
    if (Notification.permission == 'granted') {
        navigator.serviceWorker.getRegistration().then(function dk_notifications_notifyMe_callback(reg) {
            reg.showNotification('Hello world!');
        });
    }
}
