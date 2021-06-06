"use strict";

dk.validate = new DKValidate();
function DKValidate() {
    return DKPlugin.call(this);
}

//DKValidate.prototype.init = function DKValidate_init(){}
//DKValidate.prototype.end = function DKValidate_end(){}

//https://stackoverflow.com/a/9337047/688352
DKValidate.prototype.isValidVarName = function DKValidate_isValidVarName(var_name) {
    try {
        Function('var ' + var_name);
    } catch (e) {
        return false;
    }
    return true;
}

DKValidate.prototype.isValidCallStack = function DKValidate_isValidCallStack(stack) {//TODO
}

DKValidate.prototype.isValidEmail = function DKValidate_isValidEmail(email) {//TODO
}
