//https://udn.realityripple.com/docs/Web/API/WorkerGlobalScope
//
// The WorkerGlobalScope mixin is for use of APIs that are to be exposed on Window and WorkerGlobalScope objects.


var WorkerGlobalScope = function WorkerGlobalScope(pointer) {
    this.pointer = pointer;

	// Properties
    Object.defineProperty(this, "todo", {
        get: function todo() {
            return CPP_DKWorkerGlobalScope_todo(pointer)
        }
    })

	// Methods
	WorkerGlobalScope.prototype.todo = function todo() {
		//TODO
    }

    return this;
}

