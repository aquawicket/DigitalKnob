"use strict";

//https://stackoverflow.com/a/9337047/688352
function DKValidate_IsValidVarName(name) {
    try {
        Function('var ' + var_name);
    } catch (e) {
        return false;
    }
    return true;
}

function DKValidate_IsValidCallStack(stack) {//TODO
}

function DKValidate_IsValidEmail(email) {//TODO
}
