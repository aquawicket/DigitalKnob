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

dk.time = new DKTime();

function DKTime() {
    return DKPlugin.call(this, arguments);
}

DKTime.prototype.create = function DKTime_create(percision) {
    !percision && (percision = 1000);
    window.setInterval(this.update, percision);
    return this;
}

DKTime.prototype.setLatitudeLongitude = function DKTime_setLatitude_longitude(latitude, longitude, zenith) {
    latitude && (this.latitude = latitude);
    longitude && (this.longitude = longitude);
    !zenith && (zenith = 0);
    zenith && (this.longitude = zenith);
}

//TODO - make this function faster
DKTime.prototype.update = function DKTime_update() {
    const instance = this;
    dk.time.date = new Date();
    dk.time.year = dk.time.date.getFullYear();
    dk.time.month = (dk.time.date.getMonth() + 1);
    dk.time.day = dk.time.date.getDate();
    dk.time.military = dk.time.date.getHours();
    if (dk.time.military > 11) {
        dk.time.ampm = "PM";
        if (dk.time.military > 12)
            dk.time.hour = dk.time.military - 12;
        else
            dk.time.hour = dk.time.military;
    } else {
        dk.time.ampm = "AM";
        dk.time.hour = dk.time.military;
        if (dk.time.military < 10)
            dk.time.military = "0" + dk.time.military;
    }
    dk.time.minute = dk.time.date.getMinutes();
    dk.time.minute = dk.time.minute > 9 ? dk.time.minute : '0' + dk.time.minute;
    dk.time.second = dk.time.date.getSeconds();
    dk.time.second = dk.time.second > 9 ? dk.time.second : '0' + dk.time.second;
    dk.time.milliseconds = dk.time.date.getTime();
    switch (dk.time.date.getDay()) {
    case 0:
        dk.time.dayName = "Sunday";
        break;
    case 1:
        dk.time.dayName = "Monday";
        break;
    case 2:
        dk.time.dayName = "Tuesday";
        break;
    case 3:
        dk.time.dayName = "Wednesday";
        break;
    case 4:
        dk.time.dayName = "Thursday";
        break;
    case 5:
        dk.time.dayName = "Friday";
        break;
    case 6:
        dk.time.dayName = "Saturday";
        break;
    default:
        dk.time.dayName = "ERROR";
    }
    dk.time.time = Number(dk.time.military) + (dk.time.minute * .01);

    if (dk.time.longitude && dk.time.latitude) {
        let date = new Date().sunrise(dk.time.latitude, dk.time.longitude, dk.time.zenith);
        dk.time.sunrise = date.getHours() + (date.getMinutes() * .01);
        date = new Date().sunset(dk.time.latitude, dk.time.longitude, dk.time.zenith);
        dk.time.sunset = date.getHours() + (date.getMinutes() * .01);
    }
  
    for(let n=0; dk.time.updateFuncs && n < dk.time.updateFuncs.length; n++){
        dk.time.updateFuncs[n]();
    }   
}


DKTime.prototype.addUpdater = function DKTime_addUpdater(func){
    if(typeof func !== "function")
        return error("func invalid");
    !dk.time.updateFuncs && (dk.time.updateFuncs = new Array)
    dk.time.updateFuncs.push(func);
}



// Html Clock
DKTime.prototype.createClock = function DKTime_createClock(parent, top, bottom, left, right, width, height){
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

DKTime.prototype.updateClock = function DKTime_updateClock(){
    const datetime = dk.time.dayName + " " + dk.time.month + "/" + dk.time.day + "/" + dk.time.year + "  " + dk.time.hour + ":" + dk.time.minute + ":" + dk.time.second + " " + dk.time.ampm;
    if (dk.time.html)
        dk.time.html.innerHTML = datetime;
}