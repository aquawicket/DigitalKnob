
<<<<<<< HEAD
(function (Object) {
=======
(function (Object){
>>>>>>> Development
  typeof window !== 'object' && (
    this ?
      get() :
      (Object.defineProperty(Object.prototype, '_T_', {
        configurable: true,
        get: get
      }), _T_)
  );
<<<<<<< HEAD
  function get() {
=======
  function get(){
>>>>>>> Development
    var global = this || self;
    global.window = global;
    delete Object.prototype._T_;
  }
}(Object));