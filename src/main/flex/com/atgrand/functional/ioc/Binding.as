package com.atgrand.functional.ioc {
import com.atgrand.functional.error.IllegalByDefinitionError

internal final class Binding implements IScope {
    private var _module:AbstractModule
    private var _bind:Class
    private var _to:Class
    private var _toInstance:*
    private var _toProvider:Class
    private var _bindingClass:int
    private var _singletonScope:Boolean = false
    private var _evaluated:Boolean = false
    private var _value:*

    public function Binding(module:AbstractModule, bind:Class) {
        _module = module
        _bind = bind
    }

    public function to(klass:Class):IScope {
        _to = klass
        _bindingClass = 0
        return this
    }

    public function toInstance(instance:*):IScope {
        _toInstance = instance
        _bindingClass = 1
        return this
    }

    public function toProvider(provider:Class):IScope {
        _toProvider = provider
        _bindingClass = 2
        return this
    }

    internal function getInstance():* {
        if (_singletonScope) {
            if (_evaluated) {
                return _value
            }

            _value = solve()
            _evaluated = true

            return _value
        }
        else {
            return solve()
        }
    }

    private function solve():* {
        if (0 == _bindingClass) {
            return (null == _to) ? new _bind : _module.getInstance(_to)
        } else if (1 == _bindingClass) {
            return _toInstance
        } else if (2 == _bindingClass) {
            return IProvider(_module.getInstance(_toProvider)).get()
        }
        else {
            throw new IllegalByDefinitionError()
        }
    }

    public function asSingleton():void {
        _singletonScope = true
    }
}
}