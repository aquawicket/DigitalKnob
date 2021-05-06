"use strict";
// https://developer.mozilla.org/en-US/docs/Web/API/HTMLTimeElement
// https://flaviocopes.com/javascript-namespaces/

// Date/Time 
/*
const dateEvent = new Date();
//format: August 19, 1975 23:15:30 UTC
const date = dateEvent.toJSON();
//format: 1975-08-19T23:15:30.000Z
const utcDate = dateEvent.toUTCString();
//format: Tue, 19 Aug 1975 23:15:30 GMT
*/

dk.clock = new DKPlugin("dk_clock");

dk.clock.getSunrise = function dk_clock_getSunrise(latitude, longitude, zenith) {
    const date = new Date().sunrise(latitude, longitude, zenith);
    dk.clock.sunrise = date.getHours() + (date.getMinutes() * .01);
    console.log("Sunrise " + dk.clock.sunrise);
    return dk.clock.sunrise;
}
,

dk.clock.getSunset = function dk_clock_getSunset(latitude, longitude, zenith) {
    const date = new Date().sunset(latitude, longitude, zenith);
    dk.clock.sunset = date.getHours() + (date.getMinutes() * .01);
    console.log("Sunset " + dk.clock.sunset);
    return dk.clock.sunset
}
,

dk.clock.getDateInMilliseconds = function dk_clock_getDateInMilliseconds() {
    const date = new Date();
    return date.getTime();
}
,

dk.clock.create = function dk_clock_create(parent, id, top, bottom, left, right, width, weight) {
    dk.clock.html = document.createElement("a");
    dk.clock.html.id = id;
    dk.clock.html.style.position = "absolute";
    dk.clock.html.style.top = top;
    dk.clock.html.style.right = right;
    parent.appendChild(dk.clock.html);
    window.setInterval(this.update, 1000);
}
,

dk.clock.getStandardTime = function dk_clock_getStandardTime() {
    var d = new Date();
    var hour = d.getHours();
    var minute = d.getMinutes();
    minute = minute > 9 ? minute : '0' + minute;
    //pad 0
    var time = hour;
    time += ":";
    time += minute;
    if (hour > 11) {
        time += " PM";
    } else {
        time += " AM";
    }
    return time;
}
,

dk.clock.getDate = function dk_clock_getDate() {
    var d = new Date();
    var date = d.getMonth() + 1;
    date += "/";
    date += d.getDate();
    date += "/";
    date += d.getFullYear();
    return date;
}
,

dk.clock.update = function dk_clock_update() {
    const currentdate = new Date();
    dk.clock.time = currentdate.getHours() + (currentdate.getMinutes() * .01);
    let dayOfWeek;
    switch (currentdate.getDay()) {
    case 0:
        dayOfWeek = "Sunday";
        break;
    case 1:
        dayOfWeek = "Monday";
        break;
    case 2:
        dayOfWeek = "Tuesday";
        break;
    case 3:
        dayOfWeek = "Wednesday";
        break;
    case 4:
        dayOfWeek = "Thursday";
        break;
    case 5:
        dayOfWeek = "Friday";
        break;
    case 6:
        dayOfWeek = "Saturday";
        break;
    default:
        dayOfWeek = "ERROR";
    }

    const datetime = dayOfWeek + " " + (currentdate.getMonth() + 1) + "/" + currentdate.getDate() + "/" + currentdate.getFullYear() + "  " + currentdate.getHours() + ":" + currentdate.getMinutes() + ":" + currentdate.getSeconds();
    if (dk.clock.html) {
        dk.clock.html.innerHTML = datetime;
    }
}
