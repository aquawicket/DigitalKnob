if ('a'.replace(/(z)|./, function(match, g1) { return typeof g1; }) !== 'undefined') {
    String.prototype.replace = (function (native_method) {
        return function (pattern, callback) {
            if (pattern.constructor.name !== 'RegExp' || typeof callback !== 'function') {
                return native_method.call(this, pattern, callback);
            }
            var result = '', source = String(this), length = source.length, lastIndex = 0, index, match;
            pattern.lastIndex = 0;
            while ((match = pattern.exec(source))) {
                index = match.index;
                result += source.slice(lastIndex, index);
                lastIndex = index + match[0].length;
                match.push(index, source);
                result += callback.apply(null, match);
                pattern.lastIndex = lastIndex;
                if (!pattern.global) break;
                if (lastIndex === index) {
                    if (lastIndex === length) break;
                    pattern.lastIndex = lastIndex++;
                    result += source.charAt(lastIndex);
                }
            }
            if (lastIndex < length) result += source.slice(lastIndex, length);
            return result;
        }
    }(String.prototype.replace));
}