package com.atgrand.functional.ioc {
public function inject(klass:Class):* {
    if (klass == null) {
        throw new ArgumentError("Given type must not be null.")
    }

    const currentScope:IModule = Injector.module_internal::currentScope

    if (null == currentScope) {
        return Injector.module_internal::scopeOf(klass).getInstance(klass)
    }

    return currentScope.getInstance(klass)
}
}