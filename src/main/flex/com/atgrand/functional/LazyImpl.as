package com.atgrand.functional {

internal final class LazyImpl extends Product implements ILazy {
    private var _f:Function;
    private var _thisArg:*;
    private var _argArray:Array;
    private var _value:*;
    private var _evaluated:Boolean = false;

    public function LazyImpl(f:Function, thisArg:* = null, argArray:Array = null) {
        _f = f;
        _thisArg = thisArg;
        _argArray = argArray
    }

    /**
     * @inheritDoc
     */
    public function get get():* {
        if (!_evaluated) {
            _value = _f.apply(_thisArg, _argArray);
            _evaluated = true;
            _thisArg = null;
            _argArray = null;
            _f = null
        }

        return _value
    }

    /**
     * @inheritDoc
     */
    override public function productElement(i:int):* {
        if (0 == i) {
            return get
        }

        throw new RangeError("Index " + i + " is out of bounds.")
    }

    /**
     * @inheritDoc
     */
    override public function get productArity():int {
        return 1
    }
}
}