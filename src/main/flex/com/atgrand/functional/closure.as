package com.atgrand.functional {
public function closure(f:Function, ...rest):Function {
    return function (...appliedRest):* {
        return appliedRest.length == 0 ? f.apply(null, rest) : f.apply(null, appliedRest)
    }
}
}