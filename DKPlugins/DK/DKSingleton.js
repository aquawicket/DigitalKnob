//https://www.sitepoint.com/javascript-design-patterns-singleton/
"use strict";

class UserStore {
    constructor() {
        if (!UserStore.instance) {
            this._data = [];
            UserStore.instance = this;
        }
        return UserStore.instance;
    }
}

const instance = new UserStore();
Object.freeze(instance);

//Uncaught SyntaxError: Unexpected token 'export'
//export default instance;
