package com.atgrand.functional {
public function lazy(f:Function, thisArg:* = null, argArray:Array = null):ILazy {
    return new LazyImpl(f, thisArg, argArray)
}
}