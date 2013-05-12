package com.atgrand.functional.ioc {
import flash.utils.Dictionary

import com.atgrand.functional.ioc.error.BindingError

public class AbstractModule implements IModule {
    private const _map:Dictionary = new Dictionary
    private var _initialized:Boolean = false

    public function AbstractModule() {
    }

    protected function configure():void {
    }

    public final function initialize():void {
        configure()
        _initialized = true
    }

    protected final function bind(klass:Class):Binding {
        if (null != _map[klass]) {
            throw new BindingError(klass + " is already bound.")
        }

        const binding:Binding = new Binding(this, klass)

        _map[klass] = binding

        return binding
    }

    public final function getInstance(klass:Class):* {
        if (!_initialized) {
            throw new BindingError("Modules have to be created using \"Injector.initialize(new Module())\".")
        }

        const binding:Binding = _map[klass]

        try {
            Injector.module_internal::pushScope(this)
            return (null == binding) ? new klass : binding.getInstance()
        }
        finally {
            Injector.module_internal::popScope()
        }
    }

    public function binds(klass:Class):Boolean {
        return _map[klass] != null
    }
}
}