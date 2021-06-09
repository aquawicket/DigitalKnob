"use strict";

dk.validate = DKPlugin(DKValidate);
function DKValidate() {}

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
