/**
 * @license addEventListener polyfill 1.0 / Eirik Backer / MIT Licence
 * https://gist.github.com/2864711/946225eb3822c203e8d6218095d888aac5e1748e
 *
 * sounisi5011 version:
 * http://qiita.com/sounisi5011/items/a8fc80e075e4f767b79a#11
 */
<<<<<<< HEAD
(function (window, document, listeners_prop_name) {
    if ((!window.addEventListener || !window.removeEventListener) && window.attachEvent && window.detachEvent) {
=======
(function (window, document, listeners_prop_name){
    if ((!window.addEventListener || !window.removeEventListener) && window.attachEvent && window.detachEvent){
>>>>>>> Development
        /**
         * @param {*} value
         * @return {boolean}
         */
<<<<<<< HEAD
        var is_callable = function (value) {
=======
        var is_callable = function (value){
>>>>>>> Development
            return typeof value === 'function';
        };
        /**
         * @param {!Window|HTMLDocument|Node} self
         * @param {EventListener|function(!Event):(boolean|undefined)} listener
         * @return {!function(Event)|undefined}
         */
<<<<<<< HEAD
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
>>>>>>> Development
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
<<<<<<< HEAD
        var listener_set = function (self, listener, callback) {
=======
        var listener_set = function (self, listener, callback){
>>>>>>> Development
            var listeners = listener[listeners_prop_name] || (listener[listeners_prop_name] = []);
            return listener_get(self, listener) || (listeners[listeners.length] = [self, callback], callback);
        };
        /**
         * @param {string} methodName
         */
<<<<<<< HEAD
        var docHijack = function (methodName) {
            var old = document[methodName];
            document[methodName] = function (v) {
=======
        var docHijack = function (methodName){
            var old = document[methodName];
            document[methodName] = function (v){
>>>>>>> Development
                return addListen(old(v));
            };
        };
        /**
         * @this {!Window|HTMLDocument|Node}
         * @param {string} type
         * @param {EventListener|function(!Event):(boolean|undefined)} listener
         * @param {boolean=} useCapture
         */
<<<<<<< HEAD
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
>>>>>>> Development
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
<<<<<<< HEAD
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
>>>>>>> Development
                    self.detachEvent('on' + type, lis);
                }
            }
        };
        /**
         * @param {!Node|NodeList|Array} obj
         * @return {!Node|NodeList|Array}
         */
<<<<<<< HEAD
        var addListen = function (obj) {
            var i = obj.length;
            if (i) {
                while (i--) {
=======
        var addListen = function (obj){
            var i = obj.length;
            if (i){
                while (i--){
>>>>>>> Development
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
<<<<<<< HEAD
        if ('Element' in window) {
=======
        if ('Element' in window){
>>>>>>> Development
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
<<<<<<< HEAD
            document.attachEvent('onreadystatechange', function () { addListen(document.all) });
=======
            document.attachEvent('onreadystatechange', function (){ addListen(document.all) });
>>>>>>> Development
            docHijack('getElementsByTagName');
            docHijack('getElementById');
            docHijack('createElement');
            addListen(document.all);
        }
    }
})(window, document, 'x-ms-event-listeners');
