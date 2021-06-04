"use strict";

DKValidate.prototype = Object.create(DKPlugin.prototype);
function DKValidate(identifier) {
    return DKPlugin.call(this, identifier);
}
dk.validate = new DKValidate("DKValidate");


//dk.validate.init = function dk_validate_init(){}
//dk.validate.end = function dk_validate_end(){}

//https://stackoverflow.com/a/9337047/688352
dk.validate.isValidVarName = function dk_validate_isValidVarName(var_name) {
    try {
        Function('var ' + var_name);
    } catch (e) {
        return false;
    }
    return true;
}

dk.validate.isValidCallStack = function dk_validate_isValidCallStack(stack) {//TODO
}

dk.validate.isValidEmail = function dk_validate_isValidEmail(email) {//TODO
}
