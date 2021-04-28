//http://www.steves-internet-guide.com/using-javascript-mqtt-client-websockets/

"use strict";

dk.mqtt = new Object;

dk.mqtt.init = function dk_mqtt_init()(){
    dk.create("DKTasmota/mqttws31.min.js");
    dk.mqtt.mqtt;
    dk.mqtt.reconnectTimeout = 2000;
    dk.mqtt.host = "127.0.0.1";
    dk.mqtt.port = 9001;
}

dk.mqtt.onMqttConnect = function dk_mqtt_onMqttConnect() {
    // Once a connection has been made, make a subscription and send a message.
    console.log("Mqtt Connected");
    //mqtt.subscribe("sensor1");
    message = new Paho.MQTT.Message("Hello World");
    message.destinationName = "sensor1";
    mqtt.send(message);
}

dk.mqtt.connect = function dk_mqtt_connect() {
    console.log("connecting to " + host + " " + port);
    var x = Math.floor(Math.random() * 10000);
    var cname = "orderform-" + x;
    mqtt = new Paho.MQTT.Client(host,port,cname);
    //document.write("connecting to "+ host);
    var options = {
        timeout: 3,
        onSuccess: dk.mqtt.onMqttConnect,
    };

    mqtt.connect(options);
}
