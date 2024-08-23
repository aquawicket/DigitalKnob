
(function(con) {
	'use strict';
	var prop, method;
	var empty = {};
	if(typeof WScript === "object"){
		var print = function(msg) { WScript.StdOut.Write(msg+"\n"); };
	}
	var properties = 'memory'.split(',');
	var methods = ('assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn').split(',');
	while (prop = properties.pop()) con[prop] = con[prop] || empty;
	while (method = methods.pop()) con[method] = con[method] || print;
})(this.console = this.console || {});
