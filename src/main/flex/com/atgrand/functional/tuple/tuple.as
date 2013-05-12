package com.atgrand.functional.tuple {
import com.atgrand.functional.error.IllegalByDefinitionError;
import com.atgrand.functional.util.require;

public function tuple(...rest):ITuple {
    const n:int = rest.length;

    require(n > 0, "At least one element must be speficied.");
    require(n < 9, "No more than eight elements are supported.");

    switch (n) {
        case 8:
            return new Tuple8Impl(rest[0], rest[1], rest[2], rest[3], rest[4], rest[5], rest[6], rest[7]);
        case 7:
            return new Tuple7Impl(rest[0], rest[1], rest[2], rest[3], rest[4], rest[5], rest[6]);
        case 6:
            return new Tuple6Impl(rest[0], rest[1], rest[2], rest[3], rest[4], rest[5]);
        case 5:
            return new Tuple5Impl(rest[0], rest[1], rest[2], rest[3], rest[4]);
        case 4:
            return new Tuple4Impl(rest[0], rest[1], rest[2], rest[3]);
        case 3:
            return new Tuple3Impl(rest[0], rest[1], rest[2]);
        case 2:
            return new Tuple2Impl(rest[0], rest[1]);
        case 1:
            return new Tuple1Impl(rest[0]);
        default:
            throw new IllegalByDefinitionError()
    }
}
}