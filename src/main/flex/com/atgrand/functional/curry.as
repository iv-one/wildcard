package com.atgrand.functional {
public function curry(f:Function, ...rest):Function {
    return function (...appliedRest):* {
        return f.apply(null, rest.concat(appliedRest))
    }
}
}