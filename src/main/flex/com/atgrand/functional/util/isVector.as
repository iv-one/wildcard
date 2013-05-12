package com.atgrand.functional.util {
import flash.utils.getQualifiedClassName;

public function isVector(xs:*):Boolean {
    return getQualifiedClassName(xs).indexOf("__AS3__.vec::Vector") == 0;
}
}