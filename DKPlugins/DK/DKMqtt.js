"use strict";

//http://www.steves-internet-guide.com/using-javascript-mqtt-client-websockets/
DKMqtt.prototype = Object.create(DKPlugin.prototype);
function DKMqtt(identifier) {
    return DKPlugin.call(this, identifier);
}
dk.mqtt = new DKMqtt("DKMqtt");

DKMqtt.prototype.init = function DKMqtt_init() {
    dk.create("DKTasmota/mqttws31.min.js");
    this.mqtt;
    this.reconnectTimeout = 2000;
    this.host = "127.0.0.1";
    this.port = 9001;
}

DKMqtt.prototype.onMqttConnect = function DKMqtt_onMqttConnect() {
    // Once a connection has been made, make a subscription and send a message.
    console.log("Mqtt Connected");
    //mqtt.subscribe("sensor1");
    message = new Paho.MQTT.Message("Hello World");
    message.destinationName = "sensor1";
    mqtt.send(message);
}

DKMqtt.prototype.connect = function DKMqtt_connect() {
    console.log("connecting to " + host + " " + port);
    var x = Math.floor(Math.random() * 10000);
    var cname = "orderform-" + x;
    mqtt = new Paho.MQTT.Client(host,port,cname);
    //document.write("connecting to "+ host);
    var options = {
        timeout: 3,
        onSuccess: this.onMqttConnect,
    };

    mqtt.connect(options);
}
