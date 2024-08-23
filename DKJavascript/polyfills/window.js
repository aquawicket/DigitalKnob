
(function (Object) {
  typeof window !== 'object' && (
    this ?
      get() :
      (Object.defineProperty(Object.prototype, '_T_', {
        configurable: true,
        get: get
      }), _T_)
  );
  function get() {
    var global = this || self;
    global.window = global;
    delete Object.prototype._T_;
  }
}(Object));