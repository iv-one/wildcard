package com.atgrand.functional.ioc {
import flash.utils.Dictionary

import com.atgrand.functional.collections.IFuncList
import com.atgrand.functional.collections.nil
import com.atgrand.functional.ioc.error.BindingError
import com.atgrand.functional.util.isAbstract

public final class Injector {
    private static const _map:Dictionary = new Dictionary
    private static var _scopes:IFuncList = nil
    private static var _modules:IFuncList = nil
    private static var _currentScope:IModule

    public static function initialize(module:IModule):IModule {
        module.initialize()
        _modules = _modules.prepend(module)
        return module
    }

    module_internal static function pushScope(module:IModule):void {
        _currentScope = module
        _scopes = _scopes.prepend(module)
    }

    module_internal static function popScope():void {
        _scopes = _scopes.tail
        _currentScope = _scopes.nonEmpty ? IModule(_scopes.head) : null
    }

    module_internal static function get currentScope():IModule {
        return _currentScope
    }

    module_internal static function scopeOf(klass:Class):IModule {
        var result:IModule = null
        var module:IModule = null
        var modules:IFuncList = _modules

        while (modules.nonEmpty) {
            module = IModule(modules.head)

            if (module.binds(klass)) {
                if (null != result) {
                    throw new BindingError("More than one module binds " + klass + ".")
                }
                result = IModule(modules.head)
            }

            modules = modules.tail
        }

        if (null == result) {
            throw new BindingError("No binding for " + klass + " could be fond.")
        }

        return result
    }

    module_internal static function moduleOf(klass:Class):IModule {
        const possibleResult:IModule = _map[klass]

        if (null != possibleResult) {
            return possibleResult
        }

        var module:IModule = null
        var modules:IFuncList = _modules

        while (modules.nonEmpty) {
            module = IModule(modules.head)

            if (module is klass) {
                _map[klass] = module
                return module
            }

            modules = modules.tail
        }

        throw new BindingError("No module for " + klass + " could be found.")
    }

    [Abstract]
    public function Injector() { isAbstract() }
}
}