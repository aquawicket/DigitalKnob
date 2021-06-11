"use strict";
// https://developer.mozilla.org/en-US/docs/Web/API/HTMLTimeElement
// https://flaviocopes.com/javascript-namespaces/

/*
const dateEvent = new Date();
format: August 19, 1975 23:15:30 UTC
const date = dateEvent.toJSON();
format: 1975-08-19T23:15:30.000Z
const utcDate = dateEvent.toUTCString();
format: Tue, 19 Aug 1975 23:15:30 GMT
*/

dk.clock = new DKClock();

function DKClock() {
    return DKPlugin.call(this, arguments);
}

DKClock.prototype.create = function DKClock_create(percision) {
    !percision && (percision = 1000);
    window.setInterval(this.update, percision);
    return this;
}

DKClock.prototype.setLatitudeLongitude = function DKClock_setLatitude_longitude(latitude, longitude, zenith) {
    latitude && (this.latitude = latitude);
    longitude && (this.longitude = longitude);
    !zenith && (zenith = 0);
    zenith && (this.longitude = zenith);
}

//TODO - make this function faster
DKClock.prototype.update = function DKClock_update() {
    const instance = this;
    dk.clock.date = new Date();
    dk.clock.year = dk.clock.date.getFullYear();
    dk.clock.month = (dk.clock.date.getMonth() + 1);
    dk.clock.day = dk.clock.date.getDate();
    dk.clock.military = dk.clock.date.getHours();
    if (dk.clock.military > 11) {
        dk.clock.ampm = "PM";
        if (dk.clock.military > 12)
            dk.clock.hour = dk.clock.military - 12;
        else
            dk.clock.hour = dk.clock.military;
    } else {
        dk.clock.ampm = "AM";
        dk.clock.hour = dk.clock.military;
        if (dk.clock.military < 10)
            dk.clock.military = "0" + dk.clock.military;
    }
    dk.clock.minute = dk.clock.date.getMinutes();
    dk.clock.minute = dk.clock.minute > 9 ? dk.clock.minute : '0' + dk.clock.minute;
    dk.clock.second = dk.clock.date.getSeconds();
    dk.clock.second = dk.clock.second > 9 ? dk.clock.second : '0' + dk.clock.second;
    dk.clock.milliseconds = dk.clock.date.getTime();
    switch (dk.clock.date.getDay()) {
    case 0:
        dk.clock.dayName = "Sunday";
        break;
    case 1:
        dk.clock.dayName = "Monday";
        break;
    case 2:
        dk.clock.dayName = "Tuesday";
        break;
    case 3:
        dk.clock.dayName = "Wednesday";
        break;
    case 4:
        dk.clock.dayName = "Thursday";
        break;
    case 5:
        dk.clock.dayName = "Friday";
        break;
    case 6:
        dk.clock.dayName = "Saturday";
        break;
    default:
        dk.clock.dayName = "ERROR";
    }
    dk.clock.time = Number(dk.clock.military) + (dk.clock.minute * .01);

    if (dk.clock.longitude && dk.clock.latitude) {
        let date = new Date().sunrise(dk.clock.latitude, dk.clock.longitude, dk.clock.zenith);
        dk.clock.sunrise = date.getHours() + (date.getMinutes() * .01);
        date = new Date().sunset(dk.clock.latitude, dk.clock.longitude, dk.clock.zenith);
        dk.clock.sunset = date.getHours() + (date.getMinutes() * .01);
    }
  
    for(let n=0; dk.clock.updateFuncs && n < dk.clock.updateFuncs.length; n++){
        dk.clock.updateFuncs[n]();
    }   
}


DKClock.prototype.addUpdater = function DKClock_addUpdater(func){
    if(typeof func !== "function")
        return error("func invalid");
    !dk.clock.updateFuncs && (dk.clock.updateFuncs = new Array)
    dk.clock.updateFuncs.push(func);
}



// Html Clock
DKClock.prototype.createClock = function DKClock_createClock(parent, top, bottom, left, right, width, height){
    this.html = document.createElement("a");
    this.html.style.position = "absolute";
    top && (this.html.style.top = top);
    bottom && (this.html.style.bottom = bottom);
    left && (this.html.style.left = left);
    right && (this.html.style.right = right);
    width && (this.html.style.width = width);
    height && (this.html.style.height = height);
    parent.appendChild(this.html);
    this.addUpdater(this.updateClock);
    return this.html;
}

DKClock.prototype.updateClock = function DKClock_updateClock(){
    const datetime = dk.clock.dayName + " " + dk.clock.month + "/" + dk.clock.day + "/" + dk.clock.year + "  " + dk.clock.hour + ":" + dk.clock.minute + ":" + dk.clock.second + " " + dk.clock.ampm;
    if (dk.clock.html)
        dk.clock.html.innerHTML = datetime;
}