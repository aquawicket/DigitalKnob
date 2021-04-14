"use strict";
// https://developer.mozilla.org/en-US/docs/Web/API/HTMLTimeElement

// Date/Time 
/*
const dateEvent = new Date();
//format: August 19, 1975 23:15:30 UTC
const date = dateEvent.toJSON();
//format: 1975-08-19T23:15:30.000Z
const utcDate = dateEvent.toUTCString();
//format: Tue, 19 Aug 1975 23:15:30 GMT
*/

const dkClock = new Object;

function DKClock_GetSunrise(latitude, longitude, zenith){
    const date = new Date().sunrise(latitude, longitude, zenith);
    dkClock.sunrize = date.getHours() + (date.getMinutes() * .01);
    console.log("Sunrise "+dkClock.sunrize);
    return dkClock.sunrize;
}

function DKClock_GetSunset(latitude, longitude, zenith){
    const date = new Date().sunset(latitude, longitude, zenith);
    dkClock.sunset = date.getHours() + (date.getMinutes() * .01);
    console.log("Sunset "+dkClock.sunset);
    return dkClock.sunset
}

function DKClock_GetDateInMilliseconds() {
    const date = new Date();
    return date.getTime();
}

function DKClock_Create(parent, id, top, bottom, left, right, width, weight) {
    const clock = document.createElement("a");
    clock.id = id;
    clock.style.position = "absolute";
    clock.style.top = top;
    clock.style.right = right;
    parent.appendChild(clock);
    window.setInterval(DKClock_Update, 1000);
}

function DKClock_GetStandardTime() {
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

function DKClock_GetDate() {
    var d = new Date();
    var date = d.getMonth() + 1;
    date += "/";
    date += d.getDate();
    date += "/";
    date += d.getFullYear();
    return date;
}

function DKClock_Update() {
    const currentdate = new Date();
    dkClock.time = currentdate.getHours() + (currentdate.getMinutes() * .01);
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
    if (byId("clock")) {
        byId("clock").innerHTML = datetime;
    }
}
