//https://udn.realityripple.com/docs/Web/API/WorkerGlobalScope
//
// The WorkerGlobalScope mixin is for use of APIs that are to be exposed on Window and WorkerGlobalScope objects.


<<<<<<< HEAD:DKPlugins/DKDom/DKDomWorkerGlobalScope.js
var WorkerGlobalScope = function WorkerGlobalScope(pointer) {
=======
var WorkerGlobalScope = function WorkerGlobalScope(pointer){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomWorkerGlobalScope.js
    this.pointer = pointer;

	// Properties
    Object.defineProperty(this, "todo", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomWorkerGlobalScope.js
        get: function todo() {
=======
        get: function todo(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomWorkerGlobalScope.js
            return CPP_DKWorkerGlobalScope_todo(pointer)
        }
    })

	// Methods
<<<<<<< HEAD:DKPlugins/DKDom/DKDomWorkerGlobalScope.js
	WorkerGlobalScope.prototype.todo = function todo() {
=======
	WorkerGlobalScope.prototype.todo = function todo(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomWorkerGlobalScope.js
		//TODO
    }

    return this;
}

