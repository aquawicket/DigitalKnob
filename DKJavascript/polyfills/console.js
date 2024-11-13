

(function(con) {
	'use strict';
	var prop, method;
	var empty = {};
	if(typeof ActiveXObject === "function"){
		if(typeof WScript === "object"){
			var print = function(msg) { WScript.StdOut.Write(msg+"\n"); };
		} else {
			var print = function(msg) {
				// https://stackoverflow.com/a/52793021/688352
				//var WShell = new ActiveXObject('WScript.Shell');
				//var WShellExec = WShell.Exec("cmd /c echo "+msg);
				if(typeof dkconsole === "object"){
					dkconsole.log(msg);
				}
			}
		}
	}
	var properties = 'memory'.split(',');
	var methods = ('assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn').split(',');
	while (prop = properties.pop()) con[prop] = con[prop] || empty;
	while (method = methods.pop()) con[method] = con[method] || print;
})(this.console = this.console || {});
