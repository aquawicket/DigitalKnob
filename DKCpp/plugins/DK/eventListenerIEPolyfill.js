/**
 * @license addEventListener polyfill 1.0 / Eirik Backer / MIT Licence
 * https://gist.github.com/2864711/946225eb3822c203e8d6218095d888aac5e1748e
 *
 * sounisi5011 version:
 * http://qiita.com/sounisi5011/items/a8fc80e075e4f767b79a#11
 */
<<<<<<< HEAD:DKPlugins/DK/eventListenerIEPolyfill.js
(function (window, document, listeners_prop_name) {
    if ((!window.addEventListener || !window.removeEventListener) && window.attachEvent && window.detachEvent) {
=======
(function (window, document, listeners_prop_name){
    if ((!window.addEventListener || !window.removeEventListener) && window.attachEvent && window.detachEvent){
>>>>>>> Development:DKCpp/plugins/DK/eventListenerIEPolyfill.js
        /**
         * @param {*} value
         * @return {boolean}
         */
<<<<<<< HEAD:DKPlugins/DK/eventListenerIEPolyfill.js
        var is_callable = function (value) {
=======
        var is_callable = function (value){
>>>>>>> Development:DKCpp/plugins/DK/eventListenerIEPolyfill.js
            return typeof value === 'function';
        };
        /**
         * @param {!Window|HTMLDocument|Node} self
         * @param {EventListener|function(!Event):(boolean|undefined)} listener
         * @return {!function(Event)|undefined}
         */
<<<<<<< HEAD:DKPlugins/DK/eventListenerIEPolyfill.js
        var listener_get = function (self, listener) {
            var listeners = listener[listeners_prop_name];
            if (listeners) {
                var lis;
                var i = listeners.length;
                while (i--) {
                    lis = listeners[i];
                    if (lis[0] === self) {
=======
        var listener_get = function (self, listener){
            var listeners = listener[listeners_prop_name];
            if (listeners){
                var lis;
                var i = listeners.length;
                while (i--){
                    lis = listeners[i];
                    if (lis[0] === self){
>>>>>>> Development:DKCpp/plugins/DK/eventListenerIEPolyfill.js
                        return lis[1];
                    }
                }
            }
        };
        /**
         * @param {!Window|HTMLDocument|Node} self
         * @param {EventListener|function(!Event):(boolean|undefined)} listener
         * @param {!function(Event)} callback
         * @return {!function(Event)}
         */
<<<<<<< HEAD:DKPlugins/DK/eventListenerIEPolyfill.js
        var listener_set = function (self, listener, callback) {
=======
        var listener_set = function (self, listener, callback){
>>>>>>> Development:DKCpp/plugins/DK/eventListenerIEPolyfill.js
            var listeners = listener[listeners_prop_name] || (listener[listeners_prop_name] = []);
            return listener_get(self, listener) || (listeners[listeners.length] = [self, callback], callback);
        };
        /**
         * @param {string} methodName
         */
<<<<<<< HEAD:DKPlugins/DK/eventListenerIEPolyfill.js
        var docHijack = function (methodName) {
            var old = document[methodName];
            document[methodName] = function (v) {
=======
        var docHijack = function (methodName){
            var old = document[methodName];
            document[methodName] = function (v){
>>>>>>> Development:DKCpp/plugins/DK/eventListenerIEPolyfill.js
                return addListen(old(v));
            };
        };
        /**
         * @this {!Window|HTMLDocument|Node}
         * @param {string} type
         * @param {EventListener|function(!Event):(boolean|undefined)} listener
         * @param {boolean=} useCapture
         */
<<<<<<< HEAD:DKPlugins/DK/eventListenerIEPolyfill.js
        var addEvent = function (type, listener, useCapture) {
            if (is_callable(listener)) {
                var self = this;
                self.attachEvent(
                    'on' + type,
                    listener_set(self, listener, function (e) {
                        e = e || window.event;
                        e.preventDefault = e.preventDefault || function () { e.returnValue = false };
                        e.stopPropagation = e.stopPropagation || function () { e.cancelBubble = true };
=======
        var addEvent = function (type, listener, useCapture){
            if (is_callable(listener)){
                var self = this;
                self.attachEvent(
                    'on' + type,
                    listener_set(self, listener, function (e){
                        e = e || window.event;
                        e.preventDefault = e.preventDefault || function (){ e.returnValue = false };
                        e.stopPropagation = e.stopPropagation || function (){ e.cancelBubble = true };
>>>>>>> Development:DKCpp/plugins/DK/eventListenerIEPolyfill.js
                        e.target = e.target || e.srcElement || document.documentElement;
                        e.currentTarget = e.currentTarget || self;
                        e.timeStamp = e.timeStamp || (new Date()).getTime();
                        listener.call(self, e);
                    })
                );
            }
        };
        /**
         * @this {!Window|HTMLDocument|Node}
         * @param {string} type
         * @param {EventListener|function(!Event):(boolean|undefined)} listener
         * @param {boolean=} useCapture
         */
<<<<<<< HEAD:DKPlugins/DK/eventListenerIEPolyfill.js
        var removeEvent = function (type, listener, useCapture) {
            if (is_callable(listener)) {
                var self = this;
                var lis = listener_get(self, listener);
                if (lis) {
=======
        var removeEvent = function (type, listener, useCapture){
            if (is_callable(listener)){
                var self = this;
                var lis = listener_get(self, listener);
                if (lis){
>>>>>>> Development:DKCpp/plugins/DK/eventListenerIEPolyfill.js
                    self.detachEvent('on' + type, lis);
                }
            }
        };
        /**
         * @param {!Node|NodeList|Array} obj
         * @return {!Node|NodeList|Array}
         */
<<<<<<< HEAD:DKPlugins/DK/eventListenerIEPolyfill.js
        var addListen = function (obj) {
            var i = obj.length;
            if (i) {
                while (i--) {
=======
        var addListen = function (obj){
            var i = obj.length;
            if (i){
                while (i--){
>>>>>>> Development:DKCpp/plugins/DK/eventListenerIEPolyfill.js
                    obj[i].addEventListener = addEvent;
                    obj[i].removeEventListener = removeEvent;
                }
            } else {
                obj.addEventListener = addEvent;
                obj.removeEventListener = removeEvent;
            }
            return obj;
        };

        addListen([document, window]);
<<<<<<< HEAD:DKPlugins/DK/eventListenerIEPolyfill.js
        if ('Element' in window) {
=======
        if ('Element' in window){
>>>>>>> Development:DKCpp/plugins/DK/eventListenerIEPolyfill.js
            /**
             * IE8
             */
            var element = window.Element;
            element.prototype.addEventListener = addEvent;
            element.prototype.removeEventListener = removeEvent;
        } else {
            /**
             * IE < 8
             */
                //Make sure we also init at domReady
<<<<<<< HEAD:DKPlugins/DK/eventListenerIEPolyfill.js
            document.attachEvent('onreadystatechange', function () { addListen(document.all) });
=======
            document.attachEvent('onreadystatechange', function (){ addListen(document.all) });
>>>>>>> Development:DKCpp/plugins/DK/eventListenerIEPolyfill.js
            docHijack('getElementsByTagName');
            docHijack('getElementById');
            docHijack('createElement');
            addListen(document.all);
        }
    }
})(window, document, 'x-ms-event-listeners');
