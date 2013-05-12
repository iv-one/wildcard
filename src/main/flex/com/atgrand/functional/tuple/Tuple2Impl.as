package com.atgrand.functional.tuple {
import com.atgrand.functional.Product;

internal final class Tuple2Impl extends Product implements ITuple2 {
    private var __1:*;
    private var __2:*;

    public function Tuple2Impl(_1:*, _2:*) {
        __1 = _1;
        __2 = _2
    }

    public function get _1():* { return __1 }

    public function get _2():* { return __2 }

    override public function get productArity():int {
        return 2
    }

    override public function productElement(i:int):* {
        switch (i) {
            case 0:
                return __1;
            case 1:
                return __2;
            default:
                throw new RangeError()
        }
    }
}
}