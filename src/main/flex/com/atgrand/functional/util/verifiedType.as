package com.atgrand.functional.util {
import flash.utils.getQualifiedClassName;

public function verifiedType(value:*, type:Class):* {
    if (value is type) {
        return value
    }

    throw new TypeError("Expected: " + getQualifiedClassName(type)
                                + ", Actual: " + getQualifiedClassName(value))
}
}