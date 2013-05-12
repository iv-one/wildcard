package com.atgrand.functional.tuple {
import com.atgrand.functional.Product;

internal final class Tuple4Impl extends Product implements ITuple4 {
    private var __1:*
    private var __2:*
    private var __3:*
    private var __4:*

    public function Tuple4Impl(_1:*, _2:*, _3:*, _4:*) {
        __1 = _1
        __2 = _2
        __3 = _3
        __4 = _4
    }

    public function get _1():* { return __1 }

    public function get _2():* { return __2 }

    public function get _3():* { return __3 }

    public function get _4():* { return __4 }

    override public function get productArity():int {
        return 4
    }

    override public function productElement(i:int):* {
        switch (i) {
            case 0:
                return __1
            case 1:
                return __2
            case 2:
                return __3
            case 3:
                return __4
            default:
                throw new RangeError()
        }
    }
}
}