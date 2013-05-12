package com.atgrand.functional {
import flash.utils.setTimeout

internal final class ForkImpl implements IComposeable {
    private var _f:Function;
    private var _thisArg:*;
    private var _argArray:Array;
    private var _force:Boolean;

    public function ForkImpl(f:Function, thisArg:* = null, argArray:Array = null, force:Boolean = false) {
        _f = f;
        _thisArg = thisArg;
        _argArray = argArray;
        _force = force
    }

    /**
     * Generates and returns the string representation
     * of the current object.
     *
     * @return The string representation of the current object.
     */
    public function toString():String {
        return '[ForkImpl]';
    }

    public function andThen(f:Function, thisArg:* = null, argArray:Array = null):Function {
        const inner:Function = function ():void { f.apply(thisArg, argArray) };

        if (_force) {
            return function (...rest):void {
                setTimeout(
                        function ():void {
                            _f.apply(_thisArg,
                                     _argArray == null ? [inner] : _argArray.unshift(inner)
                            )
                        }, 0)
            }
        }
        else {
            return function (...rest):void {
                _f.apply(_thisArg, _argArray == null ? [inner] : _argArray.unshift(inner))
            }
        }
    }

    public function andContinue(f:Function):Function {
        const inner:Function = function (...rest):void { f.apply(_thisArg, rest) };

        if (_force) {
            return function (...rest):void {
                setTimeout(
                        function ():void {
                            _f.apply(_thisArg,
                                     _argArray == null ? [inner] : _argArray.unshift(inner)
                            )
                        }, 0)
            }
        }
        else {
            return function (...rest):void {
                _f.apply(_thisArg, _argArray == null ? [inner] : _argArray.unshift(inner))
            }
        }
    }

    public function equals(that:IFunkObject):Boolean {
        return this == that
    }
}
}