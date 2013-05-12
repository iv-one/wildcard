package com.atgrand.functional.ioc {
public function injectIn(klass:Class, module:Class):* {
    if (klass == null) {
        throw new ArgumentError("Given type must not be null.")
    } else if (module == null) {
        throw new ArgumentError("Given module type must not be null.")
    }

    return Injector.module_internal::moduleOf(module).getInstance(klass)
}
}