package com.atgrand.functional.tuple {
import com.atgrand.functional.Product;

internal final class Tuple6Impl extends Product implements ITuple6 {
    private var __1:*
    private var __2:*
    private var __3:*
    private var __4:*
    private var __5:*
    private var __6:*

    public function Tuple6Impl(_1:*, _2:*, _3:*, _4:*, _5:*, _6:*) {
        __1 = _1
        __2 = _2
        __3 = _3
        __4 = _4
        __5 = _5
        __6 = _6
    }

    public function get _1():* { return __1 }

    public function get _2():* { return __2 }

    public function get _3():* { return __3 }

    public function get _4():* { return __4 }

    public function get _5():* { return __5 }

    public function get _6():* { return __6 }

    override public function get productArity():int {
        return 6
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
            case 4:
                return __5
            case 5:
                return __6
            default:
                throw new RangeError()
        }
    }
}
}